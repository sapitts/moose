//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "CrystalPlasticityFCCDislocationLinkDefectHardening.h"
#include "libmesh/int_range.h"

registerMooseObject("SolidMechanicsApp", CrystalPlasticityFCCDislocationLinkDefectHardening);

InputParameters
CrystalPlasticityFCCDislocationLinkDefectHardening::validParams()
{
  InputParameters params = CrystalPlasticityFCCDislocationLinkHuCocksUpdate::validParams();
  params.addClassDescription(
      "Adds hardening contributions due to void and dislocation loops to the "
      "athermal dislocation glide model for FCC cyrstals developed by Hu and Cocks.");

  params.addParam<MaterialPropertyName>(
      "spherical_void_number_density",
      "The material property name of the number density of the spherical voids, in 1/mm^3.");
  params.addParam<MaterialPropertyName>(
      "mean_spherical_void_radius",
      "The material property name for the mean radius value, in mm, for the spherical voids");

  params.addParam<MaterialPropertyName>(
      "dislocation_loop_number_density",
      "The material property name of the number density of the dislocation loops, in 1/mm^3.");
  params.addParam<MaterialPropertyName>(
      "mean_dislocation_loop_radius",
      "The material property name for the mean radius for dislocation loops, in mm");

  params.addRangeCheckedParam<Real>(
      "void_hardening_coefficient",
      1.0,
      "void_hardening_coefficient>=0",
      "Leading coefficient for the contribution of voids, assumed to be spherical, "
      "to the slip system resistance value.");
  params.addRangeCheckedParam<Real>("dislocation_loop_hardening_coefficient",
                                    1.0,
                                    "dislocation_loop_hardening_coefficient>=0",
                                    "Leading coefficient for the contribution to the slip system "
                                    "resistance from dislocation loops, which are assumed to act "
                                    "as arrays of weak pinning barriers to dislocation motion.");

  return params;
}

CrystalPlasticityFCCDislocationLinkDefectHardening::
    CrystalPlasticityFCCDislocationLinkDefectHardening(const InputParameters & parameters)
  : CrystalPlasticityFCCDislocationLinkHuCocksUpdate(parameters),

    // Void hardening contributions
    _include_void_hardening((parameters.isParamValid("spherical_void_number_density") &&
                             parameters.isParamValid("mean_spherical_void_radius"))
                                ? true
                                : false),
    _void_density(_include_void_hardening
                      ? &getMaterialPropertyOld<Real>("spherical_void_number_density")
                      : nullptr),
    _void_radius(_include_void_hardening
                     ? &getMaterialPropertyOld<Real>("mean_spherical_void_radius")
                     : nullptr),

    // Dislocation loop hardening contributions
    _include_dislocation_loop_hardening(
        (parameters.isParamValid("dislocation_loop_number_density") &&
         parameters.isParamValid("mean_dislocation_loop_radius"))
            ? true
            : false),
    _dislocation_loop_density(_include_dislocation_loop_hardening
                                  ? &getMaterialPropertyOld<Real>("dislocation_loop_number_density")
                                  : nullptr),
    _dislocation_loop_radius(_include_dislocation_loop_hardening
                                 ? &getMaterialPropertyOld<Real>("mean_dislocation_loop_radius")
                                 : nullptr),

    // Slip system resistance parameters
    _void_hardening_coeff(getParam<Real>(_base_name + "void_hardening_coefficient")),
    _dislocation_loop_hardening_coeff(
        getParam<Real>(_base_name + "dislocation_loop_hardening_coefficient"))
{
}

