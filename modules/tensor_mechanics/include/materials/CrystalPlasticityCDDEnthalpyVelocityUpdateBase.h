//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#ifndef CRYSTALPLASTICITYCDDENTHALPYVELOCITYUPDATEBASE_H
#define CRYSTALPLASTICITYCDDENTHALPYVELOCITYUPDATEBASE_H

#include "CrystalPlasticityUpdate.h"

class CrystalPlasticityCDDEnthalpyVelocityUpdateBase;

template<>
InputParameters validParams<CrystalPlasticityCDDEnthalpyVelocityUpdateBase>();

/**
 * CrystalPlasticityCDDEnthalpyVelocityUpdateBase uses the multiplicative decomposition of deformation gradient
 * and solves the PK2 stress residual equation at the intermediate configuration to evolve the material state.
 * The internal variables are updated using an interative predictor-corrector algorithm.
 * Backward Euler integration rule is used for the rate equations.
 * This material that is not called by MOOSE because
 * of the compute=false flag set in the parameter list. All materials inheriting
 * from this class must be called by a separate material, such as ComputeCrystalPlasticityStress.
 */
class CrystalPlasticityCDDEnthalpyVelocityUpdateBase : public CrystalPlasticityUpdate
{
public:
  CrystalPlasticityCDDEnthalpyVelocityUpdateBase(const InputParameters & parameters);

protected:
  // void initialSetup() override;

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
   * Calculates the slip increment due to dislocation glide and the dislocation
   * glide velocity using a power law relation
   */
  virtual void calculateGlideSlipIncrement(bool & error_tolerance);

  /*
   * This virtual method is called to find the derivative of the slip increment
   * with respect to the applied shear stress on the slip system based on the
   * constiutive model defined in the child class.  This method must be overwritten
   * in the child class.
   */
  virtual void calculateConstitutiveSlipDerivative(std::vector<Real> & dslip_dtau, unsigned int slip_model_number = 0) override;

  /*
   * Calculates the derivative of the slip increment due to dislocation glide
   */
  virtual void calculateGlideSlipDerivative(std::vector<Real> & dslip_glide_dtau);

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

  void calculateDislocationDensities(bool & error_tolerance);

  /**
   * Finds the mean free glide path for forest hardening from the total number
   * of dislocations within the system
   */
  virtual Real calculateMeanFreeGlidePath();

  /**
   * Calculates the cross slip of dislocations based on the probabilty of cross
   * slip calculation from Rhee et al. (1998).
   * Uses either a Monte Carlo or a addative approach to determine how the cross
   * slip probablity is incorporated in to the cross slip of dislocations
   */
  void calculateDislocationCrossSlip();

  /**
   * Calculate the density norm of the geometrically necessary
   * dislocations through the Nye's tensor, defined as the time
   * integral of the curl of the plastic velocity gradient.
   * Follows the approach of Lye et.al. (2016).
   */
  void calculateGeometricallyNecessaryDislocations();

  /**
   * Calculates the total slip system resistance contribution for those
   * hardening mechanisms which depend on evolving quantities, such as
   * dislocations. This method adds the evolved resistance quanity to the
   * static_resistance_contribution from the initSlipSystemResistance method.
   */
  virtual void calculateSlipSystemResistance(bool & error_tolerance);

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
   * coefficient values for the self and latent system contributions.
   */
  void calculateDislocationForestHardening(std::vector<Real> & forest_strength);

  MaterialProperty<std::vector<Real> > & _mobile_dislocations;
  const MaterialProperty<std::vector<Real> > & _mobile_dislocations_old;
  MaterialProperty<std::vector<Real> > & _immobile_dislocations;
  const MaterialProperty<std::vector<Real> > & _immobile_dislocations_old;
  MaterialProperty<std::vector<Real> > & _cross_slip_dislocations;
  MaterialProperty<Real> & _geometrical_necessary_dislocations;

  MaterialProperty<std::vector<Real> > & _athermal_slip_system_resistance;
  const MaterialProperty<std::vector<Real> > & _athermal_slip_system_resistance_old;
  MaterialProperty<std::vector<Real> > & _static_resistance_contribution;

  MaterialProperty<std::vector<Real> > & _glide_slip_increment;
  const Real _temperature;

  ///@{ Material properties from the previous iteration
  MaterialProperty<std::vector<Real> > & _previous_it_mobile;
  MaterialProperty<std::vector<Real> > & _previous_it_immobile;
  MaterialProperty<std::vector<Real> > & _previous_it_resistance;
  ///@}

  MaterialProperty<RankTwoTensor> & _slip_increment_sum;
  MaterialProperty<RankTwoTensor> & _nyes_tensor;
  const MaterialProperty<RankTwoTensor> & _nyes_tensor_old;

  // /// Reference to a MooseVariable object
  // MooseVariable & _gnd_displacement_variable;
  //
  // /// Shape function derivative on the displaced mesh
  // const VariablePhiGradient & _gnd_grad_phi;

  MaterialProperty<std::vector<Real> > & _glide_velocity;

  const Real _burgers_vector;
  const Real _initial_mobile_dislocation_density;
  const Real _initial_immobile_dislocation_density;
  const Real _thermal_slip_system_resistance;
  const Real _shear_modulus;

  const Real _p_exp;
  const Real _q_exp;
  const Real _avg_dislocation_glide_distance;
  const Real _jump_frequency;
  const Real _activation_energy;

  const Real _baily_hirsch_alpha;
  const Real _dislocation_latent_hardening;
  const Real _dislocation_self_hardening;

  const Real _alpha_1;
  const Real _alpha_2;
  const Real _alpha_3;
  const Real _alpha_4;
  const Real _alpha_5;
  const Real _cross_slip_barrier_strength;
  const Real _alpha_6;
  const Real _radius_capture;
  const Real _glide_path_coeff;

  const Real _cs_activation_barrier;
  const Real _cs_activation_volume;
  const Real _boltzmann_constant;

  /// The type of cross slip method to use when calculating the amounts of cross slip
  enum CrossSlipMethod
  {
    deterministic,
    stochastic
  } _cross_slip_type;

  /// Flag to include calculations of geometrically necessary dislocations
  const bool _calculate_gnd_contribution;

  /// Coefficient for geometrically necessary dislocation density calculation
  const Real _gnd_coefficient;

  /// Gradient of the coupled plastic velocity gradient components
  std::vector<const VariableGradient *> _gradient_Lp;
};

#endif //CRYSTALPLASTICITYCDDENTHALPYVELOCITYUPDATEBASE_H
