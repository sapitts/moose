//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "CrystalPlasticityEnthalpyFlowRuleUpdate.h"
#include "libmesh/utility.h"

registerMooseObject("TensorMechanicsApp", CrystalPlasticityEnthalpyFlowRuleUpdate);

template <>
InputParameters validParams<CrystalPlasticityEnthalpyFlowRuleUpdate>()
{
  InputParameters params = validParams<CrystalPlasticityUpdate>();
  params.addClassDescription("Patra-McDowell model for dislocation density based crystal plasticity, relating mobile dislocations to slip through Orowan's law.");
  params.addParam<Real>("temperature", 323.0, "The coupled temperature, in K");
  params.addParam<Real>("burgers_vector", 0.248e-6, "The Burger's vector for the material, in mm");

  params.addParam<Real>("flow_rule_exponent_p", 0.28, "Exponent parameter used to calculate the flow rate, operates on the driving force"),
  params.addParam<Real>("flow_rule_exponent_q", 1.34, "Exponent parameter used to calculate the flow rate, operates on the 1 minus driving force term"),
  params.addParam<Real>("average_dislocation_glide_distance", 1.5e-6, "The average dislocation glide distance between barriers, in mm");
  params.addParam<Real>("dislocation_jump_frequency", 5.396e9, "Patra-McDowell jump frequency of dislocations, used to calculate the dislocation glide velocity flow rule");
  params.addParam<Real>("Boltzman_constant", 1.38065e-20, "Boltzman constant, in MPa-mm^3/K");

  params.addParam<Real>("thermal_slip_system_resistance", 50.0, "Thermal resistance to dislocation motion, due to short range obstacles and related to the Peierl's barrier strenght, in MPa");
  params.addParam<Real>("shear_modulus", 78489, "The shear modulus of the crystal, in MPa");
  params.addParam<Real>("dislocation_barrier_strength_parameter", 0.2, "Total dislocation-dislocation barrier strength factor, given as q_p in Patra and McDowell (2012)");
  params.addParam<Real>("dislocation_latent_hardening_parameter", 0.2, "Latent hardening factor for slip system hardening due to dislocations on other slip systems");
  params.addParam<Real>("dislocation_self_hardening_parameter", 1.0, "Self hardening factor for slip system hardening due to dislocations on the same slip system");

  params.addRangeCheckedParam<Real>("slip_system_strength_superposition_factor", 1.0, "slip_system_strength_superposition_factor>=1.0 & slip_system_strength_superposition_factor<=2.0", "Factor use to determine the superposition of the components of the athermal slip system strength");
  params.addParam<Real>("irradiation_cluster_defect_hardening_coefficient", 0.01, "Leading coefficient for the dispersed barrier hardening model applied to irradiation defect vacancy and percipiate clusters");
  params.addRangeCheckedParam<Real>("neutron_irradiation_dose", 0.0, "neutron_irradiation_dose>=0", "Current dose of irradiation applied to this material from a neutron source, in dpa");

  params.addParam<Real>("initial_irradiation_SIA_loop_density", 0.0, "Initial density of the self interstitial atoms loops that form from irrdiation dose; this density is the sum across all of the SIA loop planes, in 1/mm^3");
  params.addParam<Real>("irradiation_SIA_loop_hexagonal_diameter", 2.48e-5, "Mean hexagonal diameter of the self interstitial atoms loops, in mm; used to calculate the loop size by multiplying the diameter by three");
  params.addParam<Real>("irradiation_SIA_loop_hardening_coefficient", 0.37, "Leading coefficient for the dispersed barrier hardening model applied to the strength from dislocation - SIA loop interactions");
  params.addParam<Real>("irradiation_SIA_loop_glide_path_coefficient", 0.1, "Leading coefficient applied to the contribution of SIA loop - dislocation interactions to the mean free glide path for mobile dislocations");
  params.addParam<Real>("irradiation_SIA_loop_annihilation_efficiency", 120.0, "Leading coefficient for the evolution of self interstitial loop density, representing the annilation efficiency of loops by dislocations");

  params.addParam<Real>("dislocation_multiplication_coefficient", 0.9, "Constant for the multiplication of dislocations with the Frank-Reed mechanism");
  params.addParam<Real>("radius_capture_annhiliation", 8.0e-6, "Constant radius of capture for two annhiliating dislocations on the same slip plane, in mm");
  params.addParam<Real>("dislocation_dynamic_recovery_coefficient", 100.0, "Dynamic recovery constant for immobile dislocations becoming mobile");
  params.addParam<Real>("dislocation_glide_path_coefficient", 0.4, "Leading coefficient applied to the contribution of dislocation-dislocation interactions to the mean free glide path for mobile dislocations");

  params.addParam<Real>("cross_slip_activation_barrier_factor", 0.004, "The factor by which to multiply the shear modulus to calculate the strength barrier which a dislocation must overcome to cross slip");
  params.addParam<Real>("cross_slip_activation_volume_factor", 20.0, "The factor by which to multiply the burger's vector to determine the volume required for a dislocation to cross slip");
  params.addParam<Real>("cross_slip_factor", 8.0e3, "Parameterizing factor to control the degree of cross slip occuring");
  MooseEnum cross_slip_calculation_type ("deterministic stochastic", "deterministic");
  params.addParam<MooseEnum>("cross_slip_calculation_type", cross_slip_calculation_type, "Type of method to use when calculating cross slip.  The deterministic method will allow cross slip from all slip systems in the family onto a single recieving slip system while the deterministic method allows cross slip among random slip system pairs based on a Monte Carlo analysis");

  params.addParam<Real>("initial_mobile_dislocation_density", 2.0e7, "Initial density of mobile dislocation densities, in 1/mm^2");
  params.addParam<Real>("initial_immobile_dislocation_density", 3.0e7, "Initial density of immobile dislocation densities, in 1/mm^2");

  return params;
}

