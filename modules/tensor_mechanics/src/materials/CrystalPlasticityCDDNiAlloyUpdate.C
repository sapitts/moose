//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "CrystalPlasticityCDDNiAlloyUpdate.h"
#include "libmesh/utility.h"

registerMooseObject("TensorMechanicsApp", CrystalPlasticityCDDNiAlloyUpdate);

template <>
InputParameters validParams<CrystalPlasticityCDDNiAlloyUpdate>()
{
  InputParameters params = validParams<CrystalPlasticityCDDUpdateBase>();
  params.addClassDescription("Continuum Dislocation Dynamics crystal plasticity model for Ni-Cr alloys which experience formation of aging long-range ordered precipiates");

  params.addParam<Real>("tertiary_precipitate_mean_diameter", 0.0, "The average diameter of the tertiary gamma prime long-range ordered precipitates, in mm");
  params.addParam<Real>("tertiary_precipitate_volume_fraction", 0.0, "The volume fraction of the tertiary gamma prime long-range ordered precipitates, dimensionless");

  params.addParam<Real>("orowan_bowing_hardening_coefficient", 1.0, "Coefficient for the slip system strengthening due to Orowan bowing of dislocations around the long-range ordered gamma prime precipitates");

  params.addParam<Real>("tertiary_apb_shearing_coefficient", 1.0, "Coefficient for the slip system strengthing due to weakly-coupled anti-phase boundary shearing of tertiary long-range ordered precipitates");
  params.addParam<Real>("tertiary_apb_shearing_energy", 2.0e-4, "Energy of the anti-phase boundary for the weakly-coupled APB shearing model");

  params.addRequiredParam<unsigned int>("number_twin_systems", "The total number of possible active twinning systems for the crystalline material");
  params.addRequiredParam<FileName>("twin_system_file_name", "Name of the file containing the twinning systems");
  return params;
  params.addParam<Real>("characteristic_twin_shear", 1.0/std::sqrt(2.0), "The amount of shear that is characteristic for a twin in this material");
  params.addParam<Real>("upper_limit_twin_volume_fraction", 0.8, "The maximumum amount of twinning volume fraction allowed");
}

CrystalPlasticityCDDNiAlloyUpdate::CrystalPlasticityCDDNiAlloyUpdate(const InputParameters & parameters) :
    CrystalPlasticityCDDUpdateBase(parameters),

    // tertiary LRO gamma prime geometric parameters
    _tertiary_mean_diameter(getParam<Real>("tertiary_precipitate_mean_diameter")),
    _tertiary_volume_fraction(getParam<Real>("tertiary_precipitate_volume_fraction")),

    // Orowan bowing hardening parameters
    _orowan_bowing_coeff(getParam<Real>("orowan_bowing_hardening_coefficient")),

    // Weakly coupled APB shearing model (for small tertiary precipitates)
    _tertiary_apb_coeff(getParam<Real>("tertiary_apb_shearing_coefficient")),
    _tertiary_apb_energy(getParam<Real>("tertiary_apb_shearing_energy")),

    // Twinning system
    _number_twin_systems(getParam<unsigned int>("number_twin_systems")),
    _twin_system_file_name(getParam<FileName>("twin_system_file_name")),
    _volume_fraction_twins(declareProperty<std::vector<Real> >("_volume_fraction_twins")),
    _volume_fraction_twins_old(getMaterialPropertyOld<std::vector<Real> >("_volume_fraction_twins")),
    _twin_shear_increment(declareProperty<std::vector<Real> >("twin_shear_increment")),
    _characteristic_twin_shear(getParam<Real>("characteristic_twin_shear")),
    _twin_system_resistance(declareProperty<std::vector<Real> >("twin_system_resistance")),
    _tau_twin_sytem(declareProperty<std::vector<Real> >("applied_shear_stress_twin_system")),
    _limit_twin_volume_fraction(getParam<Real>("upper_limit_twin_volume_fraction"))
{
  if (_number_slip_systems >= 1000 || _number_twin_systems >= 1000)
    mooseError("CrystalPlasticityCDDNiAlloyUpdate assumes fewer than 1,000 possible slip or twin systems");

  if (_number_slip_systems != _number_twin_systems)
    mooseError("CrystalPlasticityCDDNiAlloyUpdate assumes equal numbers of twinning and glide slip systems");

    setRandomResetFrequency(EXEC_TIMESTEP_BEGIN);
}

void
CrystalPlasticityCDDNiAlloyUpdate::initQpStatefulProperties()
{
  _volume_fraction_twins[_qp].resize(_number_twin_systems);
  _twin_shear_increment[_qp].resize(_number_twin_systems);
  _twin_system_resistance[_qp].resize(_number_twin_systems);
  _tau_twin_sytem[_qp].resize(_number_twin_systems);

  //Then loop over the slip systems and set the initial values from the params
  for (unsigned int i = 0; i < _number_twin_systems; ++i)
  {
    _volume_fraction_twins[_qp][i] = 0.0;
    _twin_shear_increment[_qp][i] = 0.0;
    _twin_system_resistance[_qp][i] = 0.0;
    _tau_twin_sytem[_qp][i] = 0.0;
  }

  CrystalPlasticityCDDUpdateBase::initQpStatefulProperties();
}

