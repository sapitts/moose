[Mesh]
  file = eight_xtal.e
[]

[GlobalParams]
  displacements = 'ux uy uz'
[]

[Variables]
  [./ux]
  [../]
  [./uy]
  [../]
  [./uz]
  [../]
[]

[AuxVariables]
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
  [./rotout]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./loop_contact_density_27]
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
  [./slip_increment_0]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./glide_velocity_0]
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
  [./slip_increment_1]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./glide_velocity_1]
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
  [./slip_increment_2]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./glide_velocity_2]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./tau_2]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_13]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_13]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./immobile_disl_13]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./slip_increment_13]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./glide_velocity_13]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./tau_13]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_14]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_14]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./immobile_disl_14]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./slip_increment_14]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./glide_velocity_14]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./tau_14]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_16]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_16]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./immobile_disl_16]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./slip_increment_16]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./glide_velocity_16]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./tau_16]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_27]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_27]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./immobile_disl_27]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./slip_increment_27]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./glide_velocity_27]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./tau_27]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_29]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_29]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./immobile_disl_29]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./slip_increment_29]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./glide_velocity_29]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./tau_29]
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
  [./slip_increment_10]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./glide_velocity_10]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./tau_10]
    order = CONSTANT
    family = MONOMIAL
  [../]
[]

[Functions]
  [./tdisp]
    type = ParsedFunction
    value = 0.01*t
  [../]
[]

[Modules]
  [./TensorMechanics]
    [./Master]
      [./all]
        strain = FINITE
        add_variables = true
      [../]
    [../]
  [../]
[]

