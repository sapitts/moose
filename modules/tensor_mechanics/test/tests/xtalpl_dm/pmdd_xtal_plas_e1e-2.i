[Mesh]
  type = GeneratedMesh
  dim = 3
  elem_type = HEX8
  displacements = 'ux uy uz'
  nx = 4
  xmin = 0
  xmax = 1
  ny = 4
  ymin = 0
  ymax = 1
  nz = 4
  zmin = 0
  zmax = 1
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
  [./stress_zz]
    order = CONSTANT
    family = MONOMIAL
    block = 0
  [../]
  [./pk2]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./fp_zz]
    order = CONSTANT
    family = MONOMIAL
    block = 0
  [../]
  [./rotout]
    order = CONSTANT
    family = MONOMIAL
    block = 0
  [../]
  [./e_zz]
    order = CONSTANT
    family = MONOMIAL
    block = 0
  [../]
  [./loop_contact_density_27]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_0]
    order = CONSTANT
    family = MONOMIAL
    block = 0
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
    block = 0
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
    block = 0
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
    block = 0
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
    block = 0
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
    block = 0
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
    block = 0
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
    block = 0
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
    block = 0
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

[Kernels]
  [./TensorMechanics]
    displacements = 'ux uy uz'
    use_displaced_mesh = true
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
    block = 0
  [../]
  [./pk2]
    type = RankTwoAux
    variable = pk2
    rank_two_tensor = pk2
    index_j = 2
    index_i = 2
    execute_on = timestep_end
    block = 0
  [../]
  [./fp_zz]
    type = RankTwoAux
    variable = fp_zz
    rank_two_tensor = fp
    index_j = 2
    index_i = 2
    execute_on = timestep_end
    block = 0
  [../]
  [./e_zz]
    type = RankTwoAux
    variable = e_zz
    rank_two_tensor = lage
    index_j = 2
    index_i = 2
    execute_on = timestep_end
    block = 0
  [../]
  [./rotout]
    type = CrystalPlasticityRotationOutAux
    variable = rotout
    execute_on = timestep_end
    block = 0
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
    block = 0
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
    block = 0
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
    block = 0
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
    block = 0
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
    block = 0
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
    block = 0
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
    block = 0
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
    block = 0
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
    block = 0
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
    variable = uz
    boundary = front
    function = tdisp
  [../]
[]

[Materials]
  [./elasticity_tensor]
    type = ComputeElasticityTensorCP
    block = 0
    C_ijkl = '274.7e3 117.7e3 117.7e3 274.7e3 117.7e3 274.7e3 78.49e3 78.49e3 78.49e3' #Values for 323K
#    C_ijkl = '279.06e3 119.6e3 119.6e3 279.06e3 119.6e3 279.06e3 79.731e3 79.731e3 79.731e3'  #Values for 273K
    fill_method = symmetric9
  [../]
  [./strain]
    type = ComputeFiniteStrain
    block = 0
    displacements = 'ux uy uz'
  [../]
  [./stress]
    type = ComputeCrystalPlasticityStress
    block = 0
    crystal_plasticity_update_model = 'trial_xtalpl'
  [../]
  [./trial_xtalpl]
    type = CrystalPlasticityEnthalpyFlowRuleUpdate
    block = 0
    number_slip_systems = 48
    slip_sys_file_name = bcc_input_slip_sys.txt
    number_cross_slip_directions = 4
    number_cross_slip_planes = 12
    temperature = 323.0
    initial_mean_irradiation_cluster_defect_size = 4.0e-6
    inital_irradiation_cluster_defect_density = 5.0e13
    initial_irradiation_SIA_loop_density = 8.15e12
#    slip_increment_tolerance = 0.1
#    resistance_tol = 10
    maximum_substep_iteration = 10
#    rtol = 1e-07
#    abs_tol = 4e-6
    maxiter = 30
    maxiter_state_variable = 30
    line_search_method = CUT_HALF
    use_line_search = true
  [../]
[]

[Postprocessors]
  [./stress_zz]
    type = ElementAverageValue
    variable = stress_zz
  [../]
  [./pk2]
    type = ElementAverageValue
    variable = pk2
  [../]
  [./fp_zz]
    type = ElementAverageValue
    variable = fp_zz
  [../]
  [./rotout]
    type = ElementAverageValue
    variable = rotout
  [../]
  [./e_zz]
    type = ElementAverageValue
    variable = e_zz
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
  dt = 0.1
  [./TimeStepper]
    type = FunctionDT
    time_dt = '1e-2 1e-2  1e-3   1e-3   5e-4  5e-4'
    time_t  = '0    3.0   5.0     6.0   7.0   10.0'
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
