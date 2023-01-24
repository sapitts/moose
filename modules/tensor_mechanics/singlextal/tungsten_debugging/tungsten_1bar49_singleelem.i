[GlobalParams]
  displacements = 'disp_x disp_y disp_z'
[]

[Mesh]
  [cube]
    type = GeneratedMeshGenerator
    dim = 3
    nx = 8
    ny = 8
    nz = 8
    elem_type = HEX8
  []
[]

[AuxVariables]
  [temperature]
    initial_condition = 297.0 ##24C
  []
  [pk2_zz]
    order = FIRST
    family = LAGRANGE
  []
  [fp_zz]
    order = FIRST
    family = LAGRANGE
  []
  [e_zz]
    order = FIRST
    family = LAGRANGE
  []
  [pk2_xx]
    order = FIRST
    family = LAGRANGE
  []
  [fp_xx]
    order = FIRST
    family = LAGRANGE
  []
  [e_xx]
    order = FIRST
    family = LAGRANGE
  []
  [pk2_yy]
    order = FIRST
    family = LAGRANGE
  []
  [fp_yy]
    order = FIRST
    family = LAGRANGE
  []
  [e_yy]
    order = FIRST
    family = LAGRANGE
  []
  [vonmises_stress_cauchy]
    order = FIRST
    family = LAGRANGE
  []
  [eff_strain_green]
    order = FIRST
    family = LAGRANGE
  []
  [vonmises_stress_pk2]
    order = FIRST
    family = LAGRANGE
  []
  [eff_strain_lag]
    order = FIRST
    family = LAGRANGE
  []
  [gss_0]
    order = FIRST
    family = LAGRANGE
  []
  [dislocation_0]
    order = FIRST
    family = LAGRANGE
  []
  [slip_incr_0]
    order = FIRST
    family = LAGRANGE
  []
  [tau_0]
    order = FIRST
    family = LAGRANGE
  []
  [gss_1]
    order = FIRST
    family = LAGRANGE
  []
  [dislocation_1]
    order = FIRST
    family = LAGRANGE
  []
  [slip_incr_1]
    order = FIRST
    family = LAGRANGE
  []
  [tau_1]
    order = FIRST
    family = LAGRANGE
  []
  [gss_2]
    order = FIRST
    family = LAGRANGE
  []
  [dislocation_2]
    order = FIRST
    family = LAGRANGE
  []
  [slip_incr_2]
    order = FIRST
    family = LAGRANGE
  []
  [tau_2]
    order = FIRST
    family = LAGRANGE
  []
  [gss_3]
    order = FIRST
    family = LAGRANGE
  []
  [dislocation_3]
    order = FIRST
    family = LAGRANGE
  []
  [slip_incr_3]
    order = FIRST
    family = LAGRANGE
  []
  [tau_3]
    order = FIRST
    family = LAGRANGE
  []
  [gss_4]
    order = FIRST
    family = LAGRANGE
  []
  [dislocation_4]
    order = FIRST
    family = LAGRANGE
  []
  [slip_incr_4]
    order = FIRST
    family = LAGRANGE
  []
  [tau_4]
    order = FIRST
    family = LAGRANGE
  []
  [gss_5]
    order = FIRST
    family = LAGRANGE
  []
  [dislocation_5]
    order = FIRST
    family = LAGRANGE
  []
  [slip_incr_5]
    order = FIRST
    family = LAGRANGE
  []
  [tau_5]
    order = FIRST
    family = LAGRANGE
  []
  [gss_6]
    order = FIRST
    family = LAGRANGE
  []
  [dislocation_6]
    order = FIRST
    family = LAGRANGE
  []
  [slip_incr_6]
    order = FIRST
    family = LAGRANGE
  []
  [tau_6]
    order = FIRST
    family = LAGRANGE
  []
  [gss_7]
    order = FIRST
    family = LAGRANGE
  []
  [dislocation_7]
    order = FIRST
    family = LAGRANGE
  []
  [slip_incr_7]
    order = FIRST
    family = LAGRANGE
  []
  [tau_7]
    order = FIRST
    family = LAGRANGE
  []
  [gss_8]
    order = FIRST
    family = LAGRANGE
  []
  [dislocation_8]
    order = FIRST
    family = LAGRANGE
  []
  [slip_incr_8]
    order = FIRST
    family = LAGRANGE
  []
  [tau_8]
    order = FIRST
    family = LAGRANGE
  []
  [gss_9]
    order = FIRST
    family = LAGRANGE
  []
  [dislocation_9]
    order = FIRST
    family = LAGRANGE
  []
  [slip_incr_9]
    order = FIRST
    family = LAGRANGE
  []
  [tau_9]
    order = FIRST
    family = LAGRANGE
  []
  [gss_10]
    order = FIRST
    family = LAGRANGE
  []
  [dislocation_10]
    order = FIRST
    family = LAGRANGE
  []
  [slip_incr_10]
    order = FIRST
    family = LAGRANGE
  []
  [tau_10]
    order = FIRST
    family = LAGRANGE
  []
  [gss_11]
    order = FIRST
    family = LAGRANGE
  []
  [dislocation_11]
    order = FIRST
    family = LAGRANGE
  []
  [slip_incr_11]
    order = FIRST
    family = LAGRANGE
  []
  [tau_11]
    order = FIRST
    family = LAGRANGE
  []
