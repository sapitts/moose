/****************************************************************/
/* MOOSE - Multiphysics Object Oriented Simulation Environment  */
/*                                                              */
/*          All contents are licensed under LGPL V2.1           */
/*             See LICENSE for full restrictions                */
/****************************************************************/
#include "CrystalPlasticityUpdate.h"
#include "petscblaslapack.h"
#include "libmesh/utility.h"


template<>
InputParameters validParams<CrystalPlasticityUpdate>()
{
  InputParameters params = validParams<Material>();
  params.addClassDescription("Crystal Plasticity base class: FCC system with power law flow rule implemented");
  params.addParam<std::string>("base_name", "Optional parameter that allows the user to define multiple mechanics material systems on the same block, i.e. for multiple phases");

  //The return stress increment classes are intended to be iterative materials, so must set compute = false for all inheriting classes
  params.set<bool>("compute") = false;
  params.suppressParameter<bool>("compute");

  params.addRequiredParam<unsigned int>("number_slip_systems", "The total number of possible active slip systems for the crystalline material");
  params.addRequiredParam<FileName>("slip_sys_file_name", "Name of the file containing the slip system");

  params.addParam<Real>("rtol", 1e-6, "Constitutive stress residue relative tolerance");
  params.addParam<Real>("abs_tol", 1e-6, "Constitutive stress residue absolute tolerance");
  params.addParam<Real>("stol", 1e-2, "Constitutive slip system resistance relative residual tolerance");
  params.addParam<Real>("slip_incr_tol", 2e-2, "Maximum allowable slip in an increment");
  params.addParam<Real>("resistance_tol",1e2,"Constitutive slip system resistance residual tolerance");
  params.addParam<Real>("zero_tol", 1e-12, "Tolerance for residual check when variable value is zero");
  params.addParam<unsigned int>("maxiter", 100 , "Maximum number of iterations for stress update");
  params.addParam<unsigned int>("maxiter_state_variable", 100 , "Maximum number of iterations for state variable update");
  MooseEnum tan_mod_options("exact none","none");// Type of read
  params.addParam<MooseEnum>("tan_mod_type", tan_mod_options, "Type of tangent moduli for preconditioner: default elastic");
  params.addParam<unsigned int>("maximum_substep_iteration", 5, "Maximum number of substep iteration");
  params.addParam<bool>("use_line_search", false, "Use line search in constitutive update");
  params.addParam<Real>("min_line_search_step_size", 0.01, "Minimum line search step size");
  params.addParam<Real>("line_search_tol",0.5,"Line search bisection method tolerance");
  params.addParam<unsigned int>("line_search_maxiter",20,"Line search bisection method maximum number of iteration");
  MooseEnum line_search_method("CUT_HALF BISECTION","CUT_HALF");
  params.addParam<MooseEnum>("line_search_method",line_search_method,"The method used in line search");

  return params;
}

CrystalPlasticityUpdate::CrystalPlasticityUpdate(const InputParameters & parameters) :
    Material(parameters),
    _base_name(isParamValid("base_name") ? getParam<std::string>("base_name") + "_" : "" ),
    _elasticity_tensor(getMaterialPropertyByName<RankFourTensor>(_base_name + "elasticity_tensor")),

    _number_slip_systems(getParam<unsigned int>("number_slip_systems")),
    _slip_sys_file_name(getParam<FileName>("slip_sys_file_name")),

    _rtol(getParam<Real>("rtol")),
    _abs_tol(getParam<Real>("abs_tol")),
    _rel_state_var_tol(getParam<Real>("stol")),
    _slip_incr_tol(getParam<Real>("slip_incr_tol")),
    _resistance_tol(getParam<Real>("resistance_tol")),
    _zero_tol(getParam<Real>("zero_tol")),
    _maxiter(getParam<unsigned int>("maxiter")),
    _maxiterg(getParam<unsigned int>("maxiter_state_variable")),
    _tan_mod_type(getParam<MooseEnum>("tan_mod_type")),
    _max_substep_iter(getParam<unsigned int>("maximum_substep_iteration")),
    _use_line_search(getParam<bool>("use_line_search")),
    _min_line_search_step_size(getParam<Real>("min_line_search_step_size")),
    _line_search_tolerance(getParam<Real>("line_search_tol")),
    _line_search_max_iterations(getParam<unsigned int>("line_search_maxiter")),
    _line_search_method(getParam<MooseEnum>("line_search_method")),
    _plastic_deformation_gradient(declareProperty<RankTwoTensor>("fp")), // Plastic deformation gradient
    _plastic_deformation_gradient_old(declarePropertyOld<RankTwoTensor>("fp")), // Plastic deformation gradient of previous increment
    _pk2(declareProperty<RankTwoTensor>("pk2")), // 2nd Piola Kirchoff Stress
    _pk2_old(declarePropertyOld<RankTwoTensor>("pk2")), // 2nd Piola Kirchoff Stress of previous increment
    _total_lagrangian_strain(declareProperty<RankTwoTensor>("lage")), // Lagrangian strain
    _update_rotation(declareProperty<RankTwoTensor>("update_rot")), // Rotation tensor considering material rotation and crystal orientation