CrystalPlasticityEnthalpyFlowRuleUpdate::CrystalPlasticityEnthalpyFlowRuleUpdate(const InputParameters & parameters) :
    CrystalPlasticityUpdate(parameters),
    _mobile_dislocations(declareProperty<std::vector<Real> > ("mobile_dislocations")),
    _mobile_dislocations_old(getMaterialPropertyOld<std::vector<Real> > ("mobile_dislocations")),
    _immobile_dislocations(declareProperty<std::vector<Real> > ("immobile_dislocations")),
    _immobile_dislocations_old(getMaterialPropertyOld<std::vector<Real> > ("immobile_dislocations")),
    _cross_slip_dislocations(declareProperty<std::vector<Real> >("cross_slip_dislocations")),
    _athermal_slip_system_resistance(declareProperty<std::vector<Real> >("athermal_slip_system_resistance")),
    _athermal_slip_system_resistance_old(getMaterialPropertyOld<std::vector<Real> >("athermal_slip_system_resistance")),
    _slip_increment(declareProperty<std::vector<Real> >("plastic_slip_increment")),

    _temperature(getParam<Real>("temperature")),

    //Save off the the values of the state variables from the previous increment (before the values are old)
    _previous_it_mobile(declareProperty<std::vector<Real> >("previous_iteration_mobile_dislocations")),
    _previous_it_immobile(declareProperty<std::vector<Real> >("previous_iteration_immobile_dislocations")),
    _previous_it_athermal_resistance(declareProperty<std::vector<Real> >("previous_interation_athermal_resistance")),

    // Dislocation glide velocity calculation values
    _glide_velocity(declareProperty<std::vector<Real> >("dislocation_glide_velocity")),
    _burgers_vector(getParam<Real>("burgers_vector")),

    // Slip system resistance parameters
    _thermal_slip_system_resistance(getParam<Real>("thermal_slip_system_resistance")),
    _shear_modulus(getParam<Real>("shear_modulus")),
    _dislocation_barrier_strength_coeff(getParam<Real>("dislocation_barrier_strength_parameter")),
    _dislocation_latent_hardening(getParam<Real>("dislocation_latent_hardening_parameter")),
    _dislocation_self_hardening(getParam<Real>("dislocation_self_hardening_parameter")),
    _strength_superposition_factor(getParam<Real>("slip_system_strength_superposition_factor")),

    // dislocation-cluster_defect hardening specific parameters
    _irradiation_cluster_hardening_coeff(getParam<Real>("irradiation_cluster_defect_hardening_coefficient")),

    // dislocation-SIALoop defect hardening specific Parameters
    _initial_SIAloop_density(getParam<Real>("initial_irradiation_SIA_loop_density")),
    _irradiation_SIAloop_tensor(declareProperty<RankTwoTensor>("irradiation_SIA_loop_damage_tensor")),
    _irradiation_SIAloop_tensor_old(getMaterialPropertyOld<RankTwoTensor>("irradiation_SIA_loop_damage_tensor")),
    _irradiation_SIAloop_diameter(getParam<Real>("irradiation_SIA_loop_hexagonal_diameter")),
    _sia_loop_trapping_coeff(getParam<Real>("irradiation_SIA_loop_hardening_coefficient")),
    _sia_loop_glide_path_coeff(getParam<Real>("irradiation_SIA_loop_glide_path_coefficient")),
    _irradiation_SIAloop_annhilation_coeff(getParam<Real>("irradiation_SIA_loop_annihilation_efficiency")),
    _contact_SIAloop_density(declareProperty<std::vector<Real>>("SIA_loop_contact_density")),

    // Enthapy Flow Rule parameters
    _p_exp(getParam<Real>("flow_rule_exponent_p")),
    _q_exp(getParam<Real>("flow_rule_exponent_q")),
    _avg_dislocation_glide_distance(getParam<Real>("average_dislocation_glide_distance")),
    _jump_frequency(getParam<Real>("dislocation_jump_frequency")),
    _boltzmann_constant(getParam<Real>("Boltzman_constant")),
    _activation_energy(0.35 * _shear_modulus * Utility::pow<3>(_burgers_vector)),

    // Dislocation evolution parameters
    _dislocation_multiplication_coeff(getParam<Real>("dislocation_multiplication_coefficient")),
    _dislocation_radius_capture(getParam<Real>("radius_capture_annhiliation")),
    _dislocation_mobile_recovery_coeff(getParam<Real>("dislocation_dynamic_recovery_coefficient")),
    _dislocation_glide_path_coeff(getParam<Real>("dislocation_glide_path_coefficient")),

    // Cross slip parameters
    _cs_activation_barrier(getParam<Real>("cross_slip_activation_barrier_factor") * _shear_modulus),
    _cs_activation_volume(getParam<Real>("cross_slip_activation_volume_factor") * Utility::pow<3>(_burgers_vector)),
    _cross_slip_factor(getParam<Real>("cross_slip_factor")),
    _cross_slip_type((CrossSlipMethod)(int)getParam<MooseEnum>("cross_slip_calculation_type")),

    // Initial state variable values
    _initial_mobile_dislocation_density(getParam<Real>("initial_mobile_dislocation_density")),
    _initial_immobile_dislocation_density(getParam<Real>("initial_immobile_dislocation_density"))
{
  const Real irradiation_dpa = getParam<Real>("neutron_irradiation_dose");
  if (irradiation_dpa > 0.0)
  {
    const Real ln_dpa = std::log(irradiation_dpa);
    const Real ln_defect_density = - 0.0049 * Utility::pow<4>(ln_dpa) - 0.0931 * Utility::pow<3>(ln_dpa) - 0.6037 * Utility::pow<2>(ln_dpa) - 2.1621 * ln_dpa + 52.398;
    _irradiation_cluster_defect_density = std::exp(ln_defect_density) * 1.0e-9;  // convert from 1/m^3 to 1/mm^3
    _irradiation_cluster_defect_size = 4.1926 * std::pow(irradiation_dpa, 0.2558) * 1.0e-6;  //convert from nm to mm
  }
  else
  {
    _irradiation_cluster_defect_density = 0.0;
    _irradiation_cluster_defect_size = 0.0;
  }
}

