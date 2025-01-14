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
  // virtual void setMaterialVectorSize() override;

  // virtual void setInitialConstitutiveVariableValues() override;

  // virtual void setSubstepConstitutiveVariableValues() override;

  // virtual void updateSubstepConstitutiveVariableValues() override;

  // virtual bool calculateSlipRate() override;

  // virtual void
  // calculateEquivalentSlipIncrement(RankTwoTensor & /*equivalent_slip_increment*/) override;

  // virtual void calculateConstitutiveSlipDerivative(std::vector<Real> & dslip_dtau) override;

  // virtual void cacheStateVariablesBeforeUpdate() override;

  /**
   * Calculates the evolution of the pinning points per plane, the inverse square
   * quantity of the dislocation link length, following Hu and Cocks, International
   * Journal of Solids and Structures 78-79 (2016) 21-37.
   */
  // virtual void calculateStateVariableEvolutionRateComponent() override;

  // virtual bool updateStateVariables() override;

  // virtual void calculateConstitutiveCoplanarSlipIncrement();

  // /**
  //  * Computes the evolution increment of the pinning points, on a per slip plane
  //  * basis, as function of the self-hardening plane and the other latent-hardening
  //  * slip planes. The pinning point increment due to latent-hardened planes is given
  //  * by equation 6b of Hu & Cocks, IJSS 78-79 (2016); the pinning point increment
  //  * due to the self-hardened plane is given by equation 7 in the same paper.
  //  */
  // virtual void calculatePinningPointEvolutionIncrement();

  // /**
  //  * Calculate the current value of the incremented pinning point density
  //  * on each slip plane (coplanar group) after checking the increment falls
  //  * within user-specified tolerances
  //  */
  // bool calculatePinningPointDensity();

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
   * Calculates the slip resistance due to the dislocation links (the
   * inverse of the square root of the pinning point desnity), following
   * equation 5 of Hu & Cocks, IJSS 78-19 (2016). This quantity is computed
   * on a per slip system basis. The pinning point density on a slip plane
   * is assumed to contribute equally to all coplanar slip systems.
   */
  // virtual void calculateForestSlipResistance(std::vector<Real> & forest_hardening);

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
   * Determines if the dislocation densities have converged
   * by comparing the change in the values over the iteration period.
   */
  // virtual bool areConstitutiveStateVariablesConverged() override;

  // ///@{Pinning point (dislocation link) density quantities
  // MaterialProperty<std::vector<Real>> & _pinning_point_density;
  // const MaterialProperty<std::vector<Real>> & _pinning_point_density_old;
  // MaterialProperty<std::vector<Real>> & _pinning_point_increment;
  // const Real _initial_pinning_point_density;
  // ///@}

  // /**
  //  * Flag to include the solute hardening contribution in the slip system resistance
  //  * calculation
  //  */
  // const bool _include_solute_hardening;

  // /**
  //  * Solute atom number density, in 1/mm^3, computed by a separate material.
  //  *  Note that this value is the OLD material property and thus lags the current
  //  * value by a single timestep.
  //  */
  // const MaterialProperty<Real> * const _solute_concentration;

  // /**
  //  * Flag to include the precipitate hardening contribution in the slip system
  //  * resistance calculation
  //  */
  // const bool _include_precipitate_hardening;

  // /**
  //  * Precipitate number density, in 1/mm^3, as computed by a separate material.
  //  *  Note that this value is the OLD material property and thus lags the current
  //  * value by a single timestep.
  //  */
  // const MaterialProperty<Real> * const _precipitate_density;

  // /**
  //  * Mean precipitate radius, in mm, as computed by a separate material.
  //  *  Note that this value is the OLD material property and thus lags the current
  //  * value by a single timestep.
  //  */
  // const MaterialProperty<Real> * const _precipitate_radius;

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

  // ///@{Constants used to calculate the plastic slip increment
  // /// reference slip rate increment
  // const Real _gamma_reference;
  // /// Strain rate sensitivity exponent
  // const Real _p_exp;
  // ///@}

  // /**
  //  * Helper variable to store the coplanar sum of the slip_increment * substep_dt
  //  * vector values for use across the constitutive model calculations
  //  */
  // MaterialProperty<std::vector<Real>> & _coplanar_constitutive_slip_increment;

  // ///@{Calibration coefficients for the pinning points evolution terms
  // const Real _self_pinpt_coeff;
  // const Real _latent_pinpt_coeff;
  // ///}

  ///@{Constants associated with slip system resistance
  // const Real _forest_hardening_coeff;
  const Real _void_hardening_coeff;
  const Real _dislocation_loop_hardening_coeff;
  // const Real _burgers_vector;
  // const Real _shear_modulus;
  ///@}

  // ///@{Stores the slip system resistance, dislocation densities from the previous substep
  // std::vector<Real> _previous_substep_slip_resistance;
  // std::vector<Real> _previous_substep_pinning_points;
  // ///@}

  // ///@{ Caching current slip resistance, pinning points density values before final update
  // std::vector<Real> _slip_resistance_before_update;
  // std::vector<Real> _pinning_points_before_update;
  // ///@}
};