[AuxKernels]
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
    index_j = 1
    index_i = 1
    execute_on = timestep_end
  [../]
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
  [./rotout]
    type = CrystalPlasticityRotationOutAux
    variable = rotout
    execute_on = timestep_end
  [../]

  [./loop_contact_density_27]
    type = MaterialStdVectorAux
    variable = loop_contact_density_27
    property = SIA_loop_contact_density
    index = 27
  [../]
  [./gss_0]
    type = MaterialStdVectorAux
    variable = gss_0
    property = athermal_slip_system_resistance
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
  [./slip_inc_0]
    type = MaterialStdVectorAux
    variable = slip_increment_0
    property = plastic_slip_increment
    index = 0
    execute_on = timestep_end
  [../]
  [./glide_velocity_0]
    type = MaterialStdVectorAux
    variable = glide_velocity_0
    property = dislocation_glide_velocity
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
    property = athermal_slip_system_resistance
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
  [./slip_inc_1]
    type = MaterialStdVectorAux
    variable = slip_increment_1
    property = plastic_slip_increment
    index = 1
    execute_on = timestep_end
  [../]
  [./glide_velocity_1]
    type = MaterialStdVectorAux
    variable = glide_velocity_1
    property = dislocation_glide_velocity
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
    property = athermal_slip_system_resistance
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
  [./slip_inc_2]
    type = MaterialStdVectorAux
    variable = slip_increment_2
    property = plastic_slip_increment
    index = 2
    execute_on = timestep_end
  [../]
  [./glide_velocity_2]
    type = MaterialStdVectorAux
    variable = glide_velocity_2
    property = dislocation_glide_velocity
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
  [./gss_13]
    type = MaterialStdVectorAux
    variable = gss_13
    property = athermal_slip_system_resistance
    index = 13
    execute_on = timestep_end
  [../]
  [./mobile_disl_13]
    type = MaterialStdVectorAux
    variable = mobile_disl_13
    property = mobile_dislocations
    index = 13
    execute_on = timestep_end
  [../]
  [./immobile_disl_13]
    type = MaterialStdVectorAux
    variable = immobile_disl_13
    property = immobile_dislocations
    index = 13
    execute_on = timestep_end
  [../]
  [./slip_inc_13]
    type = MaterialStdVectorAux
    variable = slip_increment_13
    property = plastic_slip_increment
    index = 13
    execute_on = timestep_end
  [../]
  [./glide_velocity_13]
    type = MaterialStdVectorAux
    variable = glide_velocity_13
    property = dislocation_glide_velocity
    index = 13
    execute_on = timestep_end
  [../]
  [./tau_13]
    type = MaterialStdVectorAux
    variable = tau_13
    property = applied_shear_stress
    index = 13
    execute_on = timestep_end
  [../]
  [./gss_14]
    type = MaterialStdVectorAux
    variable = gss_14
    property = athermal_slip_system_resistance
    index = 14
    execute_on = timestep_end
  [../]
  [./mobile_disl_14]
    type = MaterialStdVectorAux
    variable = mobile_disl_14
    property = mobile_dislocations
    index = 14
    execute_on = timestep_end
  [../]
  [./immobile_disl_14]
    type = MaterialStdVectorAux
    variable = immobile_disl_14
    property = immobile_dislocations
    index = 14
    execute_on = timestep_end
  [../]
  [./slip_inc_14]
    type = MaterialStdVectorAux
    variable = slip_increment_14
    property = plastic_slip_increment
    index = 14
    execute_on = timestep_end
  [../]
  [./glide_velocity_14]
    type = MaterialStdVectorAux
    variable = glide_velocity_14
    property = dislocation_glide_velocity
    index = 14
    execute_on = timestep_end
  [../]
  [./tau_14]
    type = MaterialStdVectorAux
    variable = tau_14
    property = applied_shear_stress
    index = 14
    execute_on = timestep_end
  [../]
  [./gss_16]
    type = MaterialStdVectorAux
    variable = gss_16
    property = athermal_slip_system_resistance
    index = 16
    execute_on = timestep_end
  [../]
  [./mobile_disl_16]
    type = MaterialStdVectorAux
    variable = mobile_disl_16
    property = mobile_dislocations
    index = 16
    execute_on = timestep_end
  [../]
  [./immobile_disl_16]
    type = MaterialStdVectorAux
    variable = immobile_disl_16
    property = immobile_dislocations
    index = 16
    execute_on = timestep_end
  [../]
  [./slip_inc_16]
    type = MaterialStdVectorAux
    variable = slip_increment_16
    property = plastic_slip_increment
    index = 16
    execute_on = timestep_end
  [../]
  [./glide_velocity_16]
    type = MaterialStdVectorAux
    variable = glide_velocity_16
    property = dislocation_glide_velocity
    index = 16
    execute_on = timestep_end
  [../]
  [./tau_16]
    type = MaterialStdVectorAux
    variable = tau_16
    property = applied_shear_stress
    index = 16
    execute_on = timestep_end
  [../]
  [./gss_27]
    type = MaterialStdVectorAux
    variable = gss_27
    property = athermal_slip_system_resistance
    index = 27
    execute_on = timestep_end
  [../]
  [./mobile_disl_27]
    type = MaterialStdVectorAux
    variable = mobile_disl_27
    property = mobile_dislocations
    index = 27
    execute_on = timestep_end
  [../]
  [./immobile_disl_27]
    type = MaterialStdVectorAux
    variable = immobile_disl_27
    property = immobile_dislocations
    index = 27
    execute_on = timestep_end
  [../]
  [./slip_inc_27]
    type = MaterialStdVectorAux
    variable = slip_increment_27
    property = plastic_slip_increment
    index = 27
    execute_on = timestep_end
  [../]
  [./glide_velocity_27]
    type = MaterialStdVectorAux
    variable = glide_velocity_27
    property = dislocation_glide_velocity
    index = 27
    execute_on = timestep_end
  [../]
  [./tau_27]
    type = MaterialStdVectorAux
    variable = tau_27
    property = applied_shear_stress
    index = 27
    execute_on = timestep_end
  [../]
  [./gss_29]
    type = MaterialStdVectorAux
    variable = gss_29
    property = athermal_slip_system_resistance
    index = 29
    execute_on = timestep_end
  [../]
  [./mobile_disl_29]
    type = MaterialStdVectorAux
    variable = mobile_disl_29
    property = mobile_dislocations
    index = 29
    execute_on = timestep_end
  [../]
  [./immobile_disl_29]
    type = MaterialStdVectorAux
    variable = immobile_disl_29
    property = immobile_dislocations
    index = 29
    execute_on = timestep_end
  [../]
  [./slip_inc_29]
    type = MaterialStdVectorAux
    variable = slip_increment_29
    property = plastic_slip_increment
    index = 29
    execute_on = timestep_end
  [../]
  [./glide_velocity_29]
    type = MaterialStdVectorAux
    variable = glide_velocity_29
    property = dislocation_glide_velocity
    index = 29
    execute_on = timestep_end
  [../]
  [./tau_29]
    type = MaterialStdVectorAux
    variable = tau_29
    property = applied_shear_stress
    index = 29
    execute_on = timestep_end
  [../]
  [./gss_10]
    type = MaterialStdVectorAux
    variable = gss_10
    property = athermal_slip_system_resistance
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
  [./slip_inc_10]
    type = MaterialStdVectorAux
    variable = slip_increment_10
    property = plastic_slip_increment
    index = 10
    execute_on = timestep_end
  [../]
  [./glide_velocity_10]
    type = MaterialStdVectorAux
    variable = glide_velocity_10
    property = dislocation_glide_velocity
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
[]

