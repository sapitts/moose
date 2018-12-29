[GlobalParams]
  displacements = 'disp_x disp_y disp_z'
[]

[Mesh]
  file = parallel_bixtal_2elem_depth.e
[]

[AuxVariables]
  [./stress_zz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./pk2_zz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./fp_zz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./e_zz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_xx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./pk2_xx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./fp_xx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./e_xx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_yy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./pk2_yy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./fp_yy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./e_yy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./vonmises_stress_cauchy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./eff_strain_green]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./vonmises_stress_pk2]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./eff_strain_lag]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./velocity_gradient_xx]
    order = FIRST
    family = LAGRANGE
  [../]
  [./velocity_gradient_xy]
    order = FIRST
    family = LAGRANGE
  [../]
  [./velocity_gradient_xz]
    order = FIRST
    family = LAGRANGE
  [../]
  [./velocity_gradient_yx]
    order = FIRST
    family = LAGRANGE
  [../]
  [./velocity_gradient_yy]
    order = FIRST
    family = LAGRANGE
  [../]
  [./velocity_gradient_yz]
    order = FIRST
    family = LAGRANGE
  [../]
  [./velocity_gradient_zx]
    order = FIRST
    family = LAGRANGE
  [../]
  [./velocity_gradient_zy]
    order = FIRST
    family = LAGRANGE
  [../]
  [./velocity_gradient_zz]
    order = FIRST
    family = LAGRANGE
  [../]
  [./euler_angle1]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./euler_angle2]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./euler_angle3]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./nyes_tensor_00]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./nyes_tensor_01]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./nyes_tensor_02]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./nyes_tensor_10]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./nyes_tensor_11]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./nyes_tensor_12]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./nyes_tensor_20]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./nyes_tensor_21]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./nyes_tensor_22]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gnd_density]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_0]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_0]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./immobile_disl_0]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./tau_0]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_1]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_1]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./immobile_disl_1]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./tau_1]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_2]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_2]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./immobile_disl_2]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./tau_2]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_3]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_3]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./immobile_disl_3]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./tau_3]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_4]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_4]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./immobile_disl_4]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./tau_4]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_5]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_5]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./immobile_disl_5]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./tau_5]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_6]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_6]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./immobile_disl_6]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./tau_6]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_7]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_7]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./immobile_disl_7]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./tau_7]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_8]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_8]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./immobile_disl_8]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./tau_8]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_9]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_9]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./immobile_disl_9]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./tau_9]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_10]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_10]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./immobile_disl_10]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./tau_10]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_11]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_11]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./immobile_disl_11]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./tau_11]
    order = CONSTANT
    family = MONOMIAL
  [../]
[]

[Modules]
  [./TensorMechanics]
    [./Master]
      [./all]
        strain = FINITE
        add_variables = true
        volumetric_locking_correction = true
      [../]
    [../]
  [../]
[]