void
CrystalPlasticityCDDNiAlloyUpdate::initSlipSystemResistance()
{
  // Calculate the strength due to Orowan bowing
  Real bowing_strength = 0.0;
  if (_tertiary_volume_fraction != 0.0 && _orowan_bowing_coeff != 0.0)
    bowing_strength = calculateOrowanBowingHardening();

  // Calculate the strength due to weakly-coupled APB shearing
  Real weak_APB_strength = 0.0;
  if (_tertiary_volume_fraction != 0.0 && _tertiary_apb_coeff != 0.0)
    weak_APB_strength = calculateAPBWeaklyCoupledShearingHardening();

  // save to the static resistance contributions vector for this model
  // const Real constant_hardening = Utility::pow<2>(_peierls_strength)
  //                               + Utility::pow<2>(bowing_strength)
  //                               + Utility::pow<2>(weak_APB_strength);
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
    _static_resistance_contribution[_qp][i] = _peierls_strength + bowing_strength + weak_APB_strength;
    // _static_resistance_contribution[_qp][i] = std::sqrt(constant_hardening);

  // Now calculate the initial contributions from the evolving quantities:
  // Calculate the inital forest hardening from dislocations
  std::vector<Real> forest_strength(_number_slip_systems);
  calculateDislocationForestHardening(forest_strength);

  // Loop over all the slip systems and add these strength contributions
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    // const Real sq_resistance = Utility::pow<2>(forest_strength[i])
    //                          + Utility::pow<2>(_static_resistance_contribution[_qp][i]);
    // _slip_system_resistance[_qp][i] = std::sqrt(sq_resistance);

  _slip_system_resistance[_qp][i] = forest_strength[i] + _static_resistance_contribution[_qp][i];
  }
}

void
CrystalPlasticityCDDNiAlloyUpdate::calculateConstitutiveEquivalentSlipIncrement(RankTwoTensor & equivalent_slip_increment,
                                                                         bool & error_tolerance)
{
  RankTwoTensor equivalent_glide_slip_increment, equivalent_twin_shear_increment;
  equivalent_glide_slip_increment.zero();
  equivalent_twin_shear_increment.zero();
  equivalent_slip_increment.zero();

  CrystalPlasticityCDDUpdateBase::calculateGlideSlipIncrement(error_tolerance);
  if (error_tolerance)
    return;

  calculateTwinSlipIncrement(error_tolerance);
  if (error_tolerance)
    return;

  // Sum up the slip increments to find the equivalent plastic strain due to slip
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
    equivalent_glide_slip_increment += _flow_direction[_qp][i] * _glide_slip_increment[_qp][i];

  // Now store off the plastic velocity gradient for use in the calculation of the geometrically necessary dislocations
  _slip_increment_sum[_qp] = equivalent_slip_increment;

  // Sum the volume fraction of twins
  Real total_fraction_twins = 0.0;
  for (unsigned int i = 0; i < _number_twin_systems; ++i)
    total_fraction_twins += _volume_fraction_twins[_qp][i];

  // Sum the total equivalent slip increment for glide and twin
  equivalent_slip_increment = (1.0 - total_fraction_twins) * equivalent_glide_slip_increment;

  error_tolerance = false;
}

void
CrystalPlasticityCDDNiAlloyUpdate::calculateTwinSlipIncrement(bool & error_tolerance)
{
  for (unsigned int i = 0; i < _number_twin_systems; ++i)
  {
    _twin_shear_increment[_qp][i] = _volume_fraction_twins[_qp][i] * _characteristic_twin_shear;

    if (_twin_shear_increment[_qp][i] > _slip_incr_tol)
    {
#ifdef DEBUG
      mooseWarning("Maximum allowable twin slip increment exceeded on slip system ", i, " with a value of ", _twin_shear_increment[_qp][i], "At element ", _current_elem->id(), " and qp ", _qp);
#endif
      error_tolerance = true;
      return;
    }
  }
}

void
CrystalPlasticityCDDNiAlloyUpdate::calculateConstitutiveSlipDerivative(std::vector<Real> & dslip_dtau)
{
  std::vector<Real> dslip_glide_dtau(_number_slip_systems, 0.0);
  std::vector<Real> dslip_twin_dtau(_number_twin_systems, 0.0);

  CrystalPlasticityCDDUpdateBase::calculateGlideSlipDerivative(dslip_glide_dtau);
  calculateTwinSlipDerivative(dslip_twin_dtau);

//// This is the wrong way to implement this connection
//// The implementation in the parent class method assumes that flow direction
//// from the glide slip is the correct to use, and that's not the case here.
//// will need to rework the parent class methods


  for (unsigned int i = 0; i < _number_twin_systems; ++i)
    dslip_dtau[i] = dslip_glide_dtau[i] + dslip_twin_dtau[i];
}

