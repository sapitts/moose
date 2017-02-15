/****************************************************************/
/* MOOSE - Multiphysics Object Oriented Simulation Environment  */
/*                                                              */
/*          All contents are licensed under LGPL V2.1           */
/*             See LICENSE for full restrictions                */
/****************************************************************/
#include "CrystalPlasticityCDDUpdate.h"

template<>
InputParameters validParams<CrystalPlasticityCDDUpdate>()
{
  InputParameters params = validParams<CrystalPlasticityUpdate>();
  params.addClassDescription("Continuum Dislocation Dynamics model for crystal plasticity, relating mobile dislocations to slip through Orowan's law.");
  params.addParam<Real>("burgers_vector", 2.5e-7, "The Burger's vector for the material, in mm");
  params.addParam<Real>("initial_mobile_dislocation_density", 1.0e6, "Initial density of mobile dislocation densities, in 1/mm^2");
  params.addParam<Real>("initial_immobile_dislocation_density", 1.0e6, "Initial density of immobile dislocation densities, in 1/mm^2");
  params.addParam<Real>("gamma_o", 1.0, "reference strain rate on the slip system, in mm/s");
  params.addParam<Real>("strain_rate_sensitivity_exponent", 0.012, "The strain rate sensitivity exponent for the power law relationship of resolved shear stress");
  params.addParam<Real>("Peierls_stress", 11.0, "Internal friction strength for the individual slip system, in MPa");
  params.addParam<Real>("Baily_Hirsch_barrier_coefficient", 0.4, "Leading coefficient for the Baily-Hirsch dispersed barrier harding model");
  params.addParam<Real>("alpha_1", 0.02, "Mobile dislocation multiplication coefficient");
  params.addParam<Real>("alpha_2", 1.0, "Mobile-mobile dislocation annhiliation coefficient");
  params.addParam<Real>("alpha_3", 0.002, "Immobilization of mobile dislocations coefficient: mobile dislocations becoming immobile");
  params.addParam<Real>("alpha_4", 0.002, "Mobilization of immobile dislocations coefficient: immobile dislocations becoming mobile due to higher stress");
  params.addParam<Real>("alpha_5", 0.018, "Cross-slip coefficient");
  params.addParam<Real>("alpha_6", 1.0, "Mobile-immobile dislocation annhiliaton coefficient");
  params.addParam<Real>("radius_capture_annhiliation", 15.0, "Multiplier of the Burger's vector to determine the radius of capture for two annhiliating dislocations on the same slip plane");

  return params;
}

CrystalPlasticityCDDUpdate::CrystalPlasticityCDDUpdate(const InputParameters & parameters) :
    CrystalPlasticityUpdate(parameters),
    _mobile_dislocations(declareProperty<std::vector<Real> > ("mobile_dislocations")),
    _mobile_dislocations_old(declarePropertyOld<std::vector<Real> > ("mobile_dislocations")),
    _immobile_dislocations(declareProperty<std::vector<Real> > ("immobile_dislocations")),
    _immobile_dislocations_old(declarePropertyOld<std::vector<Real> > ("immobile_dislocations")),
    _slip_system_resistance(declareProperty<std::vector<Real> >("slip_system_resistance")),
    _slip_system_resistance_old(declarePropertyOld<std::vector<Real> >("slip_system_resistance")),
    _slip_increment(declareProperty<std::vector<Real> >("plastic_slip_increment")),

    //Save off the the values of the state variables from the previous increment (before the values are old)
    _previous_it_mobile(declareProperty<std::vector<Real> >("previous_iteration_mobile_dislocations")),
    _previous_it_immobile(declareProperty<std::vector<Real> >("previous_iteration_immobile_dislocations")),
    _previous_it_resistance(declareProperty<std::vector<Real> >("previous_interation_slip_system_resistance")),
//    _slip_increment_old(declarePropertyOld<std::vector<Real> >("plastic_slip_increment")),

    // Dislocation driving force values
    _tau(declareProperty<std::vector<Real> >("applied_shear_stress")),
    _glide_velocity(declareProperty<std::vector<Real> >("dislocation_glide_velocity")),
    _burgers_vector(getParam<Real>("burgers_vector")),
    _initial_mobile_dislocation_density(getParam<Real>("initial_mobile_dislocation_density")),
    _initial_immobile_dislocation_density(getParam<Real>("initial_immobile_dislocation_density")),
    _gamma_reference(getParam<Real>("gamma_o")),
    _m_exp(getParam<Real>("strain_rate_sensitivity_exponent")),
    _peierls_strength(getParam<Real>("Peierls_stress")),

    // CDD specific parameters
    _baily_hirsch_alpha(getParam<Real>("Baily_Hirsch_barrier_coefficient")),
    _alpha_1(getParam<Real>("alpha_1")),
    _alpha_2(getParam<Real>("alpha_2")),
    _alpha_3(getParam<Real>("alpha_3")),
    _alpha_4(getParam<Real>("alpha_4")),
    _alpha_5(getParam<Real>("alpha_5")),
    _alpha_6(getParam<Real>("alpha_6")),
    _radius_capture(getParam<Real>("radius_capture_annhiliation")),
    _inital_glide_velocity(4.0e-2)//_gamma_reference / (_burgers_vector * _initial_mobile_dislocation_density))
{
}