[BCs]
  [./symmy]
    type = PresetBC
    variable = uy
    boundary = bottom
    value = 0
  [../]
  [./symmx]
    type = PresetBC
    variable = ux
    boundary = left
    value = 0
  [../]
  [./symmz]
    type = PresetBC
    variable = uz
    boundary = back
    value = 0
  [../]
  [./tdisp]
    type = FunctionPresetBC
    variable = ux
    boundary = right
    function = tdisp
  [../]
[]

[Materials]
  [./elasticity_tensor1]
    type = ComputeElasticityTensorCP
    block = 1
    C_ijkl = '274.7e3 117.7e3 117.7e3 274.7e3 117.7e3 274.7e3 78.49e3 78.49e3 78.49e3'
#    C_ijkl = '242.0e3 150.0e3 150.0e3 242.06e3 150.0e3 242.0e3 112.0e3 112.0e3 112.0e3' # From Hirth and Loethe, 1969, pure alpha iron
    fill_method = symmetric9
  [../]
  [./stress1]
    type = ComputeCrystalPlasticityStress
    block = 1
    crystal_plasticity_update_model = 'trial_xtalpl1'
  [../]
  [./trial_xtalpl1]
    type = CrystalPlasticityEnthalpyFlowRuleUpdate
    block = 1
    number_slip_systems = 48
    slip_sys_file_name = bcc_input_slip_sys.txt
    number_cross_slip_directions = 4
    number_cross_slip_planes = 12
    temperature = 323.0
    initial_mean_irradiation_cluster_defect_size = 4.0e-6
    inital_irradiation_cluster_defect_density = 5.0e13
    initial_irradiation_SIA_loop_density = 8.15e12
    maximum_substep_iteration = 10
    maxiter = 30
    maxiter_state_variable = 30
    line_search_method = CUT_HALF
    use_line_search = true
  [../]
  [./elasticity_tensor2]
    type = ComputeElasticityTensorCP
    block = 2
    C_ijkl = '274.7e3 117.7e3 117.7e3 274.7e3 117.7e3 274.7e3 78.49e3 78.49e3 78.49e3'
#    C_ijkl = '242.0e3 150.0e3 150.0e3 242.06e3 150.0e3 242.0e3 112.0e3 112.0e3 112.0e3' # From Hirth and Loethe, 1969, pure alpha iron
    fill_method = symmetric9
    euler_angle_1 = 0
    euler_angle_2 = 30.0
    euler_angle_3 = 125.0
  [../]
  [./stress2]
    type = ComputeCrystalPlasticityStress
    block = 2
    crystal_plasticity_update_model = 'trial_xtalpl2'
  [../]
  [./trial_xtalpl2]
    type = CrystalPlasticityEnthalpyFlowRuleUpdate
    block = 2
    number_slip_systems = 48
    slip_sys_file_name = bcc_input_slip_sys.txt
    number_cross_slip_directions = 4
    number_cross_slip_planes = 12
    temperature = 323.0
    initial_mean_irradiation_cluster_defect_size = 4.0e-6
    inital_irradiation_cluster_defect_density = 5.0e13
    initial_irradiation_SIA_loop_density = 8.15e12
    maximum_substep_iteration = 10
    maxiter = 30
    maxiter_state_variable = 30
    line_search_method = CUT_HALF
    use_line_search = true
  [../]
  [./elasticity_tensor3]
    type = ComputeElasticityTensorCP
    block = 3
    C_ijkl = '274.7e3 117.7e3 117.7e3 274.7e3 117.7e3 274.7e3 78.49e3 78.49e3 78.49e3'