void
CrystalPlasticityEnthalpyFlowRuleUpdate::initQpStatefulProperties()
{
  _mobile_dislocations[_qp].resize(_number_slip_systems);
  _immobile_dislocations[_qp].resize(_number_slip_systems);
  _cross_slip_dislocations[_qp].resize(_number_slip_systems);
  _athermal_slip_system_resistance[_qp].resize(_number_slip_systems);

  _slip_increment[_qp].resize(_number_slip_systems);
  _glide_velocity[_qp].resize(_number_slip_systems);
  _contact_SIAloop_density[_qp].resize(_number_slip_systems);

  //Then loop over the slip systems and set the initial values for all the Reals
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    _mobile_dislocations[_qp][i] = _initial_mobile_dislocation_density / _number_slip_systems;
    _immobile_dislocations[_qp][i] = _initial_immobile_dislocation_density / _number_slip_systems;
    _cross_slip_dislocations[_qp][i] = 0.0;
    _athermal_slip_system_resistance[_qp][i] = 0.0;

    _slip_increment[_qp][i] = 0.0;
    _glide_velocity[_qp][i] = 0.0;
    _contact_SIAloop_density[_qp][i] = 0.0;
  }

  initializeSIALoopDamageTensor();
  CrystalPlasticityUpdate::initQpStatefulProperties();
}

void
CrystalPlasticityEnthalpyFlowRuleUpdate::setInitialConstitutiveVariableValues()
{
  //Use this method to set the current values to the old values.
  bool fake_error = false;
  calculateSlipSystemResistance(fake_error);  //<- should this value go after the dislocation densities are set to the old values?

  _mobile_dislocations[_qp] = _mobile_dislocations_old[_qp];
  _immobile_dislocations[_qp] = _immobile_dislocations_old[_qp];
  _irradiation_SIAloop_tensor[_qp] = _irradiation_SIAloop_tensor_old[_qp];
}

