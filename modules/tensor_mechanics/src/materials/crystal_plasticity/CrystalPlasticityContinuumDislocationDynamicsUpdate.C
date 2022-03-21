//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "CrystalPlasticityContinuumDislocationDynamicsUpdate.h"
#include "libmesh/int_range.h"

registerMooseObject("TensorMechanicsApp", CrystalPlasticityContinuumDislocationDynamicsUpdate);

InputParameters
CrystalPlasticityContinuumDislocationDynamicsUpdate::validParams()
{
  InputParameters params = CrystalPlasticityStressUpdateBase::validParams();
  params.addClassDescription("Continuum Dislocation Dynamics model for crystal plasticity, "
                             "relating mobile dislocations to slip through Orowan's law.");
  params.addParam<Real>("initial_mobile_dislocation_density",
                        1.0e6,
                        "Initial density of mobile dislocation densities, in 1/mm^2");
  params.addParam<Real>("initial_immobile_dislocation_density",
                        1.0e6,
                        "Initial density of immobile dislocation densities, in 1/mm^2");

  params.addParam<Real>("burgers_vector", 2.48e-7, "The Burger's vector for the material, in mm");
  params.addParam<Real>("gamma_o", 4.0e-2, "reference strain rate on the slip system, in mm/s");
  params.addParam<Real>("strain_rate_sensitivity_exponent",
                        0.012,
                        "The strain rate sensitivity exponent for the power law relationship of "
                        "resolved shear stress");
  params.addParam<Real>(
      "Peierls_stress", 11.0, "Internal friction strength for the individual slip system, in MPa");
  params.addParam<Real>("shear_modulus", 80.0e3, "The shear modulus of the crystal, in MPa");

  params.addParam<Real>(
      "Baily_Hirsch_barrier_coefficient",
      0.4,
      "Leading coefficient for the Baily-Hirsch dispersed barrier hardening model");
  params.addParam<Real>("dislocation_latent_hardening_parameter",
                        0.2,
                        "Latent hardening factor for slip system hardening due to dislocations on "
                        "other slip systems");
  params.addParam<Real>("dislocation_self_hardening_parameter",
                        1.0,
                        "Self hardening factor for slip system hardening due to dislocations on "
                        "the same slip system");

  params.addParam<Real>("alpha_1", 0.02, "Mobile dislocation multiplication coefficient");
  params.addParam<Real>("alpha_2", 1.0, "Mobile-mobile dislocation annhiliation coefficient");
  params.addParam<Real>(
      "alpha_3",
      0.002,
      "Immobilization of mobile dislocations coefficient: mobile dislocations becoming immobile");
  params.addParam<Real>("alpha_4",
                        0.002,
                        "Mobilization of immobile dislocations coefficient: immobile dislocations "
                        "becoming mobile due to higher stress");
  params.addParam<Real>("alpha_5", 0.018, "Cross-slip coefficient");
  params.addParam<Real>(
      "cross_slip_barrier_strength", 5.0, "The strength of the crystal to resist cross slip");
  params.addParam<Real>("alpha_6", 1.0, "Mobile-immobile dislocation annhiliaton coefficient");
  params.addParam<Real>("radius_capture_annhiliation",
                        15.0,
                        "Multiplier of the Burger's vector to determine the radius of capture for "
                        "two annhiliating dislocations on the same slip plane");
  params.addParam<Real>("mean_free_glide_path_coefficient",
                        1.0,
                        "The coefficient for the calculation of the mean free glide path term from "
                        "the mobile and immobile dislocation densities");

  params.addParam<bool>("calculate_cross_slip",
                        true,
                        "Include the cross slip term in the mobile dislocation "
                        "evolution calculation");
  params.addParam<Real>("cross_slip_activation_barrier_factor",
                        0.004,
                        "The factor by which to multiply the shear modulus to calculate the "
                        "strength barrier which a dislocation must overcome to cross slip");
  params.addParam<Real>("cross_slip_activation_volume_factor",
                        20.0,
                        "The factor by which to multiply the burger's vector to determine the "
                        "volume required for a dislocation to cross slip");
  params.addParam<Real>("Boltzman_constant", 1.38065e-20, "Boltzman constant, in MPa-mm^3/K");
  params.addParam<Real>("temperature", 323.0, "The coupled temperature, in K");

  // params.addParam<MaterialPropertyName>(
  //     "total_twin_volume_fraction",
  //     "Total twin volume fraction, if twinning is considered in the simulation");

  return params;
}

