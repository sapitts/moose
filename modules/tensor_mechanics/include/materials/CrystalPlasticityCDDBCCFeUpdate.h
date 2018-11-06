//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#ifndef CRYSTALPLASTICITYCDDBCCFEUPDATE_H
#define CRYSTALPLASTICITYCDDBCCFEUPDATE_H

#include "CrystalPlasticityCDDUpdateBase.h"

class CrystalPlasticityCDDBCCFeUpdate;

template<>
InputParameters validParams<CrystalPlasticityCDDBCCFeUpdate>();

/**
 * CrystalPlasticityCDDBCCFeUpdate uses the multiplicative decomposition of deformation gradient
 * and solves the PK2 stress residual equation at the intermediate configuration to evolve the material state.
 * The internal variables are updated using an interative predictor-corrector algorithm.
 * Backward Euler integration rule is used for the rate equations.
 * This material that is not called by MOOSE because
 * of the compute=false flag set in the parameter list. All materials inheriting
 * from this class must be called by a separate material, such as ComputeCrystalPlasticityStress.
 */

class CrystalPlasticityCDDBCCFeUpdate : public CrystalPlasticityCDDUpdateBase

{
public:
  CrystalPlasticityCDDBCCFeUpdate(const InputParameters & parameters);

protected:
  /**
   * initializes the stateful properties such as
   * stress, plastic deformation gradient, slip system resistances, etc.
   */
  virtual void initQpStatefulProperties() override;

  /**
   * This virtual method is called to set the constitutive internal state variables
   * current value to the old property value for the start of the stress convergence
   * while loop. This class also calculates the constitutive slip system resistance
   * based on the values set for the constitutive state variables.
   */
  virtual void setInitialConstitutiveVariableValues() override;

  /*
   * Finalizes the values of the state variables and slip system resistance
   * for the current timestep after convergence has been reached.
   */
  virtual void updateConstitutiveSlipSystemResistanceAndVariables(bool & error_tolerance) override;

  /*
   * Determines if the state variables, e.g. defect densities, have converged
   * by comparing the change in the values over the iteration period.
   */
  virtual bool areConstitutiveStateVariablesConverged() override;

  /**
   * Calculates the mean free path for glide dislocations as a function of the
   * total glide dislocations and the sia loop density, following Chakraborty (2016)
   */
  virtual Real calculateMeanFreeGlidePath() override;

  /**
   * Calculates the total slip system resistance contribution for those
   * hardening mechanisms which depend on evolving quantities, such as
   * dislocations. This method adds the evolved resistance quanity to the
   * static_resistance_contribution from the initSlipSystemResistance method.
   */
  virtual void calculateSlipSystemResistance(bool & error_tolerance) override;

  /**
   * Calculates the initial slip system resistance based on input parameters.
   * Includes the lone call to constant resistance contributor mechanisms and
   * sets the value for the static_resistance_contribution vector.
   */
  virtual void initSlipSystemResistance() override;

  /**
   * Applies different factors to different slip systems based on the value
   * of the slip plane normals. For slip plane normals of type {110}, an
   * anisotropic factor of 2.5 and for slip plane normals of type {123}, a
   * factor of 2.0 is applied.
   * Note: This method is only appropriate for BCC materials and is hard coded
   * for BCC alpha-iron.
   */
  void applyAnisotropicStrengthFactor();

  /**
   * Calculates the constant hardening effect of clusters of defects, e.g.
   * solute precipitates or vacancy clusters, with a dispersed barrier hardening
   * model with a sqaure root dependency on the cluster size and density.
   */
  Real calculateClusterDefectHardening();

  /**
  * Calculates the hardening due to SIA loop interaction with moving
  * dislocations in all slip systems according to the model presented in
  * Mastorakos and Zbib (2014). The hardening is applied in an isotropic
  * manner to all slip systems equally.
  */
  Real calculateSIALoopHardening();

  /**
   * Calculates the evolution of the scalar total SIA loop density following
   * Mastorakos and Zbib (2014) with a 3D interaction volume.
   * Also calculates the contribution of the SIA loops to the slip
   * system strength, which is stored as a material property.
   */
  void calculateIradiationSIALoopDensity();

  const bool _apply_anisotropic_strength;

  const Real _irradiation_hardening_coefficient;

  const Real _initial_SIAloop_density;
  MaterialProperty<Real> & _sia_loop_density;
  const MaterialProperty<Real> & _sia_loop_density_old;
  MaterialProperty<Real> & _previous_it_sia_loop;
  MaterialProperty<Real> & _sia_loop_slip_resistance;
  const Real _sia_loop_size;
  const Real _sia_loop_glide_path_coeff;
  const Real _sia_loop_hardening_coefficient;
  const Real _sia_loop_hardening_exponent;
  const Real _sia_loop_annhiliation_coefficient;
  const Real _sia_loop_radius_capture;

  Real _irradiation_cluster_defect_density;
  Real _irradiation_cluster_defect_size;

  /// Flag to run the SIA loop hardening calculations
  bool _calculate_sia_loop_hardening;
};

#endif //CRYSTALPLASTICITYCDDBCCFEUPDATE_H