//    _update_rotation_old(declarePropertyOld<RankTwoTensor>("update_rot")),
    _flow_direction(declareProperty<std::vector<RankTwoTensor>>("flow_direction")),
    _deformation_gradient(getMaterialProperty<RankTwoTensor>("deformation_gradient")),
    _deformation_gradient_old(getMaterialPropertyOld<RankTwoTensor>("deformation_gradient")),
    _slip_direction(_number_slip_systems * LIBMESH_DIM),
    _slip_plane_normal(_number_slip_systems * LIBMESH_DIM),
    _crysrot(getMaterialProperty<RankTwoTensor>("crysrot")) // defined in the elasticity tensor class for crystal plasticity ComputeElasticityTensorCP
{
  _error_tolerance = false;
  _substep_dt = 0.0;
  _delta_deformation_gradient.zero();

  getSlipSystems();
}

void
CrystalPlasticityUpdate::initQpStatefulProperties()
{
  _plastic_deformation_gradient[_qp].zero();
  _plastic_deformation_gradient[_qp].addIa(1.0);

  _pk2[_qp].zero();

  _total_lagrangian_strain[_qp].zero();

  _update_rotation[_qp].zero();
  _update_rotation[_qp].addIa(1.0);

  _flow_direction[_qp].resize(_number_slip_systems);
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
    _flow_direction[_qp][i].zero();
}

/**
 * Solves stress residual equation using Newton - Rhapson: Updates slip system resistances iteratively.
 */
void
CrystalPlasticityUpdate::updateStress(RankTwoTensor & cauchy_stress, RankFourTensor & jacobian_mult)
{
  // Userobject based crystal plasticity does not support face/boundary material property calculation.
  if (isBoundaryMaterial())
    return;

  // Depth of substepping; Limited to maximum substep iteration
  unsigned int substep_iter = 1;
  // Calculated from substep_iter as 2^substep_iter
  unsigned int num_substep = 1;
  // Store original _dt; Reset at the end of solve
//  Real dt_original = _dt; <- not sure I need to do this with my own substep dt variable

  _temporary_deformation_gradient_old = _deformation_gradient_old[_qp];
  if (_temporary_deformation_gradient_old.det() == 0)
    _temporary_deformation_gradient_old.addIa(1.0);

  _delta_deformation_gradient = _deformation_gradient[_qp] - _temporary_deformation_gradient_old;

  // Calculate the schmid tensor for the current state of the crystal lattice
  calculateFlowDirection();

  do
  {
    _error_tolerance = false;

    //reset the PK2 stress and the inverse deformation gradient to old values
    _pk2[_qp] = _pk2_old[_qp];
    _inverse_plastic_deformation_grad_old = _plastic_deformation_gradient_old[_qp].inverse();

    _substep_dt = _dt/num_substep;

    // std::cout << "With the starting dt value of " << _dt << " the substep dt is " << _substep_dt << std::endl;
    // std::cout << "  while the time is " << _t << std::endl;

    for (unsigned int istep = 0; istep < num_substep; ++istep)
    {
      // std::cout << "  inside the for loop, and whats the istep value? " << istep << std::endl;
      _temporary_deformation_gradient =  (static_cast<Real>(istep) + 1) / num_substep * _delta_deformation_gradient;
      _temporary_deformation_gradient += _temporary_deformation_gradient_old;

      // std::cout<< "what the value of error_tolerance? " << _error_tolerance << std::endl;

      solveQp();

      // std::cout<< "what the value of error_tolerance? " << _error_tolerance << std::endl;

      if (_error_tolerance)
      {
        std::cout << "do i hit this? " << std::endl;
        substep_iter++;
        std::cout << "what's the substep_iter value? " << substep_iter << std::endl;
        num_substep *= 2;
        std::cout << "what is the number substep value? " << num_substep << std::endl;
        break;
      }
      // std::cout << "do I make it out of here? " << std::endl;
    }

    if (substep_iter > _max_substep_iter && _error_tolerance)
      mooseError("CrystalPlasticityUpdate: Constitutive failure");
  }
  while (_error_tolerance);

  // _dt = dt_original;  <- not sure I need to do this with my own substep dt variable

  postSolveQp(cauchy_stress, jacobian_mult);

  if (_qp == 0)
  {
    std::cout << "Successfully solved for the new stress value in updateStress! Nice work" << std::endl;
    std::cout << "------------------------------------------------------------------------------ " << std::endl;
    std::cout << std::endl;
  }
}

void
CrystalPlasticityUpdate::solveQp()  // <- probably going to have to pass in my local sub_dt variable here
{
  setInitialConstitutiveVariableValues();
  _inverse_plastic_deformation_grad = _inverse_plastic_deformation_grad_old;

  solveStateVariables();
  if (_error_tolerance)
    return;  // pop back up and take a smaller substep

  // save off the old F^{p}.inverse now that have converged on the stress and state variables
  _inverse_plastic_deformation_grad_old = _inverse_plastic_deformation_grad;

}