void
CrystalPlasticityCDDNiAlloyUpdate::calculateTwinSlipDerivative(std::vector<Real> & dslip_twin_dtau)
{
  for (unsigned int i = 0; i < _number_twin_systems; ++i)
  {
    if (MooseUtils::absoluteFuzzyEqual(_tau_twin_sytem[_qp][i], 0.0))
      dslip_twin_dtau[i] = 0.0;
    else
    {
      const Real twin_slip_derivative = _m_exp * _tau_twin_sytem[_qp][i];
      dslip_twin_dtau[i] = _twin_shear_increment[_qp][i] / twin_slip_derivative;
    }
  }
}

void
CrystalPlasticityCDDNiAlloyUpdate::updateConstitutiveSlipSystemResistanceAndVariables(bool & error_tolerance)
{
  // Set the previous value of the internal variables for comparison in the convergence check
  _previous_it_resistance[_qp] = _slip_system_resistance[_qp];
  _previous_it_mobile[_qp] = _mobile_dislocations[_qp];
  _previous_it_immobile[_qp] = _immobile_dislocations[_qp];

  // At the early stages when all of the glide velocities are zero,
  // save a bit of time at the early stages of the simulation.
  bool no_glide_velocity = true;

  unsigned int i = 0;
  do
  {
    if (!(MooseUtils::absoluteFuzzyEqual(_glide_velocity[_qp][i], 0.0)))
      no_glide_velocity = false;

    ++i;
  } while (no_glide_velocity && (i < _number_slip_systems));

  if (!no_glide_velocity)
  {
    calculateDislocationDensities(error_tolerance);
    if (error_tolerance)
      return;
  }

  calculateTwinVolumeFraction(error_tolerance);

  calculateSlipSystemResistance(error_tolerance);
}

void
CrystalPlasticityCDDNiAlloyUpdate::calculateTwinVolumeFraction(bool & error_tolerance)
{
  std::vector<Real> increment_volume_fraction(_number_twin_systems, 0.0);

  for (unsigned int i = 0; i < _number_twin_systems; ++i)
  {
    if ( _tau_twin_sytem[_qp][i] >= 0.0 )
    {
      Real driving_force = (_tau_twin_sytem[_qp][i] / _twin_system_resistance[_qp][i]);
      increment_volume_fraction[i] = std::pow(driving_force, (1.0 / _m_exp))
                                   * _gamma_reference / _characteristic_twin_shear
                                   * _substep_dt;
    }
    else  // Constitutive law: less that zero applied stress, no twinning
      increment_volume_fraction[i] = 0.0;
  }

  for (unsigned int i = 0; i < _number_twin_systems; ++i)
  {
    if ((_volume_fraction_twins_old[_qp][i] < _zero_tol && increment_volume_fraction[i] < 0.0) ||
        (_volume_fraction_twins_old[_qp][i] < _limit_twin_volume_fraction))
      _volume_fraction_twins[_qp][i] = _volume_fraction_twins_old[_qp][i];
    else
    {
      _volume_fraction_twins[_qp][i] = increment_volume_fraction[i] + _volume_fraction_twins_old[_qp][i];
      if (_volume_fraction_twins[_qp][i] > _limit_twin_volume_fraction)
        _volume_fraction_twins[_qp][i] = _limit_twin_volume_fraction;
    }

    // check that increment is equal or positive; very small values okay
    if (_volume_fraction_twins[_qp][i] < 0.0)
    {
      error_tolerance = true;
      return;
    }
  }

  error_tolerance = false;
}


Real
CrystalPlasticityCDDNiAlloyUpdate::calculateOrowanBowingHardening()
{
  // Interparticle spacing calculation:
  //   leave room for multiple precipitates sizes in future development
  const Real geo_term = 8.0 / (3.0 * libMesh::pi * _tertiary_volume_fraction);
  const Real point_spacing = std::sqrt(geo_term) * _tertiary_mean_diameter;
  const Real interparticle_space = point_spacing - _tertiary_mean_diameter;

  Real bowing_strength = _shear_modulus * _burgers_vector / interparticle_space;
  bowing_strength *= _orowan_bowing_coeff;

  return bowing_strength;
}

Real
CrystalPlasticityCDDNiAlloyUpdate::calculateAPBWeaklyCoupledShearingHardening()
{
  // Interparticle spacing calculation
  const Real geo_term = 8.0 / (3.0 * libMesh::pi * _tertiary_volume_fraction);
  const Real point_spacing = std::sqrt(geo_term) * _tertiary_mean_diameter;
  const Real interparticle_space = point_spacing - _tertiary_mean_diameter;

  const Real energy_term = _tertiary_apb_energy * _tertiary_mean_diameter / _shear_modulus;
  const Real length_term_a = _tertiary_mean_diameter / (_burgers_vector * interparticle_space);
  const Real term_a = std::sqrt(energy_term) * length_term_a;

  const Real length_term_b = Utility::pow<2>(_tertiary_mean_diameter / point_spacing);
  const Real term_b = length_term_b * libMesh::pi / 4.0;

  const Real coeff = _tertiary_apb_coeff * _tertiary_apb_energy / (2.0 * _burgers_vector);
  const Real weak_APB_strength = coeff * (term_a - term_b);

  return weak_APB_strength;
}
