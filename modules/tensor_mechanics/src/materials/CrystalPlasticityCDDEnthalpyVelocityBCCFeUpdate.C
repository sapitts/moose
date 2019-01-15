//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "CrystalPlasticityCDDEnthalpyVelocityBCCFeUpdate.h"
#include "libmesh/utility.h"

registerMooseObject("TensorMechanicsApp", CrystalPlasticityCDDEnthalpyVelocityBCCFeUpdate);

template <>
InputParameters validParams<CrystalPlasticityCDDEnthalpyVelocityBCCFeUpdate>()
{
  InputParameters params = validParams<CrystalPlasticityCDDEnthalpyVelocityUpdateBase>();
  params.addClassDescription("Continuum Dislocation Dynamics model for crystal plasticity, relating mobile dislocations to slip through Orowan's law.");
  params.addParam<bool>("apply_anisotropic_strength", false, "Whether or not to apply anisotropic factors to the slip system strengths.  Note: This correction is only appropriate for BCC systems");

  params.addParam<Real>("defect_hardening_coefficient", 0.012, "Leading coefficient for the dispersed barrier hardening model applied to (irradiation) defect vacancy and percipiate clusters");
  params.addParam<Real>("cluster_defect_density", 0.0, "Number density of the defect clusters in this material, in mm^-3");
  params.addParam<Real>("cluster_defect_size", 0.0, "Average size, usually diameter, of the defects clusters in the material, in mm");
  params.addRangeCheckedParam<Real>("neutron_irradiation_dose", 0.0, "neutron_irradiation_dose>=0", "Current dose of irradiation applied to this material from a neutron source, in dpa");

  params.addParam<Real>("initial_irradiation_SIA_loop_density", 0.0, "Initial density of the self interstitial atoms loops that form from irrdiation dose; this density is the sum across all of the SIA loop planes, in 1/mm^3");
  params.addParam<Real>("irradiation_SIA_loop_size", 2.48e-5, "Average size of the self interstitial atoms loops, in mm");
  params.addParam<Real>("irradiation_SIA_mean_free_glide_path_coefficient", 0.5, "The coefficient for the calculation of the mean free glide path term from the SIA loop density");
  params.addParam<Real>("irradiation_SIA_loop_hardening_coefficient", 0.1, "Leading coefficient for the 3D obstacle hardening model applied to the strength from dislocation - SIA loop interactions");
  params.addParam<Real>("irradiation_SIA_loop_hardening_exponent", 0.5, "Exponential term for the contribution of the SIA loops to the slip system strength from dislocation - SIA loop interactions");
  params.addParam<Real>("irradiation_SIA_loop_annihilation_coefficient", 1.0, "Leading coefficient for the evolution of self interstitial loop density, representing the annilation of loops by dislocations");
  params. addParam<Real>("irradiation_SIA_loop_radius_capture", 15.0, "Multiplier of the Burger's vector to determin the caputre radius for SIA loop annhiliation by dislocation absorbtion");

  return params;
}