void
CrystalPlasticityFCCDislocationLinkDefectHardening::initQpStatefulProperties()
{
  CrystalPlasticityFCCDislocationLinkHuCocksUpdate::initQpStatefulProperties();
  // Resize constitutive-model specific material properties
  // _pinning_point_density[_qp].resize(_number_coplanar_groups);

  // // Set constitutive-model specific initial values from parameters
  // const Real pin_pts_density_per_plane = _initial_pinning_point_density /
  // _number_coplanar_groups; for (const auto p : make_range(_number_coplanar_groups))
  // {
  //   _pinning_point_density[_qp][p] = pin_pts_density_per_plane;
  //   _pinning_point_increment[_qp][p] = 0.0;
  //   _coplanar_constitutive_slip_increment[_qp][p] = 0.0;
  // }

  // for (const auto i : make_range(_number_slip_systems))
  // _slip_increment[_qp][i] = 0.0;

  calculateSlipResistance();

  // // Set the initial resistance from the different hardening contributors
  // std::vector<Real> forest_hardening(_number_coplanar_groups, 0.0);
  // std::vector<Real> solute_hardening(_number_coplanar_groups, 0.0);
  // std::vector<Real> precipitate_hardening(_number_coplanar_groups, 0.0);
  // std::vector<Real> void_hardening(_number_coplanar_groups, 0.0);
  // std::vector<Real> loop_hardening(_number_coplanar_groups, 0.0);

  // CrystalPlasticityFCCDislocationLinkHuCocksUpdate::calculateForestSlipResistance(forest_hardening);

  // if (_include_solute_hardening)
  //   CrystalPlasticityFCCDislocationLinkHuCocksUpdate::calculateSoluteResistance(solute_hardening);

  // if (_include_precipitate_hardening)
  //   CrystalPlasticityFCCDislocationLinkHuCocksUpdate::calculatePrecipitateResistance(
  //       precipitate_hardening);

  //   if (_include_void_hardening)
  //   calculateVoidResistance(void_hardening);

  // if (_include_dislocation_loop_hardening)
  //   calculateLoopResistance(loop_hardening);

  // for (const auto p : make_range(_number_coplanar_groups))
  // {
  //   const Real hardening_sum = precipitate_hardening[p] + solute_hardening[p];

  //   for (const auto n : index_range(_coplanar_groups[p]))
  //     _slip_resistance[_qp][_coplanar_groups[p][n]] = hardening_sum;
  // }
}

// void
// CrystalPlasticityFCCDislocationLinkDefectHardening::setMaterialVectorSize()
// {
//   CrystalPlasticityFCCDislocationLinkHuCocksUpdate::setMaterialVectorSize();

//   // Resize non-stateful material properties
//   _pinning_point_increment[_qp].resize(_number_coplanar_groups);
//   _coplanar_constitutive_slip_increment[_qp].resize(_number_coplanar_groups);
// }

// void
// CrystalPlasticityFCCDislocationLinkDefectHardening::setInitialConstitutiveVariableValues()
// {
//   _slip_resistance[_qp] = _slip_resistance_old[_qp];
//   _previous_substep_slip_resistance = _slip_resistance_old[_qp];

//   // _pinning_point_density[_qp] = _pinning_point_density_old[_qp];
//   // _previous_substep_pinning_points = _pinning_point_density_old[_qp];
// }

// void
// CrystalPlasticityFCCDislocationLinkDefectHardening::setSubstepConstitutiveVariableValues()
// {
//   _slip_resistance[_qp] = _previous_substep_slip_resistance;
//   _pinning_point_density[_qp] = _previous_substep_pinning_points;
// }

// bool
// CrystalPlasticityFCCDislocationLinkDefectHardening::calculateSlipRate()
// {
//   bool allowable_slip_increment = true;

//   for (const auto i : make_range(_number_slip_systems))
//   {
//     if (MooseUtils::absoluteFuzzyEqual(_tau[_qp][i], 0.0))
//       _slip_increment[_qp][i] = 0.0;
//     else
//     {
//       const Real driving_force = std::abs(_tau[_qp][i]) / _slip_resistance[_qp][i];
//       _slip_increment[_qp][i] = _gamma_reference * std::pow(driving_force, (_p_exp));
//       if (_tau[_qp][i] < 0.0)
//         _slip_increment[_qp][i] *= -1.0;
//     }

//     // Check that none of the slip increments are outside of the allowable tolerance
//     if (std::abs(_slip_increment[_qp][i] * _substep_dt) > _slip_incr_tol)
//     {
//       if (_print_convergence_message)
//         mooseWarning("Maximum allowable slip increment exceeded ",
//                      std::abs(_slip_increment[_qp][i] * _substep_dt));

