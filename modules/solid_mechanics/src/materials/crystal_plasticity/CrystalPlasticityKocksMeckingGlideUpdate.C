//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "CrystalPlasticityKocksMeckingGlideUpdate.h"
#include "libmesh/int_range.h"

registerMooseObject("TensorMechanicsApp", CrystalPlasticityKocksMeckingGlideUpdate);

InputParameters
CrystalPlasticityKocksMeckingGlideUpdate::validParams()
{
  InputParameters params = CrystalPlasticityStressUpdateBase::validParams();
  params.addClassDescription(
      "Two-term mobile dislocation glide model (multiplication and annhiliation) "
      "for cubic crystals with a power-law hardening glide velocity model.");

  params.addCoupledVar("temperature", "The name of the temperature variable");
  params.addRequiredRangeCheckedParam<Real>(
      "initial_dislocation_density",
      "initial_dislocation_density>0",
      "The initial state density of the mobile glide dislocations, in 1/mm^2, assumed to be split "
      "evenly among all slip systems");

  params.addRangeCheckedParam<Real>(
      "dislocation_multiplication_coefficient",
      1.0,
      "dislocation_multiplication_coefficient>0",
      "Scaling coefficient for the multiplication terms of the mobile dislocation evolution");

  params.addRequiredRangeCheckedParam<Real>(
      "burgers_vector", "burgers_vector>0", "The Burger's vector for the material, in mm");
  params.addRangeCheckedParam<Real>("reference_slip_rate",
                                    1.0e-3,
                                    "reference_slip_rate>0",
                                    "reference strain rate on the slip system, in mm/s");
  params.addRangeCheckedParam<Real>("strain_rate_sensitivity_exponent",
                                    0.05,
                                    "strain_rate_sensitivity_exponent>0",
                                    "The strain rate sensitivity exponent for the power law "
                                    "relationship for the dislocation glide velocity");
  params.addRangeCheckedParam<Real>(
      "forest_dislocation_multiplication_coefficient",
      1.0,
      "forest_dislocation_multiplication_coefficient>0",
      "The coefficient applied to only the forest dislocation contribution of the mean free glide "
      "path calcululation. The mean free glide path is used in the generation term of the "
      "dislocation evolution expression.");
  params.addRequiredRangeCheckedParam<Real>(
      "dipole_annihilation_distance",
      "dipole_annihilation_distance>0",
      "Distance between two edge dislocation dipoles for mobile dislocation annihilation");
  params.addRangeCheckedParam<Real>("grain_size",
                                    1.0,
                                    "grain_size>0",
                                    "Linear grain size dimension, in units of mm, for use in "
                                    "calculating the mean free glide path of mobile dislocations");

  params.addRangeCheckedParam<Real>(
      "forest_dislocation_hardening_coefficient",
      1.0,
      "forest_dislocation_hardening_coefficient>0",
      "Leading coefficient for the slip system resistance constribution "
      "due to forest dislocations");
  params.addRequiredRangeCheckedParam<Real>(
      "shear_modulus",
      "shear_modulus>0",
      "The average shear modulus value, used to calculate the "
      "hardening behavior of the individual slip systems");
  params.addParam<Real>("dislocation_latent_hardening_parameter",
                        0.2,
                        "Latent hardening factor for slip system hardening due to dislocations on "
                        "other slip systems");
  params.addParam<Real>("dislocation_self_hardening_parameter",
                        1.0,
                        "Self hardening factor for slip system hardening due to dislocations on "
                        "the same slip system");
  params.addRequiredRangeCheckedParam<Real>(
      "lattice_friction",
      "lattice_friction>0",
      "The initial lattice friction, or Peierls strength, for all slip systems in the crystal");

  params.addParam<MaterialPropertyName>(
      "total_twin_volume_fraction",
      "Total twin volume fraction, if twinning is considered in the simulation");

  return params;
}