void
CrystalPlasticityUpdate::postSolveQp(RankTwoTensor & cauchy_stress, RankFourTensor & jacobian_mult)
{
  // Restores the the old stateful properties after a successful solve....not sure that I'll have to
  // do this b/c automatically save to old in the child material
  //  but can have a statevariablefinalize method if needed.
  //finalizeConstitutiveStateVariables(); // <- shouldn't need anything to pass through, but maybe the flow direction tensor?

  cauchy_stress = _elastic_deformation_gradient * _pk2[_qp] * _elastic_deformation_gradient.transpose()/_elastic_deformation_gradient.det();

  // Calculate jacobian for preconditioner
  calcTangentModuli(jacobian_mult);

  RankTwoTensor identity;
  identity.addIa(1.0);

  _total_lagrangian_strain[_qp] = _deformation_gradient[_qp].transpose() * _deformation_gradient[_qp] - identity;
  _total_lagrangian_strain[_qp] = _total_lagrangian_strain[_qp] * 0.5;

  RankTwoTensor rot;
  // Calculate material rotation
  _deformation_gradient[_qp].getRUDecompositionRotation(rot);
  _update_rotation[_qp] = rot * _crysrot[_qp];
}


void
CrystalPlasticityUpdate::solveStateVariables()
{
  unsigned int iterg;
  bool iter_flag = true;

  iterg = 0;
  // Check for slip system resistance update tolerance
  while (iter_flag && iterg < _maxiterg)
  {
    solveStress();
    if (_error_tolerance)
      return;

    _plastic_deformation_gradient[_qp] = _inverse_plastic_deformation_grad.inverse();  // the postSoveStress

    // if (_qp == 3)
    // {
    //   std::cout << "----------------------------------------------------- " << std::endl;
    //   std::cout << "And the value of the current plastic deformation gradient: " << std::endl;
    //   std::cout << "  plastic deformation gradient (0,0) " << _plastic_deformation_gradient[_qp](0,0) << std::endl;
    //   std::cout << "  plastic deformation gradient (0,1) " << _plastic_deformation_gradient[_qp](0,1) << std::endl;
    //   std::cout << "  plastic deformation gradient (0,2) " << _plastic_deformation_gradient[_qp](0,2) << std::endl;
    //   std::cout << "  plastic deformation gradient (1,0) " << _plastic_deformation_gradient[_qp](1,0) << std::endl;
    //   std::cout << "  plastic deformation gradient (1,1) " << _plastic_deformation_gradient[_qp](1,1) << std::endl;
    //   std::cout << "  plastic deformation gradient (1,2) " << _plastic_deformation_gradient[_qp](1,2) << std::endl;
    //   std::cout << "  plastic deformation gradient (2,0) " << _plastic_deformation_gradient[_qp](2,0) << std::endl;
    //   std::cout << "  plastic deformation gradient (2,1) " << _plastic_deformation_gradient[_qp](2,1) << std::endl;
    //   std::cout << "  plastic deformation gradient (2,2) " << _plastic_deformation_gradient[_qp](2,2) << std::endl;
    //   std::cout << "----------------------------------------------------- " << std::endl;
    //   std::cout << std::endl;
    // }

    // Update slip system resistance and state variable after the stress has been finalized
    updateConstitutiveSlipSystemResistanceAndVariables(_error_tolerance);
    if (_error_tolerance)
      return;

    iter_flag = areConstitutiveStateVariablesConverged();  //returns false if values are converged and good to go
    iterg++;
  }

  if (iterg == _maxiterg)
  {
#ifdef DEBUG
    mooseWarning("CrystalPlasticityUpdate: Hardness Integration error\n");
#endif
    _error_tolerance = true;
  }
}