CrystalPlasticityContinuumDislocationDynamicsUpdate::
    CrystalPlasticityContinuumDislocationDynamicsUpdate(const InputParameters & parameters)
  : CrystalPlasticityStressUpdateBase(parameters),

    // Dislocation densities
    _mobile_dislocations(declareProperty<std::vector<Real>>(_base_name + "mobile_dislocations")),
    _mobile_dislocations_old(
        getMaterialPropertyOld<std::vector<Real>>(_base_name + "mobile_dislocations")),
    _mobile_dislocations_increment(
        declareProperty<std::vector<Real>>(_base_name + "mobile_dislocations_increment")),
    _initial_mobile_dislocation_density(getParam<Real>("initial_mobile_dislocation_density")),
    _immobile_dislocations(
        declareProperty<std::vector<Real>>(_base_name + "immobile_dislocations")),
    _immobile_dislocations_old(
        getMaterialPropertyOld<std::vector<Real>>(_base_name + "immobile_dislocations")),
    _immobile_dislocations_increment(
        declareProperty<std::vector<Real>>(_base_name + "immobile_dislocations_increment")),
    _initial_immobile_dislocation_density(getParam<Real>("initial_immobile_dislocation_density")),
    _cross_slip_dislocations(
        declareProperty<std::vector<Real>>(_base_name + "cross_slip_dislocations")),

    // Mobile dislocation glide velocity parameters
    _burgers_vector(getParam<Real>("burgers_vector")),
    _gamma_reference(getParam<Real>("gamma_o")),
    _m_exp(getParam<Real>("strain_rate_sensitivity_exponent")),
    _glide_velocity(declareProperty<std::vector<Real>>("dislocation_glide_velocity")),
    _inital_glide_velocity(_gamma_reference /
                           (_burgers_vector * _initial_mobile_dislocation_density)),

    // Slip system resistance parameters
    _shear_modulus(getParam<Real>("shear_modulus")),
    _peierls_strength(getParam<Real>("Peierls_stress")),
    _static_resistance_contribution(_number_slip_systems, 0.0),

    // Dislocation-dislocation hardening specific parameters
    _baily_hirsch_alpha(getParam<Real>("Baily_Hirsch_barrier_coefficient")),
    _dislocation_latent_hardening(getParam<Real>("dislocation_latent_hardening_parameter")),
    _dislocation_self_hardening(getParam<Real>("dislocation_self_hardening_parameter")),

    // CDD evolution model parameters
    _alpha_1(getParam<Real>("alpha_1")),
    _alpha_2(getParam<Real>("alpha_2")),
    _alpha_3(getParam<Real>("alpha_3")),
    _alpha_4(getParam<Real>("alpha_4")),
    _alpha_5(getParam<Real>("alpha_5")),
    _cross_slip_barrier_strength(getParam<Real>("cross_slip_barrier_strength")),
    _alpha_6(getParam<Real>("alpha_6")),
    _radius_capture(getParam<Real>("radius_capture_annhiliation")),
    _glide_path_coeff(getParam<Real>("mean_free_glide_path_coefficient")),

    // Dislocation cross slip parameters
    _calculate_cross_slip(getParam<bool>("calculate_cross_slip")),
    _cs_activation_barrier(getParam<Real>("cross_slip_activation_barrier_factor") * _shear_modulus),
    _cs_activation_volume(getParam<Real>("cross_slip_activation_volume_factor") *
                          Utility::pow<3>(_burgers_vector)),
    _boltzmann_constant(getParam<Real>("Boltzman_constant")),
    _temperature(getParam<Real>("temperature")),

    // // Twinning contributions, if used
    // _include_twinning_in_Lp(parameters.isParamValid("total_twin_volume_fraction")),
    // _twin_volume_fraction_total(_include_twinning_in_Lp
    //                                 ? &getMaterialPropertyOld<Real>("total_twin_volume_fraction")
    //                                 : nullptr)

    // resize local caching vectors used for substepping
    _previous_substep_mobile_dislocations(_number_slip_systems, 0.0),
    _previous_substep_immobile_dislocations(_number_slip_systems, 0.0),
    _previous_substep_slip_resistance(_number_slip_systems, 0.0),
    _mobile_dislocations_before_update(_number_slip_systems, 0.0),
    _immobile_dislocations_before_update(_number_slip_systems, 0.0),
    _slip_resistance_before_update(_number_slip_systems, 0.0)
{
  setRandomResetFrequency(EXEC_TIMESTEP_END);
}