[]

[Modules/TensorMechanics/Master]
  [all]
    strain = FINITE
    incremental = true
    add_variables = true
    additional_generate_output = 'stress_zz stress_xx stress_yy vonmises_stress'
    additional_material_output_order = FIRST
  []
[]

[AuxKernels]
  [pk2_zz]
    type = RankTwoAux
    variable = pk2_zz
    rank_two_tensor = second_piola_kirchhoff_stress
    index_j = 2
    index_i = 2
    execute_on = timestep_end
  []
  [fp_zz]
    type = RankTwoAux
    variable = fp_zz
    rank_two_tensor = plastic_deformation_gradient
    index_j = 2
    index_i = 2
    execute_on = timestep_end
  []
  [e_zz]
    type = RankTwoAux
    variable = e_zz
    rank_two_tensor = total_lagrangian_strain
    index_j = 2
    index_i = 2
    execute_on = timestep_end
  []
  [pk2_xx]
    type = RankTwoAux
    variable = pk2_xx
    rank_two_tensor = second_piola_kirchhoff_stress
    index_j = 0
    index_i = 0
    execute_on = timestep_end
  []
  [fp_xx]
    type = RankTwoAux
    variable = fp_xx
    rank_two_tensor = plastic_deformation_gradient
    index_j = 0
    index_i = 0
    execute_on = timestep_end
  []
  [e_xx]
    type = RankTwoAux
    variable = e_xx
    rank_two_tensor = total_lagrangian_strain
    index_j = 0
    index_i = 0
    execute_on = timestep_end
  []
  [pk2_yy]
    type = RankTwoAux
    variable = pk2_yy
    rank_two_tensor = second_piola_kirchhoff_stress
    index_j = 1
    index_i = 1
    execute_on = timestep_end
  []
  [fp_yy]
    type = RankTwoAux
    variable = fp_yy
    rank_two_tensor = plastic_deformation_gradient
    index_j = 1
    index_i = 1
    execute_on = timestep_end
  []
  [e_yy]
    type = RankTwoAux
    variable = e_yy
    rank_two_tensor = total_lagrangian_strain
    index_j = 1
    index_i = 1
    execute_on = timestep_end
  []
  [vonmises_stress_cauchy]
    type = RankTwoScalarAux
    variable = vonmises_stress_cauchy
    rank_two_tensor = stress
    scalar_type = VonMisesStress
    execute_on = timestep_end
  []
  [effective_strain_green]
    type = RankTwoScalarAux
    variable = eff_strain_green
    rank_two_tensor = total_strain
    scalar_type = VonMisesStress
    execute_on = timestep_end
  []
  [vonmises_stress_pk2]
    type = RankTwoScalarAux
    variable = vonmises_stress_pk2
    rank_two_tensor = second_piola_kirchhoff_stress
    scalar_type = VonMisesStress
    execute_on = timestep_end
  []
  [effective_strain_lag]
    type = RankTwoScalarAux
    variable = eff_strain_lag
    rank_two_tensor = total_lagrangian_strain
    scalar_type = VonMisesStress
    execute_on = timestep_end
  []
  [gss_0]
    type = NodalPatchRecoveryAux
    variable = gss_0
    nodal_patch_recovery_uo = gss_0_patch
    execute_on = timestep_end
  []
  [dislocation_0]
    type = NodalPatchRecoveryAux
    variable = dislocation_0
    nodal_patch_recovery_uo = dislocation_0_patch
    execute_on = timestep_end
  []
  [slip_incr_0]
    type = NodalPatchRecoveryAux
    variable = slip_incr_0
    nodal_patch_recovery_uo = slip_incr_0_patch
    execute_on = 'TIMESTEP_END'
  []
  [tau_0]
    type = NodalPatchRecoveryAux
    variable = tau_0
    nodal_patch_recovery_uo = tau_0_patch
    execute_on = 'TIMESTEP_END'
  []
  # [gss_0]
  #   type = MaterialStdVectorAux
  #   variable = gss_0
  #   property = slip_resistance
  #   index = 0
  #   execute_on = timestep_end
  # []
  # [dislocation_0]
  #   type = MaterialStdVectorAux
  #   variable = dislocation_0
  #   property = dislocation_density
  #   index = 0
  #   execute_on = timestep_end
  # []
  # [slip_incr_0]
  #   type = MaterialStdVectorAux
  #   variable = slip_incr_0
  #   property = constitutive_slip_increment
  #   index = 0
  #   execute_on = timestep_end
  # []
  # [tau_0]
  #   type = MaterialStdVectorAux
  #   variable = tau_0
  #   property = applied_shear_stress
  #   index = 0
  #   execute_on = timestep_end
  # []
  [gss_1]
    type = NodalPatchRecoveryAux
    variable = gss_1
    nodal_patch_recovery_uo = gss_1_patch
    execute_on = timestep_end
  []
  [dislocation_1]
    type = NodalPatchRecoveryAux
    variable = dislocation_1
    nodal_patch_recovery_uo = dislocation_1_patch
    execute_on = timestep_end
  []
  [slip_incr_1]
    type = NodalPatchRecoveryAux
    variable = slip_incr_1
    nodal_patch_recovery_uo = slip_incr_1_patch
    execute_on = 'TIMESTEP_END'
  []
  [tau_1]
    type = NodalPatchRecoveryAux
    variable = tau_1
    nodal_patch_recovery_uo = tau_1_patch
    execute_on = 'TIMESTEP_END'
  []
  [gss_2]
    type = NodalPatchRecoveryAux
    variable = gss_2
    nodal_patch_recovery_uo = gss_2_patch
    execute_on = timestep_end
  []
  [dislocation_2]
    type = NodalPatchRecoveryAux
    variable = dislocation_2
    nodal_patch_recovery_uo = dislocation_2_patch
    execute_on = timestep_end
  []
  [slip_incr_2]
    type = NodalPatchRecoveryAux
    variable = slip_incr_2
    nodal_patch_recovery_uo = slip_incr_2_patch
    execute_on = 'TIMESTEP_END'
  []
  [tau_2]
    type = NodalPatchRecoveryAux
    variable = tau_2
    nodal_patch_recovery_uo = tau_2_patch
    execute_on = 'TIMESTEP_END'
  []
  [gss_3]
    type = NodalPatchRecoveryAux
    variable = gss_3
    nodal_patch_recovery_uo = gss_3_patch
    execute_on = timestep_end
  []
  [dislocation_3]
    type = NodalPatchRecoveryAux
    variable = dislocation_3
    nodal_patch_recovery_uo = dislocation_3_patch
    execute_on = timestep_end
  []
  [slip_incr_3]
    type = NodalPatchRecoveryAux
    variable = slip_incr_3
    nodal_patch_recovery_uo = slip_incr_3_patch
    execute_on = 'TIMESTEP_END'
  []
  [tau_3]
    type = NodalPatchRecoveryAux
    variable = tau_3
    nodal_patch_recovery_uo = tau_3_patch
    execute_on = 'TIMESTEP_END'
  []
  [gss_4]
    type = NodalPatchRecoveryAux
    variable = gss_4
    nodal_patch_recovery_uo = gss_4_patch
    execute_on = timestep_end
  []
  [dislocation_4]
    type = NodalPatchRecoveryAux
    variable = dislocation_4
    nodal_patch_recovery_uo = dislocation_4_patch
    execute_on = timestep_end
  []
  [slip_incr_4]
    type = NodalPatchRecoveryAux
    variable = slip_incr_4
    nodal_patch_recovery_uo = slip_incr_4_patch
    execute_on = 'TIMESTEP_END'
  []
  [tau_4]
    type = NodalPatchRecoveryAux
    variable = tau_4
    nodal_patch_recovery_uo = tau_4_patch
    execute_on = 'TIMESTEP_END'
  []
  [gss_5]
    type = NodalPatchRecoveryAux
    variable = gss_5
    nodal_patch_recovery_uo = gss_5_patch
    execute_on = timestep_end
  []
  [dislocation_5]
    type = NodalPatchRecoveryAux
    variable = dislocation_5
    nodal_patch_recovery_uo = dislocation_5_patch
    execute_on = timestep_end
  []
  [slip_incr_5]
    type = NodalPatchRecoveryAux
    variable = slip_incr_5
    nodal_patch_recovery_uo = slip_incr_5_patch
    execute_on = 'TIMESTEP_END'
  []
  [tau_5]
    type = NodalPatchRecoveryAux
    variable = tau_5
    nodal_patch_recovery_uo = tau_5_patch
    execute_on = 'TIMESTEP_END'
  []
  [gss_6]
    type = NodalPatchRecoveryAux
    variable = gss_6
    nodal_patch_recovery_uo = gss_6_patch
    execute_on = timestep_end
  []
  [dislocation_6]
    type = NodalPatchRecoveryAux
    variable = dislocation_6
    nodal_patch_recovery_uo = dislocation_6_patch
    execute_on = timestep_end
  []
  [slip_incr_6]
    type = NodalPatchRecoveryAux
    variable = slip_incr_6
    nodal_patch_recovery_uo = slip_incr_6_patch
    execute_on = 'TIMESTEP_END'
  []
  [tau_6]
    type = NodalPatchRecoveryAux
    variable = tau_6
    nodal_patch_recovery_uo = tau_6_patch
    execute_on = 'TIMESTEP_END'
  []
  [gss_7]
    type = NodalPatchRecoveryAux
    variable = gss_7
    nodal_patch_recovery_uo = gss_7_patch
    execute_on = timestep_end
  []
  [dislocation_7]
    type = NodalPatchRecoveryAux
    variable = dislocation_7
    nodal_patch_recovery_uo = dislocation_7_patch
    execute_on = timestep_end
  []
  [slip_incr_7]
    type = NodalPatchRecoveryAux
    variable = slip_incr_7
    nodal_patch_recovery_uo = slip_incr_7_patch
    execute_on = 'TIMESTEP_END'
  []
  [tau_7]
    type = NodalPatchRecoveryAux
    variable = tau_7
    nodal_patch_recovery_uo = tau_7_patch
    execute_on = 'TIMESTEP_END'
  []
  [gss_8]
    type = NodalPatchRecoveryAux
    variable = gss_8
    nodal_patch_recovery_uo = gss_8_patch
    execute_on = timestep_end
  []
  [dislocation_8]
    type = NodalPatchRecoveryAux
    variable = dislocation_8
    nodal_patch_recovery_uo = dislocation_8_patch
    execute_on = timestep_end
  []
  [slip_incr_8]
    type = NodalPatchRecoveryAux
    variable = slip_incr_8
    nodal_patch_recovery_uo = slip_incr_8_patch
    execute_on = 'TIMESTEP_END'
  []
  [tau_8]
    type = NodalPatchRecoveryAux
    variable = tau_8
    nodal_patch_recovery_uo = tau_8_patch
    execute_on = 'TIMESTEP_END'
  []
  [gss_9]
    type = NodalPatchRecoveryAux
    variable = gss_9
    nodal_patch_recovery_uo = gss_9_patch
    execute_on = timestep_end
  []
  [dislocation_9]
    type = NodalPatchRecoveryAux
    variable = dislocation_9
    nodal_patch_recovery_uo = dislocation_9_patch
    execute_on = timestep_end
  []
  [slip_incr_9]
    type = NodalPatchRecoveryAux
    variable = slip_incr_9
    nodal_patch_recovery_uo = slip_incr_9_patch
    execute_on = 'TIMESTEP_END'
  []
  [tau_9]
    type = NodalPatchRecoveryAux
    variable = tau_9
    nodal_patch_recovery_uo = tau_9_patch
    execute_on = 'TIMESTEP_END'
  []
  [gss_10]
    type = NodalPatchRecoveryAux
    variable = gss_10
    nodal_patch_recovery_uo = gss_10_patch
    execute_on = timestep_end
  []
  [dislocation_10]
    type = NodalPatchRecoveryAux
    variable = dislocation_10
    nodal_patch_recovery_uo = dislocation_10_patch
    execute_on = timestep_end
  []
  [slip_incr_10]
    type = NodalPatchRecoveryAux
    variable = slip_incr_10
    nodal_patch_recovery_uo = slip_incr_10_patch
    execute_on = 'TIMESTEP_END'
  []
  [tau_10]
    type = NodalPatchRecoveryAux
    variable = tau_10
    nodal_patch_recovery_uo = tau_10_patch
    execute_on = 'TIMESTEP_END'
  []
  [gss_11]
    type = NodalPatchRecoveryAux
    variable = gss_11
    nodal_patch_recovery_uo = gss_11_patch
    execute_on = timestep_end
  []
  [dislocation_11]
    type = NodalPatchRecoveryAux
    variable = dislocation_11
    nodal_patch_recovery_uo = dislocation_11_patch
    execute_on = timestep_end
  []
  [slip_incr_11]
    type = NodalPatchRecoveryAux
    variable = slip_incr_11
    nodal_patch_recovery_uo = slip_incr_11_patch
    execute_on = 'TIMESTEP_END'
  []
  [tau_11]
    type = NodalPatchRecoveryAux
    variable = tau_11
    nodal_patch_recovery_uo = tau_11_patch
    execute_on = 'TIMESTEP_END'
  []