#    C_ijkl = '242.0e3 150.0e3 150.0e3 242.06e3 150.0e3 242.0e3 112.0e3 112.0e3 112.0e3' # From Hirth and Loethe, 1969, pure alpha iron
    fill_method = symmetric9
    euler_angle_1 = 40.0
    euler_angle_2 = 70.0
    euler_angle_3 = 122.0
  [../]
  [./stress3]
    type = ComputeCrystalPlasticityStress
    block = 3
    crystal_plasticity_update_model = 'trial_xtalpl3'
  [../]
  [./trial_xtalpl3]
    type = CrystalPlasticityEnthalpyFlowRuleUpdate
    block = 3
    number_slip_systems = 48
    slip_sys_file_name = bcc_input_slip_sys.txt
    number_cross_slip_directions = 4
    number_cross_slip_planes = 12
    temperature = 323.0
    initial_mean_irradiation_cluster_defect_size = 4.0e-6
    inital_irradiation_cluster_defect_density = 5.0e13
    initial_irradiation_SIA_loop_density = 8.15e12
    maximum_substep_iteration = 10
    maxiter = 30
    maxiter_state_variable = 30
    line_search_method = CUT_HALF
    use_line_search = true
  [../]
  [./elasticity_tensor4]
    type = ComputeElasticityTensorCP
    block = 4
    C_ijkl = '274.7e3 117.7e3 117.7e3 274.7e3 117.7e3 274.7e3 78.49e3 78.49e3 78.49e3'
#    C_ijkl = '242.0e3 150.0e3 150.0e3 242.06e3 150.0e3 242.0e3 112.0e3 112.0e3 112.0e3' # From Hirth and Loethe, 1969, pure alpha iron
    fill_method = symmetric9
    euler_angle_1 = 80.0
    euler_angle_2 = 110.0
    euler_angle_3 = 40.0
  [../]
  [./stress4]
    type = ComputeCrystalPlasticityStress
    block = 4
    crystal_plasticity_update_model = 'trial_xtalpl4'
  [../]
  [./trial_xtalpl4]
    type = CrystalPlasticityEnthalpyFlowRuleUpdate
    block = 4
    number_slip_systems = 48
    slip_sys_file_name = bcc_input_slip_sys.txt
    number_cross_slip_directions = 4
    number_cross_slip_planes = 12
    temperature = 323.0
    initial_mean_irradiation_cluster_defect_size = 4.0e-6
    inital_irradiation_cluster_defect_density = 5.0e13
    initial_irradiation_SIA_loop_density = 8.15e12
    maximum_substep_iteration = 10
    maxiter = 30
    maxiter_state_variable = 30
    line_search_method = CUT_HALF
    use_line_search = true
  [../]
  [./elasticity_tensor5]
    type = ComputeElasticityTensorCP
    block = 5
    C_ijkl = '274.7e3 117.7e3 117.7e3 274.7e3 117.7e3 274.7e3 78.49e3 78.49e3 78.49e3'
#    C_ijkl = '242.0e3 150.0e3 150.0e3 242.06e3 150.0e3 242.0e3 112.0e3 112.0e3 112.0e3' # From Hirth and Loethe, 1969, pure alpha iron
    fill_method = symmetric9
    euler_angle_1 = 120.0
    euler_angle_2 = 193.0
    euler_angle_3 = 247.0
  [../]
  [./stress5]
    type = ComputeCrystalPlasticityStress
    block = 5
    crystal_plasticity_update_model = 'trial_xtalpl5'
  [../]
  [./trial_xtalpl5]
    type = CrystalPlasticityEnthalpyFlowRuleUpdate
    block = 5
    number_slip_systems = 48
    slip_sys_file_name = bcc_input_slip_sys.txt
    number_cross_slip_directions = 4
    number_cross_slip_planes = 12
    temperature = 323.0
    initial_mean_irradiation_cluster_defect_size = 4.0e-6
    inital_irradiation_cluster_defect_density = 5.0e13
    initial_irradiation_SIA_loop_density = 8.15e12
    maximum_substep_iteration = 10
    maxiter = 30
    maxiter_state_variable = 30
    line_search_method = CUT_HALF
    use_line_search = true
  [../]
  [./elasticity_tensor6]
    type = ComputeElasticityTensorCP
    block = 6
    C_ijkl = '274.7e3 117.7e3 117.7e3 274.7e3 117.7e3 274.7e3 78.49e3 78.49e3 78.49e3'
