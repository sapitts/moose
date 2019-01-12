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
  params.addParam<Real>("characteristic_twin_shear", 1.0/std::sqrt(2.0), "The amount of shear that is associated with a twin in this cubic structure");
  params.addParam<Real>("coefficient_twin_resistance", 0.0, "The coefficient applied to the Peierls stress value as an initial twinning system resistance value");
  params.addParam<Real>("coefficient_twin_hardening", 1000.0, "The factor to apply to the hardening of the twin system strength as a function of the volume fraction of twins");
  params.addParam<Real>("upper_limit_twin_volume_fraction", 0.8, "The maximumum amount of twinning volume fraction allowed");

  return params;
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
    _twin_direction(_number_twin_systems * LIBMESH_DIM),
    _twin_plane_normal(_number_twin_systems * LIBMESH_DIM),
    _twin_schmid_tensor(declareProperty<std::vector<RankTwoTensor>>("twinning_schmid_tensor")),
    _total_volume_fraction_twins(declareProperty<Real>("total_volume_fraction_twins")),
    _total_volume_fraction_twins_old(getMaterialPropertyOld<Real>("total_volume_fraction_twins")),
    _twin_shear_increment(declareProperty<std::vector<Real> >("twin_slip_increment")),
    _twin_volume_fraction(declareProperty<std::vector<Real> >("twin_volume_fraction")),
    _twin_volume_fraction_old(getMaterialPropertyOld<std::vector<Real>>("twin_volume_fraction")),
    _previous_iteration_twin_volume_fraction(declareProperty<Real>("previous_iteration_twin_volume_fraction")),
    _characteristic_twin_shear(getParam<Real>("characteristic_twin_shear")),
    _twin_system_resistance(declareProperty<std::vector<Real> >("twin_system_resistance")),
    _coefficient_twin_resistance(getParam<Real>("coefficient_twin_resistance")),
    _coefficient_twin_hardening(getParam<Real>("coefficient_twin_hardening")),
    _tau_twin_sytem(declareProperty<std::vector<Real> >("applied_shear_stress_twin_system")),
    _limit_twin_volume_fraction(getParam<Real>("upper_limit_twin_volume_fraction"))
{
  if (_number_slip_systems >= 1000 || _number_twin_systems >= 1000)
    mooseError("CrystalPlasticityCDDNiAlloyUpdate assumes fewer than 1,000 possible slip or twin systems");

  if (_number_twin_systems == 0)
    _include_twinning_slip_contribution = false;
  else
    _include_twinning_slip_contribution = true;

  if (_include_twinning_slip_contribution)
    getTwinningSystems();

  setRandomResetFrequency(EXEC_TIMESTEP_BEGIN);

  // fetch coupled gradients of the plastic velocity gradient
  for (unsigned int i = 0; i < LIBMESH_DIM * LIBMESH_DIM; ++i)
    _gradient_Lp[i] = &coupledGradient("plastic_velocity_gradient_components", i);
}

void
CrystalPlasticityCDDNiAlloyUpdate::initQpStatefulProperties()
{
  if (_include_twinning_slip_contribution)
  {
    _twin_schmid_tensor[_qp].resize(_number_twin_systems);
    _twin_shear_increment[_qp].resize(_number_twin_systems);
    _twin_volume_fraction[_qp].resize(_number_twin_systems);
    _twin_system_resistance[_qp].resize(_number_twin_systems);
    _tau_twin_sytem[_qp].resize(_number_twin_systems);

    //Then loop over the slip systems and set the initial values from the params
    for (unsigned int i = 0; i < _number_twin_systems; ++i)
    {
      _twin_schmid_tensor[_qp][i].zero();
      _twin_shear_increment[_qp][i] = 0.0;
      _twin_volume_fraction[_qp][i] = 0.0;
      _twin_system_resistance[_qp][i] = 0.0;
      _tau_twin_sytem[_qp][i] = 0.0;
    }

  calculateTwinningSchmidTensor();
  }

  CrystalPlasticityCDDUpdateBase::initQpStatefulProperties();
}