void
CrystalPlasticityEnthalpyFlowRuleUpdate::calculateConstitutiveEquivalentSlipIncrement(RankTwoTensor & equivalent_slip_increment,
                                                                         bool & error_tolerance)
{
  equivalent_slip_increment.zero();

  // Save off the values from the previous increment:
//  _previous_it_slip_increment[_qp] = _slip_increment[_qp];

  // Calculate the dislocation glide velocity term for each of the slip systems
  const Real activation_term = -_activation_energy / (_boltzmann_constant * _temperature);
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    if ( std::abs(_tau[_qp][i]) >= _athermal_slip_system_resistance[_qp][i])
    {
      const Real driving_force = (std::abs(_tau[_qp][i]) - _athermal_slip_system_resistance[_qp][i]) / _thermal_slip_system_resistance;
      const Real exp_driving_force = std::pow(driving_force , _p_exp);

      if (exp_driving_force > 1.0)
      {
#ifdef DEBUG
        mooseWarning("CrystalPlasticityEnthalpyFlowRuleUpdate: Flow rule upper limit exceeded ", exp_driving_force);
#endif
        error_tolerance = true;
        return;
      }

      const Real driving_force_term = std::pow(1.0 - exp_driving_force, _q_exp);
      _glide_velocity[_qp][i] = _avg_dislocation_glide_distance * _jump_frequency * std::exp(activation_term * driving_force_term);

      if (_tau[_qp][i] < 0.0)
        _glide_velocity[_qp][i] *= -1.0;  //only need to change the sign(_tau[_qp]) if _tau[_qp] is negative
    }
    else // Not enough shear force from tau to move dislocations
      _glide_velocity[_qp][i] = 0.0;
  }

  // Calculate the slip increment on each slip system
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    // std::cout << "Inside the calculate the slip increment method at qp " << _qp  << " and on slip system number " << i << std::endl;
    // std::cout << "  and the value of the substep dt is " << _substep_dt << std::endl;
    _slip_increment[_qp][i] = _mobile_dislocations[_qp][i] * _burgers_vector * _glide_velocity[_qp][i] *_substep_dt;
    // std::cout << "  so that the slip increment here is " << _slip_increment[_qp][i] << std::endl;

    if (std::abs(_slip_increment[_qp][i]) > _slip_incr_tol)
    {
#ifdef DEBUG
      mooseWarning("Maximum allowable slip increment exceeded on slip system ", i, " with a value of ", std::abs(_slip_increment[_qp][i]));
#endif
      error_tolerance = true;
      return;
    }
  }
  // std::cout << "................................................" << std::endl;

  // Sum up the slip increments to find the equivalent plastic strain due to slip
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
    equivalent_slip_increment += _flow_direction[_qp][i] * _slip_increment[_qp][i];

  error_tolerance = false;
}

void
CrystalPlasticityEnthalpyFlowRuleUpdate::calculateConstitutiveSlipDerivative(std::vector<Real> & dslip_dtau, unsigned int /*slip_model_number*/)
{
  const Real activation_term = _activation_energy / (_boltzmann_constant * _temperature);

  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    if (MooseUtils::absoluteFuzzyEqual(_glide_velocity[_qp][i], 0.0))
      dslip_dtau[i] = 0.0;
    else
    {
    // Expand out the chain rule terms for the calculation of the glide velocity derivative
      Real d_strength_d_tau = 1.0 / _thermal_slip_system_resistance;
      if (_tau[_qp][i] < 0.0)
        d_strength_d_tau *= -1.0;  //only need to change the sign(_tau[_qp]) if _tau[_qp] is negative

      // Then apply the product rule to the driving force term with the exponents
      const Real driving_force = (std::abs(_tau[_qp][i]) - _athermal_slip_system_resistance[_qp][i]) / _thermal_slip_system_resistance;

      Real d_driving_force_d_strength = 0.0;
    if (driving_force > 0.0) // Need a positive driving force to move the dislocations
    {
      const Real exp_term_derivative = std::pow((1.0 - std::pow(driving_force, _p_exp)), (_q_exp - 1.0));
      d_driving_force_d_strength = _q_exp * _p_exp * exp_term_derivative * std::pow(driving_force, (_p_exp - 1.0));
    }
      const Real velocity_derivative = activation_term * _glide_velocity[_qp][i] * d_driving_force_d_strength * d_strength_d_tau;
      dslip_dtau[i] = _mobile_dislocations[_qp][i] * _burgers_vector * velocity_derivative * _substep_dt;
    }
  }
}

void
CrystalPlasticityEnthalpyFlowRuleUpdate::updateConstitutiveSlipSystemResistanceAndVariables(bool & error_tolerance)
{
  // Set the previous value of the slip system resistance here for comparison in the convergence check
  _previous_it_athermal_resistance[_qp] = _athermal_slip_system_resistance[_qp];
  _previous_it_mobile[_qp] = _mobile_dislocations[_qp];
  _previous_it_immobile[_qp] = _immobile_dislocations[_qp];

  if (_initial_SIAloop_density != 0.0)
    calculateIradiationSIALoopDensity();

  calculateDislocationDensities(error_tolerance);
  if (error_tolerance)
    return;

  calculateSlipSystemResistance(error_tolerance);
}