#    C_ijkl = '242.0e3 150.0e3 150.0e3 242.06e3 150.0e3 242.0e3 112.0e3 112.0e3 112.0e3' # From Hirth and Loethe, 1969, pure alpha iron
    fill_method = symmetric9
    euler_angle_1 = 40.0
    euler_angle_2 = 30.0
    euler_angle_3 = 125.0
  [../]
  [./stress6]
    type = ComputeCrystalPlasticityStress
    block = 6
    crystal_plasticity_update_model = 'trial_xtalpl6'
  [../]
  [./trial_xtalpl6]
    type = CrystalPlasticityEnthalpyFlowRuleUpdate
    block = 6
    number_slip_systems = 48
    slip_sys_file_name = bcc_input_slip_sys.txt
    number_cross_slip_directions = 4
    number_cross_slip_planes = 12
    temperature = 323.0
    initial_mean_irradiation_cluster_defect_size = 4.0e-6
    inital_irradiation_cluster_defect_density = 5.0e13
    initial_irradiation_SIA_loop_density = 8.15e12
    maximum_substep_iteration = 10
    maxiter = 30
    maxiter_state_variable = 30
    line_search_method = CUT_HALF
    use_line_search = true
  [../]
  [./elasticity_tensor7]
    type = ComputeElasticityTensorCP
    block = 7
    C_ijkl = '274.7e3 117.7e3 117.7e3 274.7e3 117.7e3 274.7e3 78.49e3 78.49e3 78.49e3'
#    C_ijkl = '242.0e3 150.0e3 150.0e3 242.06e3 150.0e3 242.0e3 112.0e3 112.0e3 112.0e3' # From Hirth and Loethe, 1969, pure alpha iron
    fill_method = symmetric9
    euler_angle_1 = 80.0
    euler_angle_2 = 70.0
    euler_angle_3 = 125.0
  [../]
  [./stress7]
    type = ComputeCrystalPlasticityStress
    block = 7
    crystal_plasticity_update_model = 'trial_xtalpl7'
  [../]
  [./trial_xtalpl7]
    type = CrystalPlasticityEnthalpyFlowRuleUpdate
    block = 7
    number_slip_systems = 48
    slip_sys_file_name = bcc_input_slip_sys.txt
    number_cross_slip_directions = 4
    number_cross_slip_planes = 12
    temperature = 323.0
    initial_mean_irradiation_cluster_defect_size = 4.0e-6
    inital_irradiation_cluster_defect_density = 5.0e13
    initial_irradiation_SIA_loop_density = 8.15e12
    maximum_substep_iteration = 10
    maxiter = 30
    maxiter_state_variable = 30
    line_search_method = CUT_HALF
    use_line_search = true
  [../]
  [./elasticity_tensor8]
    type = ComputeElasticityTensorCP
    block = 8
    C_ijkl = '274.7e3 117.7e3 117.7e3 274.7e3 117.7e3 274.7e3 78.49e3 78.49e3 78.49e3'
#    C_ijkl = '242.0e3 150.0e3 150.0e3 242.06e3 150.0e3 242.0e3 112.0e3 112.0e3 112.0e3' # From Hirth and Loethe, 1969, pure alpha iron
    fill_method = symmetric9
    euler_angle_1 = 120.0
    euler_angle_2 = 30.0
    euler_angle_3 = 125.0
  [../]
  [./stress8]
    type = ComputeCrystalPlasticityStress
    block = 8
    crystal_plasticity_update_model = 'trial_xtalpl8'
  [../]
  [./trial_xtalpl8]
    type = CrystalPlasticityEnthalpyFlowRuleUpdate
    block = 8
    number_slip_systems = 48
    slip_sys_file_name = bcc_input_slip_sys.txt
    number_cross_slip_directions = 4
    number_cross_slip_planes = 12
    temperature = 323.0
    initial_mean_irradiation_cluster_defect_size = 4.0e-6
    inital_irradiation_cluster_defect_density = 5.0e13
    initial_irradiation_SIA_loop_density = 8.15e12
    maximum_substep_iteration = 10
    maxiter = 30
    maxiter_state_variable = 30
    line_search_method = CUT_HALF
    use_line_search = true
  [../]
[]