//       allowable_slip_increment = false;
//     }
//   }

//   return allowable_slip_increment;
// }

// void
// CrystalPlasticityFCCDislocationLinkDefectHardening::calculateEquivalentSlipIncrement(
//     RankTwoTensor & equivalent_slip_increment)
// {
//   if (_include_twinning_in_Lp)
//   {
//     for (const auto i : make_range(_number_slip_systems))
//       equivalent_slip_increment += (1.0 - (*_twin_volume_fraction_total)[_qp]) *
//                                    _flow_direction[_qp][i] * _slip_increment[_qp][i] *
//                                    _substep_dt;
//   }
//   else // if no twinning volume fraction material property supplied, use base class
//     CrystalPlasticityFCCDislocationLinkHuCocksUpdate::calculateEquivalentSlipIncrement(
//         equivalent_slip_increment);
// }

// void
// CrystalPlasticityFCCDislocationLinkDefectHardening::calculateConstitutiveSlipDerivative(
//     std::vector<Real> & dslip_dtau)
// {
//   for (const auto i : make_range(_number_slip_systems))
//   {
//     if (MooseUtils::absoluteFuzzyEqual(_tau[_qp][i], 0.0))
//       dslip_dtau[i] = 0.0;
//     else
//       dslip_dtau[i] = _slip_increment[_qp][i] / (_p_exp * std::abs(_tau[_qp][i])) * _substep_dt;
//   }
// }

// bool
// CrystalPlasticityFCCDislocationLinkDefectHardening::areConstitutiveStateVariablesConverged()
// {
//   if (isConstitutiveStateVariableConverged(_pinning_point_density[_qp],
//                                            _pinning_points_before_update,
//                                            _previous_substep_pinning_points,
//                                            _rel_state_var_tol) &&
//       isConstitutiveStateVariableConverged(_slip_resistance[_qp],
//                                            _slip_resistance_before_update,
//                                            _previous_substep_slip_resistance,
//                                            _resistance_tol))
//     return true;
//   return false;
// }

// void
// CrystalPlasticityFCCDislocationLinkDefectHardening::updateSubstepConstitutiveVariableValues()
// {
//   _previous_substep_slip_resistance = _slip_resistance[_qp];
//   _previous_substep_pinning_points = _pinning_point_density[_qp];
// }

// void
// CrystalPlasticityFCCDislocationLinkDefectHardening::cacheStateVariablesBeforeUpdate()
// {
//   _slip_resistance_before_update = _slip_resistance[_qp];
//   _pinning_points_before_update = _pinning_point_density[_qp];
// }

// void
// CrystalPlasticityFCCDislocationLinkDefectHardening::calculateStateVariableEvolutionRateComponent()
// {
//   calculateConstitutiveCoplanarSlipIncrement();
//   calculatePinningPointEvolutionIncrement();
// }

// void
// CrystalPlasticityFCCDislocationLinkDefectHardening::calculateConstitutiveCoplanarSlipIncrement()
// {
//   // Compute the coplanar slip increment as the sum of the absolute slip increment
//   // on each coplanar slip system
//   for (const auto p : make_range(_number_coplanar_groups))
//   {
//     Real sum_coplanar_slip_increment = 0.0;
//     for (const auto n : index_range(_coplanar_groups[p]))
//       sum_coplanar_slip_increment += std::abs(_slip_increment[_qp][_coplanar_groups[p][n]]);

//     _coplanar_constitutive_slip_increment[_qp][p] = sum_coplanar_slip_increment * _substep_dt;
//   }
// }

// void
// CrystalPlasticityFCCDislocationLinkDefectHardening::calculatePinningPointEvolutionIncrement()
// {
//   for (const auto p : make_range(_number_coplanar_groups))
//   {
//     Real increment = 0.0;
//     for (const auto q : make_range(_number_coplanar_groups))
//     {
//       if (p == q) // self hardening
//         increment += _self_pinpt_coeff * _coplanar_constitutive_slip_increment[_qp][q];
//       else
//         increment += _latent_pinpt_coeff * _coplanar_constitutive_slip_increment[_qp][q] /
//                      (_number_coplanar_groups - 1.0);
//     }
//     _pinning_point_increment[_qp][p] = increment;
//   }
// }