void
CrystalPlasticityContinuumDislocationDynamicsUpdate::initQpStatefulProperties()
{
  CrystalPlasticityStressUpdateBase::initQpStatefulProperties();

  _mobile_dislocations[_qp].resize(_number_slip_systems);
  _mobile_dislocations_increment[_qp].resize(_number_slip_systems);
  _immobile_dislocations[_qp].resize(_number_slip_systems);
  _immobile_dislocations_increment[_qp].resize(_number_slip_systems);
  _cross_slip_dislocations[_qp].resize(_number_slip_systems);
  _glide_velocity[_qp].resize(_number_slip_systems);

  // Loop over the slip systems and set the initial values from the user input
  const Real initial_mobile_per_system = _initial_mobile_dislocation_density / _number_slip_systems;
  const Real initial_immobile_per_system =
      _initial_immobile_dislocation_density / _number_slip_systems;
  for (auto i : make_range(_number_slip_systems))
  {
    _mobile_dislocations[_qp][i] = initial_mobile_per_system;
    _mobile_dislocations_increment[_qp][i] = 0.0;
    _immobile_dislocations[_qp][i] = initial_immobile_per_system;
    _immobile_dislocations_increment[_qp][i] = 0.0;
    _cross_slip_dislocations[_qp][i] = 0.0;

    _slip_increment[_qp][i] = 0.0;
    _glide_velocity[_qp][i] = 0.0;
  }

  initSlipSystemResistance();
}

void
CrystalPlasticityContinuumDislocationDynamicsUpdate::initSlipSystemResistance()
{
  for (const auto i : make_range(_number_slip_systems))
    _static_resistance_contribution[i] = _peierls_strength;

  calculateSlipResistance();
}

void
CrystalPlasticityContinuumDislocationDynamicsUpdate::setInitialConstitutiveVariableValues()
{
  _mobile_dislocations[_qp] = _mobile_dislocations_old[_qp];
  _previous_substep_mobile_dislocations = _mobile_dislocations_old[_qp];

  _immobile_dislocations[_qp] = _immobile_dislocations_old[_qp];
  _previous_substep_immobile_dislocations = _immobile_dislocations_old[_qp];

  _slip_resistance[_qp] = _slip_resistance_old[_qp];
  _previous_substep_slip_resistance = _slip_resistance_old[_qp];
}

void
CrystalPlasticityContinuumDislocationDynamicsUpdate::setSubstepConstitutiveVariableValues()
{
  _mobile_dislocations[_qp] = _previous_substep_mobile_dislocations;
  _immobile_dislocations[_qp] = _previous_substep_immobile_dislocations;
  _slip_resistance[_qp] = _previous_substep_slip_resistance;
}

bool
CrystalPlasticityContinuumDislocationDynamicsUpdate::calculateSlipRate()
{
  for (const auto i : make_range(_number_slip_systems))
  {
    const Real abs_tau = std::abs(_tau[_qp][i]);
    if (abs_tau >= _peierls_strength)
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
        _mobile_dislocations[_qp][i] * _burgers_vector * _glide_velocity[_qp][i] * _substep_dt;
    if (std::abs(_slip_increment[_qp][i]) > _slip_incr_tol)
    {
      if (_print_convergence_message)
        mooseWarning("Maximum allowable slip increment exceeded ",
                     std::abs(_slip_increment[_qp][i]));

      return false;
    }
    // Hold on to this because I"m not sure if I'm goign to need to multiply by the timestep here
    // if (std::abs(_slip_increment[_qp][i]) * _substep_dt > _slip_incr_tol)
    // {
    //   if (_print_convergence_message)
    //     mooseWarning("Maximum allowable slip increment exceeded ",
    //                  std::abs(_slip_increment[_qp][i]) * _substep_dt);
    //
    //   return false;
    // }
  }
  return true;
}