CrystalPlasticityKocksMeckingGlideUpdate::CrystalPlasticityKocksMeckingGlideUpdate(
    const InputParameters & parameters)
  : CrystalPlasticityStressUpdateBase(parameters),

    _temperature(coupledValue("temperature")),
    _mobile_dislocation_density(
        declareProperty<std::vector<Real>>(_base_name + "mobile_dislocation_density")),
    _mobile_dislocation_density_old(
        getMaterialPropertyOld<std::vector<Real>>(_base_name + "mobile_dislocation_density")),
    _mobile_dislocation_increment(
        declareProperty<std::vector<Real>>(_base_name + "mobile_dislocation_increment")),
    _initial_dislocation_density(getParam<Real>(_base_name + "initial_dislocation_density")),

    // Mobile dislocation glide velocity parameters
    _burgers_vector(getParam<Real>(_base_name + "burgers_vector")),
    _gamma_reference(getParam<Real>(_base_name + "reference_slip_rate")),
    _m_exp(getParam<Real>("strain_rate_sensitivity_exponent")),
    _glide_velocity(declareProperty<std::vector<Real>>("dislocation_glide_velocity")),
    _inital_glide_velocity(_gamma_reference / (_burgers_vector * _initial_dislocation_density)),

    // plastic slip increment used in constitutive model calculations
    _constitutive_slip_increment(declareProperty<std::vector<Real>>("constitutive_slip_increment")),

    // Mobile dislocation evolution calibration coefficients
    _multiplication_coeff(getParam<Real>(_base_name + "dislocation_multiplication_coefficient")),
    _forest_generation_coeff(
        getParam<Real>(_base_name + "forest_dislocation_multiplication_coefficient")),
    _edge_distance_coeff(getParam<Real>(_base_name + "dipole_annihilation_distance")),
    _grain_size(getParam<Real>(_base_name + "grain_size")),

    // Slip system resistance parameters
    _forest_hardening_coeff(
        getParam<Real>(_base_name + "forest_dislocation_hardening_coefficient")),
    _forest_latent_hardening(getParam<Real>("dislocation_latent_hardening_parameter")),
    _forest_self_hardening(getParam<Real>("dislocation_self_hardening_parameter")),
    _shear_modulus(getParam<Real>(_base_name + "shear_modulus")),
    _initial_lattice_friction(getParam<Real>(_base_name + "lattice_friction")),
    _static_resistance_contribution(_number_slip_systems, 0.0),

    // Twinning contributions, if used
    _include_twinning_in_Lp(parameters.isParamValid("total_twin_volume_fraction")),
    _twin_volume_fraction_total(_include_twinning_in_Lp
                                    ? &getMaterialPropertyOld<Real>("total_twin_volume_fraction")
                                    : nullptr)
{
  // resize local caching vectors used for substepping
  _previous_substep_slip_resistance.resize(_number_slip_systems);
  _previous_substep_mobile_dislocations.resize(_number_slip_systems);
  _slip_resistance_before_update.resize(_number_slip_systems);
  _mobile_dislocations_before_update.resize(_number_slip_systems);
}

void
CrystalPlasticityKocksMeckingGlideUpdate::initQpStatefulProperties()
{
  CrystalPlasticityStressUpdateBase::initQpStatefulProperties();
  // Resize constitutive-model specific material properties
  _mobile_dislocation_density[_qp].resize(_number_slip_systems);
  _mobile_dislocation_increment[_qp].resize(_number_slip_systems);
  _glide_velocity[_qp].resize(_number_slip_systems);
  _constitutive_slip_increment[_qp].resize(_number_slip_systems);

  // Set constitutive-model specific initial values from parameters
  const Real dislocation_density_per_system = _initial_dislocation_density / _number_slip_systems;
  for (const auto i : make_range(_number_slip_systems))
  {
    _mobile_dislocation_density[_qp][i] = dislocation_density_per_system;
    _mobile_dislocation_increment[_qp][i] = 0.0;

    _slip_increment[_qp][i] = 0.0;
    _glide_velocity[_qp][i] = 0.0;
  }

  /// add an initial resistance calculation here?
  /// And then set the slip resistance calculation too
}