bool
CrystalPlasticityEnthalpyFlowRuleUpdate::areConstitutiveStateVariablesConverged()
{
  Real mobile_diff, immobile_diff = 0.0;

  // Will have to run through twice:  once for each type of state variable because I've hardcoded them
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    // Calculate the change in the state variables over the two iterations
    mobile_diff = std::abs(_previous_it_mobile[_qp][i] - _mobile_dislocations[_qp][i]);
    immobile_diff = std::abs(_previous_it_immobile[_qp][i] - _immobile_dislocations[_qp][i]);

    // Set the iteration flag to rerun if the old value is pretty much zero and if the difference from iterations is above tolerance
    if (_mobile_dislocations_old[_qp][i] < _zero_tol)
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
        std::cout << "Hit mobile diff too large compared to old" << std::endl;
        return true;
      }

    if (_immobile_dislocations_old[_qp][i] < _zero_tol)
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
        std::cout << "Hit immobile dislocations and the too large immobile diff " << std::endl;
        return true;
      }
    }
  }

  // Check slip system convergence; could be it's own method
  Real resistance_diff = 0.0;
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    resistance_diff = std::abs(_previous_it_athermal_resistance[_qp][i] - _athermal_slip_system_resistance[_qp][i]);
    if (resistance_diff > _resistance_tol) //_zero_tol)
    {
      std::cout << " The value of the slip resistance on slip system " << i << " is greater than the tolerance and is " << resistance_diff << std::endl;
      return true;
    }
  }
  return false;
}


void
CrystalPlasticityEnthalpyFlowRuleUpdate::calculateSlipSystemResistance(bool & error_tolerance)
{
  // Calculate the slip system strength due to dislocation-dislocation interaction
  std::vector<Real> strength_dislocations(_number_slip_systems);
  const Real dislocation_strength_coeff = _burgers_vector * _shear_modulus * _dislocation_barrier_strength_coeff;
  for (unsigned int a = 0; a < _number_slip_systems; ++a)
  {
    Real sum = 0.0;
    for (unsigned int b = 0; b < _number_slip_systems; ++b)
    {
      if (a != b)
        sum += _dislocation_latent_hardening * (_mobile_dislocations[_qp][b] + _immobile_dislocations[_qp][b]);
      else
        sum += _dislocation_self_hardening * (_mobile_dislocations[_qp][b] + _immobile_dislocations[_qp][b]);
    }
    strength_dislocations[a] = dislocation_strength_coeff * std::sqrt(sum);
  }

  // Call the method to calculate the slip system strength due to irradiation clusters
  Real strength_clusters = 0.0;
  if (_irradiation_cluster_defect_density > 0.0)
    strength_clusters = calculateIrradiationClusterStrength();

  // calculate the strength due to SIA loops
  std::vector<Real> strength_sia_loops;
  strength_sia_loops.resize(_number_slip_systems, 0.0);

  if (_initial_SIAloop_density != 0.0)
  {
    Real sia_loop_strength_coeff = _sia_loop_trapping_coeff * _shear_modulus * _burgers_vector;
    for (unsigned int i = 0; i < _number_slip_systems; ++i)
      strength_sia_loops[i] = sia_loop_strength_coeff * _contact_SIAloop_density[_qp][i];
  }

  if (_strength_superposition_factor != 1.0)
  {
    for (unsigned int i = 0; i < _number_slip_systems; ++i)
    {
      Real sum = std::pow(strength_dislocations[i], _strength_superposition_factor);
      sum += std::pow(strength_clusters, _strength_superposition_factor);
      sum += std::pow(strength_sia_loops[i], _strength_superposition_factor);
      _athermal_slip_system_resistance[_qp][i] = std::pow(sum, (1.0 / _strength_superposition_factor));
    }
  }
  else // straight addative decomposition of strengths
    for (unsigned int i = 0; i < _number_slip_systems; ++i)
      _athermal_slip_system_resistance[_qp][i] = strength_dislocations[i] + strength_clusters + strength_sia_loops[i];

  // std::cout << "Now evaluating the update-ability of the resistance" << std::endl;
  //Now perform the check to see if the slip system should be updated
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    if (_athermal_slip_system_resistance_old[_qp][i] < _zero_tol && _athermal_slip_system_resistance[_qp][i] < 0.0)
    {
      _athermal_slip_system_resistance[_qp][i] = _athermal_slip_system_resistance_old[_qp][i];
      // std::cout << "  in slip system " << i << " and the value of the old value / increment is too small to update" << std::endl;
    }

    if (_athermal_slip_system_resistance[_qp][i] < 0.0)
      error_tolerance = true;
  }
}