void
CrystalPlasticityUpdate::solveStress()
{
  unsigned int iter = 0;
  RankTwoTensor dpk2;
  Real rnorm, rnorm0, rnorm_prev;

  // Calculate stress residual
  calcResidJacob();
  if (_error_tolerance)
  {
#ifdef DEBUG
    mooseWarning("CrystalPlasticityUpdate: Slip increment exceeds tolerance - Element number ", _current_elem->id(), " Gauss point = ", _qp);
#endif
    return;
  }

  rnorm = _residual_tensor.L2norm();
  rnorm0 = rnorm;

  if (_qp == 0)
    std::cout << "The rnorm0 is " << rnorm0 << std::endl;

  // Check for stress residual tolerance
  while (rnorm > _rtol * rnorm0 && rnorm0 > _abs_tol && iter <  _maxiter)
  {
    // if (_qp == 0)
    // {
    //   std::cout << "Alright pk2, what are you here in the residual while loop of calculate residual? " << std::endl;
    //   std::cout << "  pk2(0,0) " << _pk2[_qp](0,0) << std::endl;
    //   std::cout << "  pk2(0,1) " << _pk2[_qp](0,1) << std::endl;
    //   std::cout << "  pk2(0,2) " << _pk2[_qp](0,2) << std::endl;
    //   std::cout << "  pk2(1,0) " << _pk2[_qp](1,0) << std::endl;
    //   std::cout << "  pk2(1,1) " << _pk2[_qp](1,1) << std::endl;
    //   std::cout << "  pk2(1,2) " << _pk2[_qp](1,2) << std::endl;
    //   std::cout << "  pk2(2,0) " << _pk2[_qp](2,0) << std::endl;
    //   std::cout << "  pk2(2,1) " << _pk2[_qp](2,1) << std::endl;
    //   std::cout << "  pk2(2,2) " << _pk2[_qp](2,2) << std::endl;
    //   std::cout << std::endl;
    // }

    // Calculate stress increment
    dpk2 = - _jacobian.invSymm() * _residual_tensor;
    // if (_qp == 0)
    // {
    //   std::cout << "And the increment of stress is: " << std::endl;
    //   std::cout << "  dpk2(0,0) " << dpk2(0,0) << std::endl;
    //   std::cout << "  dpk2(0,1) " << dpk2(0,1) << std::endl;
    //   std::cout << "  dpk2(0,2) " << dpk2(0,2) << std::endl;
    //   std::cout << "  dpk2(1,0) " << dpk2(1,0) << std::endl;
    //   std::cout << "  dpk2(1,1) " << dpk2(1,1) << std::endl;
    //   std::cout << "  dpk2(1,2) " << dpk2(1,2) << std::endl;
    //   std::cout << "  dpk2(2,0) " << dpk2(2,0) << std::endl;
    //   std::cout << "  dpk2(2,1) " << dpk2(2,1) << std::endl;
    //   std::cout << "  dpk2(2,2) " << dpk2(2,2) << std::endl;
    //   std::cout << std::endl;
    // }

    _pk2[_qp] = _pk2[_qp] + dpk2;

    // if (_qp == 0)
    // {
    //   std::cout << "new pk2, going into the calc residual call " << std::endl;
    //   std::cout << "  pk2(0,0) " << _pk2[_qp](0,0) << std::endl;
    //   std::cout << "  pk2(0,1) " << _pk2[_qp](0,1) << std::endl;
    //   std::cout << "  pk2(0,2) " << _pk2[_qp](0,2) << std::endl;
    //   std::cout << "  pk2(1,0) " << _pk2[_qp](1,0) << std::endl;
    //   std::cout << "  pk2(1,1) " << _pk2[_qp](1,1) << std::endl;
    //   std::cout << "  pk2(1,2) " << _pk2[_qp](1,2) << std::endl;
    //   std::cout << "  pk2(2,0) " << _pk2[_qp](2,0) << std::endl;
    //   std::cout << "  pk2(2,1) " << _pk2[_qp](2,1) << std::endl;
    //   std::cout << "  pk2(2,2) " << _pk2[_qp](2,2) << std::endl;
    //   std::cout << std::endl;
    // }
    calcResidJacob();

    if (_error_tolerance)
    {
#ifdef DEBUG
      mooseWarning("CrystalPlasticityUpdate: Slip increment exceeds tolerance - Element number ", _current_elem->id(), " Gauss point = ", _qp);
#endif
      return;
    }

    rnorm_prev = rnorm;
    rnorm = _residual_tensor.L2norm();

    if (_qp == 0)
    {
      std::cout << "Finally, the calculated residual error is " << rnorm << std::endl;
    }

    if (_use_line_search && rnorm > rnorm_prev && !lineSearchUpdate(rnorm_prev, dpk2))
    {
#ifdef DEBUG
      mooseWarning("CrystalPlasticityUpdate: Failed with line search");
#endif
      _error_tolerance = true;
      return;
    }

    if (_use_line_search)
      rnorm = _residual_tensor.L2norm();

    if (_qp == 0)
    {
      std::cout << "Concluding iteration number " << iter << std::endl;
      std::cout << "-----------------------------" << std::endl;
      std::cout << std::endl;
    }

    iter++;
  }

  if (iter >= _maxiter)
  {
#ifdef DEBUG
    mooseWarning("CrystalPlasticityUpdate: Stress Integration error rmax = ", rnorm);
#endif
    _error_tolerance = true;
  }
}

// Calculates stress residual equation and jacobian
void
CrystalPlasticityUpdate::calcResidJacob()
{
  calcResidual();
  if (_error_tolerance)
    return;
  calcJacobian();
}