// void
// CrystalPlasticityContinuumDislocationDynamicsUpdate::calculateEquivalentSlipIncrement(
//     RankTwoTensor & equivalent_slip_increment)
// {
//   // if (_include_twinning_in_Lp)
//   // {
//   //   for (auto i : make_range(_number_slip_systems))
//   //     equivalent_slip_increment += (1.0 - (*_twin_volume_fraction_total)[_qp]) *
//   //                                  _flow_direction[_qp][i] * _slip_increment[_qp][i] *
//   //                                  _substep_dt;
//   // }
//   // else // if no twinning volume fraction material property supplied, use base class
//   //   CrystalPlasticityStressUpdateBase::calculateEquivalentSlipIncrement(equivalent_slip_increment);
//  Also here is where I summed up the GND contribution for the nonlocal effects case
// }

void
CrystalPlasticityContinuumDislocationDynamicsUpdate::calculateConstitutiveSlipDerivative(
    std::vector<Real> & dslip_dtau)
{
  for (const auto i : make_range(_number_slip_systems))
  {
    if (MooseUtils::absoluteFuzzyEqual(_tau[_qp][i], 0.0))
      dslip_dtau[i] = 0.0;
    else
    {
      const Real glide_velocity_derivative = _glide_velocity[_qp][i] / (_m_exp * _tau[_qp][i]);
      dslip_dtau[i] =
          _mobile_dislocations[_qp][i] * _burgers_vector * glide_velocity_derivative * _substep_dt;
    }
  }
}

bool
CrystalPlasticityContinuumDislocationDynamicsUpdate::areConstitutiveStateVariablesConverged()
{
  if (isConstitutiveStateVariableConverged(_mobile_dislocations[_qp],
                                           _mobile_dislocations_before_update,
                                           _previous_substep_mobile_dislocations,
                                           _rel_state_var_tol) &&
      isConstitutiveStateVariableConverged(_immobile_dislocations[_qp],
                                           _immobile_dislocations_before_update,
                                           _previous_substep_immobile_dislocations,
                                           _rel_state_var_tol) &&
      isConstitutiveStateVariableConverged(_slip_resistance[_qp],
                                           _slip_resistance_before_update,
                                           _previous_substep_slip_resistance,
                                           _resistance_tol))
    return true;
  return false;
}

void
CrystalPlasticityContinuumDislocationDynamicsUpdate::updateSubstepConstitutiveVariableValues()
{
  _previous_substep_mobile_dislocations = _mobile_dislocations[_qp];
  _previous_substep_immobile_dislocations = _immobile_dislocations[_qp];
  _previous_substep_slip_resistance = _slip_resistance[_qp];
}

void
CrystalPlasticityContinuumDislocationDynamicsUpdate::cacheStateVariablesBeforeUpdate()
{
  _mobile_dislocations_before_update = _mobile_dislocations[_qp];
  _immobile_dislocations_before_update = _immobile_dislocations[_qp];
  _slip_resistance_before_update = _slip_resistance[_qp];
}

void
CrystalPlasticityContinuumDislocationDynamicsUpdate::calculateStateVariableEvolutionRateComponent()
{
  if (_calculate_cross_slip)
    calculateStochasticDislocationCrossSlip();

  // if (_calculate_gnd_contribution)
  //   calculateGeometricallyNecessaryDislocations();

  calculateCDDModelDislocationIncrement();
}