[]

[BCs]
  [symmetric_y]
    type = DirichletBC
    variable = disp_y
    boundary = 'bottom'
    value = 0
  []
  [symmetric_x]
    type = DirichletBC
    variable = disp_x
    boundary = 'left'
    value = 0
  []
  [symmetric_z]
    type = DirichletBC
    variable = disp_z
    boundary = 'back'
    value = 0
  []
  [tdisp]
    type = FunctionDirichletBC
    variable = disp_z
    boundary = 'front'
    function = '8.5e-4*t' #given strain rate for the 1bar49 orientation
  []
[]

[Materials]
  [elasticity_tensor_xtal]
    type = ComputeElasticityTensorConstantRotationCP
    # C_ijkl = '521.0e3 201.0e3 201.0e3 521.0e3 201.0e3 521.0e3 160.0e3 160.0e3 160.0e3' #Lim et al (2015) JMPS
    C_ijkl = '5.224e5 2.044e5 2.044e5 5.224e5 2.044e5 5.224e5 1.606e5 1.606e5 1.606e5' # at 24C, from Lowie and Gonas (1967) J. Applied Physics
    fill_method = symmetric9
    euler_angle_1 = 35.0
    euler_angle_2 = 24.613597652978576
    euler_angle_3 = -14.036243467926473
  []
  [stress]
    type = ComputeMultipleCrystalPlasticityStress
    crystal_plasticity_models = 'trial_xtalpl'
    tan_mod_type = exact
    maximum_substep_iteration = 10
    # print_state_variable_convergence_error_messages = true
  []
  [trial_xtalpl]
    type = CrystalPlasticityTungstenGlideUpdate
    number_slip_systems = 12
    slip_sys_file_name = input_slip_sys_bcc12.txt
    temperature = temperature
    initial_dislocation_density = 1.0e6 # Argon and Maloof 1966 #5.5e3 from Brunner 2010  #4.5e8 # roughly David's measurement # 1.0e7 from Srivastava et al (2013)
    burgers_vector = 2.74e-07 # Lim et al (2015) JMPS
    dislocation_multiplication_coefficient = 1
    dipole_annihilation_distance = 2.74e-07 #given in Cereceda et al 2016 as equal to the burgers vector, CHECK THIS AGAIN LATER
    lattice_friction = 12.0 #Lim et al (2015) JMPS, High temperature value
    shear_modulus = 1.600e5 # at 24C, from Lowie and Gonas (1967) J. Applied Physics
    stol = 1.0e-3
    # print_state_variable_convergence_error_messages = true
  []