void
CrystalPlasticityCDDNiAlloyUpdate::setInitialConstitutiveVariableValues()
{
  _total_volume_fraction_twins[_qp] = _total_volume_fraction_twins_old[_qp];
  CrystalPlasticityCDDUpdateBase::setInitialConstitutiveVariableValues();
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

  if (_include_twinning_slip_contribution)
  {
    Real sum = 0.0;
    const Real barrier_coeffient = _baily_hirsch_alpha * _burgers_vector * _shear_modulus;

    for (unsigned int i = 0; i < _number_slip_systems; ++i)
      sum += _mobile_dislocations[_qp][i] + _immobile_dislocations[_qp][i];

    const Real forest_strength = barrier_coeffient * std::sqrt(sum);

    for (unsigned int i = 0; i < _number_twin_systems; ++i)
      _twin_system_resistance[_qp][i] = forest_strength + _coefficient_twin_resistance * _peierls_strength;
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

  if (_include_twinning_slip_contribution)
  {
    for (unsigned int i = 0; i < _number_twin_systems; ++i)
    {
      _tau_twin_sytem[_qp][i] = _pk2[_qp].doubleContraction(_twin_schmid_tensor[_qp][i]);
      // std::cout << "What do I get for a tau here? " << _tau_twin_sytem[_qp][i] << std::endl;
    }
  }

  // Sum up the slip increments to find the equivalent plastic strain due to glide
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
    equivalent_glide_slip_increment += _flow_direction[_qp][i] * _glide_slip_increment[_qp][i];

  if (_include_twinning_slip_contribution)
  {
    calculateTwinSlipIncrement(error_tolerance);
    for (unsigned int i = 0; i < _number_twin_systems; ++i)
      equivalent_twin_shear_increment += _twin_schmid_tensor[_qp][i] * _twin_shear_increment[_qp][i];
  }
  // std::cout << "The equivalent twin shear increment is " << equivalent_twin_shear_increment << std::endl;

  // Sum the total equivalent slip increment for glide and twin
  equivalent_slip_increment = (1.0 - _total_volume_fraction_twins[_qp]) * equivalent_glide_slip_increment;
  equivalent_slip_increment += equivalent_twin_shear_increment;

  //old method with double counting the volume fraction of twins
  // equivalent_slip_increment = (1.0 - _total_volume_fraction_twins[_qp]) * equivalent_glide_slip_increment
                               // + _total_volume_fraction_twins[_qp] * equivalent_twin_shear_increment;


  // Now store off the plastic velocity gradient for use in the GND calculation
  _slip_increment_sum[_qp] = equivalent_slip_increment;

  error_tolerance = false;
}

void
CrystalPlasticityCDDNiAlloyUpdate::calculateTwinSlipIncrement(bool & error_tolerance)
{
  // std::cout << "Inside calculateTwinSlipIncrement at element " << _current_elem->id() << " and qp " << _qp << std::endl;
  if (MooseUtils::relativeFuzzyLessThan(_total_volume_fraction_twins_old[_qp], _limit_twin_volume_fraction))
  {
    for (unsigned int i = 0; i < _number_twin_systems; ++i)
    {
      if ( _tau_twin_sytem[_qp][i] >= 0.0 ) // changed from requiring greater than the strength
      {
        const Real driving_force = (_tau_twin_sytem[_qp][i] / _twin_system_resistance[_qp][i]);
        _twin_shear_increment[_qp][i] = std::pow(driving_force, (1.0 / _m_exp))
                                       * _gamma_reference * _substep_dt;
      }
      else  // Constitutive law: less than zero applied stress, no twinning
        _twin_shear_increment[_qp][i] = 0.0;

      // std::cout << "  on twin system " << i << "  the calculated twin shear increment is " << _twin_shear_increment[_qp][i]  << std::endl;
    }
  }
  else // Once reach the limit of volume fraction, all subsequent increments will be zero
  {
    // _total_volume_fraction_twins[_qp] = _total_volume_fraction_twins_old[_qp];
    std::fill(_twin_shear_increment[_qp].begin(), _twin_shear_increment[_qp].end(), 0.0);
  }

  for (unsigned int i = 0; i < _number_twin_systems; ++i)
  {
    // std::cout << "  on the twin system " << i << " the twin shear increment is " << _twin_shear_increment[_qp][i] << std::endl;
    if (_twin_shear_increment[_qp][i] > _slip_incr_tol)
    {
#ifdef DEBUG
      mooseWarning("Maximum allowable twinning volume fraction increment exceeded on twin system ", i, " with a value of ", _twin_shear_increment[_qp][i], " at element ", _current_elem->id(), " and qp ", _qp);
#endif
      error_tolerance = true;
      return;
    }
  }
  error_tolerance = false;
}

void
CrystalPlasticityCDDNiAlloyUpdate::calculateTwinVolumeFraction(bool & error_tolerance)
{
  // std::cout << "Inside calculateTwinVolumeFraction at element " << _current_elem->id() << " and qp " << _qp << std::endl;
  Real total_volume_fraction_increment = 0.0;
  for (unsigned int i = 0; i < _number_twin_systems; ++i)
  {
    _twin_volume_fraction[_qp][i] = _twin_shear_increment[_qp][i] / _characteristic_twin_shear + _twin_volume_fraction_old[_qp][i];
    total_volume_fraction_increment += _twin_shear_increment[_qp][i] / _characteristic_twin_shear;
  }

  if (_total_volume_fraction_twins_old[_qp] < _zero_tol && total_volume_fraction_increment < 0.0)
    _total_volume_fraction_twins[_qp] = _total_volume_fraction_twins_old[_qp];
  else
    _total_volume_fraction_twins[_qp] = total_volume_fraction_increment + _total_volume_fraction_twins_old[_qp];

  if (_total_volume_fraction_twins[_qp] < 0.0)
  {
    error_tolerance = true;
    return;
  }
  else if (MooseUtils::relativeFuzzyGreaterThan(_total_volume_fraction_twins[_qp], _limit_twin_volume_fraction, _zero_tol))
  {
    error_tolerance = true;
    return;
  }
  error_tolerance = false;
}

void
CrystalPlasticityCDDNiAlloyUpdate::calculateTotalPlasticDeformationGradientDerivative(RankFourTensor & total_dfpinvdpk2)
{
  RankFourTensor dfpinv_dpk2_glide, dfpinv_dpk2_twin;
  const unsigned int glide_slip_model = 1;
  const unsigned int twin_slip_model = 2;

  CrystalPlasticityUpdate::calculateConstitutivePlasticDeformationGradientDerivative(dfpinv_dpk2_glide, _flow_direction[_qp], _number_slip_systems, glide_slip_model);

  if (_include_twinning_slip_contribution)
    CrystalPlasticityUpdate::calculateConstitutivePlasticDeformationGradientDerivative(dfpinv_dpk2_twin, _twin_schmid_tensor[_qp], _number_twin_systems, twin_slip_model);

  total_dfpinvdpk2 = dfpinv_dpk2_glide + dfpinv_dpk2_twin;
}


void
CrystalPlasticityCDDNiAlloyUpdate::calculateConstitutiveSlipDerivative(std::vector<Real> & dslip_dtau, unsigned int slip_model_number)
{
  if (slip_model_number == 1)
    CrystalPlasticityCDDUpdateBase::calculateGlideSlipDerivative(dslip_dtau);

  if (slip_model_number == 2)
    calculateTwinSlipDerivative(dslip_dtau);
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
  CrystalPlasticityCDDUpdateBase::updateConstitutiveSlipSystemResistanceAndVariables(error_tolerance);

  if (error_tolerance)
    return;

  if (_include_twinning_slip_contribution)
  {
    _previous_iteration_twin_volume_fraction[_qp] = _total_volume_fraction_twins[_qp];

    calculateTwinVolumeFraction(error_tolerance);
    if (error_tolerance)
      return;

    calculateTwinSystemResistance(error_tolerance);
  }
}

bool
CrystalPlasticityCDDNiAlloyUpdate::areConstitutiveStateVariablesConverged()
{
  bool not_converged_flag = false;

  const Real twin_diff = std::abs(_previous_iteration_twin_volume_fraction[_qp]
                        - _total_volume_fraction_twins[_qp]);

  if (_total_volume_fraction_twins_old[_qp] < _zero_tol)
  {
    if (twin_diff > _zero_tol)
    {
      std::cout << "Hit a value of too little old twin volume fraction and too much new twin volume fraction! \n with twin diff " << twin_diff << std::endl;
      not_converged_flag = true;
    }
  }
  else
  {
    if (twin_diff > _rel_state_var_tol * _total_volume_fraction_twins_old[_qp])
    {
      std::cout << " Failed in twinning because the change in volume fraction is too large at " << twin_diff << std::endl;
      std::cout << " twin volume fraction: " << _total_volume_fraction_twins[_qp] << " with the tolerance: " << _rel_state_var_tol << " and the old value: " << _total_volume_fraction_twins_old[_qp] << std::endl;
      not_converged_flag = true;
    }
  }

  if (!not_converged_flag)
    not_converged_flag = CrystalPlasticityCDDUpdateBase::areConstitutiveStateVariablesConverged();

  return not_converged_flag;
}

Real CrystalPlasticityCDDNiAlloyUpdate::calculateMeanFreeGlidePath()
{
  Real forest_only_glide_path_inv = CrystalPlasticityCDDUpdateBase::calculateMeanFreeGlidePath();

  Real twin_glide_path_inv = std::sqrt(1.0 - _total_volume_fraction_twins[_qp]);
  // std::cout << "The value of the forest mean free glide path is " << forest_only_glide_path_inv << std::endl;
  // std::cout << " and the value of the twin glide path contribution is " << twin_glide_path_inv << std::endl;

  Real glide_path_inv = forest_only_glide_path_inv / twin_glide_path_inv;

  return glide_path_inv;
}

void
CrystalPlasticityCDDNiAlloyUpdate::calculateTwinSystemResistance(bool & error_tolerance)
{
  Real sum = 0.0;
  const Real barrier_coeffient = _baily_hirsch_alpha * _burgers_vector * _shear_modulus;

  for (unsigned int i = 0; i < _number_slip_systems; ++i)
    sum += _mobile_dislocations[_qp][i] + _immobile_dislocations[_qp][i];

  const Real forest_strength = barrier_coeffient * std::sqrt(sum);

  // need to check if this method of strenghtening makes any sense...
  // Added the coefficient (order 1e3) and the sqrt to bring up the value of the
  // twinning system hardening to be in line with the hardening from the slip systems
  const Real twin_forest = _coefficient_twin_hardening * _shear_modulus * std::sqrt(_total_volume_fraction_twins[_qp]);

  for (unsigned int i = 0; i < _number_twin_systems; ++i)
    _twin_system_resistance[_qp][i] = forest_strength + twin_forest +
                                      _coefficient_twin_resistance * _peierls_strength;


  //Now perform the check to see if the slip system should be updated
  // But I don't need this right now because these values are set by glide dislcoations
  // and are checked there
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

void
CrystalPlasticityCDDNiAlloyUpdate::getTwinningSystems()
{
  bool orthonormal_error = false;

  CrystalPlasticityUpdate::getPlaneNormalAndDirectionVectors(_twin_system_file_name, _number_twin_systems, _twin_plane_normal, _twin_direction, orthonormal_error);

  if (orthonormal_error)
    mooseError("CrystalPlasticityUpdate Error: The twin system file contains a twin direction and twin plane normal pair that are not orthonormal");
}

void
CrystalPlasticityCDDNiAlloyUpdate::calculateTwinningSchmidTensor()
{
  CrystalPlasticityUpdate::calculateSchmidTensor(_number_twin_systems, _twin_plane_normal, _twin_direction, _twin_schmid_tensor[_qp]);
}