[Postprocessors]
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
  [./rotout]
    type = ElementAverageValue
    variable = rotout
  [../]
  [./loop_contact_density_27]
    type = ElementAverageValue
    variable = loop_contact_density_27
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
  [./slip_increment_0]
    type = ElementAverageValue
    variable = slip_increment_0
  [../]
  [./glide_velocity_0]
    type = ElementAverageValue
    variable = glide_velocity_0
  [../]
  [./tau_0]
    type = ElementAverageValue
    variable = tau_0
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
  [./slip_increment_1]
    type = ElementAverageValue
    variable = slip_increment_1
  [../]
  [./glide_velocity_1]
    type = ElementAverageValue
    variable = glide_velocity_1
  [../]
  [./tau_1]
    type = ElementAverageValue
    variable = tau_1
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
  [./slip_increment_2]
    type = ElementAverageValue
    variable = slip_increment_2
  [../]
  [./glide_velocity_2]
    type = ElementAverageValue
    variable = glide_velocity_2
  [../]
  [./tau_2]
    type = ElementAverageValue
    variable = tau_2
  [../]
  [./gss_13]
    type = ElementAverageValue
    variable = gss_13
  [../]
  [./mobile_disl_13]
    type = ElementAverageValue
    variable = mobile_disl_13
  [../]
  [./immobile_disl_13]
    type = ElementAverageValue
    variable = immobile_disl_13
  [../]
  [./slip_increment_13]
    type = ElementAverageValue
    variable = slip_increment_13
  [../]
  [./glide_velocity_13]
    type = ElementAverageValue
    variable = glide_velocity_13
  [../]
  [./tau_13]
    type = ElementAverageValue
    variable = tau_13
  [../]
  [./gss_14]
    type = ElementAverageValue
    variable = gss_14
  [../]
  [./mobile_disl_14]
    type = ElementAverageValue
    variable = mobile_disl_14
  [../]
  [./immobile_disl_14]
    type = ElementAverageValue
    variable = immobile_disl_14
  [../]
  [./slip_increment_14]
    type = ElementAverageValue
    variable = slip_increment_14
  [../]
  [./glide_velocity_14]
    type = ElementAverageValue
    variable = glide_velocity_14
  [../]
  [./tau_14]
    type = ElementAverageValue
    variable = tau_14
  [../]
  [./gss_16]
    type = ElementAverageValue
    variable = gss_16
  [../]
  [./mobile_disl_16]
    type = ElementAverageValue
    variable = mobile_disl_16
  [../]
  [./immobile_disl_16]
    type = ElementAverageValue
    variable = immobile_disl_16
  [../]
  [./slip_increment_16]
    type = ElementAverageValue
    variable = slip_increment_16
  [../]
  [./glide_velocity_16]
    type = ElementAverageValue
    variable = glide_velocity_16
  [../]
  [./tau_16]
    type = ElementAverageValue
    variable = tau_16
  [../]
  [./gss_27]
    type = ElementAverageValue
    variable = gss_27
  [../]
  [./mobile_disl_27]
    type = ElementAverageValue
    variable = mobile_disl_27
  [../]
  [./immobile_disl_27]
    type = ElementAverageValue
    variable = immobile_disl_27
  [../]
  [./slip_increment_27]
    type = ElementAverageValue
    variable = slip_increment_27
  [../]
  [./glide_velocity_27]
    type = ElementAverageValue
    variable = glide_velocity_27
  [../]
  [./tau_27]
    type = ElementAverageValue
    variable = tau_27
  [../]
  [./gss_29]
    type = ElementAverageValue
    variable = gss_29
  [../]
  [./mobile_disl_29]
    type = ElementAverageValue
    variable = mobile_disl_29
  [../]
  [./immobile_disl_29]
    type = ElementAverageValue
    variable = immobile_disl_29
  [../]
  [./slip_increment_29]
    type = ElementAverageValue
    variable = slip_increment_29
  [../]
  [./glide_velocity_29]
    type = ElementAverageValue
    variable = glide_velocity_29
  [../]
  [./tau_29]
    type = ElementAverageValue
    variable = tau_29
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
  [./slip_increment_10]
    type = ElementAverageValue
    variable = slip_increment_10
  [../]
  [./glide_velocity_10]
    type = ElementAverageValue
    variable = glide_velocity_10
  [../]
  [./tau_10]
    type = ElementAverageValue
    variable = tau_10
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
  [./TimeStepper]
    type = FunctionDT
    time_dt = '1e-3 1e-4  1e-5 1e-6'
    time_t  = '0    3.0   5.0  10.0'
  [../]

  #Preconditioned JFNK (default)
  solve_type = 'PJFNK'

  #petsc_options_iname = -pc_hypre_type
  #petsc_options_value = boomerang
  petsc_options = '-snes_ksp_ew'
  l_tol = 1e-2 # <--- l_tol is ignored when EW is used.
  petsc_options_iname = '-pc_type -pc_factor_mat_solver_package'
  petsc_options_value = 'lu superlu_dist'
  #petsc_options_iname = '-pc_type'
  #petsc_options_value = 'lu'

  nl_abs_tol = 1e-10
  nl_rel_step_tol = 1e-10
  dtmax = 10.0
  nl_rel_tol = 1e-10
  ss_check_tol = 1e-10
  end_time = 10.0
  dtmin = 1.0e-5
#  num_steps = 2
  nl_abs_step_tol = 1e-10
[]

[Outputs]
  csv = true
  exodus = true
[]
