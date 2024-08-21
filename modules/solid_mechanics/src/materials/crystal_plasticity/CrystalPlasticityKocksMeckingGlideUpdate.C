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

registerMooseObject("SolidMechanicsApp", CrystalPlasticityKocksMeckingGlideUpdate);

InputParameters
CrystalPlasticityKocksMeckingGlideUpdate::validParams()
{
  InputParameters params = CrystalPlasticityStressUpdateBase::validParams();
  params.addClassDescription("Two-term dislocation glide model (multiplication and annhiliation) "
                             "for cubic crystals with a power-law hardening glide velocity model.");

  params.addRequiredRangeCheckedParam<Real>(
      "initial_dislocation_density",
      "initial_dislocation_density>0",
      "The initial state density of the glide dislocations, in 1/mm^2, assumed to be split "
      "evenly among all slip systems");

  params.addRangeCheckedParam<Real>(
      "dislocation_multiplication_coefficient",
      1.0,
      "dislocation_multiplication_coefficient>0",
      "Scaling coefficient for the multiplication terms of the dislocation evolution");

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
      "Distance between two edge dislocation dipoles for dislocation annihilation");
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

    _dislocation_density(declareProperty<std::vector<Real>>(_base_name + "dislocation_density")),
    _dislocation_density_old(
        getMaterialPropertyOld<std::vector<Real>>(_base_name + "dislocation_density")),
    _dislocation_increment(
        declareProperty<std::vector<Real>>(_base_name + "dislocation_increment")),
    _initial_dislocation_density(getParam<Real>(_base_name + "initial_dislocation_density")),

    // Dislocation glide velocity parameters
    _burgers_vector(getParam<Real>(_base_name + "burgers_vector")),
    _gamma_reference(getParam<Real>(_base_name + "reference_slip_rate")),
    _m_exp(getParam<Real>("strain_rate_sensitivity_exponent")),
    _glide_velocity(declareProperty<std::vector<Real>>("dislocation_glide_velocity")),
    _inital_glide_velocity(_gamma_reference / (_burgers_vector * _initial_dislocation_density)),

    // plastic slip increment used in constitutive model calculations
    _constitutive_slip_increment(declareProperty<std::vector<Real>>("constitutive_slip_increment")),

    // Dislocation evolution calibration coefficients
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
  _previous_substep_dislocations.resize(_number_slip_systems);
  _slip_resistance_before_update.resize(_number_slip_systems);
  _dislocations_before_update.resize(_number_slip_systems);

  sortForestInteractions();
}

void
CrystalPlasticityKocksMeckingGlideUpdate::initQpStatefulProperties()
{
  CrystalPlasticityStressUpdateBase::initQpStatefulProperties();
  // Resize constitutive-model specific material properties
  _dislocation_density[_qp].resize(_number_slip_systems);

  // Set constitutive-model specific initial values from parameters
  const Real dislocation_density_per_system = _initial_dislocation_density / _number_slip_systems;
  for (const auto i : make_range(_number_slip_systems))
  {
    _dislocation_density[_qp][i] = dislocation_density_per_system;
    _slip_increment[_qp][i] = 0.0;
  }

  /// add an initial resistance calculation here?
  /// And then set the slip resistance calculation too
}

void
CrystalPlasticityKocksMeckingGlideUpdate::setMaterialVectorSize()
{
  CrystalPlasticityStressUpdateBase::setMaterialVectorSize();

  // Resize non-stateful material properties
  _dislocation_increment[_qp].resize(_number_slip_systems);
  _glide_velocity[_qp].resize(_number_slip_systems);
  _constitutive_slip_increment[_qp].resize(_number_slip_systems);
}

void
CrystalPlasticityKocksMeckingGlideUpdate::sortForestInteractions()
{
  _forest_interaction_systems.resize(_number_slip_systems);

  for (const auto p : make_range(_number_slip_systems))
  {
    for (const auto d : make_range(_number_slip_systems))
    {
      const auto dot = _slip_plane_normal[p] * (_slip_direction[d]);
      if (!(MooseUtils::absoluteFuzzyEqual(dot, 0.0)))
        _forest_interaction_systems[p].push_back(d);
    }
  }

  if (_print_convergence_message)
  {
    mooseWarning("The provided slip systems have been sorted into the forest dislocation "
                 "interaction groups: \n");
    for (const auto p : make_range(_number_slip_systems))
    {
      Moose::out << "  For slip system " << p
                 << " the following slip systems will contribute to the forest dislocation "
                    "calculation:\n      [";
      for (const auto i : index_range(_forest_interaction_systems[p]))
        Moose::out << " " << _forest_interaction_systems[p][i] << " ";
      Moose::out << "]\n";
    }
  }
}

void
CrystalPlasticityKocksMeckingGlideUpdate::setInitialConstitutiveVariableValues()
{
  _slip_resistance[_qp] = _slip_resistance_old[_qp];
  _previous_substep_slip_resistance = _slip_resistance_old[_qp];

  _dislocation_density[_qp] = _dislocation_density_old[_qp];
  _previous_substep_dislocations = _dislocation_density_old[_qp];
}

