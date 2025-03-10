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

  calculateSlipResistance();
}

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

  if (_include_void_hardening && ((*_void_radius)[_qp] > 0.0 && (*_void_density)[_qp] > 0.0))
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
  const Real diameter = 2.0 * (*_void_radius)[_qp];
  const Real mean_free_path = 1.0 / std::sqrt((*_void_density)[_qp] * diameter);
  const Real effective_diameter = diameter * mean_free_path / (diameter + mean_free_path);
  const Real lead_denom = 2.0 * libMesh::pi * mean_free_path;
  const Real lead_term = _void_hardening_coeff * _burgers_vector * _shear_modulus / lead_denom;

  const Real length_term = std::log(mean_free_path / _burgers_vector);
  const Real diameter_term = std::log(effective_diameter / _burgers_vector) + 0.7;

  for (const auto j : make_range(_number_coplanar_groups))
    void_hardening[j] = lead_term * std::pow(diameter_term, 3. / 2.0) / std::sqrt(length_term);
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