[AuxKernels]
  [./stress_zz]
    type = RankTwoAux
    variable = stress_zz
    rank_two_tensor = stress
    index_j = 2
    index_i = 2
    execute_on = timestep_end
  [../]
  [./pk2_zz]
    type = RankTwoAux
    variable = pk2_zz
    rank_two_tensor = pk2
    index_j = 2
    index_i = 2
    execute_on = timestep_end
  [../]
  [./fp_zz]
    type = RankTwoAux
    variable = fp_zz
    rank_two_tensor = fp
    index_j = 2
    index_i = 2
    execute_on = timestep_end
  [../]
  [./e_zz]
    type = RankTwoAux
    variable = e_zz
    rank_two_tensor = lage
    index_j = 2
    index_i = 2
    execute_on = timestep_end
  [../]
  [./stress_xx]
    type = RankTwoAux
    variable = stress_xx
    rank_two_tensor = stress
    index_j = 0
    index_i = 0
    execute_on = timestep_end
  [../]
  [./pk2_xx]
    type = RankTwoAux
    variable = pk2_xx
    rank_two_tensor = pk2
    index_j = 0
    index_i = 0
    execute_on = timestep_end
  [../]
  [./fp_xx]
    type = RankTwoAux
    variable = fp_xx
    rank_two_tensor = fp
    index_j = 0
    index_i = 0
    execute_on = timestep_end
  [../]
  [./e_xx]
    type = RankTwoAux
    variable = e_xx
    rank_two_tensor = lage
    index_j = 0
    index_i = 0
    execute_on = timestep_end
  [../]
  [./stress_yy]
    type = RankTwoAux
    variable = stress_yy
    rank_two_tensor = stress
    index_j = 1
    index_i = 1
    execute_on = timestep_end
  [../]
  [./pk2_yy]
    type = RankTwoAux
    variable = pk2_yy
    rank_two_tensor = pk2
    index_j = 1
    index_i = 1
    execute_on = timestep_end
  [../]
  [./fp_yy]
    type = RankTwoAux
    variable = fp_yy
    rank_two_tensor = fp
    index_j = 1
    index_i = 1
    execute_on = timestep_end
  [../]
  [./e_yy]
    type = RankTwoAux
    variable = e_yy
    rank_two_tensor = lage
    index_j = 0
    index_i = 0
    execute_on = timestep_end
  [../]
  [./vonmises_stress_cauchy]
    type = RankTwoScalarAux
    variable = vonmises_stress_cauchy
    rank_two_tensor = stress
    scalar_type = VonMisesStress
    execute_on = timestep_end
  [../]
  [./effective_strain_green]
    type = RankTwoScalarAux
    variable = eff_strain_green
    rank_two_tensor = total_strain
    scalar_type = EffectiveStrain
    execute_on = timestep_end
  [../]
  [./vonmises_stress_pk2]
    type = RankTwoScalarAux
    variable = vonmises_stress_pk2
    rank_two_tensor = pk2
    scalar_type = VonMisesStress
    execute_on = timestep_end
  [../]
  [./effective_strain_lag]
    type = RankTwoScalarAux
    variable = eff_strain_lag
    rank_two_tensor = lage
    scalar_type = EffectiveStrain
    execute_on = timestep_end
  [../]
  [./velocity_grad_xx_recovered]
    type = RankTwoAux
    rank_two_tensor = plastic_velocity_gradient
    variable = velocity_gradient_xx
    patch_polynomial_order = FIRST
    index_i = 0
    index_j = 0
    # execute_on = 'nonlinear'
  [../]
  [./velocity_grad_xy_recovered]
    type = RankTwoAux
    rank_two_tensor = plastic_velocity_gradient
    variable = velocity_gradient_xy
    patch_polynomial_order = FIRST
    index_i = 0
    index_j = 1
    # execute_on = 'nonlinear'
  [../]
  [./velocity_grad_xz_recovered]
    type = RankTwoAux
    rank_two_tensor = plastic_velocity_gradient
    variable = velocity_gradient_xz
    patch_polynomial_order = FIRST
    index_i = 0
    index_j = 2
    # execute_on = 'nonlinear'
  [../]
  [./velocity_grad_yx_recovered]
    type = RankTwoAux
    rank_two_tensor = plastic_velocity_gradient
    variable = velocity_gradient_yx
    patch_polynomial_order = FIRST
    index_i = 1
    index_j = 0
    # execute_on = 'nonlinear'
  [../]
  [./velocity_grad_yy_recovered]
    type = RankTwoAux
    rank_two_tensor = plastic_velocity_gradient
    variable = velocity_gradient_yy
    patch_polynomial_order = FIRST
    index_i = 1
    index_j = 1
    # execute_on = 'nonlinear'
  [../]
  [./velocity_grad_yz_recovered]
    type = RankTwoAux
    rank_two_tensor = plastic_velocity_gradient
    variable = velocity_gradient_yz
    patch_polynomial_order = FIRST
    index_i = 1
    index_j = 2
    # execute_on = 'nonlinear'
  [../]
  [./velocity_grad_zx_recovered]
    type = RankTwoAux
    rank_two_tensor = plastic_velocity_gradient
    variable = velocity_gradient_zx
    patch_polynomial_order = FIRST
    index_i = 2
    index_j = 0
    # execute_on = 'nonlinear'
  [../]
  [./velocity_grad_zy_recovered]
    type = RankTwoAux
    rank_two_tensor = plastic_velocity_gradient
    variable = velocity_gradient_zy
    patch_polynomial_order = FIRST
    index_i = 1
    index_j = 2
    # execute_on = 'nonlinear'
  [../]
  [./velocity_grad_zz_recovered]
    type = RankTwoAux
    rank_two_tensor = plastic_velocity_gradient
    variable = velocity_gradient_zz
    patch_polynomial_order = FIRST
    index_i = 2
    index_j = 2
    # execute_on = 'nonlinear'
  [../]
  [./euler_angle1]
    type = MaterialRealVectorValueAux
    variable = euler_angle1
    property = Euler_angles
    component = 0
    execute_on = initial
  [../]
  [./euler_angle2]
    type = MaterialRealVectorValueAux
    variable = euler_angle2
    property = Euler_angles
    component = 1
    execute_on = initial
  [../]
  [./euler_angle3]
    type = MaterialRealVectorValueAux
    variable = euler_angle3
    property = Euler_angles
    component = 2
    execute_on = initial
  [../]
  [./nyes_tensor_00]
    type = RankTwoAux
    variable = nyes_tensor_00
    rank_two_tensor = Nyes_dislocation_tensor
    index_i = 0
    index_j = 0
    execute_on = timestep_end
  [../]
  [./nyes_tensor_01]
    type = RankTwoAux
    variable = nyes_tensor_01
    rank_two_tensor = Nyes_dislocation_tensor
    index_i = 0
    index_j = 1
    execute_on = timestep_end
  [../]
  [./nyes_tensor_02]
    type = RankTwoAux
    variable = nyes_tensor_02
    rank_two_tensor = Nyes_dislocation_tensor
    index_i = 0
    index_j = 2
    execute_on = timestep_end
  [../]
  [./nyes_tensor_10]
    type = RankTwoAux
    variable = nyes_tensor_10
    rank_two_tensor = Nyes_dislocation_tensor
    index_i = 1
    index_j = 0
    execute_on = timestep_end
  [../]
  [./nyes_tensor_11]
    type = RankTwoAux
    variable = nyes_tensor_11
    rank_two_tensor = Nyes_dislocation_tensor
    index_i = 1
    index_j = 1
    execute_on = timestep_end
  [../]
  [./nyes_tensor_12]
    type = RankTwoAux
    variable = nyes_tensor_12
    rank_two_tensor = Nyes_dislocation_tensor
    index_i = 1
    index_j = 2
    execute_on = timestep_end
  [../]
  [./nyes_tensor_20]
    type = RankTwoAux
    variable = nyes_tensor_20
    rank_two_tensor = Nyes_dislocation_tensor
    index_i = 2
    index_j = 0
    execute_on = timestep_end
  [../]
  [./nyes_tensor_21]
    type = RankTwoAux
    variable = nyes_tensor_21
    rank_two_tensor = Nyes_dislocation_tensor
    index_i = 2
    index_j = 1
    execute_on = timestep_end
  [../]
  [./nyes_tensor_22]
    type = RankTwoAux
    variable = nyes_tensor_22
    rank_two_tensor = Nyes_dislocation_tensor
    index_i = 2
    index_j = 2
    execute_on = timestep_end
  [../]
  [./gnd_density]
    type = MaterialRealAux
    variable = gnd_density
    property = density_norm_geometric_necessary_dislocations
    execute_on = timestep_end
  [../]
  #[./rot_out_001]
  #  type = CrystalPlasticityRotationOutAux
  #  variable = rot_out_001
  #  execute_on = timestep_end
  #[../]
  [./gss_0]
    type = MaterialStdVectorAux
    variable = gss_0
    property = slip_system_resistance
    index = 0
    execute_on = timestep_end
  [../]
  [./mobile_disl_0]
    type = MaterialStdVectorAux
    variable = mobile_disl_0
    property = mobile_dislocations
    index = 0
    execute_on = timestep_end
  [../]
  [./immobile_disl_0]
    type = MaterialStdVectorAux
    variable = immobile_disl_0
    property = immobile_dislocations
    index = 0
    execute_on = timestep_end
  [../]
  [./tau_0]
    type = MaterialStdVectorAux
    variable = tau_0
    property = applied_shear_stress
    index = 0
    execute_on = timestep_end
  [../]
  [./gss_1]
    type = MaterialStdVectorAux
    variable = gss_1
    property = slip_system_resistance
    index = 1
    execute_on = timestep_end
  [../]
  [./mobile_disl_1]
    type = MaterialStdVectorAux
    variable = mobile_disl_1
    property = mobile_dislocations
    index = 1
    execute_on = timestep_end
  [../]
  [./immobile_disl_1]
    type = MaterialStdVectorAux
    variable = immobile_disl_1
    property = immobile_dislocations
    index = 1
    execute_on = timestep_end
  [../]
  [./tau_1]
    type = MaterialStdVectorAux
    variable = tau_1
    property = applied_shear_stress
    index = 1
    execute_on = timestep_end
  [../]
  [./gss_2]
    type = MaterialStdVectorAux
    variable = gss_2
    property = slip_system_resistance
    index = 2
    execute_on = timestep_end
  [../]
  [./mobile_disl_2]
    type = MaterialStdVectorAux
    variable = mobile_disl_2
    property = mobile_dislocations
    index = 2
    execute_on = timestep_end
  [../]
  [./immobile_disl_2]
    type = MaterialStdVectorAux
    variable = immobile_disl_2
    property = immobile_dislocations
    index = 2
    execute_on = timestep_end
  [../]
  [./tau_2]
    type = MaterialStdVectorAux
    variable = tau_2
    property = applied_shear_stress
    index = 2
    execute_on = timestep_end
  [../]
  [./gss_3]
    type = MaterialStdVectorAux
    variable = gss_3
    property = slip_system_resistance
    index = 3
    execute_on = timestep_end
  [../]
  [./mobile_disl_3]
    type = MaterialStdVectorAux
    variable = mobile_disl_3
    property = mobile_dislocations
    index = 3
    execute_on = timestep_end
  [../]
  [./immobile_disl_3]
    type = MaterialStdVectorAux
    variable = immobile_disl_3
    property = immobile_dislocations
    index = 3
    execute_on = timestep_end
  [../]
  [./tau_3]
    type = MaterialStdVectorAux
    variable = tau_3
    property = applied_shear_stress
    index = 3
    execute_on = timestep_end
  [../]
  [./gss_4]
    type = MaterialStdVectorAux
    variable = gss_4
    property = slip_system_resistance
    index = 4
    execute_on = timestep_end
  [../]
  [./mobile_disl_4]
    type = MaterialStdVectorAux
    variable = mobile_disl_4
    property = mobile_dislocations
    index = 4
    execute_on = timestep_end
  [../]
  [./immobile_disl_4]
    type = MaterialStdVectorAux
    variable = immobile_disl_4
    property = immobile_dislocations
    index = 4
    execute_on = timestep_end
  [../]
  [./tau_4]
    type = MaterialStdVectorAux
    variable = tau_4
    property = applied_shear_stress
    index = 4
    execute_on = timestep_end
  [../]
  [./gss_5]
    type = MaterialStdVectorAux
    variable = gss_5
    property = slip_system_resistance
    index = 5
    execute_on = timestep_end
  [../]
  [./mobile_disl_5]
    type = MaterialStdVectorAux
    variable = mobile_disl_5
    property = mobile_dislocations
    index = 5
    execute_on = timestep_end
  [../]
  [./immobile_disl_5]
    type = MaterialStdVectorAux
    variable = immobile_disl_5
    property = immobile_dislocations
    index = 5
    execute_on = timestep_end
  [../]
  [./tau_5]
    type = MaterialStdVectorAux
    variable = tau_5
    property = applied_shear_stress
    index = 5
    execute_on = timestep_end
  [../]
  [./gss_6]
    type = MaterialStdVectorAux
    variable = gss_6
    property = slip_system_resistance
    index = 6
    execute_on = timestep_end
  [../]
  [./mobile_disl_6]
    type = MaterialStdVectorAux
    variable = mobile_disl_6
    property = mobile_dislocations
    index = 6
    execute_on = timestep_end
  [../]
  [./immobile_disl_6]
    type = MaterialStdVectorAux
    variable = immobile_disl_6
    property = immobile_dislocations
    index = 6
    execute_on = timestep_end
  [../]
  [./tau_6]
    type = MaterialStdVectorAux
    variable = tau_6
    property = applied_shear_stress
    index = 6
    execute_on = timestep_end
  [../]
  [./gss_7]
    type = MaterialStdVectorAux
    variable = gss_7
    property = slip_system_resistance
    index = 7
    execute_on = timestep_end
  [../]
  [./mobile_disl_7]
    type = MaterialStdVectorAux
    variable = mobile_disl_7
    property = mobile_dislocations
    index = 7
    execute_on = timestep_end
  [../]
  [./immobile_disl_7]
    type = MaterialStdVectorAux
    variable = immobile_disl_7
    property = immobile_dislocations
    index = 7
    execute_on = timestep_end
  [../]
  [./tau_7]
    type = MaterialStdVectorAux
    variable = tau_7
    property = applied_shear_stress
    index = 7
    execute_on = timestep_end
  [../]
  [./gss_8]
    type = MaterialStdVectorAux
    variable = gss_8
    property = slip_system_resistance
    index = 8
    execute_on = timestep_end
  [../]
  [./mobile_disl_8]
    type = MaterialStdVectorAux
    variable = mobile_disl_8
    property = mobile_dislocations
    index = 8
    execute_on = timestep_end
  [../]
  [./immobile_disl_8]
    type = MaterialStdVectorAux
    variable = immobile_disl_8
    property = immobile_dislocations
    index = 8
    execute_on = timestep_end
  [../]
  [./tau_8]
    type = MaterialStdVectorAux
    variable = tau_8
    property = applied_shear_stress
    index = 8
    execute_on = timestep_end
  [../]
  [./gss_9]
    type = MaterialStdVectorAux
    variable = gss_9
    property = slip_system_resistance
    index = 9
    execute_on = timestep_end
  [../]
  [./mobile_disl_9]
    type = MaterialStdVectorAux
    variable = mobile_disl_9
    property = mobile_dislocations
    index = 9
    execute_on = timestep_end
  [../]
  [./immobile_disl_9]
    type = MaterialStdVectorAux
    variable = immobile_disl_9
    property = immobile_dislocations
    index = 9
    execute_on = timestep_end
  [../]
  [./tau_9]
    type = MaterialStdVectorAux
    variable = tau_9
    property = applied_shear_stress
    index = 9
    execute_on = timestep_end
  [../]
  [./gss_10]
    type = MaterialStdVectorAux
    variable = gss_10
    property = slip_system_resistance
    index = 10
    execute_on = timestep_end
  [../]
  [./mobile_disl_10]
    type = MaterialStdVectorAux
    variable = mobile_disl_10
    property = mobile_dislocations
    index = 10
    execute_on = timestep_end
  [../]
  [./immobile_disl_10]
    type = MaterialStdVectorAux
    variable = immobile_disl_10
    property = immobile_dislocations
    index = 10
    execute_on = timestep_end
  [../]
  [./tau_10]
    type = MaterialStdVectorAux
    variable = tau_10
    property = applied_shear_stress
    index = 10
    execute_on = timestep_end
  [../]
  [./gss_11]
    type = MaterialStdVectorAux
    variable = gss_11
    property = slip_system_resistance
    index = 11
    execute_on = timestep_end
  [../]
  [./mobile_disl_11]
    type = MaterialStdVectorAux
    variable = mobile_disl_11
    property = mobile_dislocations
    index = 11
    execute_on = timestep_end
  [../]
  [./immobile_disl_11]
    type = MaterialStdVectorAux
    variable = immobile_disl_11
    property = immobile_dislocations
    index = 11
    execute_on = timestep_end
  [../]
  [./tau_11]
    type = MaterialStdVectorAux
    variable = tau_11
    property = applied_shear_stress
    index = 11
    execute_on = timestep_end
  [../]
