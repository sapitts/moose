//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "CoupledRadiativeHeatFluxBC.h"

registerMooseObject("HeatConductionApp", CoupledRadiativeHeatFluxBC);

defineLegacyParams(CoupledRadiativeHeatFluxBC);

InputParameters
CoupledRadiativeHeatFluxBC::validParams()
{
  InputParameters params = IntegratedBC::validParams();
  params.addClassDescription(
      "Radiative heat transfer boundary condition with the far field temperature, of an assummed black body, given by auxiliary variables and constant emissivity");
  params.addCoupledVar("alpha", 1., "Volume fraction of components");
  params.addRequiredCoupledVar("T_infinity", "Field holding far-field temperature");
  // params.addRequiredParam<std::vector<Real>>("emissivity", "The emissivity of the surface to which this boundary belongs");
  params.addRequiredParam<Real>("emissivity", "The emissivity of the surface to which this boundary belongs");
  params.addParam<Real>("sigma", 5.67e-8, "The Stefan-Boltzmann constant");

  return params;
}

CoupledRadiativeHeatFluxBC::CoupledRadiativeHeatFluxBC(const InputParameters & parameters)
  : IntegratedBC(parameters),
    _n_components(coupledComponents("T_infinity")),
    _emissivity(getParam<Real>("emissivity")),
    _sigma(getParam<Real>("sigma"))
{
  if (coupledComponents("alpha") != _n_components)
    paramError(
        "alpha",
        "The number of coupled components does not match the number of `T_infinity` components.");
  // if (coupledComponents("emissivity") != _n_components)
  //   paramError(
  //       "emissivity",
  //       "The number of coupled components does not match the number of `T_infinity` components.");

  // _emissivity.resize(_n_components);
  _T_infinity.resize(_n_components);
  _alpha.resize(_n_components);
  for (std::size_t c = 0; c < _n_components; c++)
  {
    // _emissivity[c] = getParam<std::vector<Real>>("emissivity", c);
    _T_infinity[c] = &coupledValue("T_infinity", c);
    _alpha[c] = &coupledValue("alpha", c);
  }
}

Real
CoupledRadiativeHeatFluxBC::computeQpResidual()
{
  Real q = 0;
  for (std::size_t c = 0; c < _n_components; c++)
    q += (*_alpha[c])[_qp] * _emissivity * _sigma * (Utility::pow<4>(_u[_qp]) - Utility::pow<4>((*_T_infinity[c])[_qp]));
  return _test[_i][_qp] * q;
}

Real
CoupledRadiativeHeatFluxBC::computeQpJacobian()
{
  Real dq = 0;
  for (std::size_t c = 0; c < _n_components; c++)
    dq += (*_alpha[c])[_qp] * _emissivity * _sigma * 4.0 * Utility::pow<3>(_u[_qp]) * _phi[_j][_qp];
  return _test[_i][_qp] * dq;
}