void
CrystalPlasticityKocksMeckingGlideUpdate::setInitialConstitutiveVariableValues()
{
  _slip_resistance[_qp] = _slip_resistance_old[_qp];
  _previous_substep_slip_resistance = _slip_resistance_old[_qp];

  _mobile_dislocation_density[_qp] = _mobile_dislocation_density_old[_qp];
  _previous_substep_mobile_dislocations = _mobile_dislocation_density_old[_qp];
}

void
CrystalPlasticityKocksMeckingGlideUpdate::setSubstepConstitutiveVariableValues()
{
  _slip_resistance[_qp] = _previous_substep_slip_resistance;
  _mobile_dislocation_density[_qp] = _previous_substep_mobile_dislocations;
}

bool
CrystalPlasticityKocksMeckingGlideUpdate::calculateSlipRate()
{
  for (const auto i : make_range(_number_slip_systems))
  {
    const Real abs_tau = std::abs(_tau[_qp][i]);
    if (abs_tau >= _initial_lattice_friction)
    {
      const Real driving_force = abs_tau / _slip_resistance[_qp][i];
      _glide_velocity[_qp][i] = _inital_glide_velocity * std::pow(driving_force, (1.0 / _m_exp));
      if (_tau[_qp][i] < 0.0)
        _glide_velocity[_qp][i] *= -1.0;
    }
    else // Not enough driving force to move the dislocations
      _glide_velocity[_qp][i] = 0.0;
  }

  // Calculate the slip increment due to mobile dislocation glide (Orowan's relation)
  for (const auto i : make_range(_number_slip_systems))
  {
    _slip_increment[_qp][i] =
        _mobile_dislocation_density[_qp][i] * _burgers_vector * _glide_velocity[_qp][i];
    _constitutive_slip_increment[_qp][i] = _slip_increment[_qp][i] * _substep_dt;
    if (std::abs(_constitutive_slip_increment[_qp][i]) > _slip_incr_tol)
    {
      if (_print_convergence_message)
        mooseWarning("Maximum allowable slip increment exceeded ",
                     std::abs(_constitutive_slip_increment[_qp][i]));

      return false;
    }
  }
  return true;
}

void
CrystalPlasticityKocksMeckingGlideUpdate::calculateEquivalentSlipIncrement(
    RankTwoTensor & equivalent_slip_increment)
{
  if (_include_twinning_in_Lp)
  {
    for (const auto i : make_range(_number_slip_systems))
      equivalent_slip_increment += (1.0 - (*_twin_volume_fraction_total)[_qp]) *
                                   _flow_direction[_qp][i] * _slip_increment[_qp][i] * _substep_dt;
  }
  else // if no twinning volume fraction material property supplied, use base class
    CrystalPlasticityStressUpdateBase::calculateEquivalentSlipIncrement(equivalent_slip_increment);
}

void
CrystalPlasticityKocksMeckingGlideUpdate::calculateConstitutiveSlipDerivative(
    std::vector<Real> & dslip_dtau)
{
  for (const auto i : make_range(_number_slip_systems))
  {
    if (MooseUtils::absoluteFuzzyEqual(_tau[_qp][i], 0.0))
      dslip_dtau[i] = 0.0;
    else
      dslip_dtau[i] = _slip_increment[_qp][i] / (_m_exp * std::abs(_tau[_qp][i])) * _substep_dt;
  }
}

bool
CrystalPlasticityKocksMeckingGlideUpdate::areConstitutiveStateVariablesConverged()
{
  if (isConstitutiveStateVariableConverged(_mobile_dislocation_density[_qp],
                                           _mobile_dislocations_before_update,
                                           _previous_substep_mobile_dislocations,
                                           _rel_state_var_tol) &&
      isConstitutiveStateVariableConverged(_slip_resistance[_qp],
                                           _slip_resistance_before_update,
                                           _previous_substep_slip_resistance,
                                           _resistance_tol))
    return true;
  return false;
}