CrystalPlasticityCDDEnthalpyVelocityBCCFeUpdate::CrystalPlasticityCDDEnthalpyVelocityBCCFeUpdate(const InputParameters & parameters) :
    CrystalPlasticityCDDEnthalpyVelocityUpdateBase(parameters),

    // Anisotropic hardening specific parameters
    _apply_anisotropic_strength(getParam<bool>("apply_anisotropic_strength")),

    // dislocation-Cu cluster hardening specific parameters
    _irradiation_hardening_coefficient(getParam<Real>("defect_hardening_coefficient")),

    // dislocation-SIA loop hardening specific parameters
    _initial_SIAloop_density(getParam<Real>("initial_irradiation_SIA_loop_density")),
    _sia_loop_density(declareProperty<Real>("irradiation_SIA_loop_density")),
    _sia_loop_density_old(getMaterialPropertyOld<Real>("irradiation_SIA_loop_density")),
    _previous_it_sia_loop(declareProperty<Real>("previous_iteration_SIA_loop_density")),
    _sia_loop_slip_resistance(declareProperty<Real>("irradiation_SIA_loop_slip_resistance")),
    _sia_loop_size(getParam<Real>("irradiation_SIA_loop_size")),
    _sia_loop_glide_path_coeff(getParam<Real>("irradiation_SIA_mean_free_glide_path_coefficient")),
    _sia_loop_hardening_coefficient(getParam<Real>("irradiation_SIA_loop_hardening_coefficient")),
    _sia_loop_hardening_exponent(getParam<Real>("irradiation_SIA_loop_hardening_exponent")),
    _sia_loop_annhiliation_coefficient(getParam<Real>("irradiation_SIA_loop_annihilation_coefficient")),
    _sia_loop_radius_capture(getParam<Real>("irradiation_SIA_loop_radius_capture"))
{
  const Real irradiation_dpa = getParam<Real>("neutron_irradiation_dose");
  _irradiation_cluster_defect_density = getParam<Real>("cluster_defect_density");
  _irradiation_cluster_defect_size = getParam<Real>("cluster_defect_size");

  if (irradiation_dpa != 0.0 && (_irradiation_cluster_defect_density != 0.0 || _irradiation_cluster_defect_size != 0.0))
    mooseError("Either the cluster defect characteristics can be specified or only the neutron irradiation dose can be specified in this model");

  if (irradiation_dpa > 0.0)
  {
    const Real ln_dpa = std::log(irradiation_dpa);
    const Real ln_defect_density = - 0.0049 * Utility::pow<4>(ln_dpa) - 0.0931 * Utility::pow<3>(ln_dpa) - 0.6037 * Utility::pow<2>(ln_dpa) - 2.1621 * ln_dpa + 52.398;
    _irradiation_cluster_defect_density = std::exp(ln_defect_density) * 1.0e-9;  // convert from 1/m^3 to 1/mm^3
    _irradiation_cluster_defect_size = 4.1926 * std::pow(irradiation_dpa, 0.2558) * 1.0e-6;  //convert from nm to mm
  }
  else if (_irradiation_cluster_defect_density == 0.0 && _irradiation_cluster_defect_size == 0.0)
  {
    _irradiation_cluster_defect_density = 0.0;
    _irradiation_cluster_defect_size = 0.0;
  }
  else if (_irradiation_cluster_defect_density == 0.0 || _irradiation_cluster_defect_size == 0.0)
    mooseError("Both the cluster defect density and the average size must be specified to fully define the defect characteristics");

  if (parameters.isParamSetByUser("initial_irradiation_SIA_loop_density"))
    _calculate_sia_loop_hardening = true;
  else
    _calculate_sia_loop_hardening = false;

  if (_number_slip_systems >= 1000)
    mooseError("CrystalPlasticityCDDEnthalpyVelocityUpdateBase assumes fewer than 1,000 possible slip systems");

  // not sure if I need these last two or not
  setRandomResetFrequency(EXEC_TIMESTEP_BEGIN);

  // fetch coupled gradients of the plastic velocity gradient
  for (unsigned int i = 0; i < LIBMESH_DIM * LIBMESH_DIM; ++i)
    _gradient_Lp[i] = &coupledGradient("plastic_velocity_gradient_components", i);
}

void
CrystalPlasticityCDDEnthalpyVelocityBCCFeUpdate::initQpStatefulProperties()
{
  CrystalPlasticityCDDEnthalpyVelocityUpdateBase::initQpStatefulProperties();

  _sia_loop_density[_qp] = _initial_SIAloop_density;
}

void
CrystalPlasticityCDDEnthalpyVelocityBCCFeUpdate::setInitialConstitutiveVariableValues()
{
  CrystalPlasticityCDDEnthalpyVelocityUpdateBase::setInitialConstitutiveVariableValues();
  _sia_loop_density[_qp] = _sia_loop_density_old[_qp];
}