void
CrystalPlasticityCDDUpdate::initQpStatefulProperties()
{
  _mobile_dislocations[_qp].resize(_number_slip_systems);
  _mobile_dislocations_old[_qp].resize(_number_slip_systems);
  _immobile_dislocations[_qp].resize(_number_slip_systems);
  _immobile_dislocations_old[_qp].resize(_number_slip_systems);
  _slip_system_resistance[_qp].resize(_number_slip_systems);
  _slip_system_resistance_old[_qp].resize(_number_slip_systems);

  _slip_increment[_qp].resize(_number_slip_systems);
  _tau[_qp].resize(_number_slip_systems);
  _glide_velocity[_qp].resize(_number_slip_systems);

  //Then loop over the slip systems and set the initial values for all the Reals
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    _mobile_dislocations[_qp][i] = _initial_mobile_dislocation_density / _number_slip_systems;
    _mobile_dislocations_old[_qp][i] = _initial_mobile_dislocation_density / _number_slip_systems;
    _immobile_dislocations[_qp][i] = _initial_immobile_dislocation_density / _number_slip_systems;
    _immobile_dislocations_old[_qp][i] = _initial_immobile_dislocation_density / _number_slip_systems;
    _slip_system_resistance[_qp][i] = _peierls_strength;
    _slip_system_resistance_old[_qp][i] = _peierls_strength;

    _slip_increment[_qp][i] = 0.0;
    _tau[_qp][i] = 0.0;
    _glide_velocity[_qp][i] = 0.0;
  }

  CrystalPlasticityUpdate::initQpStatefulProperties();
}

void
CrystalPlasticityCDDUpdate::setInitialConstitutiveVariableValues()
{
  //Use this method to set the current values to the old values.
  bool fake_error = false;
  calculateSlipSystemResistance(fake_error);


  // _slip_system_resistance[_qp] = _slip_system_resistance_old[_qp];
  _mobile_dislocations[_qp] = _mobile_dislocations_old[_qp];
  _immobile_dislocations[_qp] = _immobile_dislocations_old[_qp];
}