void
CrystalPlasticityEnthalpyFlowRuleUpdate::calculateDislocationDensities(bool & error_tolerance)
{
  std::vector<Real> increment_mobile(_number_slip_systems, 0.0);
  std::vector<Real> increment_immobile(_number_slip_systems, 0.0);

  if (_number_cross_slip_directions != 0)
    calculateDislocationCrossSlip();

  // Calculate the average line length of the dislocations segments, which is constant on all slip systems
  Real avg_dislocation_segment_len = 0.0;
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
    avg_dislocation_segment_len += _mobile_dislocations[_qp][i];

  avg_dislocation_segment_len = std::sqrt(std::abs(avg_dislocation_segment_len)); //<- probably don't need the abs value, but let's play it safe

  //Calculate terms of the dislocation evolution for each slip system: Multiplication is slip system independent
  const Real mult_term = _dislocation_multiplication_coeff * avg_dislocation_segment_len / _burgers_vector;

  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    const Real annhil_term = 2.0 * _dislocation_radius_capture * _mobile_dislocations[_qp][i] / _burgers_vector;

    // The forest trapping term includes contributions from the total dislocations and the SIA loops
    Real sqrt_total_disl = std::sqrt(_mobile_dislocations[_qp][i] + _immobile_dislocations[_qp][i]);
    Real forest_trapping = _dislocation_glide_path_coeff * sqrt_total_disl + _sia_loop_glide_path_coeff * _contact_SIAloop_density[_qp][i];
    const Real immob_term = forest_trapping / _burgers_vector;

    const Real recover_term = _dislocation_mobile_recovery_coeff * _immobile_dislocations[_qp][i];

    // put the increment here, then run the tolerance check and update in a separate loop
    increment_mobile[i] = (mult_term - annhil_term - immob_term) * std::abs(_slip_increment[_qp][i])  + _cross_slip_dislocations[_qp][i];

    // Pull from the previously calculated cross slip terms
    increment_immobile[i] = (immob_term - recover_term) * std::abs(_slip_increment[_qp][i]);
  }


  // std::cout << "Now evaluating the update-ability of the dislocations" << std::endl;
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    if (_mobile_dislocations_old[_qp][i] < _zero_tol && increment_mobile[i] < 0.0)
      _mobile_dislocations[_qp][i] = _mobile_dislocations_old[_qp][i];
    else
      _mobile_dislocations[_qp][i] = increment_mobile[i] + _mobile_dislocations_old[_qp][i];

    if (_immobile_dislocations_old[_qp][i] < _zero_tol && increment_immobile[i] < 0.0)
      _immobile_dislocations[_qp][i] = _immobile_dislocations_old[_qp][i];
    else
      _immobile_dislocations[_qp][i] = increment_immobile[i] + _immobile_dislocations_old[_qp][i];

    // check that increment is equal or positive; very small values okay
    if (_mobile_dislocations[_qp][i] < 0.0 || _immobile_dislocations[_qp][i] < 0.0)  // Okay if looking at the total, not the increment. Should never have negative numbers of dislocations.
    {
      error_tolerance = true;
    }
  }
}

