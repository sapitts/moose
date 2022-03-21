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

class CrystalPlasticityContinuumDislocationDynamicsUpdate;

/**
 * CrystalPlasticityContinuumDislocationDynamicsUpdate calculates the plastic
 * slip increment for each dislocation glide slip system as a function of mobile
 * and immobile dislocation densities and the interactions among them. These
 * dislocation interactions are based upon dislocation dynamics simulations in
 * BCC crystals.
 */

class CrystalPlasticityContinuumDislocationDynamicsUpdate : public CrystalPlasticityStressUpdateBase
{
public:
  static InputParameters validParams();

  CrystalPlasticityContinuumDislocationDynamicsUpdate(const InputParameters & parameters);

protected:
  virtual void initQpStatefulProperties() override;

  virtual void setInitialConstitutiveVariableValues() override;

  virtual void setSubstepConstitutiveVariableValues() override;

  virtual void updateSubstepConstitutiveVariableValues() override;

  /**
   * Calculates the plastic slip on each dislocation glide slip system through
   * an Orowan's Law relationship as a function of mobile dislocation density,
   * an average dislocation velocity measure, and the Burgers vector, following
   * Pitts et al. A Continuum Dislocation Dynamics Crystal Plasticity Approach
   * to Irradiated Body-Centered Cubic alpha-Iron. Journal of Engineering Materials
   * and Technology 144(2022)1, 011018.
   */
  virtual bool calculateSlipRate() override;

  virtual void calculateConstitutiveSlipDerivative(std::vector<Real> & dslip_dtau) override;

  virtual void cacheStateVariablesBeforeUpdate() override;

  // virtual void
  // calculateEquivalentSlipIncrement(RankTwoTensor & /*equivalent_slip_increment*/) override;

  virtual void calculateStateVariableEvolutionRateComponent() override;

  virtual bool updateStateVariables() override;

  /**
   * Calculates the cross slip of dislocations based on the probabilty of cross
   * slip calculation from Rhee et al. (1998). Uses a stochastic Monte Carlo
   * approach to determine how the cross slip probablity is incorporated into
   * the cross slip of dislocations, following Pitts et al. JEMT 2022
   */
  void calculateStochasticDislocationCrossSlip();

  /**
   * Calculates the increment of mobile dislocation density and of immobile
   * dislocation density for each slip system, following Li et al. IJP 2014
   */
  void calculateCDDModelDislocationIncrement();

  /**
   * Finds the mean free glide path for forest hardening from the total number
   * of dislocations within the system following Ohashi PMA 1994.
   */
  virtual Real calculateMeanFreeGlidePath();

  /**
   * Calculates the current dislocation density from the incremented value for
   * each dislocation population type. Includes a check to ensure the dislocation
   * density values are always positive values.
   */
  bool calculateDislocationDensity(std::vector<Real> & current_density,
                                   const std::vector<Real> & previous_substep_density,
                                   const std::vector<Real> & density_increment);

  /**
   * Calculates the total slip system resistance contribution for those
   * hardening mechanisms which depend on evolving quantities, such as
   * dislocations. This method adds the evolved resistance quantity to the
   * static_resistance_contribution from the initSlipSystemResistance method.
   */
  virtual void calculateSlipResistance() override;

  /**
   * Calculates the initial slip system resistance based on input parameters.
   * Includes the lone call to constant resistance contributor mechanisms and
   * sets the value for the static_resistance_contribution vector.
   */
  virtual void initSlipSystemResistance();

  /**
   * Calculates the contribution of hardening due to dislocation densities on
   * the self and on latent slip systems according to the modified Bailey-Hirsch
   * hardening model. The dislocation forest hardening model applies  user set
   * coefficient values for the self and latent system contributions, following
   * Ohashi PMA 1994.
   */
  void calculateDislocationForestHardening(std::vector<Real> & forest_strength);

  /**
   * Determines if the dislocation densities have converged by comparing the
   * incremental change from the previous iteration period to a user-defined
   * tolerance.
   */
  virtual bool areConstitutiveStateVariablesConverged() override;

  ///@{Density of dislocations which glide under the applied driving force
  MaterialProperty<std::vector<Real>> & _mobile_dislocations;
  const MaterialProperty<std::vector<Real>> & _mobile_dislocations_old;
  MaterialProperty<std::vector<Real>> & _mobile_dislocations_increment;
  const Real _initial_mobile_dislocation_density;
  ///@}

  ///@{Dislocation density population that is locked due to obstacles
  MaterialProperty<std::vector<Real>> & _immobile_dislocations;
  const MaterialProperty<std::vector<Real>> & _immobile_dislocations_old;
  MaterialProperty<std::vector<Real>> & _immobile_dislocations_increment;
  const Real _initial_immobile_dislocation_density;
  ///@}

  /// Population of dislocations that cross slip
  MaterialProperty<std::vector<Real>> & _cross_slip_dislocations;

  // MaterialProperty<Real> & _geometrical_necessary_dislocations;
  // MaterialProperty<RankTwoTensor> & _slip_increment_sum;
  // MaterialProperty<RankTwoTensor> & _nyes_tensor;
  // const MaterialProperty<RankTwoTensor> & _nyes_tensor_old;

  ///@{Constants used in Orowans relation to calculate the plastic slip increment
  const Real _burgers_vector;
  const Real _gamma_reference;
  const Real _m_exp;
  ///@}

  ///@{Average velocity of the mobile dislocation density, used in Orowan's relation
  MaterialProperty<std::vector<Real>> & _glide_velocity;
  const Real _inital_glide_velocity;
  ///@}

  ///@{Constants associated with individual slip system resistance
  const Real _shear_modulus;
  const Real _peierls_strength;
  std::vector<Real> _static_resistance_contribution;
  ///@}

  ///@{Coefficients used in the dislocation hardening model, following Ohashi PMA 1994
  const Real _baily_hirsch_alpha;
  const Real _dislocation_latent_hardening;
  const Real _dislocation_self_hardening;
  ///@}

  ///@{Coeffients for the CDD glide dislocation density evolution model, Li et al IJP 2014
  const Real _alpha_1;
  const Real _alpha_2;
  const Real _alpha_3;
  const Real _alpha_4;
  const Real _alpha_5;
  const Real _cross_slip_barrier_strength;
  const Real _alpha_6;
  const Real _radius_capture;
  const Real _glide_path_coeff;
  ///@}

  ///@{Constants used to calculate probability of cross slip, Rhee et al MSMSE 1998
  const bool _calculate_cross_slip;
  const Real _cs_activation_barrier;
  const Real _cs_activation_volume;
  const Real _boltzmann_constant;
  const Real _temperature;
  ///@}

  // /// Flag to include calculations of geometrically necessary dislocations
  // const bool _calculate_gnd_contribution;
  //
  // /// Coefficient for geometrically necessary dislocation density calculation
  // const Real _gnd_coefficient;
  //
  // /// Gradient of the coupled plastic velocity gradient components
  // std::vector<const VariableGradient *> _gradient_Lp;

  ///@{Stores the slip system resistance, dislocation densities from the previous substep
  std::vector<Real> _previous_substep_mobile_dislocations;
  std::vector<Real> _previous_substep_immobile_dislocations;
  std::vector<Real> _previous_substep_slip_resistance;
  ///@}

  ///@{ Caching current slip resistance, dislocation density values before final update
  std::vector<Real> _mobile_dislocations_before_update;
  std::vector<Real> _immobile_dislocations_before_update;
  std::vector<Real> _slip_resistance_before_update;
  ///@}
};