[]

[BCs]
  [./roller_z]
    type = PresetBC
    variable = disp_z
    boundary = bottom
    value = 0
  [../]
  [./fixed_pt_y]
    type = PresetBC
    variable = disp_y
    boundary = center
    value = 0
  [../]
  [./fixed_pt_x]
    type = PresetBC
    variable = disp_x
    boundary = center
    value = 0
  [../]
  [./tension_displacement]
    type = FunctionPresetBC
    variable = disp_z
    boundary = top
    function = '1.0e-3*t'
  [../]
[]

[Materials]
  [./crystal_plasticity_stress]
    type = ComputeCrystalPlasticityStress
    crystal_plasticity_update_model = 'trial_xtalpl'
  [../]
  [./trial_xtalpl]
    type = CrystalPlasticityCDDNiAlloyUpdate
    number_slip_systems = 12
    slip_sys_file_name = 'fcc_input_slip_sys.txt'
    number_twin_systems = 0
    twin_system_file_name = 'fcc_input_slip_sys.txt'
    number_cross_slip_directions = 0
    number_cross_slip_planes = 0
    temperature = 298.0
    initial_immobile_dislocation_density = 0.5e3 #half initial dislocation density in Kondou et.al. 2008;
    initial_mobile_dislocation_density = 0.5e3 #half initial dislocation density in Kondou et.al. 2008;
    alpha_1 = 0.035 #from initial [111] fitting for much larger dislocation density
    alpha_2 = 0.5
    alpha_3 = 0.002
    alpha_4 = 0.002
    alpha_5 = 0.001
    alpha_6 = 0.1
    include_GND_contribution = true
    plastic_velocity_gradient_components = 'velocity_gradient_xx velocity_gradient_xy velocity_gradient_xz velocity_gradient_yx velocity_gradient_yy velocity_gradient_yz velocity_gradient_zx velocity_gradient_zy velocity_gradient_zz'
    tertiary_precipitate_mean_diameter = 0.0 # No additional hardening
    tertiary_precipitate_volume_fraction = 0.0 #No additional hardening
    Peierls_stress = 5.46 #1.0e-4 times shear modulus
    shear_modulus = 54.6e3 #Hirth and Lothe for Cu, pg 837
    burgers_vector = 2.556e-07 #Simon, Drexler, and Reed NIST MN 177
    stol = 0.01 #Was using 1.0e-3 before
    maximum_substep_iteration = 10
    maxiter = 30
    maxiter_state_variable = 30
    line_search_method = CUT_HALF
    use_line_search = true
    tan_mod_type = exact
  [../]
  [./elasticity_tensor_right]
    type = ComputeElasticityTensorConstantRotationCP
    block = 2
    C_ijkl = '168.4e3 121.4e3 121.4e3 168.4e3 121.4e3 168.4e3 75.4e3 75.4e3 75.4e3' #Hirth and Lothe for Cu, 2nd ed, pg 837
    fill_method = symmetric9
    euler_angle_1 = 315.5
    euler_angle_2 = 280.5
    euler_angle_3 = 248.2
  [../]
  [./elasticity_tensor_left]
    type = ComputeElasticityTensorConstantRotationCP
    block = 1
    C_ijkl = '168.4e3 121.4e3 121.4e3 168.4e3 121.4e3 168.4e3 75.4e3 75.4e3 75.4e3' #Hirth and Lothe for Cu, 2nd ed, pg 837
    fill_method = symmetric9
    euler_angle_1 = 44.46
    euler_angle_2 = 79.48
    euler_angle_3 = 111.8
  [../]
  # [./stress_52bar1]
  #   type = ComputeCrystalPlasticityStress
  #   block = 1
  #   crystal_plasticity_update_model = 'trial_xtalpl_52bar1'
  # [../]
  # [./trial_xtalpl_52bar1]
  #   type = CrystalPlasticityCDDNiAlloyUpdate
  #  block = 1
  #   number_slip_systems = 12
  #   slip_sys_file_name = 'fcc_input_slip_sys.txt'
  #   number_twin_systems = 0
  #   twin_system_file_name = 'fcc_input_slip_sys.txt'
  #   number_cross_slip_directions = 0
  #   number_cross_slip_planes = 0
  #   temperature = 298.0
  #   initial_immobile_dislocation_density = 0.5e3 #half initial dislocation density in Kondou et.al. 2008;
  #   initial_mobile_dislocation_density = 0.5e3 #half initial dislocation density in Kondou et.al. 2008;
  #   alpha_1 = 0.035 #from initial [111] fitting for much larger dislocation density
  #   alpha_2 = 0.5
  #   alpha_3 = 0.002
  #   alpha_4 = 0.002
  #   alpha_5 = 0.001
  #   alpha_6 = 0.1
  #   include_GND_contribution = true
  #   plastic_velocity_gradient_components = 'velocity_gradient_xx velocity_gradient_xy velocity_gradient_xz velocity_gradient_yx velocity_gradient_yy velocity_gradient_yz velocity_gradient_zx velocity_gradient_zy velocity_gradient_zz'
  #   tertiary_precipitate_mean_diameter = 0.0 # No additional hardening
  #   tertiary_precipitate_volume_fraction = 0.0 #No additional hardening
  #   Peierls_stress = 5.46 #1.0e-4 times shear modulus
  #   shear_modulus = 54.6e3 #Hirth and Lothe for Cu, pg 837
  #   burgers_vector = 2.556e-07 #Simon, Drexler, and Reed NIST MN 177
  #   stol = 1.0e-3
  #   maximum_substep_iteration = 10
  #   maxiter = 30
  #   maxiter_state_variable = 30
  #   line_search_method = CUT_HALF
  #   use_line_search = true
  #   tan_mod_type = exact
  # [../]