[]

[UserObjects]
  [gss_0_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'slip_resistance'
    component = '0'
    execute_on = TIMESTEP_END
  []
  [dislocation_0_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'dislocation_density'
    component = '0'
    execute_on = TIMESTEP_END
  []
  [slip_incr_0_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'constitutive_slip_increment'
    component = '0'
    execute_on = TIMESTEP_END
  []
  [tau_0_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'applied_shear_stress'
    component = '0'
    execute_on = TIMESTEP_END
  []
  [gss_1_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'slip_resistance'
    component = '1'
    execute_on = TIMESTEP_END
  []
  [dislocation_1_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'dislocation_density'
    component = '1'
    execute_on = TIMESTEP_END
  []
  [slip_incr_1_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'constitutive_slip_increment'
    component = '1'
    execute_on = TIMESTEP_END
  []
  [tau_1_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'applied_shear_stress'
    component = '1'
    execute_on = TIMESTEP_END
  []
  [gss_2_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'slip_resistance'
    component = '2'
    execute_on = TIMESTEP_END
  []
  [dislocation_2_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'dislocation_density'
    component = '2'
    execute_on = TIMESTEP_END
  []
  [slip_incr_2_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'constitutive_slip_increment'
    component = '2'
    execute_on = TIMESTEP_END
  []
  [tau_2_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'applied_shear_stress'
    component = '2'
    execute_on = TIMESTEP_END
  []
  [gss_3_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'slip_resistance'
    component = '3'
    execute_on = TIMESTEP_END
  []
  [dislocation_3_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'dislocation_density'
    component = '3'
    execute_on = TIMESTEP_END
  []
  [slip_incr_3_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'constitutive_slip_increment'
    component = '3'
    execute_on = TIMESTEP_END
  []
  [tau_3_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'applied_shear_stress'
    component = '3'
    execute_on = TIMESTEP_END
  []
  [gss_4_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'slip_resistance'
    component = '4'
    execute_on = TIMESTEP_END
  []
  [dislocation_4_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'dislocation_density'
    component = '4'
    execute_on = TIMESTEP_END
  []
  [slip_incr_4_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'constitutive_slip_increment'
    component = '4'
    execute_on = TIMESTEP_END
  []
  [tau_4_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'applied_shear_stress'
    component = '4'
    execute_on = TIMESTEP_END
  []
  [gss_5_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'slip_resistance'
    component = '5'
    execute_on = TIMESTEP_END
  []
  [dislocation_5_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'dislocation_density'
    component = '5'
    execute_on = TIMESTEP_END
  []
  [slip_incr_5_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'constitutive_slip_increment'
    component = '5'
    execute_on = TIMESTEP_END
  []
  [tau_5_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'applied_shear_stress'
    component = '5'
    execute_on = TIMESTEP_END
  []
  [gss_6_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'slip_resistance'
    component = '6'
    execute_on = TIMESTEP_END
  []
  [dislocation_6_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'dislocation_density'
    component = '6'
    execute_on = TIMESTEP_END
  []
  [slip_incr_6_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'constitutive_slip_increment'
    component = '6'
    execute_on = TIMESTEP_END
  []
  [tau_6_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'applied_shear_stress'
    component = '6'
    execute_on = TIMESTEP_END
  []
  [gss_7_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'slip_resistance'
    component = '7'
    execute_on = TIMESTEP_END
  []
  [dislocation_7_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'dislocation_density'
    component = '7'
    execute_on = TIMESTEP_END
  []
  [slip_incr_7_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'constitutive_slip_increment'
    component = '7'
    execute_on = TIMESTEP_END
  []
  [tau_7_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'applied_shear_stress'
    component = '7'
    execute_on = TIMESTEP_END
  []
  [gss_8_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'slip_resistance'
    component = '8'
    execute_on = TIMESTEP_END
  []
  [dislocation_8_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'dislocation_density'
    component = '8'
    execute_on = TIMESTEP_END
  []
  [slip_incr_8_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'constitutive_slip_increment'
    component = '8'
    execute_on = TIMESTEP_END
  []
  [tau_8_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'applied_shear_stress'
    component = '8'
    execute_on = TIMESTEP_END
  []
  [gss_9_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'slip_resistance'
    component = '9'
    execute_on = TIMESTEP_END
  []
  [dislocation_9_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'dislocation_density'
    component = '9'
    execute_on = TIMESTEP_END
  []
  [slip_incr_9_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'constitutive_slip_increment'
    component = '9'
    execute_on = TIMESTEP_END
  []
  [tau_9_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'applied_shear_stress'
    component = '9'
    execute_on = TIMESTEP_END
  []
  [gss_10_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'slip_resistance'
    component = '10'
    execute_on = TIMESTEP_END
  []
  [dislocation_10_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'dislocation_density'
    component = '10'
    execute_on = TIMESTEP_END
  []
  [slip_incr_10_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'constitutive_slip_increment'
    component = '10'
    execute_on = TIMESTEP_END
  []
  [tau_10_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'applied_shear_stress'
    component = '10'
    execute_on = TIMESTEP_END
  []
  [gss_11_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'slip_resistance'
    component = '11'
    execute_on = TIMESTEP_END
  []
  [dislocation_11_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'dislocation_density'
    component = '11'
    execute_on = TIMESTEP_END
  []
  [slip_incr_11_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'constitutive_slip_increment'
    component = '11'
    execute_on = TIMESTEP_END
  []
  [tau_11_patch]
    type = NodalPatchRecoveryMaterialProperty
    patch_polynomial_order = FIRST
    property = 'applied_shear_stress'
    component = '11'
    execute_on = TIMESTEP_END
  []
[]

[Postprocessors]
  [stress_zz]
    type = ElementAverageValue
    variable = stress_zz
  []
  [pk2_zz]
    type = ElementAverageValue
    variable = pk2_zz
  []
  [fp_zz]
    type = ElementAverageValue
    variable = fp_zz
  []
  #[rot_out_001]
  #  type = ElementAverageValue
  #  variable = rot_out_001
  #[]
  [e_zz]
    type = ElementAverageValue
    variable = e_zz
  []
  [stress_xx]
    type = ElementAverageValue
    variable = stress_xx
  []
  [pk2_xx]
    type = ElementAverageValue
    variable = pk2_xx
  []
  [fp_xx]
    type = ElementAverageValue
    variable = fp_xx
  []
  [e_xx]
    type = ElementAverageValue
    variable = e_xx
  []
  [stress_yy]
    type = ElementAverageValue
    variable = stress_yy
  []
  [pk2_yy]
    type = ElementAverageValue
    variable = pk2_yy
  []
  [fp_yy]
    type = ElementAverageValue
    variable = fp_yy
  []
  [e_yy]
    type = ElementAverageValue
    variable = e_yy
  []
  [vonmises_stress_cauchy]
    type = ElementAverageValue
    variable = vonmises_stress_cauchy
  []
  [effective_strain_green]
    type = ElementAverageValue
    variable = eff_strain_green
  []
  [vonmises_stress_pk2]
    type = ElementAverageValue
    variable = vonmises_stress_pk2
  []
  [effective_strain]
    type = ElementAverageValue
    variable = eff_strain_lag
  []
  [gss_0]
    type = ElementAverageValue
    variable = gss_0
  []
  [dislocation_0]
    type = ElementAverageValue
    variable = dislocation_0
  []
  [slip_incr_0]
    type = ElementAverageValue
    variable = slip_incr_0
  []
  [tau_0]
    type = ElementAverageValue
    variable = tau_0
  []
  [gss_1]
    type = ElementAverageValue
    variable = gss_1
  []
  [dislocation_1]
    type = ElementAverageValue
    variable = dislocation_1
  []
  [slip_incr_1]
    type = ElementAverageValue
    variable = slip_incr_1
  []
  [tau_1]
    type = ElementAverageValue
    variable = tau_1
  []
  [gss_2]
    type = ElementAverageValue
    variable = gss_2
  []
  [dislocation_2]
    type = ElementAverageValue
    variable = dislocation_2
  []
  [slip_incr_2]
    type = ElementAverageValue
    variable = slip_incr_2
  []
  [tau_2]
    type = ElementAverageValue
    variable = tau_2
  []
  [gss_3]
    type = ElementAverageValue
    variable = gss_3
  []
  [dislocation_3]
    type = ElementAverageValue
    variable = dislocation_3
  []
  [slip_incr_3]
    type = ElementAverageValue
    variable = slip_incr_3
  []
  [tau_3]
    type = ElementAverageValue
    variable = tau_3
  []
  [gss_4]
    type = ElementAverageValue
    variable = gss_4
  []
  [dislocation_4]
    type = ElementAverageValue
    variable = dislocation_4
  []
  [slip_incr_4]
    type = ElementAverageValue
    variable = slip_incr_4
  []
  [tau_4]
    type = ElementAverageValue
    variable = tau_4
  []
  [gss_5]
    type = ElementAverageValue
    variable = gss_5
  []
  [dislocation_5]
    type = ElementAverageValue
    variable = dislocation_5
  []
  [slip_incr_5]
    type = ElementAverageValue
    variable = slip_incr_5
  []
  [tau_5]
    type = ElementAverageValue
    variable = tau_5
  []
  [gss_6]
    type = ElementAverageValue
    variable = gss_6
  []
  [dislocation_6]
    type = ElementAverageValue
    variable = dislocation_6
  []
  [slip_incr_6]
    type = ElementAverageValue
    variable = slip_incr_6
  []
  [tau_6]
    type = ElementAverageValue
    variable = tau_6
  []
  [gss_7]
    type = ElementAverageValue
    variable = gss_7
  []
  [dislocation_7]
    type = ElementAverageValue
    variable = dislocation_7
  []
  [slip_incr_7]
    type = ElementAverageValue
    variable = slip_incr_7
  []
  [tau_7]
    type = ElementAverageValue
    variable = tau_7
  []
  [gss_8]
    type = ElementAverageValue
    variable = gss_8
  []
  [dislocation_8]
    type = ElementAverageValue
    variable = dislocation_8
  []
  [slip_incr_8]
    type = ElementAverageValue
    variable = slip_incr_8
  []
  [tau_8]
    type = ElementAverageValue
    variable = tau_8
  []
  [gss_9]
    type = ElementAverageValue
    variable = gss_9
  []
  [dislocation_9]
    type = ElementAverageValue
    variable = dislocation_9
  []
  [slip_incr_9]
    type = ElementAverageValue
    variable = slip_incr_9
  []
  [tau_9]
    type = ElementAverageValue
    variable = tau_9
  []
  [gss_10]
    type = ElementAverageValue
    variable = gss_10
  []
  [dislocation_10]
    type = ElementAverageValue
    variable = dislocation_10
  []
  [slip_incr_10]
    type = ElementAverageValue
    variable = slip_incr_10
  []
  [tau_10]
    type = ElementAverageValue
    variable = tau_10
  []
  [gss_11]
    type = ElementAverageValue
    variable = gss_11
  []
  [dislocation_11]
    type = ElementAverageValue
    variable = dislocation_11
  []
  [slip_incr_11]
    type = ElementAverageValue
    variable = slip_incr_11
  []
  [tau_11]
    type = ElementAverageValue
    variable = tau_11
  []
[]

[Preconditioning]
  [smp]
    type = SMP
    full = true
  []
[]

[Executioner]
  type = Transient
  solve_type = NEWTON #'PJFNK'

  petsc_options_iname = '-pc_type -pc_asm_overlap -sub_pc_type -ksp_type -ksp_gmres_restart'
  petsc_options_value = ' asm      2              lu            gmres     200'
  nl_abs_tol = 1e-10
  nl_rel_tol = 1e-8 # was 1e-10 in initial testing

  [TimeStepper]
    type = IterationAdaptiveDT
    optimal_iterations = 3
    dt = 0.1
  []
  dtmin = 1.0e-3
  dtmax = 10.0
  end_time = 50.0 #250.0 # 120s needed to reach 10% strain
[]

[Outputs]
  exodus = true
  csv = true
  color = false
  # checkpoint = true
  perf_graph = true
[]
