/****************************************************************/
/* MOOSE - Multiphysics Object Oriented Simulation Environment  */
/*                                                              */
/*          All contents are licensed under LGPL V2.1           */
/*             See LICENSE for full restrictions                */
/****************************************************************/
#ifndef CRYSTALPLASTICITYKHALINDIUPDATE_H
#define CRYSTALPLASTICITYKHALINDIUPDATE_H

#include "CrystalPlasticityUpdate.h"

class CrystalPlasticityKhalindiUpdate;

template<>
InputParameters validParams<CrystalPlasticityKhalindiUpdate>();

/**
 * CrystalPlasticityKhalindiUpdate uses the multiplicative decomposition of deformation gradient
 * and solves the PK2 stress residual equation at the intermediate configuration to evolve the material state.
 * The internal variables are updated using an interative predictor-corrector algorithm.
 * Backward Euler integration rule is used for the rate equations.
 * This material that is not called by MOOSE because
 * of the compute=false flag set in the parameter list. All materials inheriting
 * from this class must be called by a separate material, such as ComputeCrystalPlasticityStress.
 */

class CrystalPlasticityKhalindiUpdate : public CrystalPlasticityUpdate

{
public:
  CrystalPlasticityKhalindiUpdate(const InputParameters & parameters);

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
  virtual void calculateConstitutiveSlipDerivative(std::vector<Real> & dslip_dtau) override;

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

  MaterialProperty<std::vector<Real> > & _slip_system_resistance;
  MaterialProperty<std::vector<Real> > & _slip_system_resistance_old;
  MaterialProperty<std::vector<Real> > & _slip_increment;
//  MaterialProperty<std::vector<Real> > & _slip_increment_old;

  MaterialProperty<std::vector<Real> > & _previous_it_slip_increment;
  MaterialProperty<std::vector<Real> > & _previous_it_resistance;

  MaterialProperty<std::vector<Real> > & _tau;

  const Real _r;
  const Real _h;
  const Real _tau_sat;
  const Real _gss_a;
  const Real _ao;
  const Real _xm;
  const Real _gss_initial;
};

#endif //CRYSTALPLASTICITYKHALINDIUPDATE_H