void
CrystalPlasticityKocksMeckingGlideUpdate::updateSubstepConstitutiveVariableValues()
{
  _previous_substep_slip_resistance = _slip_resistance[_qp];
  _previous_substep_mobile_dislocations = _mobile_dislocation_density[_qp];
}

void
CrystalPlasticityKocksMeckingGlideUpdate::cacheStateVariablesBeforeUpdate()
{
  _slip_resistance_before_update = _slip_resistance[_qp];
  _mobile_dislocations_before_update = _mobile_dislocation_density[_qp];
}

void
CrystalPlasticityKocksMeckingGlideUpdate::calculateStateVariableEvolutionRateComponent()
{
  calculateMobileDislocationEvolutionIncrement();
}

void
CrystalPlasticityKocksMeckingGlideUpdate::calculateMobileDislocationEvolutionIncrement()
{
  DenseVector<Real> mean_free_glide_path(_number_slip_systems);
  calculateMeanFreeGlidePath(mean_free_glide_path);

  for (const auto i : make_range(_number_slip_systems))
  {
    const Real driving_force = std::abs(_constitutive_slip_increment[_qp][i]) / _burgers_vector;
    const Real multiplication = _multiplication_coeff * mean_free_glide_path(i);
    const Real annihilation = 2.0 * _edge_distance_coeff * _mobile_dislocation_density[_qp][i];
    _mobile_dislocation_increment[_qp][i] = driving_force * (multiplication - annihilation);
  }
}

void
CrystalPlasticityKocksMeckingGlideUpdate::calculateMeanFreeGlidePath(
    DenseVector<Real> & mean_free_glide_path)
{
  const Real grain_size_term = 1.0 / _grain_size;
  Real forest_dislocation_sum = 0.0;
  for (const auto i : make_range(_number_slip_systems))
    forest_dislocation_sum += _mobile_dislocation_density[_qp][i];

  for (const auto i : make_range(_number_slip_systems))
    mean_free_glide_path(i) =
        _forest_generation_coeff * std::sqrt(forest_dislocation_sum) + grain_size_term;
}

void
CrystalPlasticityKocksMeckingGlideUpdate::calculateSlipResistance()
{
  DenseVector<Real> forest_hardening(_number_slip_systems);

  const Real lead_term = _forest_hardening_coeff * _shear_modulus * _burgers_vector;
  for (const auto i : make_range(_number_slip_systems))
  {
    Real sum_hardening = 0.0;
    for (const auto j : make_range(_number_slip_systems))
    {
      if (i == j)
        sum_hardening += _forest_self_hardening * _mobile_dislocation_density[_qp][j];
      else
        sum_hardening += _forest_latent_hardening * _mobile_dislocation_density[_qp][j];
    }

    forest_hardening(i) = lead_term * std::sqrt(sum_hardening);
  }

  // have the constant initial value, while it's not a function of temperature, sum
  for (const auto i : make_range(_number_slip_systems))
    _slip_resistance[_qp][i] = _initial_lattice_friction + forest_hardening(i);
}

bool
CrystalPlasticityKocksMeckingGlideUpdate::updateStateVariables()
{
  if (calculateMobileDislocationDensity())
    return true;
  else
    return false;
}

bool
CrystalPlasticityKocksMeckingGlideUpdate::calculateMobileDislocationDensity()
{
  for (const auto i : make_range(_number_slip_systems))
  {
    if (_previous_substep_mobile_dislocations[i] < _zero_tol &&
        _mobile_dislocation_increment[_qp][i] < 0.0)
      _mobile_dislocation_density[_qp][i] = _previous_substep_mobile_dislocations[i];
    else
      _mobile_dislocation_density[_qp][i] =
          _previous_substep_mobile_dislocations[i] + _mobile_dislocation_increment[_qp][i];

    if (_mobile_dislocation_density[_qp][i] < 0.0)
      return false;
  }
  return true;
}