void
CrystalPlasticityContinuumDislocationDynamicsUpdate::calculateStochasticDislocationCrossSlip()
{
  for (const auto i : make_range(_number_cross_slip_directions))
  {
    std::vector<Real> family_xslip_probability(_number_cross_slip_planes);
    Real family_xslip_probability_sum = 0.0;
    std::vector<std::vector<unsigned int> > family_xslip_interactions(_number_cross_slip_planes, std::vector<unsigned int>(_number_cross_slip_planes, 1000));

    // Determine the probability of cross slip for each slip plane in the family
    for (const auto j : make_range(_number_cross_slip_planes))
    {
      const auto index = _cross_slip_familes[i][j];
      const Real xslip_force = (_cs_activation_barrier - std::abs(_tau[_qp][index])) * _cs_activation_volume;
      const Real xslip_probabilty = std::exp(-xslip_force / (_boltzmann_constant * _temperature));

      family_xslip_probability[j] = xslip_probabilty;
      family_xslip_probability_sum += xslip_probabilty;
    }

    // Now normalize the components of each probabilty by dividing by the probabilty sum
    for (const auto j : make_range(_number_cross_slip_planes))
      family_xslip_probability[j] /= family_xslip_probability_sum;

    // And build the CDF function for this family
    for (const auto j : make_range(_number_cross_slip_planes-1))
      family_xslip_probability[j + 1] += family_xslip_probability[j];

    if (MooseUtils::relativeFuzzyGreaterThan(family_xslip_probability[_number_cross_slip_planes - 1], 1.0))
      mooseError("The cumulative distribution function for the stochastic cross slip analysis was incorrectly calculated");

    // Monte Carlo Analysis using Moose's RandomInterface, assumes all systems can cross slip
    for (const auto giving_system : make_range(_number_cross_slip_planes))
    {
      // const Real xslip_dice = getRandomReal();
      const Real xslip_dice = 0.5;

      // Now check the value of the random xslip dice against the bin values to determine into which
      // slip system the dislocations will cross slip
      for (const auto j : make_range(_number_cross_slip_planes))
      {
        if (xslip_dice < family_xslip_probability[j])
        {
          const auto recieving_system = j;

          if (giving_system != recieving_system)  // Not self: cross slip occurs
          {
            // Find the actual index that corresponds to the giving system
            const auto index = _cross_slip_familes[i][giving_system];
            family_xslip_interactions[giving_system][giving_system] = index;
            family_xslip_interactions[recieving_system][giving_system] = index;
            // std::cout << "The value of the random Real is " << xslip_dice << " on slip system " << index << "\n";
          }
        break;
        }
      }
    }

    // Now need to calculate the sum of the cross slip dislocations
    // (probabilty * mobile dislocations) acting on each slip system in the cross slip family
    for (const auto a : make_range(_number_cross_slip_planes))
    {
      Real single_system_sum = 0.0;
      for (const auto b : make_range(_number_cross_slip_planes))
      {
        if (family_xslip_interactions[a][b] != 1000) // 1000 is the intital placeholder
        {
          const auto index = family_xslip_interactions[a][b];

          if (a != b) // recieving dislocations
            single_system_sum += _mobile_dislocations[_qp][index];
          else // a == b, giving dislocations
            single_system_sum -= _mobile_dislocations[_qp][index];
        }
      }
      // Now that have completed the summing, store in the appropriate position in the material property
      const auto self_index = _cross_slip_familes[i][a];
      _cross_slip_dislocations[_qp][self_index] = single_system_sum;
    }
  }
}


void
CrystalPlasticityContinuumDislocationDynamicsUpdate::calculateCDDModelDislocationIncrement()
{
  const Real glide_path_inv = calculateMeanFreeGlidePath();

  std::cout << "Looking at the cross slip for each slip system at qp " << _qp << "\n";
  for (const auto i : make_range(_number_slip_systems))
  {
    std::cout << "On slip system: " << i << "\n";
    const Real term1 = _alpha_1 * _mobile_dislocations[_qp][i] * glide_path_inv;

    const Real term2_mobile_sq = _mobile_dislocations[_qp][i] * _mobile_dislocations[_qp][i];
    const Real term2 = 2.0 * _alpha_2 * _radius_capture * _burgers_vector * term2_mobile_sq;
    const Real term3 = _alpha_3 * _mobile_dislocations[_qp][i] * glide_path_inv;

    const Real term4_force = std::sqrt(std::abs(_tau[_qp][i] / _slip_resistance[_qp][i]));
    const Real term4 = _alpha_4 * term4_force * _immobile_dislocations[_qp][i] * glide_path_inv;

    std::cout << "  the cross slip dislocations from the specific method is " << _cross_slip_dislocations[_qp][i] << "\n";
    const Real term5 = _cross_slip_dislocations[_qp][i] * _alpha_5 * glide_path_inv;
    std::cout << "  and the term 5 value is " << term5 * std::abs(_glide_velocity[_qp][i]) * _substep_dt << "\n";

    const Real term6 = _alpha_6 * _radius_capture * _burgers_vector * _mobile_dislocations[_qp][i] *
                       _immobile_dislocations[_qp][i];

    // Now add up the separate terms in the CDD Model
    _mobile_dislocations_increment[_qp][i] = (term1 - term2 - term3 + term4 + term5 - term6) *
                                             std::abs(_glide_velocity[_qp][i]) * _substep_dt;
    _immobile_dislocations_increment[_qp][i] =
        (term3 - term4 - term6) * std::abs(_glide_velocity[_qp][i]) * _substep_dt;

    // Update here the cross slip dislocations for consistency with other dislocation measures
    if (_calculate_cross_slip)
    {
      _cross_slip_dislocations[_qp][i] *=
          _alpha_5 * glide_path_inv * std::abs(_glide_velocity[_qp][i]) * _substep_dt;
      std::cout << "  and after mobile, immobile dislocation update the cross slip dislocation density is " << _cross_slip_dislocations[_qp][i] <<"\n\n";
    }
  }
}