void
CrystalPlasticityCDDEnthalpyVelocityBCCFeUpdate::updateConstitutiveSlipSystemResistanceAndVariables(bool & error_tolerance)
{
  // Set the previous value of the slip system resistance here for comparison in the convergence check
  _previous_it_resistance[_qp] = _athermal_slip_system_resistance[_qp];
  _previous_it_mobile[_qp] = _mobile_dislocations[_qp];
  _previous_it_immobile[_qp] = _immobile_dislocations[_qp];
  _previous_it_sia_loop[_qp] = _sia_loop_density[_qp];

  // At the early stages when all of the glide velocities are zero,
  // save a bit of time at the early stages of the simulation.
  bool no_glide_velocity = true;

  unsigned int i = 0;
  do
  {
    if (!(MooseUtils::absoluteFuzzyEqual(_glide_velocity[_qp][i], 0.0)))
    {
      no_glide_velocity = false;
    }
    ++i;
  } while (no_glide_velocity && (i < _number_slip_systems));

  if (no_glide_velocity)
  {
    error_tolerance = false;
    return;
  }

  if (_calculate_sia_loop_hardening)
    calculateIradiationSIALoopDensity();

  calculateDislocationDensities(error_tolerance);
  if (error_tolerance)
    return;

  calculateSlipSystemResistance(error_tolerance);
}

bool
CrystalPlasticityCDDEnthalpyVelocityBCCFeUpdate::areConstitutiveStateVariablesConverged()
{
  bool density_and_resistance_not_converged = CrystalPlasticityCDDEnthalpyVelocityUpdateBase::areConstitutiveStateVariablesConverged();
  if (density_and_resistance_not_converged)
    return true;

  // Check that the SIA loop evolution is converged
  Real sia_loop_diff = std::abs(_previous_it_sia_loop[_qp] - _sia_loop_density[_qp]);
  if (sia_loop_diff > _rel_state_var_tol * _sia_loop_density_old[_qp])
    return true;

  return false;
}

Real
CrystalPlasticityCDDEnthalpyVelocityBCCFeUpdate::calculateMeanFreeGlidePath()
{
  Real forest_only_glide_path_inv = CrystalPlasticityCDDEnthalpyVelocityUpdateBase::calculateMeanFreeGlidePath();

  Real sia_glide_path_inv = _sia_loop_glide_path_coeff * std::sqrt(_sia_loop_size *_sia_loop_density[_qp]);

  Real glide_path_inv = forest_only_glide_path_inv + sia_glide_path_inv;

  return glide_path_inv;
}

void
CrystalPlasticityCDDEnthalpyVelocityBCCFeUpdate::calculateSlipSystemResistance(bool & error_tolerance)
{
  std::vector<Real> forest_strength(_number_slip_systems, 0.0);

  // Call all of the hardening components that vary with time
  calculateDislocationForestHardening(forest_strength);

  if (_calculate_sia_loop_hardening)
    _sia_loop_slip_resistance[_qp] = calculateSIALoopHardening();

  for (unsigned int i = 0; i < _number_slip_systems; ++i)
    _athermal_slip_system_resistance[_qp][i] = forest_strength[i] +
                                      _sia_loop_slip_resistance[_qp] +
                                      _static_resistance_contribution[_qp][i];

  //Now perform the check to see if the slip system should be updated
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    if (_athermal_slip_system_resistance_old[_qp][i] < _zero_tol && _athermal_slip_system_resistance[_qp][i] < 0.0)
      _athermal_slip_system_resistance[_qp][i] = _athermal_slip_system_resistance_old[_qp][i];

    if (_athermal_slip_system_resistance[_qp][i] < 0.0)
    {
      error_tolerance = true;
      return;
    }
  }
  error_tolerance = false;
}

