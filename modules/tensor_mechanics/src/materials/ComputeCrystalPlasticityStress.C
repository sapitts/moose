/****************************************************************/
/* MOOSE - Multiphysics Object Oriented Simulation Environment  */
/*                                                              */
/*          All contents are licensed under LGPL V2.1           */
/*             See LICENSE for full restrictions                */
/****************************************************************/
#include "ComputeCrystalPlasticityStress.h"
#include "CrystalPlasticityUpdate.h"

template<>
InputParameters validParams<ComputeCrystalPlasticityStress>()
{
  InputParameters params = validParams<ComputeFiniteStrainElasticStress>();
  params.addClassDescription("Compute stress using a crystal plasticity consitutive relation");
  // params.addParam<unsigned int>("max_iterations", 30, "Maximum number of the stress update iterations over the stress change after all update materials are called");
  // params.addParam<Real>("relative_tolerance", 1e-5, "Relative convergence tolerance for the stress update iterations over the stress change after all update materials are called");
  // params.addParam<Real>("absolute_tolerance", 1e-5, "Absolute convergence tolerance for the stress update iterations over the stress change after all update materials are called");
  // params.addParam<bool>("output_iteration_info", false, "Set to true to output stress update iteration information over the stress change");
  params.addRequiredParam<MaterialName>("crystal_plasticity_update_model", "The stress update crystal plasticity material objects to use to calculate stress.");
  return params;
}

ComputeCrystalPlasticityStress::ComputeCrystalPlasticityStress(const InputParameters & parameters) :
    ComputeFiniteStrainElasticStress(parameters),
//    _max_its(parameters.get<unsigned int>("max_iterations")),
//    _relative_tolerance(parameters.get<Real>("relative_tolerance")),
//    _absolute_tolerance(parameters.get<Real>("absolute_tolerance")),
//    _output_iteration_info(getParam<bool>("output_iteration_info")),
    _elasticity_tensor(getMaterialPropertyByName<RankFourTensor>(_base_name + "elasticity_tensor"))
//    _elastic_strain_old(declarePropertyOld<RankTwoTensor>(_base_name + "elastic_strain")),
//    _strain_increment(getMaterialProperty<RankTwoTensor>(_base_name + "strain_increment")),
//    _model_name(getParam<MaterialName>("crystal_plasticity_update_model"))
{
}

void
ComputeCrystalPlasticityStress::initialSetup()
{
  MaterialName model_name = getParam<MaterialName>("crystal_plasticity_update_model");
  CrystalPlasticityUpdate * xtapl_model = dynamic_cast<CrystalPlasticityUpdate *>(&getMaterialByName(model_name));
    if (xtapl_model)
      _model = xtapl_model;
    else
      mooseError("Model " + model_name + " is not compatible with ComputeCrystalPlasticityStress");
}

void
ComputeCrystalPlasticityStress::computeQpStress()
{
  // Nothing to update during the first time step
  // ComputeQpStress is not called during the zeroth time step, so no need to guard against _t_step == 0

  RankTwoTensor stress_new;
  RankFourTensor jacobian_mult;

  _model->setQp(_qp);
  _model->updateStress(stress_new, jacobian_mult);

  if (_qp == 0)
    std::cout << "Then in the compute stress class, stress new is " << stress_new(0,0) << std::endl;
  _elastic_strain[_qp].zero();
  //  _mechanical_strain[_qp] = mechanical_strain_new; //Can not update the mechanical strain in a computeStressBase class
  _stress[_qp] = stress_new;

  //Compute dstress_dstrain
  _Jacobian_mult[_qp] = jacobian_mult; //This is NOT the exact jacobian
}

// void
// ComputeCrystalPlasticityStress::updateQpStress(RankTwoTensor & strain_increment,
//                                           RankTwoTensor & stress_new)
// {
//   if (_output_iteration_info == true)
//   {
//     _console
//       << std::endl
//       << "iteration output for ComputeCrystalPlasticityStress solve:"
//       << " time=" <<_t
//       << " int_pt=" << _qp
//       << std::endl;
//   }
//
//   RankTwoTensor elastic_strain_increment;
//
//   Real l2norm_delta_stress, first_l2norm_delta_stress;
//   unsigned int counter = 0;
//
//   std::vector<RankTwoTensor> inelastic_strain_increment;
//   inelastic_strain_increment.resize(_models.size());
//
//   for (unsigned i_rmm = 0; i_rmm < _models.size(); ++i_rmm)
//     inelastic_strain_increment[i_rmm].zero();
//
//   RankTwoTensor stress_max, stress_min;
//
//   do
//   {
//     for (unsigned i_rmm = 0; i_rmm < _models.size(); ++i_rmm)
//     {
//       _models[i_rmm]->setQp(_qp);
//
//       elastic_strain_increment = strain_increment;
//
//       for (unsigned j_rmm = 0; j_rmm < _models.size(); ++j_rmm)
//         if (i_rmm != j_rmm)
//           elastic_strain_increment -= inelastic_strain_increment[j_rmm];
//
//       stress_new = _elasticity_tensor[_qp] * (elastic_strain_increment + _elastic_strain_old[_qp]);
//
//       _models[i_rmm]->updateStress(elastic_strain_increment,
//                                    inelastic_strain_increment[i_rmm],
//                                    stress_new);
// }