void
CrystalPlasticityCDDUpdate::calculateConstitutiveEquivalentSlipIncrement(RankTwoTensor & equivalent_slip_increment,
                                                                         bool & error_tolerance)
{
  equivalent_slip_increment.zero();

  // Save off the values from the previous increment:
//  _previous_it_slip_increment[_qp] = _slip_increment[_qp];
  _previous_it_mobile[_qp] = _mobile_dislocations[_qp];
  _previous_it_immobile[_qp] = _immobile_dislocations[_qp];

  if (_error_tolerance)
    return;

  // std::cout << "Alright obnoixous pk2, what are you here in computeSlipIncrement? " << std::endl;
  // std::cout << "  pk2(0,0) " << _pk2[_qp](0,0) << std::endl;
  // std::cout << "  pk2(0,1) " << _pk2[_qp](0,1) << std::endl;
  // std::cout << "  pk2(0,2) " << _pk2[_qp](0,2) << std::endl;
  // std::cout << "  pk2(1,0) " << _pk2[_qp](1,0) << std::endl;
  // std::cout << "  pk2(1,1) " << _pk2[_qp](1,1) << std::endl;
  // std::cout << "  pk2(1,2) " << _pk2[_qp](1,2) << std::endl;
  // std::cout << "  pk2(2,0) " << _pk2[_qp](2,0) << std::endl;
  // std::cout << "  pk2(2,1) " << _pk2[_qp](2,1) << std::endl;
  // std::cout << "  pk2(2,2) " << _pk2[_qp](2,2) << std::endl;

  // Calculate the dislocation glide velocity term for each of the slip systems
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    // std::cout << "  Within the calculation of the applied shear stress for slip system: " << i << std::endl;
    // std::cout << "    the flow direction (0,0) is " << _flow_direction[_qp][i](0,0) << std::endl;
    // std::cout << "    the flow direction (0,1) is " << _flow_direction[_qp][i](0,1) << std::endl;
    // std::cout << "    the flow direction (0,2) is " << _flow_direction[_qp][i](0,2) << std::endl;
    // std::cout << "    the flow direction (1,0) is " << _flow_direction[_qp][i](1,0) << std::endl;
    // std::cout << "    the flow direction (1,1) is " << _flow_direction[_qp][i](1,1) << std::endl;
    // std::cout << "    the flow direction (1,2) is " << _flow_direction[_qp][i](1,2) << std::endl;
    // std::cout << "    the flow direction (2,0) is " << _flow_direction[_qp][i](2,0) << std::endl;
    // std::cout << "    the flow direction (2,1) is " << _flow_direction[_qp][i](2,1) << std::endl;
    // std::cout << "    the flow direction (2,2) is " << _flow_direction[_qp][i](2,2) << std::endl;
    _tau[_qp][i] = _pk2[_qp].doubleContraction(_flow_direction[_qp][i]);

    if (_qp == 0)
      std::cout << "  then the calculated tau on slip system " << i << " is " << _tau[_qp][i] << std::endl;

    if ( std::abs(_tau[_qp][i] / _peierls_strength ) >= 1.0 )
    {
      Real driving_force = std::abs(_tau[_qp][i] / _slip_system_resistance[_qp][i]);
      _glide_velocity[_qp][i] = _inital_glide_velocity * std::pow(driving_force, 1.0 / _m_exp);
      if (_tau[_qp][i] < 0.0)
        _glide_velocity[_qp][i] *= -1.0;  //only need to change the sign(_tau[_qp]) if _tau[_qp] is negative

      // std::cout << "  the slip system resistance is " << _slip_system_resistance[_qp][i] << std::endl;
      // std::cout << "  the driving force value is " << driving_force << std::endl;
      // std::cout << "  the initial glide velocity is " << _inital_glide_velocity << std::endl;
      // std::cout << "  the power law exponent " << _m_exp << std::endl;
      // std::cout << "  the glide velocity is " << _glide_velocity[_qp][i] << std::endl;
    }

    // std::cout << "  then the dislocation glide velocity on slip system " << i << " is " << _glide_velocity[_qp][i] << std::endl;
  }

  // Calculate the slip increment on each slip system
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    _slip_increment[_qp][i] = _mobile_dislocations[_qp][i] * _burgers_vector * _glide_velocity[_qp][i] *_substep_dt;  //Erin multiplied this by dt

    if (std::abs(_slip_increment[_qp][i]) > _slip_incr_tol)
    {
#ifdef DEBUG
      mooseWarning("Maximum allowable slip increment exceeded on slip system ", i, " with a value of ", std::abs(_slip_increment[_qp][i]));
#endif
      error_tolerance = true;
      return;
    }
  }

  // Sum up the slip increments to find the equivalent plastic strain due to slip
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    equivalent_slip_increment += _flow_direction[_qp][i] * _slip_increment[_qp][i] * _substep_dt;
    // if (_qp == 0)
    // {
    //   std::cout << "The slip increment (rate * time ) on slip system " << i << " is " << _slip_increment[_qp][i] * _substep_dt << std::endl;
    // }
  }

  error_tolerance = false;
}

void
CrystalPlasticityCDDUpdate::calculateConstitutiveSlipDerivative(std::vector<Real> & dslip_dtau)
{
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    if (MooseUtils::absoluteFuzzyEqual(_tau[_qp][i], 0.0))
      dslip_dtau[i] = 0.0;
    else
    {
      const Real velocity_derivative = _glide_velocity[_qp][i] / (_m_exp * _tau[_qp][i]);
      dslip_dtau[i] = _mobile_dislocations[_qp][i] * _burgers_vector * velocity_derivative * _substep_dt;
    }

    // if (_qp == 0)
    //   std::cout << "  the derivative of the slip increment on slip system " << i << " is " << dslip_dtau[i] << std::endl;
  }
}

void
CrystalPlasticityCDDUpdate::updateConstitutiveSlipSystemResistanceAndVariables(bool & error_tolerance)
{
  // Set the previous value of the slip system resistance here for comparison in the convergence check
  _previous_it_resistance[_qp] = _slip_system_resistance[_qp];
  _previous_it_mobile[_qp] = _mobile_dislocations[_qp];
  _previous_it_immobile[_qp] = _immobile_dislocations[_qp];

  calculateDislocationDensities(error_tolerance);
  if (error_tolerance)
    return;

  calculateSlipSystemResistance(error_tolerance);
  // if (error_tolerance)
  //   return;
}