[]

[Postprocessors]
  [./stress_zz]
    type = ElementAverageValue
    variable = stress_zz
  [../]
  [./pk2_zz]
    type = ElementAverageValue
    variable = pk2_zz
  [../]
  [./fp_zz]
    type = ElementAverageValue
    variable = fp_zz
  [../]
  [./e_zz]
    type = ElementAverageValue
    variable = e_zz
  [../]
  [./stress_xx]
    type = ElementAverageValue
    variable = stress_xx
  [../]
  [./pk2_xx]
    type = ElementAverageValue
    variable = pk2_xx
  [../]
  [./fp_xx]
    type = ElementAverageValue
    variable = fp_xx
  [../]
  [./e_xx]
    type = ElementAverageValue
    variable = e_xx
  [../]
  [./stress_yy]
    type = ElementAverageValue
    variable = stress_yy
  [../]
  [./pk2_yy]
    type = ElementAverageValue
    variable = pk2_yy
  [../]
  [./fp_yy]
    type = ElementAverageValue
    variable = fp_yy
  [../]
  [./e_yy]
    type = ElementAverageValue
    variable = e_yy
  [../]
  [./vonmises_stress_cauchy]
    type = ElementAverageValue
    variable = vonmises_stress_cauchy
  [../]
  [./effective_strain_green]
    type = ElementAverageValue
    variable = eff_strain_green
  [../]
  [./vonmises_stress_pk2]
    type = ElementAverageValue
    variable = vonmises_stress_pk2
  [../]
  [./effective_strain]
    type = ElementAverageValue
    variable = eff_strain_lag
  [../]
  [./velocity_gradient_xx]
    type = AverageNodalVariableValue
    variable = velocity_gradient_xx
  [../]
  [./velocity_gradient_xy]
    type = AverageNodalVariableValue
    variable = velocity_gradient_xy
  [../]
  [./velocity_gradient_xz]
    type = AverageNodalVariableValue
    variable = velocity_gradient_xz
  [../]
  [./velocity_gradient_yx]
    type = AverageNodalVariableValue
    variable = velocity_gradient_yx
  [../]
  [./velocity_gradient_yy]
    type = AverageNodalVariableValue
    variable = velocity_gradient_yy
  [../]
  [./velocity_gradient_yz]
    type = AverageNodalVariableValue
    variable = velocity_gradient_yz
  [../]
  [./velocity_gradient_zx]
    type = AverageNodalVariableValue
    variable = velocity_gradient_zx
  [../]
  [./velocity_gradient_zy]
    type = AverageNodalVariableValue
    variable = velocity_gradient_zy
  [../]
  [./velocity_gradient_zz]
    type = AverageNodalVariableValue
    variable = velocity_gradient_zz
  [../]
  [./euler_angle1]
    type = ElementAverageValue
    variable = euler_angle1
    execute_on = initial
  [../]
  [./euler_angle2]
    type = ElementAverageValue
    variable = euler_angle2
    execute_on = initial
  [../]
  [./euler_angle3]
    type = ElementAverageValue
    variable = euler_angle3
    execute_on = initial
  [../]
  [./nyes_tensor_00]
    type = ElementAverageValue
    variable = nyes_tensor_00
  [../]
  [./nyes_tensor_01]
    type = ElementAverageValue
    variable = nyes_tensor_01
  [../]
  [./nyes_tensor_02]
    type = ElementAverageValue
    variable = nyes_tensor_02
  [../]
  [./nyes_tensor_10]
    type = ElementAverageValue
    variable = nyes_tensor_10
  [../]
  [./nyes_tensor_11]
    type = ElementAverageValue
    variable = nyes_tensor_11
  [../]
  [./nyes_tensor_12]
    type = ElementAverageValue
    variable = nyes_tensor_12
  [../]
  [./nyes_tensor_20]
    type = ElementAverageValue
    variable = nyes_tensor_20
  [../]
  [./nyes_tensor_21]
    type = ElementAverageValue
    variable = nyes_tensor_21
  [../]
  [./nyes_tensor_22]
    type = ElementAverageValue
    variable = nyes_tensor_22
  [../]
  [./gnd_density]
    type = ElementAverageValue
    variable = gnd_density
  [../]
  [./gnd_density_left]
    type = ElementAverageValue
    variable = gnd_density
    block = 1
  [../]
  [./gnd_density_right]
    type = ElementAverageValue
    variable = gnd_density
    block = 2
  [../]
  [./gss_0]
    type = ElementAverageValue
    variable = gss_0
  [../]
  [./mobile_disl_0]
    type = ElementAverageValue
    variable = mobile_disl_0
  [../]
  [./immobile_disl_0]
    type = ElementAverageValue
    variable = immobile_disl_0
  [../]
  [./tau_0]
    type = ElementAverageValue
    variable = tau_0
  [../]
  [./tau_0_left]
    type = ElementAverageValue
    variable = tau_0
    block = 1
  [../]
  [./tau_0_right]
    type = ElementAverageValue
    variable = tau_0
    block = 2
  [../]
  [./gss_1]
    type = ElementAverageValue
    variable = gss_1
  [../]
  [./mobile_disl_1]
    type = ElementAverageValue
    variable = mobile_disl_1
  [../]
  [./immobile_disl_1]
    type = ElementAverageValue
    variable = immobile_disl_1
  [../]
  [./tau_1]
    type = ElementAverageValue
    variable = tau_1
  [../]
  [./tau_1_left]
    type = ElementAverageValue
    variable = tau_1
    block = 1
  [../]
  [./tau_1_right]
    type = ElementAverageValue
    variable = tau_1
    block = 2
  [../]
  [./gss_2]
    type = ElementAverageValue
    variable = gss_2
  [../]
  [./mobile_disl_2]
    type = ElementAverageValue
    variable = mobile_disl_2
  [../]
  [./immobile_disl_2]
    type = ElementAverageValue
    variable = immobile_disl_2
  [../]
  [./tau_2]
    type = ElementAverageValue
    variable = tau_2
  [../]
  [./tau_2_left]
    type = ElementAverageValue
    variable = tau_2
    block = 1
  [../]
  [./tau_2_right]
    type = ElementAverageValue
    variable = tau_2
    block = 2
  [../]
  [./gss_3]
    type = ElementAverageValue
    variable = gss_3
  [../]
  [./mobile_disl_3]
    type = ElementAverageValue
    variable = mobile_disl_3
  [../]
  [./immobile_disl_3]
    type = ElementAverageValue
    variable = immobile_disl_3
  [../]
  [./tau_3]
    type = ElementAverageValue
    variable = tau_3
  [../]
  [./tau_3_left]
    type = ElementAverageValue
    variable = tau_3
    block = 1
  [../]
  [./tau_3_right]
    type = ElementAverageValue
    variable = tau_3
    block = 2
  [../]
  [./gss_4]
    type = ElementAverageValue
    variable = gss_4
  [../]
  [./mobile_disl_4]
    type = ElementAverageValue
    variable = mobile_disl_4
  [../]
  [./immobile_disl_4]
    type = ElementAverageValue
    variable = immobile_disl_4
  [../]
  [./tau_4]
    type = ElementAverageValue
    variable = tau_4
  [../]
  [./tau_4_left]
    type = ElementAverageValue
    variable = tau_4
    block = 1
  [../]
  [./tau_4_right]
    type = ElementAverageValue
    variable = tau_4
    block = 2
  [../]
  [./gss_5]
    type = ElementAverageValue
    variable = gss_5
  [../]
  [./mobile_disl_5]
    type = ElementAverageValue
    variable = mobile_disl_5
  [../]
  [./immobile_disl_5]
    type = ElementAverageValue
    variable = immobile_disl_5
  [../]
  [./tau_5]
    type = ElementAverageValue
    variable = tau_5
  [../]
  [./tau_5_left]
    type = ElementAverageValue
    variable = tau_5
    block = 1
  [../]
  [./tau_5_right]
    type = ElementAverageValue
    variable = tau_5
    block = 2
  [../]
  [./gss_6]
    type = ElementAverageValue
    variable = gss_6
  [../]
  [./mobile_disl_6]
    type = ElementAverageValue
    variable = mobile_disl_6
  [../]
  [./immobile_disl_6]
    type = ElementAverageValue
    variable = immobile_disl_6
  [../]
  [./tau_6]
    type = ElementAverageValue
    variable = tau_6
  [../]
  [./tau_6_left]
    type = ElementAverageValue
    variable = tau_6
    block = 1
  [../]
  [./tau_6_right]
    type = ElementAverageValue
    variable = tau_6
    block = 2
  [../]
  [./gss_7]
    type = ElementAverageValue
    variable = gss_7
  [../]
  [./mobile_disl_7]
    type = ElementAverageValue
    variable = mobile_disl_7
  [../]
  [./immobile_disl_7]
    type = ElementAverageValue
    variable = immobile_disl_7
  [../]
  [./tau_7]
    type = ElementAverageValue
    variable = tau_7
  [../]
  [./tau_7_left]
    type = ElementAverageValue
    variable = tau_7
    block = 1
  [../]
  [./tau_7_right]
    type = ElementAverageValue
    variable = tau_7
    block = 2
  [../]
  [./gss_8]
    type = ElementAverageValue
    variable = gss_8
  [../]
  [./mobile_disl_8]
    type = ElementAverageValue
    variable = mobile_disl_8
  [../]
  [./immobile_disl_8]
    type = ElementAverageValue
    variable = immobile_disl_8
  [../]
  [./tau_8]
    type = ElementAverageValue
    variable = tau_8
  [../]
  [./tau_8_left]
    type = ElementAverageValue
    variable = tau_8
    block = 1
  [../]
  [./tau_8_right]
    type = ElementAverageValue
    variable = tau_8
    block = 2
  [../]
  [./gss_9]
    type = ElementAverageValue
    variable = gss_9
  [../]
  [./mobile_disl_9]
    type = ElementAverageValue
    variable = mobile_disl_9
  [../]
  [./immobile_disl_9]
    type = ElementAverageValue
    variable = immobile_disl_9
  [../]
  [./tau_9]
    type = ElementAverageValue
    variable = tau_9
  [../]
  [./tau_9_left]
    type = ElementAverageValue
    variable = tau_9
    block = 1
  [../]
  [./tau_9_right]
    type = ElementAverageValue
    variable = tau_9
    block = 2
  [../]
  [./gss_10]
    type = ElementAverageValue
    variable = gss_10
  [../]
  [./mobile_disl_10]
    type = ElementAverageValue
    variable = mobile_disl_10
  [../]
  [./immobile_disl_10]
    type = ElementAverageValue
    variable = immobile_disl_10
  [../]
  [./tau_10]
    type = ElementAverageValue
    variable = tau_10
  [../]
  [./tau_10_left]
    type = ElementAverageValue
    variable = tau_10
    block = 1
  [../]
  [./tau_10_right]
    type = ElementAverageValue
    variable = tau_10
    block = 2
  [../]
  [./gss_11]
    type = ElementAverageValue
    variable = gss_11
  [../]
  [./mobile_disl_11]
    type = ElementAverageValue
    variable = mobile_disl_11
  [../]
  [./immobile_disl_11]
    type = ElementAverageValue
    variable = immobile_disl_11
  [../]
  [./tau_11]
    type = ElementAverageValue
    variable = tau_11
  [../]
  [./tau_11_left]
    type = ElementAverageValue
    variable = tau_11
    block = 1
  [../]
  [./tau_11_right]
    type = ElementAverageValue
    variable = tau_11
    block = 2
  [../]
[]

[Preconditioning]
  [./smp]
    type = SMP
    full = true
  [../]
[]

[Executioner]
  type = Transient
  solve_type = PJFNK

  l_tol = 1e-3
  l_max_its = 50
  petsc_options_iname = '-pc_type -pc_asm_overlap -sub_pc_type -ksp_type -ksp_gmres_restart'
  petsc_options_value = ' asm      2              lu            gmres     200'
  nl_abs_tol = 1e-6
  nl_rel_tol = 1e-6 #take down from 1e-4 when in the elastic region

  dtmax = 5.0e-3
  dtmin = 1.0e-4
  dt = 5.0e-4
  end_time = 1.35 #10 #is the final time

  [./Predictor]
    type = SimplePredictor
    scale = 1.0
    skip_times_old = '0.0'
  [../]
[]

[Outputs]
  csv = true
  interval = 25
  [./out]
    type = Exodus
    elemental_as_nodal = true
  [../]
  [./checkpoint]
    type = Checkpoint
    interval = 25
    num_files = 3
  [../]
  perf_graph = true
[]