void
CrystalPlasticityKocksMeckingGlideUpdate::setSubstepConstitutiveVariableValues()
{
  _slip_resistance[_qp] = _previous_substep_slip_resistance;
  _dislocation_density[_qp] = _previous_substep_dislocations;
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

  // Calculate the slip increment due to dislocation glide (Orowan's relation)
  for (const auto i : make_range(_number_slip_systems))
  {
    _slip_increment[_qp][i] =
        _dislocation_density[_qp][i] * _burgers_vector * _glide_velocity[_qp][i];
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
  if (isConstitutiveStateVariableConverged(_dislocation_density[_qp],
                                           _dislocations_before_update,
                                           _previous_substep_dislocations,
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
  _previous_substep_dislocations = _dislocation_density[_qp];
}

void
CrystalPlasticityKocksMeckingGlideUpdate::cacheStateVariablesBeforeUpdate()
{
  _slip_resistance_before_update = _slip_resistance[_qp];
  _dislocations_before_update = _dislocation_density[_qp];
}

void
CrystalPlasticityKocksMeckingGlideUpdate::calculateStateVariableEvolutionRateComponent()
{
  calculateDislocationEvolutionIncrement();
}

void
CrystalPlasticityKocksMeckingGlideUpdate::calculateDislocationEvolutionIncrement()
{
  DenseVector<Real> mean_free_glide_path(_number_slip_systems);
  calculateMeanFreeGlidePath(mean_free_glide_path);

  for (const auto i : make_range(_number_slip_systems))
  {
    const Real driving_force = std::abs(_constitutive_slip_increment[_qp][i]) / _burgers_vector;
    const Real multiplication = _multiplication_coeff * mean_free_glide_path(i);
    const Real annihilation = 2.0 * _edge_distance_coeff * _dislocation_density[_qp][i];
    _dislocation_increment[_qp][i] = driving_force * (multiplication - annihilation);
  }
}

void
CrystalPlasticityKocksMeckingGlideUpdate::calculateMeanFreeGlidePath(
    DenseVector<Real> & mean_free_glide_path)
{
  const Real grain_size_term = 1.0 / _grain_size;
  DenseVector<Real> forest_dislocation_density(_number_slip_systems, 0.0);

  for (const auto i : make_range(_number_slip_systems))
  {
    for (const auto b : index_range(_forest_interaction_systems[i]))
    {
      const auto index = _forest_interaction_systems[i][b];
      forest_dislocation_density(i) += _dislocation_density[_qp][index];
    }
  }

  for (const auto i : make_range(_number_slip_systems))
    mean_free_glide_path(i) =
        _forest_generation_coeff * std::sqrt(forest_dislocation_density(i)) + grain_size_term;
}

void
CrystalPlasticityKocksMeckingGlideUpdate::calculateSlipResistance()
{
  std::vector<Real> forest_hardening(_number_slip_systems);
  calculateForestSlipResistance(forest_hardening);

  // add to the constant initial value, while it's not a function of temperature
  for (const auto i : make_range(_number_slip_systems))
    _slip_resistance[_qp][i] = _initial_lattice_friction + forest_hardening[i];
}

void
CrystalPlasticityKocksMeckingGlideUpdate::calculateForestSlipResistance(
    std::vector<Real> & forest_hardening)
{
  const Real lead_term = _forest_hardening_coeff * _shear_modulus * _burgers_vector;
  for (const auto i : make_range(_number_slip_systems))
  {
    Real sum_hardening = 0.0;
    for (const auto j : make_range(_number_slip_systems))
    {
      if (i == j)
        sum_hardening += _forest_self_hardening * _dislocation_density[_qp][j];
      else
        sum_hardening += _forest_latent_hardening * _dislocation_density[_qp][j];
    }

    forest_hardening[i] = lead_term * std::sqrt(sum_hardening);
  }
}

bool
CrystalPlasticityKocksMeckingGlideUpdate::updateStateVariables()
{
  if (calculateDislocationDensity())
    return true;
  else
    return false;
}

bool
CrystalPlasticityKocksMeckingGlideUpdate::calculateDislocationDensity()
{
  bool positive_dislocation_density = true;
  for (const auto i : make_range(_number_slip_systems))
  {
    if (_previous_substep_dislocations[i] < _zero_tol && _dislocation_increment[_qp][i] < 0.0)
      _dislocation_density[_qp][i] = _previous_substep_dislocations[i];
    else
      _dislocation_density[_qp][i] =
          _previous_substep_dislocations[i] + _dislocation_increment[_qp][i];

    if (_dislocation_density[_qp][i] < 0.0)
    {
      mooseError("this code really hates me and is a super material. also there was a negative "
                 "dislocation density");
      positive_dislocation_density = false;
    }
  }
  return positive_dislocation_density;
}
