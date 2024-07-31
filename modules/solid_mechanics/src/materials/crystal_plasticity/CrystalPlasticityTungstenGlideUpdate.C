//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "CrystalPlasticityTungstenGlideUpdate.h"

registerMooseObject("SolidMechanicsApp", CrystalPlasticityTungstenGlideUpdate);

InputParameters
CrystalPlasticityTungstenGlideUpdate::validParams()
{
  InputParameters params = CrystalPlasticityKocksMeckingGlideUpdate::validParams();
  params.addClassDescription(
      "Two-term mobile dislocation glide model (multiplication and annhiliation) "
      "for cubic crystals with a power-law hardening glide velocity model.");

  params.addCoupledVar("temperature", "The name of the temperature variable");
  params.addParam<Real>(
      "critical_peierls_stress_temperature",
      800.0,
      "The temperature, in K, at which the thermal contributions to the Peierl's flow stress are "
      "no longer active; temperatures below this user-specified value are used to calculate the "
      "Peierl's thermal contributions to the dislocation slip resistance");
  params.addParam<Real>("peierls_potential_regimeI",
                        2035.0,
                        "Representation of the Peierls potential for the Elastic Interaction "
                        "model, in MPa. This value is used in the mid-temperature range Regime I "
                        "calculation of the thermal Peierls stress");
  params.addParam<Real>("peierls_potential_regimeII",
                        1039.0,
                        "Antiparabolic representation of the Peierls potentail, in MPa, for the "
                        "lower temperature Regime II thermal Peierls stress calcualtion. The "
                        "Regime II expression is based on the Line Theory model.");

  return params;
}

CrystalPlasticityTungstenGlideUpdate::CrystalPlasticityTungstenGlideUpdate(
    const InputParameters & parameters)
  : CrystalPlasticityKocksMeckingGlideUpdate(parameters),

    _temperature(coupledValue("temperature")),
    _critical_peierls_temperature(getParam<Real>("critical_peierls_stress_temperature")),
    _thermal_peierls_r1(getParam<Real>("peierls_potential_regimeI")),
    _thermal_peierls_r2(getParam<Real>("peierls_potential_regimeII"))
{
}

void
CrystalPlasticityTungstenGlideUpdate::calculateSlipResistance()
{
  std::vector<Real> forest_hardening(_number_slip_systems, 0.0);
  calculateForestSlipResistance(forest_hardening);

  std::vector<Real> thermal_peierls_stress(_number_slip_systems, 0.0);
  calculateThermalPeierlsFlowStress(thermal_peierls_stress);

  for (const auto i : make_range(_number_slip_systems))
    _slip_resistance[_qp][i] =
        _initial_lattice_friction + forest_hardening[i] + thermal_peierls_stress[i];
}

void
CrystalPlasticityTungstenGlideUpdate::calculateThermalPeierlsFlowStress(
    std::vector<Real> & thermal_peierls_stress)
{
  // Check the temperature to determine if athermal contributions are active
  if (_temperature[_qp] > _critical_peierls_temperature)
  {
    std::fill(thermal_peierls_stress.begin(), thermal_peierls_stress.end(), 0.0);
    return;
  }

  for (const auto i : make_range(_number_slip_systems))
  {
    const Real reg1_sq = 1.0 - _temperature[_qp] / _critical_peierls_temperature;
    const Real reg1 = _thermal_peierls_r1 * Utility::pow<2>(reg1_sq);

    const Real reg2_sqrt = std::sqrt(_temperature[_qp] / _critical_peierls_temperature);
    const Real reg2 = _thermal_peierls_r2 * (1.0 - reg2_sqrt);

    // Compare and save the minimum value
    if (reg1 < reg2)
      thermal_peierls_stress[i] = reg1;
    else
      thermal_peierls_stress[i] = reg2;
  }
}