bool
CrystalPlasticityCDDUpdate::areConstitutiveStateVariablesConverged()
{
  Real mobile_diff, immobile_diff = 0.0;

  // Will have to run through twice:  once for each type of state variable because I've hardcoded them
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    // Calculate the change in the state variables over the two iterations
    mobile_diff = std::abs(_previous_it_mobile[_qp][i] - _mobile_dislocations[_qp][i]);
    immobile_diff = std::abs(_previous_it_immobile[_qp][i] - _immobile_dislocations[_qp][i]);

    // Set the iteration flag to rerun if the old value is pretty much zero and if the difference from iterations is above tolerance
    if ((std::abs(_mobile_dislocations_old[_qp][i])) < _zero_tol)
    {
      if (mobile_diff > _zero_tol)
      {
        std::cout << "Hit the zero old mobile dislocations and too big mobile diff" << std::endl;
        return true;
      }
    }
    else
      if (mobile_diff > _rel_state_var_tol * std::abs(_mobile_dislocations_old[_qp][i]))
      {
        std::cout << "Hit the non zero old mobile dislocations and mobile diff too large compared to old" << std::endl;
        return true;
      }

    if (std::abs(_immobile_dislocations_old[_qp][i]) < _zero_tol)
    {
      if (immobile_diff > _zero_tol)
      {
        std::cout << "Hit the zero old immobile dislocations and the non zero immobile diff" << std::endl;
        return true;
      }
    }
    else
    {
      if (immobile_diff > _rel_state_var_tol * std::abs(_immobile_dislocations_old[_qp][i]))
      {
        std::cout << "Hit the non zero old immobile dislocations and the too large immobile diff " << std::endl;
        return true;
      }
    }
  }

  // Check slip system convergence; could be it's own method
  Real resistance_diff = 0.0;
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    resistance_diff = std::abs(_previous_it_resistance[_qp][i] - _slip_system_resistance[_qp][i]);
    if (resistance_diff > _resistance_tol) //_zero_tol)
    {
      std::cout << " The value of the slip resistance on slip system " << i << " is greater than the tolerance and is " << resistance_diff << std::endl;
      return true;
    }
  }

  // If make it here, everything converged nicely
  std::cout << "all the state variables converged nicely - good job! " << std::endl;
  return false;
}


void
CrystalPlasticityCDDUpdate::calculateSlipSystemResistance(bool & error_tolerance)
{
  // Use hard coded shear modulus and Omega matrix for now
  const Real barrier_coeffient = _baily_hirsch_alpha * _burgers_vector * 80.0e3 * 0.1;
  Real strength_dislocations, sum_dislocations = 0.0;
  for (unsigned int j = 0; j < _number_slip_systems; ++j)
    sum_dislocations += _immobile_dislocations[_qp][j] + _mobile_dislocations[_qp][j];

  strength_dislocations = std::sqrt(sum_dislocations) * barrier_coeffient;

  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
//    _slip_system_resistance[_qp][i] = _peierls_strength;
    _slip_system_resistance[_qp][i] = _peierls_strength + strength_dislocations;

    if (_qp == 0)
      std::cout << "In the calculate slip system method, the slip system strength for system " << i << " is " << _slip_system_resistance[_qp][i] << std::endl;
  }

  // Will also need to add in a method to calculate the slip system strength due to irradiation
  // use as an inheriting class

  // std::cout << "Now evaluating the update-ability of the resistance" << std::endl;
  //Now perform the check to see if the slip system should be updated
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    if (_slip_system_resistance_old[_qp][i] < _zero_tol && _slip_system_resistance[_qp][i] < 0.0)
    {
      _slip_system_resistance[_qp][i] = _slip_system_resistance_old[_qp][i];
      std::cout << "  in slip system " << i << " and the value of the old value / increment is too small to update" << std::endl;
    }

    if (_slip_system_resistance[_qp][i] < 0.0)
      error_tolerance = true;
  }
}