void
CrystalPlasticityUpdate::calcResidual()
{
  RankTwoTensor identity, ce, elastic_strain, ce_pk2, equivalent_slip_increment, pk2_new;

  identity.zero();
  identity.addIa(1.0);

  // std::cout << "Alright obnoixous pk2, what are you here in calculateResidual? " << std::endl;
  // std::cout << "  pk2(0,0) " << _pk2[_qp](0,0) << std::endl;
  // std::cout << "  pk2(0,1) " << _pk2[_qp](0,1) << std::endl;
  // std::cout << "  pk2(0,2) " << _pk2[_qp](0,2) << std::endl;
  // std::cout << "  pk2(1,0) " << _pk2[_qp](1,0) << std::endl;
  // std::cout << "  pk2(1,1) " << _pk2[_qp](1,1) << std::endl;
  // std::cout << "  pk2(1,2) " << _pk2[_qp](1,2) << std::endl;
  // std::cout << "  pk2(2,0) " << _pk2[_qp](2,0) << std::endl;
  // std::cout << "  pk2(2,1) " << _pk2[_qp](2,1) << std::endl;
  // std::cout << "  pk2(2,2) " << _pk2[_qp](2,2) << std::endl;

  equivalent_slip_increment.zero();

  // for (unsigned int i = 0; i < _number_slip_systems; ++i)
  // {
  //   std::cout << "  Right before the call to the child class for slip system: " << i << std::endl;
  //   std::cout << "    the flow direction (0,0) is " << _flow_direction[_qp][i](0,0) << std::endl;
  //   std::cout << "    the flow direction (0,1) is " << _flow_direction[_qp][i](0,1) << std::endl;
  //   std::cout << "    the flow direction (0,2) is " << _flow_direction[_qp][i](0,2) << std::endl;
  //   std::cout << "    the flow direction (1,0) is " << _flow_direction[_qp][i](1,0) << std::endl;
  //   std::cout << "    the flow direction (1,1) is " << _flow_direction[_qp][i](1,1) << std::endl;
  //   std::cout << "    the flow direction (1,2) is " << _flow_direction[_qp][i](1,2) << std::endl;
  //   std::cout << "    the flow direction (2,0) is " << _flow_direction[_qp][i](2,0) << std::endl;
  //   std::cout << "    the flow direction (2,1) is " << _flow_direction[_qp][i](2,1) << std::endl;
  //   std::cout << "    the flow direction (2,2) is " << _flow_direction[_qp][i](2,2) << std::endl;
  // }

  // Call the overwritten method in the inheriting class that contains the constitutive model
  calculateConstitutiveEquivalentSlipIncrement(equivalent_slip_increment, _error_tolerance);

  if (_error_tolerance)
    return;

  equivalent_slip_increment = identity - equivalent_slip_increment;
  // if (_qp == 0)
  // {
  //   std::cout << "Inside of the calculate Residual method at qp " << _qp << std::endl;
  //   std::cout << "  equivalent_slip_increment (0,0) " << equivalent_slip_increment(0,0) << std::endl;
  //   std::cout << "  equivalent_slip_increment (0,1) " <<  equivalent_slip_increment(0,1) << std::endl;
  //   std::cout << "  equivalent_slip_increment (0,2) " <<  equivalent_slip_increment(0,2) << std::endl;
  //   std::cout << "  equivalent_slip_increment (1,0) " <<  equivalent_slip_increment(1,0) << std::endl;
  //   std::cout << "  equivalent_slip_increment (1,1) " <<  equivalent_slip_increment(1,1) << std::endl;
  //   std::cout << "  equivalent_slip_increment (1,2) " <<  equivalent_slip_increment(1,2) << std::endl;
  //   std::cout << "  equivalent_slip_increment (2,0) " <<  equivalent_slip_increment(2,0) << std::endl;
  //   std::cout << "  equivalent_slip_increment (2,1) " <<  equivalent_slip_increment(2,1) << std::endl;
  //   std::cout << "  equivalent_slip_increment (2,2) " <<  equivalent_slip_increment(2,2) << std::endl;
  //
  // }

  _inverse_plastic_deformation_grad = _inverse_plastic_deformation_grad_old * equivalent_slip_increment;

  // if (_qp == 0)
  // {
    // std::cout << "And the value of the old inverse plastic deformation gradient: " << std::endl;
    // std::cout << "  inverse plastic deformation gradient (0,0) " << _inverse_plastic_deformation_grad(0,0) << std::endl;
    // std::cout << "  inverse plastic deformation gradient (0,1) " << _inverse_plastic_deformation_grad(0,1) << std::endl;
    // std::cout << "  inverse plastic deformation gradient (0,2) " << _inverse_plastic_deformation_grad(0,2) << std::endl;
    // std::cout << "  inverse plastic deformation gradient (1,0) " << _inverse_plastic_deformation_grad(1,0) << std::endl;
    // std::cout << "  inverse plastic deformation gradient (1,1) " << _inverse_plastic_deformation_grad(1,1) << std::endl;
    // std::cout << "  inverse plastic deformation gradient (1,2) " << _inverse_plastic_deformation_grad(1,2) << std::endl;
    // std::cout << "  inverse plastic deformation gradient (2,0) " << _inverse_plastic_deformation_grad(2,0) << std::endl;
    // std::cout << "  inverse plastic deformation gradient (2,1) " << _inverse_plastic_deformation_grad(2,1) << std::endl;
    // std::cout << "  inverse plastic deformation gradient (2,2) " << _inverse_plastic_deformation_grad(2,2) << std::endl;
    // std::cout << std::endl;
  //   std::cout << "And the value of the temporary deformation gradient: " << std::endl;
  //   std::cout << "  temporary deformation gradient (0,0) " << _temporary_deformation_gradient(0,0) << std::endl;
  //   std::cout << "  temporary deformation gradient (0,1) " << _temporary_deformation_gradient(0,1) << std::endl;
  //   std::cout << "  temporary deformation gradient (0,2) " << _temporary_deformation_gradient(0,2) << std::endl;
  //   std::cout << "  temporary deformation gradient (1,0) " << _temporary_deformation_gradient(1,0) << std::endl;
  //   std::cout << "  temporary deformation gradient (1,1) " << _temporary_deformation_gradient(1,1) << std::endl;
  //   std::cout << "  temporary deformation gradient (1,2) " << _temporary_deformation_gradient(1,2) << std::endl;
  //   std::cout << "  temporary deformation gradient (2,0) " << _temporary_deformation_gradient(2,0) << std::endl;
  //   std::cout << "  temporary deformation gradient (2,1) " << _temporary_deformation_gradient(2,1) << std::endl;
  //   std::cout << "  temporary deformation gradient (2,2) " << _temporary_deformation_gradient(2,2) << std::endl;
  //   std::cout << std::endl;
  // }

  _elastic_deformation_gradient = _temporary_deformation_gradient * _inverse_plastic_deformation_grad;

  ce = _elastic_deformation_gradient.transpose() * _elastic_deformation_gradient;
  elastic_strain = ce - identity;
  elastic_strain *= 0.5;
  // if (_qp == 0)
  // {
  //   std::cout << "And the value of the green elastic deformation gradient: " << std::endl;
  //   std::cout << "  elastic gradient (0,0) " << elastic_strain(0,0) << std::endl;
  //   std::cout << "  elastic gradient (0,1) " << elastic_strain(0,1) << std::endl;
  //   std::cout << "  elastic gradient (0,2) " << elastic_strain(0,2) << std::endl;
  //   std::cout << "  elastic gradient (1,0) " << elastic_strain(1,0) << std::endl;
  //   std::cout << "  elastic gradient (1,1) " << elastic_strain(1,1) << std::endl;
  //   std::cout << "  elastic gradient (1,2) " << elastic_strain(1,2) << std::endl;
  //   std::cout << "  elastic gradient (2,0) " << elastic_strain(2,0) << std::endl;
  //   std::cout << "  elastic gradient (2,1) " << elastic_strain(2,1) << std::endl;
  //   std::cout << "  elastic gradient (2,2) " << elastic_strain(2,2) << std::endl;
  //   std::cout << "----------------------------------------------------- " << std::endl;
  //   std::cout << std::endl;
  // }

  pk2_new = _elasticity_tensor[_qp] * elastic_strain;

  _residual_tensor = _pk2[_qp] - pk2_new;

  // if (_qp == 0)
  // {
  //   std::cout << "PK2 new from the elastic strain: " << std::endl;
  //   std::cout << "  pk2_new(0,0) " << pk2_new(0,0) << std::endl;
  //   std::cout << "  pk2_new(0,1) " << pk2_new(0,1) << std::endl;
  //   std::cout << "  pk2_new(0,2) " << pk2_new(0,2) << std::endl;
  //   std::cout << "  pk2_new(1,0) " << pk2_new(1,0) << std::endl;
  //   std::cout << "  pk2_new(1,1) " << pk2_new(1,1) << std::endl;
  //   std::cout << "  pk2_new(1,2) " << pk2_new(1,2) << std::endl;
  //   std::cout << "  pk2_new(2,0) " << pk2_new(2,0) << std::endl;
  //   std::cout << "  pk2_new(2,1) " << pk2_new(2,1) << std::endl;
  //   std::cout << "  pk2_new(2,2) " << pk2_new(2,2) << std::endl;
  //   std::cout << std::endl;
  //
  //   std::cout << "so that the residual tensor calculated is:" << std::endl;
  //   std::cout << "  residual(0,0) " << _residual_tensor(0,0) << std::endl;
  //   std::cout << "  residual(0,1) " << _residual_tensor(0,1) << std::endl;
  //   std::cout << "  residual(0,2) " << _residual_tensor(0,2) << std::endl;
  //   std::cout << "  residual(1,0) " << _residual_tensor(1,0) << std::endl;
  //   std::cout << "  residual(1,1) " << _residual_tensor(1,1) << std::endl;
  //   std::cout << "  residual(1,2) " << _residual_tensor(1,2) << std::endl;
  //   std::cout << "  residual(2,0) " << _residual_tensor(2,0) << std::endl;
  //   std::cout << "  residual(2,1) " << _residual_tensor(2,1) << std::endl;
  //   std::cout << "  residual(2,2) " << _residual_tensor(2,2) << std::endl;
  //   std::cout << "-----------------------------------------" << std::endl;
  // }
}

