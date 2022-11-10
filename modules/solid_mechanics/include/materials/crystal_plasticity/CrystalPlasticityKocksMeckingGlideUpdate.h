//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "CrystalPlasticityStressUpdateBase.h"

class CrystalPlasticityKocksMeckingGlideUpdate;

/**
 * CrystalPlasticityKocksMeckingGlideUpdate computes the dislocation
 * forest evolution for the prismatic, pyramidal, and basal slip systems
 */

class CrystalPlasticityKocksMeckingGlideUpdate : public CrystalPlasticityStressUpdateBase
{
public:
  static InputParameters validParams();

  CrystalPlasticityKocksMeckingGlideUpdate(const InputParameters & parameters);

protected:
  virtual void initQpStatefulProperties() override;

  virtual void setInitialConstitutiveVariableValues() override;

  virtual void setSubstepConstitutiveVariableValues() override;

  virtual void updateSubstepConstitutiveVariableValues() override;

  virtual bool calculateSlipRate() override;

  virtual void
  calculateEquivalentSlipIncrement(RankTwoTensor & /*equivalent_slip_increment*/) override;

  virtual void calculateConstitutiveSlipDerivative(std::vector<Real> & dslip_dtau) override;

  virtual void cacheStateVariablesBeforeUpdate() override;

  /**
   * Calculates the evolution of the mobile glide dislocations with a two-term
   * constitutive model with a Kocks-Mecking form, following Cereceda et al.
   * International Journal of Plasticity 78 (2016) 242-265.
   */
  virtual void calculateStateVariableEvolutionRateComponent() override;

  virtual bool updateStateVariables() override;

  /**
   * Computes the evolution increment of the mobile (glide) dislocations on each
   * slip system in the Kocks-Mecking form, from equation 23 of Cereceda et al.
   * IJP 78 (2016) 242-265.
   * Additional coefficient values are added to enable model calibration to
   * different cubic crystals.
   */
  virtual void calculateMobileDislocationEvolutionIncrement();

  /**
   * Calculates the mean free glide path for dislocation glide, following
   * Lee et al. IJP 2010
   */
  virtual void calculateMeanFreeGlidePath(DenseVector<Real> & mean_free_glide_path);

  /**
   * Calculate the current value of the incremented mobile dislocation density
   * on each slip system after checking the increment falls within user-specified
   * tolerances
   */
  bool calculateMobileDislocationDensity();

  /**
   * Calculates the sum of the contribution of the initial slip resistance and the
   * forest dislocation density to the current slip resistance for each slip system,
   * following Ohashi. Philosophical Magazine A (1994) 70(5) 793-803
   */
  virtual void calculateSlipResistance() override;

  /**
   * Determines if the dislocation densities have converged
   * by comparing the change in the values over the iteration period.
   */
  virtual bool areConstitutiveStateVariablesConverged() override;

  /// Coupled temperature variable
  const VariableValue & _temperature;

  ///@{Mobile glide dislocation density quantities
  MaterialProperty<std::vector<Real>> & _mobile_dislocation_density;
  const MaterialProperty<std::vector<Real>> & _mobile_dislocation_density_old;
  MaterialProperty<std::vector<Real>> & _mobile_dislocation_increment;
  const Real _initial_dislocation_density;
  ///@}

  ///@{Constants used in Orowans relation to calculate the plastic slip increment
  const Real _burgers_vector;
  /// reference slip rate, used to calculate the initial glide velocity
  const Real _gamma_reference;
  /// strain rate sensitivity exponent
  const Real _m_exp;
  /// Average velocity of the mobile dislocation density, used in Orowan's relation
  MaterialProperty<std::vector<Real>> & _glide_velocity;
  const Real _inital_glide_velocity;
  ///@}

  /**
   * Helper variable to store the slip_increment * substep_dt vector values
   * for use across the constitutive model calculations
   */
  MaterialProperty<std::vector<Real>> & _constitutive_slip_increment;

  ///@{Calibration coefficients for the mobile dislocation evolution terms
  const Real _multiplication_coeff;
  const Real _forest_generation_coeff;
  const Real _edge_distance_coeff;
  ///}

  /// Linear grain size measurement value, in units of mm
  const Real _grain_size;

  ///@{Constants associated with individual slip system resistance
  const Real _forest_hardening_coeff;
  const Real _forest_latent_hardening;
  const Real _forest_self_hardening;
  const Real _shear_modulus;
  const Real _initial_lattice_friction;
  std::vector<Real> _static_resistance_contribution;
  ///@}

  ///@{Stores the slip system resistance, dislocation densities from the previous substep
  std::vector<Real> _previous_substep_slip_resistance;
  std::vector<Real> _previous_substep_mobile_dislocations;
  ///@}

  ///@{ Caching current slip resistance, dislocation density values before final update
  std::vector<Real> _slip_resistance_before_update;
  std::vector<Real> _mobile_dislocations_before_update;
  ///@}

  /**
   * Flag to include the total twin volume fraction in the plastic velocity
   * gradient calculation, per Kalidindi IJP (2001).
   */
  const bool _include_twinning_in_Lp;

  /**
   * User-defined material property name for the total volume fraction of twins
   * in a twinning propagation constitutive model, when this class is used in
   * conjunction with the twinning propagation model.
   * Note that this value is the OLD material property and thus lags the current
   * value by a single timestep.
   */
  const MaterialProperty<Real> * const _twin_volume_fraction_total;
};