void
CrystalPlasticityCDDUpdate::calculateDislocationDensities(bool & error_tolerance)
{
  std::vector<Real> increment_mobile(_number_slip_systems, 0.0);
  std::vector<Real> increment_immobile(_number_slip_systems, 0.0);

  // Calculate the mean free glide path for dislocation motion on each slip system
  Real glide_path_inv = 0.0;
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
    glide_path_inv += _mobile_dislocations[_qp][i] + _immobile_dislocations[_qp][i];

  glide_path_inv = std::sqrt(std::abs(glide_path_inv));
  std::cout << "  the inverse mean free glide path is " << glide_path_inv << std::endl;

  //Calculate terms of the dislocation evolution for each slip system -> probably want to change from using the old value here
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    const Real term1 = _alpha_1 * _mobile_dislocations[_qp][i] * std::abs(_glide_velocity[_qp][i]) * glide_path_inv;

    const Real term2_mobile_sq = _mobile_dislocations[_qp][i] * _mobile_dislocations[_qp][i] * std::abs(_glide_velocity[_qp][i]);
    const Real term2 = 2.0 * _alpha_2 * _radius_capture * _burgers_vector * term2_mobile_sq;
    const Real term3 = _alpha_3 * _mobile_dislocations[_qp][i] * std::abs(_glide_velocity[_qp][i]) * glide_path_inv;

    const Real term4_force = std::sqrt(std::abs(_tau[_qp][i] / _slip_system_resistance[_qp][i]));
    const Real term4 = _alpha_4 * term4_force * _immobile_dislocations[_qp][i] * std::abs(_glide_velocity[_qp][i]) * glide_path_inv;

    // const Real term5 = cross slip is hard
    const Real term6 = _alpha_6 * _radius_capture * _burgers_vector * _mobile_dislocations[_qp][i] * _immobile_dislocations[_qp][i] * std::abs(_glide_velocity[_qp][i]);

    std::cout << "The current slip system is " << i << std::endl;
    std::cout << "  term 1 " << term1 << std::endl;
    std::cout << "  term 2 " << term2 << std::endl;
    std::cout << "  term 3 " << term3 << std::endl;
    std::cout << "  term 4 " << term4 << std::endl;
    std::cout << "  term 6 " << term6 << std::endl;


//put the increment here, then run the tolerance check and update in a separate loop
    increment_mobile[i] = (term1 - term2 - term3 + term4 - term6) * _substep_dt;
    increment_immobile[i] = (term3 - term6) * _substep_dt;

    std::cout << "for the slip system number " << i << std::endl;
    std::cout << "  the mobile dislocation increment is " << increment_mobile[i] << std::endl;
    std::cout << "  the immobile dislocation increment is " << increment_immobile[i] << std::endl;
  }

  std::cout << "Now evaluating the update-ability of the dislocations" << std::endl;


  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    if (_mobile_dislocations_old[_qp][i] < _zero_tol && increment_mobile[i] < 0.0)
    {
      _mobile_dislocations[_qp][i] = _mobile_dislocations_old[_qp][i];
      std::cout << "  in slip system " << i << " and the value of the mobile dislocations old value / increment is too small to update" << std::endl;
    }
    else
    {
      if (_qp == 0)
      {
        std::cout << "  on slip system " << i << " and the mobile dislocations increment is " << increment_mobile[i] << std::endl;
        std::cout << "    and the old mobile dislocations value is " << _mobile_dislocations_old[_qp][i] << std::endl;
      }
      _mobile_dislocations[_qp][i] = increment_mobile[i] + _mobile_dislocations_old[_qp][i];
      if (_qp == 0)
        std::cout << "  and the value of the mobile dislocations is updated to " << _mobile_dislocations[_qp][i] << std::endl;
    }

    if (_immobile_dislocations_old[_qp][i] < _zero_tol && increment_immobile[i] < 0.0)
    {
      _immobile_dislocations[_qp][i] = _immobile_dislocations_old[_qp][i];
      std::cout << "  in slip system " << i << " and the value of the immobile dislocations old value / increment is too small to update" << std::endl;
    }
    else
    {
      if (_qp == 0)
      {
        std::cout << "  on slip system " << i << " and the immobile dislocations increment is " << increment_immobile[i] << std::endl;
        std::cout << "    and the old immobile value is " << _immobile_dislocations_old[_qp][i] << std::endl;
      }
      _immobile_dislocations[_qp][i] = increment_immobile[i] + _immobile_dislocations_old[_qp][i];
      if (_qp == 0)
        std::cout << "  and the value of the immobile dislocations is updated to " << _immobile_dislocations[_qp][i] << std::endl;
    }

    // check that increment is equal or positive; very small values okay
    if (_mobile_dislocations[_qp][i] < 0.0 || _immobile_dislocations[_qp][i] < 0.0)  // Okay if looking at the total, not the increment. Should never have negative numbers of dislocations.
    {
      std::cout << "The mobile dislocations value is " << _mobile_dislocations[_qp][i] << std::endl;
      std::cout << "The immobile dislocations value is " << _immobile_dislocations[_qp][i] << std::endl;

      error_tolerance = true;
//      return;
    }
  }
//  error_tolerance = false;
}