void
CrystalPlasticityFCCDislocationLinkDefectHardening::calculateSlipResistance()
{
  // set up local vectors for all hardening contributions
  std::vector<Real> forest_hardening(_number_coplanar_groups, 0.0);
  std::vector<Real> solute_hardening(_number_coplanar_groups, 0.0);
  std::vector<Real> precipitate_hardening(_number_coplanar_groups, 0.0);
  std::vector<Real> void_hardening(_number_coplanar_groups, 0.0);
  std::vector<Real> loop_hardening(_number_coplanar_groups, 0.0);

  // check to see if the hardening contribution should be included before calculating
  CrystalPlasticityFCCDislocationLinkHuCocksUpdate::calculateForestSlipResistance(forest_hardening);

  if (_include_solute_hardening)
    CrystalPlasticityFCCDislocationLinkHuCocksUpdate::calculateSoluteResistance(solute_hardening);

  if (_include_precipitate_hardening)
    CrystalPlasticityFCCDislocationLinkHuCocksUpdate::calculatePrecipitateResistance(
        precipitate_hardening);

  if (_include_void_hardening)
    calculateVoidResistance(void_hardening);

  if (_include_dislocation_loop_hardening)
    calculateLoopResistance(loop_hardening);

  for (const auto p : make_range(_number_coplanar_groups))
  {
    const Real sq_forest = Utility::pow<2>(forest_hardening[p]);
    const Real sq_precipitates = Utility::pow<2>(precipitate_hardening[p]);
    const Real sq_voids = Utility::pow<2>(void_hardening[p]);

    const Real hardening_sum =
        std::sqrt(sq_forest + sq_precipitates + sq_voids) + solute_hardening[p] + loop_hardening[p];
    for (const auto n : index_range(_coplanar_groups[p]))
      _slip_resistance[_qp][_coplanar_groups[p][n]] = hardening_sum;
  }
}

void
CrystalPlasticityFCCDislocationLinkDefectHardening::calculateVoidResistance(
    std::vector<Real> & void_hardening)
{
  const Real lead_term = _void_hardening_coeff * _burgers_vector * _shear_modulus;
  const Real mean_free_path = 2.0 * (*_void_density)[_qp] * (*_void_radius)[_qp];

  for (const auto j : make_range(_number_coplanar_groups))
    void_hardening[j] = lead_term * std::sqrt(mean_free_path);
}

void
CrystalPlasticityFCCDislocationLinkDefectHardening::calculateLoopResistance(
    std::vector<Real> & loop_hardening)
{
  const Real lead_term = _dislocation_loop_hardening_coeff * _burgers_vector * _shear_modulus;
  const Real mean_free_path =
      2.0 * (*_dislocation_loop_density)[_qp] * (*_dislocation_loop_radius)[_qp];

  for (const auto j : make_range(_number_coplanar_groups))
    loop_hardening[j] = lead_term * std::sqrt(mean_free_path);
}

// bool
// CrystalPlasticityFCCDislocationLinkDefectHardening::updateStateVariables()
// {
//   if (calculatePinningPointDensity())
//     return true;
//   else
//     return false;
// }

// bool
// CrystalPlasticityFCCDislocationLinkDefectHardening::calculatePinningPointDensity()
// {
//   bool positive_pinning_point_density = true;
//   for (const auto n : make_range(_number_coplanar_groups))
//   {
//     if (_previous_substep_pinning_points[n] < _zero_tol && _pinning_point_increment[_qp][n] <
//     0.0)
//       _pinning_point_density[_qp][n] = _previous_substep_pinning_points[n];
//     else
//       _pinning_point_density[_qp][n] =
//           _previous_substep_pinning_points[n] + _pinning_point_increment[_qp][n];

//     if (_pinning_point_density[_qp][n] < 0.0)
//     {
//       mooseError("A negative pinning points density was computed");
//       positive_pinning_point_density = false;
//     }
//   }
//   return positive_pinning_point_density;
// }
