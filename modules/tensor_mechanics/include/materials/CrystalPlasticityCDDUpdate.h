/****************************************************************/
/* MOOSE - Multiphysics Object Oriented Simulation Environment  */
/*                                                              */
/*          All contents are licensed under LGPL V2.1           */
/*             See LICENSE for full restrictions                */
/****************************************************************/
#ifndef CRYSTALPLASTICITYCDDUPDATE_H
#define CRYSTALPLASTICITYCDDUPDATE_H

#include "CrystalPlasticityUpdate.h"

class CrystalPlasticityCDDUpdate;

template<>
InputParameters validParams<CrystalPlasticityCDDUpdate>();

/**
 * CrystalPlasticityCDDUpdate uses the multiplicative decomposition of deformation gradient
 * and solves the PK2 stress residual equation at the intermediate configuration to evolve the material state.
 * The internal variables are updated using an interative predictor-corrector algorithm.
 * Backward Euler integration rule is used for the rate equations.
 * This material that is not called by MOOSE because
 * of the compute=false flag set in the parameter list. All materials inheriting
 * from this class must be called by a separate material, such as ComputeCrystalPlasticityStress.
 */

class CrystalPlasticityCDDUpdate : public CrystalPlasticityUpdate

{
public:
  CrystalPlasticityCDDUpdate(const InputParameters & parameters);

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
  virtual void updateConstitutiveSlipSystemResistanceAndVariables() override;

  /*
   * Determines if the state variables, e.g. defect densities, have converged
   * by comparing the change in the values over the iteration period.
   */
  virtual bool areConstitutiveStateVariablesConverged() override;

  void calculateSlipSystemResistance();

  void calculateDislocationDensities(bool & error_tolerance);

  MaterialProperty<std::vector<Real> > & _mobile_dislocations;
  MaterialProperty<std::vector<Real> > & _mobile_dislocations_old;
  MaterialProperty<std::vector<Real> > & _immobile_dislocations;
  MaterialProperty<std::vector<Real> > & _immobile_dislocations_old;
  MaterialProperty<std::vector<Real> > & _slip_system_resistance;
  MaterialProperty<std::vector<Real> > & _slip_increment;
//  MaterialProperty<std::vector<Real> > & _slip_increment_old;

  MaterialProperty<std::vector<Real> > & _previous_it_mobile;
  MaterialProperty<std::vector<Real> > & _previous_it_immobile;
  MaterialProperty<std::vector<Real> > & _previous_it_slip_increment;

  MaterialProperty<std::vector<Real> > & _tau;
  MaterialProperty<std::vector<Real> > & _glide_velocity;

  const Real _burgers_vector;
  const Real _initial_dislocation_density;
  const Real _gamma_reference;
  const Real _m_exp;

  const Real _peierls_strength;
  const Real _baily_hirsch_alpha;

  const Real _alpha_1;
  const Real _alpha_2;
  const Real _alpha_3;
  const Real _alpha_4;
  const Real _alpha_5;
  const Real _alpha_6;
  const Real _radius_capture;

  const Real _inital_glide_velocity;
};

#endif //CRYSTALPLASTICITYCDDUPDATE_H
