/****************************************************************/
/* MOOSE - Multiphysics Object Oriented Simulation Environment  */
/*                                                              */
/*          All contents are licensed under LGPL V2.1           */
/*             See LICENSE for full restrictions                */
/****************************************************************/
#ifndef CRYSTALPLASTICITYUPDATE_H
#define CRYSTALPLASTICITYUPDATE_H

#include "RankTwoTensor.h"
#include "RankFourTensor.h"
#include "Conversion.h"

class CrystalPlasticityUpdate;

template<>
InputParameters validParams<CrystalPlasticityUpdate>();

/**
 * CrystalPlasticityUpdate uses the multiplicative decomposition of deformation gradient
 * and solves the PK2 stress residual equation at the intermediate configuration to evolve the material state.
 * The internal variables are updated using an interative predictor-corrector algorithm.
 * Backward Euler integration rule is used for the rate equations.
 * This material that is not called by MOOSE because
 * of the compute=false flag set in the parameter list. All materials inheriting
 * from this class must be called by a separate material, such as ComputeCrystalPlasticityStress.
 */
class CrystalPlasticityUpdate : public Material
{
public:
  CrystalPlasticityUpdate(const InputParameters & parameters);

  /**
   * updates the stress at a quadrature point.
   */
  virtual void updateStress(RankTwoTensor & cauchy_stress, RankFourTensor & jacobian_mult);

  /// Sets the value of the global variable _qp for inheriting classes
  void setQp(unsigned int qp);

  ///@{ Retained as empty methods to avoid a warning from Material.C in framework. These methods are unused in all inheriting classes and should not be overwritten.
  void resetQpProperties() final {}
  void resetProperties() final {}
  ///@}

protected:
  /**
   * initializes the stateful properties such as
   * stress, plastic deformation gradient, slip system resistances, etc.
   */
  virtual void initQpStatefulProperties() override;

  /**
   * calls the residual and jacobian functions used in the
   * stress update algorithm.
   */
  void calcResidJacob();

  // /**
  //  * updates the slip system resistances and state variables.
  //  * override to modify slip system resistance and state variable evolution.
  //  */
  // virtual void updateSlipSystemResistanceAndStateVariable();

  /**
   * solve stress and internal variables.
   */
  void solveQp();

  /**
   * update stress and internal variable after solve.
   */
  void postSolveQp(RankTwoTensor & stress_new, RankFourTensor & jacobian_mult);

  /**
   * solve internal variables stress as a function of the slip specified by the
   * constitutive model defined in the inheriting class
   */
  void solveStatevar();

  /**
   * solves for stress, updates plastic deformation gradient.
   */
  void solveStress();

  /**
   * Calculate stress residual as the difference between the stored material property
   * PK2 stress and the elastic PK2 stress calculated from the constitutive
   * equivalent_slip_increment
   */
  void calcResidual();

  /**
   * Calculate jacobian.
   */
  void calcJacobian();

  /**
   * calculate the tangent moduli for preconditioner.
   * Default is the elastic stiffness matrix.
   * Exact jacobian is currently implemented.
   * tan_mod_type can be modified to exact in .i file to turn it on.
   */
  void calcTangentModuli(RankFourTensor & jacobian_mult);

  /**
   * calculate the elastic tangent moduli for preconditioner.
   */
  void elasticTangentModuli(RankFourTensor & jacobian_mult);

  /**
   * calculate the exact tangent moduli for preconditioner.
   */
  void elastoPlasticTangentModuli(RankFourTensor & jacobian_mult);

  /**
   * performs the line search update
   */
  bool lineSearchUpdate(const Real rnorm_prev, const RankTwoTensor);

  /*
   * Computes the Schmid tensor (m x n) for the current crystal lattice orientation for each slip system.
   */
  void calculateFlowDirection();

  /*
   * Read in the slip systems for the crystal from a file
   */
  void getSlipSystems();

  /*
   * This virtual method is called to calculate the total slip system slip
   * increment based on the constitutive model defined in the child class.
   * This method must be overwritten in the child class.
   */
  virtual void calculateConstitutiveEquivalentSlipIncrement(RankTwoTensor & /*equivalent_slip_increment*/,
                                                            bool & /*error_tolerance*/){};