void
CrystalPlasticityUpdate::calcJacobian()
{
  RankFourTensor dfedfpinv, deedfe, dfpinvdpk2;

  //Declare the vector, size nss, for the dslip_dtau
  std::vector<Real> dslip_dtau(_number_slip_systems, 0.0);

  for (unsigned int i = 0; i < LIBMESH_DIM; ++i)
    for (unsigned int j = 0; j < LIBMESH_DIM; ++j)
      for (unsigned int k = 0; k < LIBMESH_DIM; ++k)
        dfedfpinv(i,j,k,j) = _temporary_deformation_gradient(i,k);

  for (unsigned int i = 0; i < LIBMESH_DIM; ++i)
    for (unsigned int j = 0; j < LIBMESH_DIM; ++j)
      for (unsigned int k = 0; k < LIBMESH_DIM; ++k)
      {
        deedfe(i,j,k,i) = deedfe(i,j,k,i) + _elastic_deformation_gradient(k,j) * 0.5;
        deedfe(i,j,k,j) = deedfe(i,j,k,j) + _elastic_deformation_gradient(k,i) * 0.5;
      }

  // Call the overwritten method in the inheriting class for the constitutive model specifics
  calculateConstitutiveSlipDerivative(dslip_dtau);

  std::vector<RankTwoTensor> dtaudpk2(_number_slip_systems);
  std::vector<RankTwoTensor> dfpinvdslip(_number_slip_systems);

  // if (_qp == 0)
  //   std::cout << "In the calculate Jacobian bit " << std::endl;

  for (unsigned int j = 0; j < _number_slip_systems; ++j)
  {
    dtaudpk2[j] = _flow_direction[_qp][j];
    dfpinvdslip[j] = - _inverse_plastic_deformation_grad_old * _flow_direction[_qp][j];
    dfpinvdpk2 += (dfpinvdslip[j] * dslip_dtau[j] * _substep_dt).outerProduct(dtaudpk2[j]);
    // if (_qp == 0)
    // {
    //   std::cout << "On the slip system " << j << " the value of the slip derivative wrt to tau is " << dslip_dtau[j] << std::endl;
    // }
  }

  _jacobian = RankFourTensor::IdentityFour() - (_elasticity_tensor[_qp] * deedfe * dfedfpinv * dfpinvdpk2);
}