Real
CrystalPlasticityContinuumDislocationDynamicsUpdate::calculateMeanFreeGlidePath()
{
  Real glide_path_inv = 0.0;
  for (const auto i : make_range(_number_slip_systems))
    glide_path_inv += _mobile_dislocations[_qp][i] + _immobile_dislocations[_qp][i];

  glide_path_inv = std::sqrt(glide_path_inv) // + _geometrical_necessary_dislocations[_qp])
                   * _glide_path_coeff;

  return glide_path_inv;
}

bool
CrystalPlasticityContinuumDislocationDynamicsUpdate::updateStateVariables()
{
  if (calculateDislocationDensity(_mobile_dislocations[_qp],
                                  _previous_substep_mobile_dislocations,
                                  _mobile_dislocations_increment[_qp]) &&
      calculateDislocationDensity(_immobile_dislocations[_qp],
                                  _previous_substep_immobile_dislocations,
                                  _immobile_dislocations_increment[_qp]))
    return true;
  else
    return false;
}

bool
CrystalPlasticityContinuumDislocationDynamicsUpdate::calculateDislocationDensity(
    std::vector<Real> & current_density,
    const std::vector<Real> & previous_substep_density,
    const std::vector<Real> & density_increment)
{
  bool positive_dislocation_density = true;

  for (const auto i : make_range(_number_slip_systems))
  {
    if (previous_substep_density[i] < _zero_tol && density_increment[i] < 0.0)
      current_density[i] = previous_substep_density[i];
    else
      current_density[i] = previous_substep_density[i] + density_increment[i];

    if (current_density[i] < 0.0)
      positive_dislocation_density = false;
  }
  return positive_dislocation_density;
}

void
CrystalPlasticityContinuumDislocationDynamicsUpdate::calculateSlipResistance()
{
  std::vector<Real> forest_strength(_number_slip_systems, 0.0);
  calculateDislocationForestHardening(forest_strength);

  for (const auto i : make_range(_number_slip_systems))
    _slip_resistance[_qp][i] = forest_strength[i] + _static_resistance_contribution[i];

  /**Hold on to the square root dependence, just in case
   * const Real sq_resistance = Utility::pow<2>(forest_strength[i])
   *                          + Utility::pow<2>(_static_resistance_contribution[i]);
   * _slip_resistance[_qp][i] = std::sqrt(sq_resistance);
   */
}

void
CrystalPlasticityContinuumDislocationDynamicsUpdate::calculateDislocationForestHardening(
    std::vector<Real> & forest_strength)
{
  const Real barrier_coeffient = _baily_hirsch_alpha * _burgers_vector * _shear_modulus;

  for (const auto i : make_range(_number_slip_systems))
  {
    Real sum = 0.0;
    for (const auto j : make_range(_number_slip_systems))
    {
      if (i != j)
        sum += _dislocation_latent_hardening *
               (_mobile_dislocations[_qp][j] + _immobile_dislocations[_qp][j]);
      else
        sum += _dislocation_self_hardening *
               (_mobile_dislocations[_qp][j] + _immobile_dislocations[_qp][j]);
    }
    forest_strength[i] = barrier_coeffient * std::sqrt(sum);
  }
}