  /*
   * This virtual method is called to find the derivative of the slip increment
   * with respect to the applied shear stress on the slip system based on the
   * constiutive model defined in the child class.  This method must be overwritten
   * in the child class.
   */
  virtual void calculateConstitutiveSlipDerivative(std::vector<Real> & /*dslip_dtau*/){};

  /*
   * Finalizes the values of the state variables and slip system resistance
   * for the current timestep after convergence has been reached.
   */
  virtual void updateConstitutiveSlipSystemResistanceAndVariables(){};

  /*
   * Determines if the state variables, e.g. defect densities, have converged
   * by comparing the change in the values over the iteration period.
   */
  virtual bool areConstitutiveStateVariablesConverged(){ return true; };
  //
  // /// Number of slip rate user objects
  // unsigned int _num_uo_slip_rates;
  //
  // /// Number of slip resistance user objects
  // unsigned int _num_uo_slip_resistances;
  //
  // /// Number of state variable user objects
  // unsigned int _num_uo_state_vars;
  //
  // /// Number of state variable evolution rate component user objects
  // unsigned int _num_uo_state_var_evol_rate_comps;
  //
  // /// Local state variable
  // std::vector<std::vector<Real> > _state_vars_old;
  //
  // /// Local old state variable
  // std::vector<std::vector<Real> > _state_vars_prev;

  /// optional parameter to define several mechanical systems on the same block, e.g. multiple phases
  const std::string _base_name;

  const MaterialProperty<RankFourTensor> & _elasticity_tensor;

  ///Maximum number of active slip systems for the crystalline material being modeled
  const unsigned int _number_slip_systems;

  /// File should contain slip plane normal and direction.
  std::string _slip_sys_file_name;

  /// Stress residual equation relative tolerance
  Real _rtol;
  /// Stress residual equation absolute tolerance
  Real _abs_tol;
  /// Internal variable update equation tolerance
  Real _rel_state_var_tol;
  /// Residual tolerance when variable value is zero. Default 1e-12.
  Real _zero_tol;

  /// Residual tensor
  RankTwoTensor _residual_tensor;

  /// Jacobian tensor
  RankFourTensor _jacobian;

  /// Maximum number of iterations for stress update
  unsigned int _maxiter;
  /// Maximum number of iterations for internal variable update
  unsigned int _maxiterg;

  /// Type of tangent moduli calculation
  MooseEnum _tan_mod_type;

  /// Maximum number of substep iterations
  unsigned int _max_substep_iter;

  /// Flag to activate line serach
  bool _use_line_search;

  /// Minimum line search step size
  Real _min_line_search_step_size;

  /// Line search bisection method tolerance
  Real _line_search_tolerance;

  /// Line search bisection method maximum iteration number
  unsigned int _line_search_max_iterations;

  /// Line search method
  MooseEnum _line_search_method;

  MaterialProperty<RankTwoTensor> & _plastic_deformation_gradient;
  MaterialProperty<RankTwoTensor> & _plastic_deformation_gradient_old;
  MaterialProperty<RankTwoTensor> & _pk2;
  MaterialProperty<RankTwoTensor> & _pk2_old;
  MaterialProperty<RankTwoTensor> & _total_lagrangian_strain;
  MaterialProperty<RankTwoTensor> & _update_rotation;
//  MaterialProperty<RankTwoTensor> & _update_rotation_old;

  std::vector<MaterialProperty<RankTwoTensor> *> _flow_direction;

  const MaterialProperty<RankTwoTensor> & _deformation_gradient;
  const MaterialProperty<RankTwoTensor> & _deformation_gradient_old;

  DenseVector<Real> _slip_direction;
  DenseVector<Real> _slip_plane_normal;

  /// Crystal rotation
  const MaterialProperty<RankTwoTensor> & _crysrot;

  RankTwoTensor _temporary_deformation_gradient;
  RankTwoTensor _elastic_deformation_gradient, _inverse_plastic_deformation_grad_old, _inverse_plastic_deformation_grad;
  // DenseVector<Real> _tau;

  /// Flag to check whether convergence is achieved
  bool _error_tolerance;

  /// Substepping time step value used within the inheriting constitutive models
  Real _substep_dt;
  /// Used for substepping; Uniformly divides the increment in deformation gradient
  RankTwoTensor _delta_deformation_gradient, _temporary_deformation_gradient_old;
  /// Scales the substepping increment to obtain deformation gradient at a substep iteration
  Real _dfgrd_scale_factor;
};

#endif //CRYSTALPLASTICITYUPDATE_H
