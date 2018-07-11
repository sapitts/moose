/****************************************************************/
/* MOOSE - Multiphysics Object Oriented Simulation Environment  */
/*                                                              */
/*          All contents are licensed under LGPL V2.1           */
/*             See LICENSE for full restrictions                */
/****************************************************************/
#ifndef CRYSTALPLASTICITYENTHALPYFLOWRULEUPDATE_H
#define CRYSTALPLASTICITYENTHALPYFLOWRULEUPDATE_H

#include "CrystalPlasticityUpdate.h"

class CrystalPlasticityEnthalpyFlowRuleUpdate;

template<>
InputParameters validParams<CrystalPlasticityEnthalpyFlowRuleUpdate>();

/**
 * CrystalPlasticityEnthalpyFlowRuleUpdate uses the multiplicative decomposition of deformation gradient
 * and solves the PK2 stress residual equation at the intermediate configuration to evolve the material state.
 * The internal variables are updated using an interative predictor-corrector algorithm.
 * Backward Euler integration rule is used for the rate equations.
 * This material that is not called by MOOSE because
 * of the compute=false flag set in the parameter list. All materials inheriting
 * from this class must be called by a separate material, such as ComputeCrystalPlasticityStress.
 */

class CrystalPlasticityEnthalpyFlowRuleUpdate : public CrystalPlasticityUpdate
{
public:
  CrystalPlasticityEnthalpyFlowRuleUpdate(const InputParameters & parameters);

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
   * This virtual method is called to calculate the total slip system slip
   * increment based on the constitutive model defined in the child class.
   * This method must be overwritten in the child class.
   */
  virtual void calculateConstitutiveEquivalentSlipIncrement(RankTwoTensor & equivalent_slip_increment,
                                                            bool & error_tolerance) override;

  /*
   * This virtual method is called to find the derivative of the slip increment
   * with respect to the applied shear stress on the slip system based on the
   * constiutive model defined in the child class.  This method must be overwritten
   * in the child class.
   */
  virtual void calculateConstitutiveSlipDerivative(std::vector<Real> & dslip_dtau, unsigned int slip_model_number = 0) override;

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

  void calculateSlipSystemResistance(bool & error_tolerance);

  void calculateDislocationDensities(bool & error_tolerance);

  void calculateDislocationCrossSlip();

  /**
   * Dispersed barrier hardening model for dislocation interaction with irradiation
   * vacancy clusters and percipiate (e.g. copper) clusters.
   */
  Real calculateIrradiationClusterStrength();

  /**
   * Calculates the initial damage tensor for SIA loops, assuming that the
   * density of the SIA loops is evenly distributed across all of the normal loop planes
   * and that the normal loop planes of type {112} are the same as given in the slip systems
   * input for the BCC crystal following Chakraborty and Biner (2016)
   */
  void initializeSIALoopDamageTensor();

  /**
   * Calculates the evolution of the SIA loop damage tensor following from
   * Barton et.al.(2013).  Also calculates the square root of the contract
   * density, the potential space of dislocation-SIA loop interactions, as
   * a helper functionality to other methods in the class.
   */
  void calculateIradiationSIALoopDensity();

  ///@{Vector of variables to store the dislocation densities; one vector entry per slip system
  MaterialProperty<std::vector<Real> > & _mobile_dislocations;
  const MaterialProperty<std::vector<Real> > & _mobile_dislocations_old;
  MaterialProperty<std::vector<Real> > & _immobile_dislocations;
  const MaterialProperty<std::vector<Real> > & _immobile_dislocations_old;
  MaterialProperty<std::vector<Real> > & _cross_slip_dislocations;
  ///@}

  ///@{Slip system resistance due to physical barriers to dislocation motion, e.g. other dislocations and defects
  MaterialProperty<std::vector<Real> > & _athermal_slip_system_resistance;
  const MaterialProperty<std::vector<Real> > & _athermal_slip_system_resistance_old;
  ///@}

  MaterialProperty<std::vector<Real> > & _slip_increment;

  const Real _temperature;

  MaterialProperty<std::vector<Real> > & _previous_it_mobile;
  MaterialProperty<std::vector<Real> > & _previous_it_immobile;
  MaterialProperty<std::vector<Real> > & _previous_it_athermal_resistance;

  MaterialProperty<std::vector<Real> > & _glide_velocity;
  const Real _burgers_vector;

  const Real _thermal_slip_system_resistance;
  const Real _shear_modulus;
  const Real _dislocation_barrier_strength_coeff;
  const Real _dislocation_latent_hardening;
  const Real _dislocation_self_hardening;
  const Real _strength_superposition_factor;

  const Real _irradiation_cluster_hardening_coeff;
  Real _irradiation_cluster_defect_density;
  Real _irradiation_cluster_defect_size;

  const Real _initial_SIAloop_density;
  MaterialProperty<RankTwoTensor> & _irradiation_SIAloop_tensor;
  const MaterialProperty<RankTwoTensor> & _irradiation_SIAloop_tensor_old;
  const Real _irradiation_SIAloop_diameter;
  const Real _sia_loop_trapping_coeff;
  const Real _sia_loop_glide_path_coeff;
  const Real _irradiation_SIAloop_annhilation_coeff;
  MaterialProperty<std::vector<Real> > & _contact_SIAloop_density;

  const Real _p_exp;
  const Real _q_exp;
  const Real _avg_dislocation_glide_distance;
  const Real _jump_frequency;
  const Real _boltzmann_constant;
  const Real _activation_energy;

  const Real _dislocation_multiplication_coeff;
  const Real _dislocation_radius_capture;
  const Real _dislocation_mobile_recovery_coeff;
  const Real _dislocation_glide_path_coeff;

  const Real _cs_activation_barrier;
  const Real _cs_activation_volume;
  const Real _cross_slip_factor;

  /// The type of cross slip method to use when calculating the amounts of cross slip
  enum CrossSlipMethod
  {
    deterministic,
    stochastic
  } _cross_slip_type;

  const Real _initial_mobile_dislocation_density;
  const Real _initial_immobile_dislocation_density;
};

#endif //CRYSTALPLASTICITYENTHALPYFLOWRULEUPDATE_H