void
CrystalPlasticityUpdate::calcTangentModuli(RankFourTensor & jacobian_mult)
{
  switch (_tan_mod_type)
  {
    case 0:
      elastoPlasticTangentModuli(jacobian_mult);
      break;
    default:
     elasticTangentModuli(jacobian_mult);
 }
}

void
CrystalPlasticityUpdate::elastoPlasticTangentModuli(RankFourTensor & jacobian_mult)
{
  RankFourTensor tan_mod;
  RankTwoTensor pk2fet, fepk2;
  RankFourTensor deedfe, dsigdpk2dfe, dfedf;

  // Fill in the matrix stiffness material property
  for (unsigned int i = 0; i < LIBMESH_DIM; ++i)
    for (unsigned int j = 0; j < LIBMESH_DIM; ++j)
      for (unsigned int k = 0; k < LIBMESH_DIM; ++k)
      {
        deedfe(i,j,k,i) = deedfe(i,j,k,i) + _elastic_deformation_gradient(k,j) * 0.5;
        deedfe(i,j,k,j) = deedfe(i,j,k,j) + _elastic_deformation_gradient(k,i) * 0.5;
      }

  dsigdpk2dfe = _elastic_deformation_gradient.mixedProductIkJl(_elastic_deformation_gradient) * _elasticity_tensor[_qp] * deedfe;

  pk2fet = _pk2[_qp] * _elastic_deformation_gradient.transpose();
  fepk2 = _elastic_deformation_gradient * _pk2[_qp];

  for (unsigned int i = 0; i < LIBMESH_DIM; ++i)
    for (unsigned int j = 0; j < LIBMESH_DIM; ++j)
      for (unsigned int l = 0; l < LIBMESH_DIM; ++l)
      {
        tan_mod(i,j,i,l) += pk2fet(l,j);
        tan_mod(i,j,j,l) += fepk2(i,l);
      }

  tan_mod += dsigdpk2dfe;

  Real je = _elastic_deformation_gradient.det();
  if (je > 0.0)
    tan_mod /= je;

  for (unsigned int i = 0; i < LIBMESH_DIM; ++i)
    for (unsigned int j = 0; j < LIBMESH_DIM; ++j)
      for (unsigned int l = 0; l < LIBMESH_DIM; ++l)
        dfedf(i,j,i,l) =  _inverse_plastic_deformation_grad(l,j);


  jacobian_mult = tan_mod * dfedf;
}

void
CrystalPlasticityUpdate::elasticTangentModuli(RankFourTensor & jacobian_mult)
{
  // update jacobian_mult
  jacobian_mult = _elasticity_tensor[_qp];
}

