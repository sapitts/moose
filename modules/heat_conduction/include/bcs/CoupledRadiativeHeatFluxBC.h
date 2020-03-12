//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "IntegratedBC.h"

class CoupledRadiativeHeatFluxBC;

template <>
InputParameters validParams<CoupledRadiativeHeatFluxBC>();

/**
 * Boundary condition for convective heat flux where temperature and heat transfer coefficient are
 * given by auxiliary variables.  Typically used in multi-app coupling scenario. It is possible to
 * couple in a vector variable where each entry corresponds to a "phase".
 */
class CoupledRadiativeHeatFluxBC : public IntegratedBC
{
public:
  static InputParameters validParams();

  CoupledRadiativeHeatFluxBC(const InputParameters & parameters);

protected:
  virtual Real computeQpResidual();
  virtual Real computeQpJacobian();

  /// The number of components
  unsigned int _n_components;
  /// Far-field temperatue fields for each component
  std::vector<const VariableValue *> _T_infinity;

  /// Surface emissivity constant
  // std::vector<const Real> _emissivity;
  const Real _emissivity;

  /// Volume fraction of individual phase
  std::vector<const VariableValue *> _alpha;

  /// Stefan-Boltzmann constant
  const Real _sigma;
};
