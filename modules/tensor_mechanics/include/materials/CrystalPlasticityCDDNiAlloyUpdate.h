/****************************************************************/
/* MOOSE - Multiphysics Object Oriented Simulation Environment  */
/*                                                              */
/*          All contents are licensed under LGPL V2.1           */
/*             See LICENSE for full restrictions                */
/****************************************************************/
#ifndef CRYSTALPLASTICITYCDDNIALLOYUPDATE_H
#define CRYSTALPLASTICITYCDDNIALLOYUPDATE_H

#include "CrystalPlasticityCDDUpdateBase.h"

class CrystalPlasticityCDDNiAlloyUpdate;

template<>
InputParameters validParams<CrystalPlasticityCDDNiAlloyUpdate>();

/**
 * CrystalPlasticityCDDNiAlloyUpdate uses the multiplicative decomposition of deformation gradient
 * and solves the PK2 stress residual equation at the intermediate configuration to evolve the material state.
 * The internal variables are updated using an interative predictor-corrector algorithm.
 * Backward Euler integration rule is used for the rate equations.
 * This material that is not called by MOOSE because
 * of the compute=false flag set in the parameter list. All materials inheriting
 * from this class must be called by a separate material, such as ComputeCrystalPlasticityStress.
 */

class CrystalPlasticityCDDNiAlloyUpdate : public CrystalPlasticityCDDUpdateBase

{
public:
  CrystalPlasticityCDDNiAlloyUpdate(const InputParameters & parameters);

protected:
  /**
   * initializes the stateful properties such as
   * stress, plastic deformation gradient, slip system resistances, etc.
   */
  virtual void initQpStatefulProperties() override;

  /*
   * This virtual method is called to calculate the total slip system slip
   * increment based on the constitutive model defined in the child class.
   * This method must be overwritten in the child class.
   */
  virtual void calculateConstitutiveEquivalentSlipIncrement(RankTwoTensor & equivalent_slip_increment,
                                                            bool & error_tolerance) override;

  /**
   * Calculates the plastic shear slip increment due to twinning growth
   * following the phemonological model proposed in Kalidindi (2001)
   * International Journal of Plasticity, 17(6) pp. 837-860, eqn 18.
   */
  virtual void calculateTwinSlipIncrement(bool & error_tolerance);

  /*
   * This virtual method is called to find the derivative of the slip increment
   * with respect to the applied shear stress on the slip system based on the
   * constiutive model defined in the child class.  This method must be overwritten
   * in the child class.
   */
  virtual void calculateConstitutiveSlipDerivative(std::vector<Real> & dslip_dtau) override;

  /*
   * Calculates the derivative of the slip increment due to twinning growth
   */
  virtual void calculateTwinSlipDerivative(std::vector<Real> & dslip_twin_dtau);

  /*
   * Finalizes the values of the state variables and slip system resistance
   * for the current timestep after convergence has been reached.
   */
  virtual void updateConstitutiveSlipSystemResistanceAndVariables(bool & error_tolerance) override;

  /**
   * Calculates the  twin volume fraction rate following the phemonological model
   * proposed in Kalidindi (2001) International Journal of Plasticity, 17(6)
   * pp. 837-860, eqn 19.
   */
  void calculateTwinVolumeFraction(bool & error_tolerance);

  /**
   * Calculates the initial slip system resistance based on input parameters.
   * Includes the lone call to constant resistance contributor mechanisms and
   * sets the value for the static_resistance_contribution vector.
   */
  virtual void initSlipSystemResistance() override;

  /**
   * Calculates the constant hardening effect due to Orowan bowing of
   * dislocations around long-range ordered precipitates as a function of the
   * interparicle spacing
   */
  Real calculateOrowanBowingHardening();

  /**
   * Calculates the constant hardening contribution from Anti-Phase boundary
   * shearing of small tertiary long-range ordered precipitates, termed
   * weakly-coupled shearing because these precipitates are too small to contain
   * both dislocation partials. This method implements the APB weakly-coupled
   * model from Kozar et al. Metallurgical and Materials Transactions A, Vol 40A
   * (2009), Eq 9. A constant line tension value of $T_L = Gb/2$ is used.
   */
  Real calculateAPBWeaklyCoupledShearingHardening();

  ///@{Geometric characteristics of the tertiary LRO gamma prime precipitates
  const Real _tertiary_mean_diameter;
  const Real _tertiary_volume_fraction;
  ///@}

  /// Strengthening due to Orowan bowing coefficient
  const Real _orowan_bowing_coeff;

  ///@{Anti-Phase boundary weakly-coupled shearing model parameters
  const Real _tertiary_apb_coeff;
  const Real _tertiary_apb_energy;
  ///@}

  /// Maximum number of active twinning systems for the crystalline material being modeled
  const unsigned int _number_twin_systems;

  /// File should contain twinning plane normal and direction.
  std::string _twin_system_file_name;

  ///@{ Evolving state variable for twinned volume fraction of the crystal
  MaterialProperty<std::vector<Real> > & _volume_fraction_twins;
  const MaterialProperty<std::vector<Real> > & _volume_fraction_twins_old;
  ///@}

  ///@{ Plastic shear due to growth of twins
  MaterialProperty<std::vector<Real> > & _twin_shear_increment;
  const Real _characteristic_twin_shear;
  ///@}

  /// Resistance of the crystal to growth of twins
  MaterialProperty<std::vector<Real> > & _twin_system_resistance;

  /// Resolved applied shear stress on the twinning system
  MaterialProperty<std::vector<Real> > & _tau_twin_sytem;

  /// Maximum amount of twinning volume fraction at a material point
  const Real _limit_twin_volume_fraction;

  /**
   * Boolean to include the twinning calculations based on the number of twinning
   * systems set by the user.
   */
  bool _include_twinning_slip_contribution;

};

#endif //CRYSTALPLASTICITYCDDNIALLOYUPDATE_H
