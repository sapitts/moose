//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "CrystalPlasticityFCCDislocationLinkHuCocksUpdate.h"

class CrystalPlasticityFCCDislocationLinkDefectHardening;

/**
 * CrystalPlasticityFCCDislocationLinkDefectHardening computes the athermal
 * pinning point density evolution due to dislocation glide, following
 * Hu and Cocks IJSS 78-79 (2016) 21-37.
 */

class CrystalPlasticityFCCDislocationLinkDefectHardening
  : public CrystalPlasticityFCCDislocationLinkHuCocksUpdate
{
public:
  static InputParameters validParams();

  CrystalPlasticityFCCDislocationLinkDefectHardening(const InputParameters & parameters);

protected:
  virtual void initQpStatefulProperties() override;

  /**
   * Sums the contributions from the solute slip resistance,
   * percipitate hardening, and the forest dislocation hardening, on a
   * per slip system basis. Forest, percipitate, and void hardening contributions
   * are considered strong and are thus combined with a geometric mean. The
   * hardening contributions of solutes and dislocation loops are considered
   * weak obstacles; these contributions are linearly summed
   */
  virtual void calculateSlipResistance() override;

  /**
   * Calculates the slip resistance due to void number density and mean
   * void radius, as defined by separate material properties, using a
   * classical Orowan hardening model.
   */
  virtual void calculateVoidResistance(std::vector<Real> & void_hardening);

  /**
   * Calculates the slip resistance due to dislocation loop number density
   * and mean  void radius, as defined by separate material properties, using
   * a classical Orowan hardening model.
   */
  virtual void calculateLoopResistance(std::vector<Real> & loop_hardening);

  /**
   * Flag to include the void hardening contribution in the slip system
   * resistance calculation
   */
  const bool _include_void_hardening;

  /**
   * Spherical void number density, in 1/mm^3, as computed by a separate material.
   *  Note that this value is the OLD material property and thus lags the current
   * value by a single timestep.
   */
  const MaterialProperty<Real> * const _void_density;

  /**
   * Mean spherical void radius, in mm, as computed by a separate material.
   *  Note that this value is the OLD material property and thus lags the current
   * value by a single timestep.
   */
  const MaterialProperty<Real> * const _void_radius;

  /**
   * Flag to include the dislocaiton loop hardening contribution in the slip system
   * resistance calculation
   */
  const bool _include_dislocation_loop_hardening;

  /**
   * Dislocation loop number density, in 1/mm^3, as computed by a separate material.
   *  Note that this value is the OLD material property and thus lags the current
   * value by a single timestep.
   */
  const MaterialProperty<Real> * const _dislocation_loop_density;

  /**
   * Mean dislocation loop radius, in mm, as computed by a separate material.
   *  Note that this value is the OLD material property and thus lags the current
   * value by a single timestep.
   */
  const MaterialProperty<Real> * const _dislocation_loop_radius;

  ///@{Constants associated with slip system resistance
  // const Real _forest_hardening_coeff;
  const Real _void_hardening_coeff;
  const Real _dislocation_loop_hardening_coeff;
};