void
CrystalPlasticityEnthalpyFlowRuleUpdate::calculateDislocationCrossSlip()
{
  if (_cross_slip_type == deterministic)
  {
    // Work within the cross slip families for the cross slip calculation
    for (unsigned int i = 0; i < _number_cross_slip_directions; ++i)
    {
      unsigned int family_probability_index = 1000000; // Pick something unphysical that will be out of bounds if not set below
      Real family_xslip_probability = 0.0;
      Real family_xslip_dislocation_sum = 0.0;
      bool cross_slip_occurs = true;

      // Determine which slip system has the highest probability of cross slip
      for (unsigned int j = 0; j < _number_cross_slip_planes; ++j)
      {
        unsigned int index = _cross_slip_familes[i][j];
        Real xslip_force = (_cs_activation_barrier - std::abs(_tau[_qp][index])) * _cs_activation_volume;
        Real xslip_probabilty = std::exp(-xslip_force / (_boltzmann_constant * _temperature));

        if (MooseUtils::relativeFuzzyGreaterThan(xslip_probabilty, family_xslip_probability))
        {
          family_xslip_probability = xslip_probabilty;
          family_probability_index = index;
          cross_slip_occurs = true;
        }
        else if (MooseUtils::relativeFuzzyEqual(xslip_probabilty, family_xslip_probability))
          cross_slip_occurs = false;
      }

      if (family_probability_index > _number_slip_systems)
        mooseError("The cross slip calculation of the max cross slip probability was not completed correctly");

      // Calculate the change in dislocations due to cross slip in this family
      // if there is a single slip system with a clear maximum probabilty
      if (cross_slip_occurs)
      {
        for (unsigned int j = 0; j < _number_cross_slip_planes; ++j)
        {
          unsigned int index = _cross_slip_familes[i][j];
          if (index != family_probability_index)
          {
            Real xslip_dislocations = _cross_slip_factor * family_xslip_probability * _mobile_dislocations[_qp][index] * std::abs(_slip_increment[_qp][index]);
            _cross_slip_dislocations[_qp][index] = -xslip_dislocations;
            family_xslip_dislocation_sum += xslip_dislocations;
          }
        }
        _cross_slip_dislocations[_qp][family_probability_index] = family_xslip_dislocation_sum;
      }
    }
  }
  else if (_cross_slip_type == stochastic)
  {
    // Work within the cross slip families for the cross slip calculation
    for (unsigned int i = 0; i < _number_cross_slip_directions; ++i)
    {
      std::vector<Real> family_xslip_probability;
      family_xslip_probability.resize(_number_cross_slip_planes);
      Real family_xslip_probability_sum = 0.0;
      std::vector<std::vector<unsigned int> > family_xslip_interactions;
      family_xslip_interactions.resize(_number_cross_slip_planes);

      // Determine the probability of cross slip for each slip plane in the family
      for (unsigned int j = 0; j < _number_cross_slip_planes; ++j)
      {
        unsigned int index = _cross_slip_familes[i][j];
        Real xslip_force = (_cs_activation_barrier - std::abs(_tau[_qp][index])) * _cs_activation_volume;
        Real xslip_probabilty = std::exp(-xslip_force / (_boltzmann_constant * _temperature));

        family_xslip_probability[j] = xslip_probabilty;
        family_xslip_probability_sum += xslip_probabilty;

        //Clean out the interaction vector for the current cross slip family before adding data
        family_xslip_interactions[j].resize(0);
      }

      // Now normalize the components of each probabilty by dividing by the probabilty sum
      for (unsigned int j = 0; j < _number_cross_slip_planes; ++j)
        family_xslip_probability[j] /= family_xslip_probability_sum;

      // And build the CDF function for this family
      for (unsigned int j = 1; j < _number_cross_slip_planes; ++j)
        family_xslip_probability[j] += family_xslip_probability[j-1];

      for (unsigned int k = 0; k < _number_cross_slip_planes; ++k)
        // std::cout << "  such that the normalized probability for cross slip system " << k << " is " << family_xslip_probability[k] << std::endl;

      if (MooseUtils::relativeFuzzyGreaterThan(family_xslip_probability[_number_cross_slip_planes - 1], 1.0))
        mooseError("The cumulative distribution function for the stochastic cross slip analysis was incorrectly calculated");

      // Monte Carlo Analysis using MooseRandom
      for (unsigned int giving_system = 0; giving_system < _number_cross_slip_planes; ++giving_system)
      {
        //throw the dice with the MooseRandom
        Real xslip_dice = MooseRandom::rand();
        // Now check the value of the random dice against the bin values to determine into which
        // slip system the dislocations will cross slip
        for (unsigned int j = 0; j < _number_cross_slip_planes; ++j)
        {
          if (xslip_dice < family_xslip_probability[j])
          {
            unsigned int recieving_system = j;
            // Now check to see if self-cross slip (none occurs) or actual cross slip occurs
            if (giving_system != recieving_system)  // Not self cross slip
            {
              family_xslip_interactions[giving_system].push_back(giving_system);
              family_xslip_interactions[recieving_system].push_back(giving_system);
            }
          break;
          }
        }
      }

      // Now need to calculate the sum of the cross slip dislocations
      // (probabilty * mobile dislocations) acting on each slip system in the cross slip family
      for (unsigned int a = 0; a < _number_cross_slip_planes; ++a)
      {
        // std::cout << "Summing up the probability * dislocations now, starting with the " << a <<"th system" << std::endl;
        unsigned int number_interactions = family_xslip_interactions[a].size();
        Real single_system_sum = 0.0;
        for (unsigned int b = 0; b < number_interactions; ++b)
        {
          // pull the index, calculated based b-> number in cross_slip_family-> number in number_slip_systems
          // to get the mobile dislocations value needed
          unsigned int cross_slip_index = family_xslip_interactions[a][b];
          unsigned int index = _cross_slip_familes[i][cross_slip_index];

          //if a == b: sum -= 1 * mobile_dislocations[index]
          if (a == cross_slip_index)
            single_system_sum -= _mobile_dislocations[_qp][index];
          // else if a != b: sum += * mobile_dislocations[index]
          else if (a != cross_slip_index)
            single_system_sum += _mobile_dislocations[_qp][index];
        }
        // Now that have completed the summing, store in the appropriate position in the material property
        unsigned int self_index = _cross_slip_familes[i][a];
        _cross_slip_dislocations[_qp][self_index] = single_system_sum * (family_xslip_probability_sum / _number_cross_slip_planes)
                                                     * _cross_slip_factor * std::abs(_slip_increment[_qp][self_index]);
      }
    }
  }
}

