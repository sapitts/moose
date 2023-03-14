//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "CrystalPlasticityKocksMeckingGlideUpdate.h"

class CrystalPlasticityTungstenGlideUpdate;

/**
 * CrystalPlasticityTungstenGlideUpdate computes the temperature-dependent
 * lattice friction value for tungsten
 */

class CrystalPlasticityTungstenGlideUpdate : public CrystalPlasticityKocksMeckingGlideUpdate
{
public:
  static InputParameters validParams();

  CrystalPlasticityTungstenGlideUpdate(const InputParameters & parameters);

protected:
  /**
   * Calculates the sum of the contributions from the initial slip resistance and the
   * forest dislocation hardening
   */
  virtual void calculateSlipResistance() override;

  /**
   * Calculates the temperature dependent Peierls potential flow stress for
   * BCC metals below the material specific critical temperature, in a two
   * regime approach, following Lim et al. JMPS (2015). Regime I (middle
   * temperature regime) is based on the dislocation interaction model
   * for fully-formed dislocation kink-pairs. Regime II (low temperature
   * regime) is considers the case of not-fully formed kinks and is based
   * on the dislocation line tension model.
   */
  virtual void calculateThermalPeierlsFlowStress(std::vector<Real> & thermal_peierls_stress);

  /// Coupled temperature variable
  const VariableValue & _temperature;

  ///@{Constants used to calcuate the thermal contributions of the Peierl's stress
  const Real _critical_peierls_temperature;
  const Real _thermal_peierls_r1;
  const Real _thermal_peierls_r2;
  ///@}
};