bool
CrystalPlasticityUpdate::lineSearchUpdate(const Real rnorm_prev, const RankTwoTensor dpk2)
{
  switch (_line_search_method)
  {
    case 0: // CUT_HALF
    {
      Real rnorm;
      Real step = 1.0;

      do
      {
        _pk2[_qp] = _pk2[_qp] - step * dpk2;
        step /= 2.0;
        _pk2[_qp] = _pk2[_qp] + step * dpk2;

        calcResidual();
        rnorm = _residual_tensor.L2norm();
      }
      while (rnorm > rnorm_prev && step > _min_line_search_step_size);

      // has norm improved or is the step still above minumum search step size?
      return (rnorm <= rnorm_prev || step > _min_line_search_step_size);
    }

    case 1: // BISECTION
    {
      unsigned int count = 0;
      Real step_a = 0.0;
      Real step_b = 1.0;
      Real step = 1.0;
      Real s_m = 1000.0;
      Real rnorm = 1000.0;

      calcResidual();
      Real s_b = _residual_tensor.doubleContraction(dpk2);
      Real rnorm1 = _residual_tensor.L2norm();
      _pk2[_qp] = _pk2[_qp] - dpk2;
      calcResidual();
      Real s_a = _residual_tensor.doubleContraction(dpk2);
      Real rnorm0 = _residual_tensor.L2norm();
      _pk2[_qp] = _pk2[_qp] + dpk2;

      if ((rnorm1/rnorm0) < _line_search_tolerance || s_a*s_b > 0)
      {
        calcResidual();
        return true;
      }

      while ((rnorm/rnorm0) > _line_search_tolerance && count < _line_search_max_iterations)
      {
        _pk2[_qp] = _pk2[_qp] - step*dpk2;
        step = 0.5 * (step_b + step_a);
        _pk2[_qp] = _pk2[_qp] + step*dpk2;
        calcResidual();
        s_m = _residual_tensor.doubleContraction(dpk2);
        rnorm = _residual_tensor.L2norm();

        if (s_m*s_a < 0.0)
        {
          step_b = step;
          s_b = s_m;
        }
        if (s_m*s_b < 0.0)
        {
          step_a = step;
          s_a = s_m;
        }
        count++;
      }

      // below tolerance and max iterations?
      return  ((rnorm/rnorm0) < _line_search_tolerance && count < _line_search_max_iterations);
    }

    default:
      mooseError("Line search method is not provided.");
  }
}

void
CrystalPlasticityUpdate::calculateFlowDirection()
{
  DenseVector<Real> slip_direction(LIBMESH_DIM*_number_slip_systems), slip_plane_normal(LIBMESH_DIM*_number_slip_systems);

  // Update slip direction and normal with crystal orientation
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    for (unsigned int j = 0; j < LIBMESH_DIM; ++j)
    {
      slip_direction(i*LIBMESH_DIM+j) = 0.0;
      for (unsigned int k = 0; k < LIBMESH_DIM; ++k)
        slip_direction(i*LIBMESH_DIM+j) = slip_direction(i*LIBMESH_DIM+j) + _crysrot[_qp](j,k) * _slip_direction(i*LIBMESH_DIM+k);
    }

    for (unsigned int j = 0; j < LIBMESH_DIM; ++j)
    {
      slip_plane_normal(i*LIBMESH_DIM+j) = 0.0;
      for (unsigned int k = 0; k < LIBMESH_DIM; ++k)
        slip_plane_normal(i*LIBMESH_DIM+j) = slip_plane_normal(i*LIBMESH_DIM+j) + _crysrot[_qp](j,k) * _slip_plane_normal(i*LIBMESH_DIM+k);
    }
  }

  // Calculate Schmid tensor and resolved shear stresses
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    for (unsigned int j = 0; j < LIBMESH_DIM; ++j)
      for (unsigned int k = 0; k < LIBMESH_DIM; ++k)
        _flow_direction[_qp][i](j,k) = slip_direction(i*LIBMESH_DIM+j) * slip_plane_normal(i*LIBMESH_DIM+k);
  }

}

void
CrystalPlasticityUpdate::getSlipSystems()
{
  Real vec[LIBMESH_DIM];
  std::ifstream fileslipsys;

  MooseUtils::checkFileReadable(_slip_sys_file_name);

  fileslipsys.open(_slip_sys_file_name.c_str());

  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    // Read the slip normal
    for (unsigned int j = 0; j < LIBMESH_DIM; ++j)
      if (!(fileslipsys >> vec[j]))
        mooseError("CrystalPlasticitySlipRate Error: Premature end of file reading slip system file \n");

    // Normalize the vectors
    Real mag;
    mag = Utility::pow<2>(vec[0]) + Utility::pow<2>(vec[1]) + Utility::pow<2>(vec[2]);
    mag = std::sqrt(mag);

    for (unsigned j = 0; j < LIBMESH_DIM; ++j)
      _slip_plane_normal(i * LIBMESH_DIM + j) = vec[j] / mag;

    // Read the slip direction
    for (unsigned int j = 0; j < LIBMESH_DIM; ++j)
      if (!(fileslipsys >> vec[j]))
        mooseError("CrystalPlasticitySlipRate Error: Premature end of file reading slip system file \n");

    // Normalize the vectors
    mag = Utility::pow<2>(vec[0]) + Utility::pow<2>(vec[1]) + Utility::pow<2>(vec[2]);
    mag = std::sqrt(mag);

    for (unsigned int j = 0; j < LIBMESH_DIM; ++j)
      _slip_direction(i * LIBMESH_DIM + j) = vec[j] / mag;

    mag = 0.0;
    for (unsigned int j = 0; j < LIBMESH_DIM; ++j)
      mag += _slip_direction(i * LIBMESH_DIM + j) * _slip_plane_normal(i * LIBMESH_DIM + j);

    if (std::abs(mag) > 1e-8)
      mooseError("CrystalPlasticitySlipRate Error: Slip direction and normal not orthonormal, System number = ", i, "\n");
  }

  fileslipsys.close();
}

void
CrystalPlasticityUpdate::setQp(unsigned int qp)
{
  _qp = qp;
}