void
CrystalPlasticityCDDEnthalpyVelocityBCCFeUpdate::initSlipSystemResistance()
{
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
    _static_resistance_contribution[_qp][i] = 0.0;

  if (_apply_anisotropic_strength)
    applyAnisotropicStrengthFactor();

  Real cluster_strength = 0.0;
  if (_irradiation_cluster_defect_density != 0.0)
    cluster_strength = calculateClusterDefectHardening();

  // End of the static resistance contributions for this model
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
    _static_resistance_contribution[_qp][i] += cluster_strength;


  // Now calculate the initial contributions from the evolving quantities:
  Real sia_loop_strength = 0.0;
  if (_calculate_sia_loop_hardening)
    sia_loop_strength = calculateSIALoopHardening();

  _sia_loop_slip_resistance[_qp] = sia_loop_strength;

  std::vector<Real> forest_strength(_number_slip_systems);
  calculateDislocationForestHardening(forest_strength);

  // Loop over all the slip systems and add these strength contributions
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
    _athermal_slip_system_resistance[_qp][i] = forest_strength[i] +
                                      _sia_loop_slip_resistance[_qp] +
                                      _static_resistance_contribution[_qp][i];
}

void
CrystalPlasticityCDDEnthalpyVelocityBCCFeUpdate::applyAnisotropicStrengthFactor()
{
  const Real sum_110_type = std::sqrt(2.0);
  const Real sum_112_type = 4.0 / std::sqrt(1.0 * 2.0 + 4.0);
  const Real sum_123_type = 6.0 / std::sqrt(1.0 + 4.0 + 9.0);

  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    Real sum_plane_components = 0.0;
    for (unsigned int j = 0; j < LIBMESH_DIM; ++j)
      sum_plane_components += std::abs(_slip_plane_normal(i * LIBMESH_DIM + j));

    // Now determine what type each plane normal is and apply the factor
    if (MooseUtils::relativeFuzzyEqual(sum_plane_components, sum_110_type))
      _static_resistance_contribution[_qp][i] *= 2.5;
    else if (MooseUtils::relativeFuzzyEqual(sum_plane_components, sum_112_type))
      _static_resistance_contribution[_qp][i] *= 1.0;
    else if (MooseUtils::relativeFuzzyEqual(sum_plane_components, sum_123_type))
      _static_resistance_contribution[_qp][i] *= 2.0;
    else
      mooseError("Unexpected slip plane normal vector for applying BCC anisotropy in the elastic constants");
  }
}

Real
CrystalPlasticityCDDEnthalpyVelocityBCCFeUpdate::calculateClusterDefectHardening()
{
  // Calculate the strength due to cluster defects
  // with the dispersed barrier hardening model; same value for all slip systems
  const Real dispersed_power = 0.5; // Value should be determined from DD
  const Real dispersed_barrier = _irradiation_cluster_defect_size * _irradiation_cluster_defect_density;

  Real irr_cluster_strength = _irradiation_hardening_coefficient * _shear_modulus;
  irr_cluster_strength *= _burgers_vector * std::pow(dispersed_barrier, dispersed_power);

  return irr_cluster_strength;
}

Real
CrystalPlasticityCDDEnthalpyVelocityBCCFeUpdate::calculateSIALoopHardening()
{
  // Calculate the contribution to the slip system resistance due to SIA loops
  // Obstacle spacing = 1.0 / cbrt (_sia_loop_density)
  const Real coeff = _sia_loop_hardening_coefficient * _shear_modulus;
  const Real inner = Utility::pow<2>(_burgers_vector) * _sia_loop_size * _sia_loop_density[_qp];
  const Real sia_loop_slip_resistance = coeff * std::pow(inner, _sia_loop_hardening_exponent);

  return sia_loop_slip_resistance;
}

void
CrystalPlasticityCDDEnthalpyVelocityBCCFeUpdate::calculateIradiationSIALoopDensity()
{
  // The call order dicates that we are using the older version of the
  // dislocation density and the glide velocity to run the evolution calculation
  Real mobile_sum = 0.0;
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
    mobile_sum += _mobile_dislocations[_qp][i] * std::abs(_glide_velocity[_qp][i]);

  const Real increment_coeff = -4.0 * _sia_loop_annhiliation_coefficient * _sia_loop_radius_capture * _burgers_vector;
  const Real increment_sia_loop = increment_coeff * _sia_loop_density[_qp] * mobile_sum * _substep_dt;
  _sia_loop_density[_qp] = increment_sia_loop + _sia_loop_density_old[_qp];
}