Real
CrystalPlasticityEnthalpyFlowRuleUpdate::calculateIrradiationClusterStrength()
{
  const Real sqrt_cluster = std::sqrt(_irradiation_cluster_defect_density * _irradiation_cluster_defect_size);
  const Real lg_term = std::log(1.0 / (2.0 * _burgers_vector * sqrt_cluster));
  Real strength_clusters = _irradiation_cluster_hardening_coeff * _shear_modulus * _burgers_vector * lg_term * sqrt_cluster;

  return strength_clusters;
}

void
CrystalPlasticityEnthalpyFlowRuleUpdate::calculateIradiationSIALoopDensity()
{
  // Store the rank two tensor of the slip plane normals in a vector
  std::vector<RankTwoTensor> slip_plane_normal_tensor;
  slip_plane_normal_tensor.resize(_number_slip_systems);

  for (unsigned int k = 0; k < _number_slip_systems; ++k)
    for (unsigned int i = 0; i < LIBMESH_DIM; ++i)
      for (unsigned int j = 0; j < LIBMESH_DIM; ++j)
        slip_plane_normal_tensor[k](i,j) = _slip_plane_normal(k * LIBMESH_DIM + i) * _slip_plane_normal(k * LIBMESH_DIM + j);

  // Calculate the increment of the damage tensor as a sum
  RankTwoTensor sum_damage_increment;
  sum_damage_increment.zero();
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    Real damage = slip_plane_normal_tensor[i].doubleContraction(_irradiation_SIAloop_tensor[_qp]);
    RankTwoTensor damage_tensor = damage * slip_plane_normal_tensor[i];
    sum_damage_increment += damage_tensor * std::abs(_slip_increment[_qp][i]) * _substep_dt;
  }
  RankTwoTensor damage_increment = -_irradiation_SIAloop_annhilation_coeff * sum_damage_increment;

  // Update the damage tensor with the increment
  _irradiation_SIAloop_tensor[_qp] = damage_increment + _irradiation_SIAloop_tensor_old[_qp];

  // Calculate the sqrt contact density for use in dislocation evolution
  //  and slip system strength with the new defect density
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    Real contraction = slip_plane_normal_tensor[i].doubleContraction(_irradiation_SIAloop_tensor[_qp]);
    _contact_SIAloop_density[_qp][i] = std::sqrt(contraction);
  }

}

void
CrystalPlasticityEnthalpyFlowRuleUpdate::initializeSIALoopDamageTensor()
{
  // Avoid the extra calculation if no SIA loops are present
  if (_initial_SIAloop_density == 0.0)
  {
    _irradiation_SIAloop_tensor[_qp].zero();
    return;
  }

  //First loop through the given slip planes for this crystal and determine which are of the {112} type
  std::vector<unsigned int> sia_planes_indices;
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    for (unsigned int j = 0; j < LIBMESH_DIM; ++j)
    {
      Real component = std::abs(_slip_plane_normal(i * LIBMESH_DIM + j)) * std::sqrt(6.0);
      if (!(MooseUtils::relativeFuzzyEqual(component, 1.0) || MooseUtils::relativeFuzzyEqual(component, 2.0)))
      {
        break;
      }
      else if (j == 2) // type {112}
        sia_planes_indices.push_back(i);
    }
  }

  // Now calculate the initial damage density tensor
  const Real number_loop_planes = sia_planes_indices.size();
  const Real sia_density = _initial_SIAloop_density / number_loop_planes;
  const Real sia_coeff = sia_density * 3.0 * _irradiation_SIAloop_diameter;
  RankTwoTensor sum_loop_normals;
  RankTwoTensor identity;
  identity.addIa(1.0);

  for (unsigned int k = 0; k < number_loop_planes; ++k)
  {
    unsigned int index = sia_planes_indices[k];
    RankTwoTensor dyadic_normal;
    dyadic_normal.zero();
    for (unsigned int i = 0; i < LIBMESH_DIM; ++i)
      for (unsigned int j = 0; j < LIBMESH_DIM; ++j)
        dyadic_normal(i,j) = _slip_plane_normal(index * LIBMESH_DIM + i) * _slip_plane_normal(index * LIBMESH_DIM + j);

    sum_loop_normals += identity - dyadic_normal;
  }
  _irradiation_SIAloop_tensor[_qp] = sia_coeff * sum_loop_normals;
}
