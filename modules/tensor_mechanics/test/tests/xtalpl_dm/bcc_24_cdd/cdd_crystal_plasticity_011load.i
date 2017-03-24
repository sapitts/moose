[Mesh]
  type = GeneratedMesh
  dim = 3
  elem_type = HEX8
  displacements = 'ux uy uz'
#  nx = 3
  xmin = 0
  xmax = 1
#  ny = 3
  ymin = 0
  ymax = 1
#  nz = 3
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
  [../]
  [./pk2_zz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./fp_zz]
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
  #[./rot_out_001]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  [./e_zz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./e_xx]
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
  [./xslip_disl_0]
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
  [./xslip_disl_1]
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
  [./xslip_disl_2]
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
  [./gss_3]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_3]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./xslip_disl_3]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./immobile_disl_3]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./slip_increment_3]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./glide_velocity_3]
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
  [./xslip_disl_4]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./immobile_disl_4]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./slip_increment_4]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./glide_velocity_4]
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
  [./xslip_disl_5]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./immobile_disl_5]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./slip_increment_5]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./glide_velocity_5]
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
  [./xslip_disl_6]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./immobile_disl_6]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./slip_increment_6]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./glide_velocity_6]
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
  [./xslip_disl_7]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./immobile_disl_7]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./slip_increment_7]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./glide_velocity_7]
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
  [./xslip_disl_8]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./immobile_disl_8]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./slip_increment_8]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./glide_velocity_8]
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
    block = 0
  [../]
  [./mobile_disl_9]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./xslip_disl_9]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./immobile_disl_9]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./slip_increment_9]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./glide_velocity_9]
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
    block = 0
  [../]
  [./mobile_disl_10]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./xslip_disl_10]
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
  [./gss_11]
    order = CONSTANT
    family = MONOMIAL
    block = 0
  [../]
  [./mobile_disl_11]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./xslip_disl_11]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./immobile_disl_11]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./slip_increment_11]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./glide_velocity_11]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./tau_11]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_12]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_12]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./xslip_disl_12]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./immobile_disl_12]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./slip_increment_12]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./glide_velocity_12]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./tau_12]
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
  [./xslip_disl_13]
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
  [./xslip_disl_14]
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
  [./gss_15]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_15]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./xslip_disl_15]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./immobile_disl_15]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./slip_increment_15]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./glide_velocity_15]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./tau_15]
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
  [./xslip_disl_16]
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
  [./gss_17]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_17]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./xslip_disl_17]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./immobile_disl_17]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./slip_increment_17]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./glide_velocity_17]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./tau_17]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_18]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_18]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./xslip_disl_18]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./immobile_disl_18]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./slip_increment_18]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./glide_velocity_18]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./tau_18]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_19]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_19]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./xslip_disl_19]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./immobile_disl_19]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./slip_increment_19]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./glide_velocity_19]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./tau_19]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_20]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_20]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./xslip_disl_20]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./immobile_disl_20]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./slip_increment_20]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./glide_velocity_20]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./tau_20]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_21]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_21]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./xslip_disl_21]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./immobile_disl_21]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./slip_increment_21]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./glide_velocity_21]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./tau_21]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_22]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_22]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./xslip_disl_22]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./immobile_disl_22]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./slip_increment_22]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./glide_velocity_22]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./tau_22]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_23]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_23]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./xslip_disl_23]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./immobile_disl_23]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./slip_increment_23]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./glide_velocity_23]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./tau_23]
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
  [./xslip_disl_0]
    type = MaterialStdVectorAux
    variable = xslip_disl_0
    property = cross_slip_dislocations
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
  [./xslip_disl_1]
    type = MaterialStdVectorAux
    variable = xslip_disl_1
    property = cross_slip_dislocations
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
  [./xslip_disl_2]
    type = MaterialStdVectorAux
    variable = xslip_disl_2
    property = cross_slip_dislocations
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
  [./gss_3]
    type = MaterialStdVectorAux
    variable = gss_3
    property = slip_system_resistance
    index = 3
    execute_on = timestep_end
    block = 0
  [../]
  [./mobile_disl_3]
    type = MaterialStdVectorAux
    variable = mobile_disl_3
    property = mobile_dislocations
    index = 3
    execute_on = timestep_end
  [../]
  [./xslip_disl_3]
    type = MaterialStdVectorAux
    variable = xslip_disl_3
    property = cross_slip_dislocations
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
  [./slip_inc_3]
    type = MaterialStdVectorAux
    variable = slip_increment_3
    property = plastic_slip_increment
    index = 3
    execute_on = timestep_end
  [../]
  [./glide_velocity_3]
    type = MaterialStdVectorAux
    variable = glide_velocity_3
    property = dislocation_glide_velocity
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
  [./xslip_disl_4]
    type = MaterialStdVectorAux
    variable = xslip_disl_4
    property = cross_slip_dislocations
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
  [./slip_inc_4]
    type = MaterialStdVectorAux
    variable = slip_increment_4
    property = plastic_slip_increment
    index = 4
    execute_on = timestep_end
  [../]
  [./glide_velocity_4]
    type = MaterialStdVectorAux
    variable = glide_velocity_4
    property = dislocation_glide_velocity
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
  [./xslip_disl_5]
    type = MaterialStdVectorAux
    variable = xslip_disl_5
    property = cross_slip_dislocations
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
  [./slip_inc_5]
    type = MaterialStdVectorAux
    variable = slip_increment_5
    property = plastic_slip_increment
    index = 5
    execute_on = timestep_end
  [../]
  [./glide_velocity_5]
    type = MaterialStdVectorAux
    variable = glide_velocity_5
    property = dislocation_glide_velocity
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
    block = 0
  [../]
  [./mobile_disl_6]
    type = MaterialStdVectorAux
    variable = mobile_disl_6
    property = mobile_dislocations
    index = 6
    execute_on = timestep_end
  [../]
  [./xslip_disl_6]
    type = MaterialStdVectorAux
    variable = xslip_disl_6
    property = cross_slip_dislocations
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
  [./slip_inc_6]
    type = MaterialStdVectorAux
    variable = slip_increment_6
    property = plastic_slip_increment
    index = 6
    execute_on = timestep_end
  [../]
  [./glide_velocity_6]
    type = MaterialStdVectorAux
    variable = glide_velocity_6
    property = dislocation_glide_velocity
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
  [./xslip_disl_7]
    type = MaterialStdVectorAux
    variable = xslip_disl_7
    property = cross_slip_dislocations
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
  [./slip_inc_7]
    type = MaterialStdVectorAux
    variable = slip_increment_7
    property = plastic_slip_increment
    index = 7
    execute_on = timestep_end
  [../]
  [./glide_velocity_7]
    type = MaterialStdVectorAux
    variable = glide_velocity_7
    property = dislocation_glide_velocity
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
  [./xslip_disl_8]
    type = MaterialStdVectorAux
    variable = xslip_disl_8
    property = cross_slip_dislocations
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
  [./slip_inc_8]
    type = MaterialStdVectorAux
    variable = slip_increment_8
    property = plastic_slip_increment
    index = 8
    execute_on = timestep_end
  [../]
  [./glide_velocity_8]
    type = MaterialStdVectorAux
    variable = glide_velocity_8
    property = dislocation_glide_velocity
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
  [./xslip_disl_9]
    type = MaterialStdVectorAux
    variable = xslip_disl_9
    property = cross_slip_dislocations
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
  [./slip_inc_9]
    type = MaterialStdVectorAux
    variable = slip_increment_9
    property = plastic_slip_increment
    index = 9
    execute_on = timestep_end
  [../]
  [./glide_velocity_9]
    type = MaterialStdVectorAux
    variable = glide_velocity_9
    property = dislocation_glide_velocity
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
  [./xslip_disl_10]
    type = MaterialStdVectorAux
    variable = xslip_disl_10
    property = cross_slip_dislocations
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
  [./xslip_disl_11]
    type = MaterialStdVectorAux
    variable = xslip_disl_11
    property = cross_slip_dislocations
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
  [./slip_inc_11]
    type = MaterialStdVectorAux
    variable = slip_increment_11
    property = plastic_slip_increment
    index = 11
    execute_on = timestep_end
  [../]
  [./glide_velocity_11]
    type = MaterialStdVectorAux
    variable = glide_velocity_11
    property = dislocation_glide_velocity
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
  [./gss_12]
    type = MaterialStdVectorAux
    variable = gss_12
    property = slip_system_resistance
    index = 12
    execute_on = timestep_end
  [../]
  [./mobile_disl_12]
    type = MaterialStdVectorAux
    variable = mobile_disl_12
    property = mobile_dislocations
    index = 12
    execute_on = timestep_end
  [../]
  [./xslip_disl_12]
    type = MaterialStdVectorAux
    variable = xslip_disl_12
    property = cross_slip_dislocations
    index = 12
    execute_on = timestep_end
  [../]
  [./immobile_disl_12]
    type = MaterialStdVectorAux
    variable = immobile_disl_12
    property = immobile_dislocations
    index = 12
    execute_on = timestep_end
  [../]
  [./slip_inc_12]
    type = MaterialStdVectorAux
    variable = slip_increment_12
    property = plastic_slip_increment
    index = 12
    execute_on = timestep_end
  [../]
  [./glide_velocity_12]
    type = MaterialStdVectorAux
    variable = glide_velocity_12
    property = dislocation_glide_velocity
    index = 12
    execute_on = timestep_end
  [../]
  [./tau_12]
    type = MaterialStdVectorAux
    variable = tau_12
    property = applied_shear_stress
    index = 12
    execute_on = timestep_end
  [../]
  [./gss_13]
    type = MaterialStdVectorAux
    variable = gss_13
    property = slip_system_resistance
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
  [./xslip_disl_13]
    type = MaterialStdVectorAux
    variable = xslip_disl_13
    property = cross_slip_dislocations
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
    property = slip_system_resistance
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
  [./xslip_disl_14]
    type = MaterialStdVectorAux
    variable = xslip_disl_14
    property = cross_slip_dislocations
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
  [./gss_15]
    type = MaterialStdVectorAux
    variable = gss_15
    property = slip_system_resistance
    index = 15
    execute_on = timestep_end
  [../]
  [./mobile_disl_15]
    type = MaterialStdVectorAux
    variable = mobile_disl_15
    property = mobile_dislocations
    index = 15
    execute_on = timestep_end
  [../]
  [./xslip_disl_15]
    type = MaterialStdVectorAux
    variable = xslip_disl_15
    property = cross_slip_dislocations
    index = 15
    execute_on = timestep_end
  [../]
  [./immobile_disl_15]
    type = MaterialStdVectorAux
    variable = immobile_disl_15
    property = immobile_dislocations
    index = 15
    execute_on = timestep_end
  [../]
  [./slip_inc_15]
    type = MaterialStdVectorAux
    variable = slip_increment_15
    property = plastic_slip_increment
    index = 15
    execute_on = timestep_end
  [../]
  [./glide_velocity_15]
    type = MaterialStdVectorAux
    variable = glide_velocity_15
    property = dislocation_glide_velocity
    index = 15
    execute_on = timestep_end
  [../]
  [./tau_15]
    type = MaterialStdVectorAux
    variable = tau_15
    property = applied_shear_stress
    index = 15
    execute_on = timestep_end
  [../]
  [./gss_16]
    type = MaterialStdVectorAux
    variable = gss_16
    property = slip_system_resistance
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
  [./xslip_disl_16]
    type = MaterialStdVectorAux
    variable = xslip_disl_16
    property = cross_slip_dislocations
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
  [./gss_17]
    type = MaterialStdVectorAux
    variable = gss_17
    property = slip_system_resistance
    index = 17
    execute_on = timestep_end
  [../]
  [./mobile_disl_17]
    type = MaterialStdVectorAux
    variable = mobile_disl_17
    property = mobile_dislocations
    index = 17
    execute_on = timestep_end
  [../]
  [./xslip_disl_17]
    type = MaterialStdVectorAux
    variable = xslip_disl_17
    property = cross_slip_dislocations
    index = 17
    execute_on = timestep_end
  [../]
  [./immobile_disl_17]
    type = MaterialStdVectorAux
    variable = immobile_disl_17
    property = immobile_dislocations
    index = 17
    execute_on = timestep_end
  [../]
  [./slip_inc_17]
    type = MaterialStdVectorAux
    variable = slip_increment_17
    property = plastic_slip_increment
    index = 17
    execute_on = timestep_end
  [../]
  [./glide_velocity_17]
    type = MaterialStdVectorAux
    variable = glide_velocity_17
    property = dislocation_glide_velocity
    index = 17
    execute_on = timestep_end
  [../]
  [./tau_17]
    type = MaterialStdVectorAux
    variable = tau_17
    property = applied_shear_stress
    index = 17
    execute_on = timestep_end
  [../]
  [./gss_18]
    type = MaterialStdVectorAux
    variable = gss_18
    property = slip_system_resistance
    index = 18
    execute_on = timestep_end
  [../]
  [./mobile_disl_18]
    type = MaterialStdVectorAux
    variable = mobile_disl_18
    property = mobile_dislocations
    index = 18
    execute_on = timestep_end
  [../]
  [./xslip_disl_18]
    type = MaterialStdVectorAux
    variable = xslip_disl_18
    property = cross_slip_dislocations
    index = 18
    execute_on = timestep_end
  [../]
  [./immobile_disl_18]
    type = MaterialStdVectorAux
    variable = immobile_disl_18
    property = immobile_dislocations
    index = 18
    execute_on = timestep_end
  [../]
  [./slip_inc_18]
    type = MaterialStdVectorAux
    variable = slip_increment_18
    property = plastic_slip_increment
    index = 18
    execute_on = timestep_end
  [../]
  [./glide_velocity_18]
    type = MaterialStdVectorAux
    variable = glide_velocity_18
    property = dislocation_glide_velocity
    index = 18
    execute_on = timestep_end
  [../]
  [./tau_18]
    type = MaterialStdVectorAux
    variable = tau_18
    property = applied_shear_stress
    index = 18
    execute_on = timestep_end
  [../]
  [./gss_19]
    type = MaterialStdVectorAux
    variable = gss_19
    property = slip_system_resistance
    index = 19
    execute_on = timestep_end
  [../]
  [./mobile_disl_19]
    type = MaterialStdVectorAux
    variable = mobile_disl_19
    property = mobile_dislocations
    index = 19
    execute_on = timestep_end
  [../]
  [./xslip_disl_19]
    type = MaterialStdVectorAux
    variable = xslip_disl_19
    property = cross_slip_dislocations
    index = 19
    execute_on = timestep_end
  [../]
  [./immobile_disl_19]
    type = MaterialStdVectorAux
    variable = immobile_disl_19
    property = immobile_dislocations
    index = 19
    execute_on = timestep_end
  [../]
  [./slip_inc_19]
    type = MaterialStdVectorAux
    variable = slip_increment_19
    property = plastic_slip_increment
    index = 19
    execute_on = timestep_end
  [../]
  [./glide_velocity_19]
    type = MaterialStdVectorAux
    variable = glide_velocity_19
    property = dislocation_glide_velocity
    index = 19
    execute_on = timestep_end
  [../]
  [./tau_19]
    type = MaterialStdVectorAux
    variable = tau_19
    property = applied_shear_stress
    index = 19
    execute_on = timestep_end
  [../]
  [./gss_20]
    type = MaterialStdVectorAux
    variable = gss_20
    property = slip_system_resistance
    index = 20
    execute_on = timestep_end
  [../]
  [./mobile_disl_20]
    type = MaterialStdVectorAux
    variable = mobile_disl_20
    property = mobile_dislocations
    index = 20
    execute_on = timestep_end
  [../]
  [./xslip_disl_20]
    type = MaterialStdVectorAux
    variable = xslip_disl_20
    property = cross_slip_dislocations
    index = 20
    execute_on = timestep_end
  [../]
  [./immobile_disl_20]
    type = MaterialStdVectorAux
    variable = immobile_disl_20
    property = immobile_dislocations
    index = 20
    execute_on = timestep_end
  [../]
  [./slip_inc_20]
    type = MaterialStdVectorAux
    variable = slip_increment_20
    property = plastic_slip_increment
    index = 20
    execute_on = timestep_end
  [../]
  [./glide_velocity_20]
    type = MaterialStdVectorAux
    variable = glide_velocity_20
    property = dislocation_glide_velocity
    index = 20
    execute_on = timestep_end
  [../]
  [./tau_20]
    type = MaterialStdVectorAux
    variable = tau_20
    property = applied_shear_stress
    index = 20
    execute_on = timestep_end
  [../]
  [./gss_21]
    type = MaterialStdVectorAux
    variable = gss_21
    property = slip_system_resistance
    index = 21
    execute_on = timestep_end
  [../]
  [./mobile_disl_21]
    type = MaterialStdVectorAux
    variable = mobile_disl_21
    property = mobile_dislocations
    index = 21
    execute_on = timestep_end
  [../]
  [./xslip_disl_21]
    type = MaterialStdVectorAux
    variable = xslip_disl_21
    property = cross_slip_dislocations
    index = 21
    execute_on = timestep_end
  [../]
  [./immobile_disl_21]
    type = MaterialStdVectorAux
    variable = immobile_disl_21
    property = immobile_dislocations
    index = 21
    execute_on = timestep_end
  [../]
  [./slip_inc_21]
    type = MaterialStdVectorAux
    variable = slip_increment_21
    property = plastic_slip_increment
    index = 21
    execute_on = timestep_end
  [../]
  [./glide_velocity_21]
    type = MaterialStdVectorAux
    variable = glide_velocity_21
    property = dislocation_glide_velocity
    index = 21
    execute_on = timestep_end
  [../]
  [./tau_21]
    type = MaterialStdVectorAux
    variable = tau_21
    property = applied_shear_stress
    index = 21
    execute_on = timestep_end
  [../]
  [./gss_22]
    type = MaterialStdVectorAux
    variable = gss_22
    property = slip_system_resistance
    index = 22
    execute_on = timestep_end
  [../]
  [./mobile_disl_22]
    type = MaterialStdVectorAux
    variable = mobile_disl_22
    property = mobile_dislocations
    index = 22
    execute_on = timestep_end
  [../]
  [./xslip_disl_22]
    type = MaterialStdVectorAux
    variable = xslip_disl_22
    property = cross_slip_dislocations
    index = 22
    execute_on = timestep_end
  [../]
  [./immobile_disl_22]
    type = MaterialStdVectorAux
    variable = immobile_disl_22
    property = immobile_dislocations
    index = 22
    execute_on = timestep_end
  [../]
  [./slip_inc_22]
    type = MaterialStdVectorAux
    variable = slip_increment_22
    property = plastic_slip_increment
    index = 22
    execute_on = timestep_end
  [../]
  [./glide_velocity_22]
    type = MaterialStdVectorAux
    variable = glide_velocity_22
    property = dislocation_glide_velocity
    index = 22
    execute_on = timestep_end
  [../]
  [./tau_22]
    type = MaterialStdVectorAux
    variable = tau_22
    property = applied_shear_stress
    index = 22
    execute_on = timestep_end
  [../]
  [./gss_23]
    type = MaterialStdVectorAux
    variable = gss_23
    property = slip_system_resistance
    index = 23
    execute_on = timestep_end
  [../]
  [./mobile_disl_23]
    type = MaterialStdVectorAux
    variable = mobile_disl_23
    property = mobile_dislocations
    index = 23
    execute_on = timestep_end
  [../]
  [./xslip_disl_23]
    type = MaterialStdVectorAux
    variable = xslip_disl_23
    property = cross_slip_dislocations
    index = 23
    execute_on = timestep_end
  [../]
  [./immobile_disl_23]
    type = MaterialStdVectorAux
    variable = immobile_disl_23
    property = immobile_dislocations
    index = 23
    execute_on = timestep_end
  [../]
  [./slip_inc_23]
    type = MaterialStdVectorAux
    variable = slip_increment_23
    property = plastic_slip_increment
    index = 23
    execute_on = timestep_end
  [../]
  [./glide_velocity_23]
    type = MaterialStdVectorAux
    variable = glide_velocity_23
    property = dislocation_glide_velocity
    index = 23
    execute_on = timestep_end
  [../]
  [./tau_23]
    type = MaterialStdVectorAux
    variable = tau_23
    property = applied_shear_stress
    index = 23
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
  [./elasticity_tensor]
    type = ComputeElasticityTensorCP
    C_ijkl = '274.7e3 117.7e3 117.7e3 274.7e3 117.7e3 274.7e3 78.49e3 78.49e3 78.49e3' #Values for 323K
#    C_ijkl = '279.06e3 119.6e3 119.6e3 279.06e3 119.6e3 279.06e3 79.731e3 79.731e3 79.731e3'  #Values for 273K
    fill_method = symmetric9
    euler_angle_1 = 120.0
    euler_angle_2 = 125.264
    euler_angle_3 = 45.0
  [../]
  [./strain]
    type = ComputeFiniteStrain
    displacements = 'ux uy uz'
  [../]
  [./stress]
    type = ComputeCrystalPlasticityStress
    crystal_plasticity_update_model = 'trial_xtalpl'
  [../]
  [./trial_xtalpl]
    type = CrystalPlasticityCDDUpdate
    number_slip_systems = 24
    slip_sys_file_name = bcc_24_input_slip_sys.txt
    number_cross_slip_directions = 4
    number_cross_slip_planes = 6
    temperature = 323.0
    initial_immobile_dislocation_density = 2.0e6
    initial_mobile_dislocation_density = 2.0e6
    initial_mean_irradiation_cluster_defect_size = 0.0 #34.0e-6
    inital_irradiation_cluster_defect_density = 0.0 #5.0e13
    #initial_irradiation_SIA_loop_density = 0.0 #8.15e10 #Bring down to same order of magnitude as Pritam seemed to use
    Peierls_stress = 11.0 #390.0  #Alpha-iron is 11MPa
    shear_modulus = 78489
    stol = 1.0e-3
#    slip_increment_tolerance = 1.0e-3
    maximum_substep_iteration = 10
    maxiter = 30
    maxiter_state_variable = 30
    line_search_method = CUT_HALF
    use_line_search = true
    tan_mod_type = exact
  [../]
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
  #[./rot_out_001]
  #  type = ElementAverageValue
  #  variable = rot_out_001
  #[../]
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
  [./gss_0]
    type = ElementAverageValue
    variable = gss_0
  [../]
  [./mobile_disl_0]
    type = ElementAverageValue
    variable = mobile_disl_0
  [../]
  [./cross_slip_disl_0]
    type = ElementAverageValue
    variable = xslip_disl_0
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
  [./cross_slip_disl_1]
    type = ElementAverageValue
    variable = xslip_disl_1
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
  [./cross_slip_disl_2]
    type = ElementAverageValue
    variable = xslip_disl_2
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
  [./gss_3]
    type = ElementAverageValue
    variable = gss_3
  [../]
  [./mobile_disl_3]
    type = ElementAverageValue
    variable = mobile_disl_3
  [../]
  [./cross_slip_disl_3]
    type = ElementAverageValue
    variable = xslip_disl_3
  [../]
  [./immobile_disl_3]
    type = ElementAverageValue
    variable = immobile_disl_3
  [../]
  [./slip_increment_3]
    type = ElementAverageValue
    variable = slip_increment_3
  [../]
  [./glide_velocity_3]
    type = ElementAverageValue
    variable = glide_velocity_3
  [../]
  [./tau_3]
    type = ElementAverageValue
    variable = tau_3
  [../]
  [./gss_4]
    type = ElementAverageValue
    variable = gss_4
  [../]
  [./mobile_disl_4]
    type = ElementAverageValue
    variable = mobile_disl_4
  [../]
  [./cross_slip_disl_4]
    type = ElementAverageValue
    variable = xslip_disl_4
  [../]
  [./immobile_disl_4]
    type = ElementAverageValue
    variable = immobile_disl_4
  [../]
  [./slip_increment_4]
    type = ElementAverageValue
    variable = slip_increment_4
  [../]
  [./glide_velocity_4]
    type = ElementAverageValue
    variable = glide_velocity_4
  [../]
  [./tau_4]
    type = ElementAverageValue
    variable = tau_4
  [../]
  [./gss_5]
    type = ElementAverageValue
    variable = gss_5
  [../]
  [./mobile_disl_5]
    type = ElementAverageValue
    variable = mobile_disl_5
  [../]
  [./cross_slip_disl_5]
    type = ElementAverageValue
    variable = xslip_disl_5
  [../]
  [./immobile_disl_5]
    type = ElementAverageValue
    variable = immobile_disl_5
  [../]
  [./slip_increment_5]
    type = ElementAverageValue
    variable = slip_increment_5
  [../]
  [./glide_velocity_5]
    type = ElementAverageValue
    variable = glide_velocity_5
  [../]
  [./tau_5]
    type = ElementAverageValue
    variable = tau_5
  [../]
  [./gss_6]
    type = ElementAverageValue
    variable = gss_6
  [../]
  [./mobile_disl_6]
    type = ElementAverageValue
    variable = mobile_disl_6
  [../]
  [./cross_slip_disl_6]
    type = ElementAverageValue
    variable = xslip_disl_6
  [../]
  [./immobile_disl_6]
    type = ElementAverageValue
    variable = immobile_disl_6
  [../]
  [./slip_increment_6]
    type = ElementAverageValue
    variable = slip_increment_6
  [../]
  [./glide_velocity_6]
    type = ElementAverageValue
    variable = glide_velocity_6
  [../]
  [./tau_6]
    type = ElementAverageValue
    variable = tau_6
  [../]
  [./gss_7]
    type = ElementAverageValue
    variable = gss_7
  [../]
  [./mobile_disl_7]
    type = ElementAverageValue
    variable = mobile_disl_7
  [../]
  [./cross_slip_disl_7]
    type = ElementAverageValue
    variable = xslip_disl_7
  [../]
  [./immobile_disl_7]
    type = ElementAverageValue
    variable = immobile_disl_7
  [../]
  [./slip_increment_7]
    type = ElementAverageValue
    variable = slip_increment_7
  [../]
  [./glide_velocity_7]
    type = ElementAverageValue
    variable = glide_velocity_7
  [../]
  [./tau_7]
    type = ElementAverageValue
    variable = tau_7
  [../]
  [./gss_8]
    type = ElementAverageValue
    variable = gss_8
  [../]
  [./mobile_disl_8]
    type = ElementAverageValue
    variable = mobile_disl_8
  [../]
  [./cross_slip_disl_8]
    type = ElementAverageValue
    variable = xslip_disl_8
  [../]
  [./immobile_disl_8]
    type = ElementAverageValue
    variable = immobile_disl_8
  [../]
  [./slip_increment_8]
    type = ElementAverageValue
    variable = slip_increment_8
  [../]
  [./glide_velocity_8]
    type = ElementAverageValue
    variable = glide_velocity_8
  [../]
  [./tau_8]
    type = ElementAverageValue
    variable = tau_8
  [../]
  [./gss_9]
    type = ElementAverageValue
    variable = gss_9
  [../]
  [./mobile_disl_9]
    type = ElementAverageValue
    variable = mobile_disl_9
  [../]
  [./cross_slip_disl_9]
    type = ElementAverageValue
    variable = xslip_disl_9
  [../]
  [./immobile_disl_9]
    type = ElementAverageValue
    variable = immobile_disl_9
  [../]
  [./slip_increment_9]
    type = ElementAverageValue
    variable = slip_increment_9
  [../]
  [./glide_velocity_9]
    type = ElementAverageValue
    variable = glide_velocity_9
  [../]
  [./tau_9]
    type = ElementAverageValue
    variable = tau_9
  [../]
  [./gss_10]
    type = ElementAverageValue
    variable = gss_10
  [../]
  [./mobile_disl_10]
    type = ElementAverageValue
    variable = mobile_disl_10
  [../]
  [./cross_slip_disl_10]
    type = ElementAverageValue
    variable = xslip_disl_10
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
  [./gss_11]
    type = ElementAverageValue
    variable = gss_11
  [../]
  [./mobile_disl_11]
    type = ElementAverageValue
    variable = mobile_disl_11
  [../]
  [./cross_slip_disl_11]
    type = ElementAverageValue
    variable = xslip_disl_11
  [../]
  [./immobile_disl_11]
    type = ElementAverageValue
    variable = immobile_disl_11
  [../]
  [./slip_increment_11]
    type = ElementAverageValue
    variable = slip_increment_11
  [../]
  [./glide_velocity_11]
    type = ElementAverageValue
    variable = glide_velocity_11
  [../]
  [./tau_11]
    type = ElementAverageValue
    variable = tau_11
  [../]
  [./gss_12]
    type = ElementAverageValue
    variable = gss_12
  [../]
  [./mobile_disl_12]
    type = ElementAverageValue
    variable = mobile_disl_12
  [../]
  [./cross_slip_disl_12]
    type = ElementAverageValue
    variable = xslip_disl_12
  [../]
  [./immobile_disl_12]
    type = ElementAverageValue
    variable = immobile_disl_12
  [../]
  [./slip_increment_12]
    type = ElementAverageValue
    variable = slip_increment_12
  [../]
  [./glide_velocity_12]
    type = ElementAverageValue
    variable = glide_velocity_12
  [../]
  [./tau_12]
    type = ElementAverageValue
    variable = tau_12
  [../]
  [./gss_13]
    type = ElementAverageValue
    variable = gss_13
  [../]
  [./mobile_disl_13]
    type = ElementAverageValue
    variable = mobile_disl_13
  [../]
  [./cross_slip_disl_13]
    type = ElementAverageValue
    variable = xslip_disl_13
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
  [./cross_slip_disl_14]
    type = ElementAverageValue
    variable = xslip_disl_14
  [../]
  [./immobile_disl_14]
    type = ElementAverageValue
    variable = immobile_disl_14
  [../]
  [./slip_increment_14]
    type = ElementAverageValue
    variable = slip_increment_14
  [../]
  [./glide_velocity_146]
    type = ElementAverageValue
    variable = glide_velocity_14
  [../]
  [./tau_14]
    type = ElementAverageValue
    variable = tau_14
  [../]
  [./gss_15]
    type = ElementAverageValue
    variable = gss_15
  [../]
  [./mobile_disl_15]
    type = ElementAverageValue
    variable = mobile_disl_15
  [../]
  [./cross_slip_disl_15]
    type = ElementAverageValue
    variable = xslip_disl_15
  [../]
  [./immobile_disl_15]
    type = ElementAverageValue
    variable = immobile_disl_15
  [../]
  [./slip_increment_15]
    type = ElementAverageValue
    variable = slip_increment_15
  [../]
  [./glide_velocity_15]
    type = ElementAverageValue
    variable = glide_velocity_15
  [../]
  [./tau_15]
    type = ElementAverageValue
    variable = tau_15
  [../]
  [./gss_16]
    type = ElementAverageValue
    variable = gss_16
  [../]
  [./mobile_disl_16]
    type = ElementAverageValue
    variable = mobile_disl_16
  [../]
  [./cross_slip_disl_16]
    type = ElementAverageValue
    variable = xslip_disl_16
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
    variable = tau_1
  [../]
  [./gss_17]
    type = ElementAverageValue
    variable = gss_17
  [../]
  [./mobile_disl_17]
    type = ElementAverageValue
    variable = mobile_disl_17
  [../]
  [./cross_slip_disl_17]
    type = ElementAverageValue
    variable = xslip_disl_17
  [../]
  [./immobile_disl_17]
    type = ElementAverageValue
    variable = immobile_disl_17
  [../]
  [./slip_increment_17]
    type = ElementAverageValue
    variable = slip_increment_17
  [../]
  [./glide_velocity_17]
    type = ElementAverageValue
    variable = glide_velocity_17
  [../]
  [./tau_17]
    type = ElementAverageValue
    variable = tau_17
  [../]
  [./gss_18]
    type = ElementAverageValue
    variable = gss_18
  [../]
  [./mobile_disl_18]
    type = ElementAverageValue
    variable = mobile_disl_18
  [../]
  [./cross_slip_disl_18]
    type = ElementAverageValue
    variable = xslip_disl_18
  [../]
  [./immobile_disl_18]
    type = ElementAverageValue
    variable = immobile_disl_18
  [../]
  [./slip_increment_18]
    type = ElementAverageValue
    variable = slip_increment_18
  [../]
  [./glide_velocity_18]
    type = ElementAverageValue
    variable = glide_velocity_18
  [../]
  [./tau_18]
    type = ElementAverageValue
    variable = tau_18
  [../]
  [./gss_19]
    type = ElementAverageValue
    variable = gss_19
  [../]
  [./mobile_disl_19]
    type = ElementAverageValue
    variable = mobile_disl_19
  [../]
  [./cross_slip_disl_19]
    type = ElementAverageValue
    variable = xslip_disl_19
  [../]
  [./immobile_disl_19]
    type = ElementAverageValue
    variable = immobile_disl_19
  [../]
  [./slip_increment_19]
    type = ElementAverageValue
    variable = slip_increment_19
  [../]
  [./glide_velocity_19]
    type = ElementAverageValue
    variable = glide_velocity_19
  [../]
  [./tau_19]
    type = ElementAverageValue
    variable = tau_19
  [../]
  [./gss_20]
    type = ElementAverageValue
    variable = gss_20
  [../]
  [./mobile_disl_20]
    type = ElementAverageValue
    variable = mobile_disl_20
  [../]
  [./cross_slip_disl_20]
    type = ElementAverageValue
    variable = xslip_disl_20
  [../]
  [./immobile_disl_20]
    type = ElementAverageValue
    variable = immobile_disl_20
  [../]
  [./slip_increment_20]
    type = ElementAverageValue
    variable = slip_increment_20
  [../]
  [./glide_velocity_20]
    type = ElementAverageValue
    variable = glide_velocity_20
  [../]
  [./tau_20]
    type = ElementAverageValue
    variable = tau_20
  [../]
  [./gss_21]
    type = ElementAverageValue
    variable = gss_21
  [../]
  [./mobile_disl_21]
    type = ElementAverageValue
    variable = mobile_disl_21
  [../]
  [./cross_slip_disl_21]
    type = ElementAverageValue
    variable = xslip_disl_21
  [../]
  [./immobile_disl_21]
    type = ElementAverageValue
    variable = immobile_disl_21
  [../]
  [./slip_increment_21]
    type = ElementAverageValue
    variable = slip_increment_21
  [../]
  [./glide_velocity_21]
    type = ElementAverageValue
    variable = glide_velocity_21
  [../]
  [./tau_21]
    type = ElementAverageValue
    variable = tau_21
  [../]
  [./gss_22]
    type = ElementAverageValue
    variable = gss_22
  [../]
  [./mobile_disl_22]
    type = ElementAverageValue
    variable = mobile_disl_22
  [../]
  [./cross_slip_disl_22]
    type = ElementAverageValue
    variable = xslip_disl_22
  [../]
  [./immobile_disl_22]
    type = ElementAverageValue
    variable = immobile_disl_22
  [../]
  [./slip_increment_22]
    type = ElementAverageValue
    variable = slip_increment_22
  [../]
  [./glide_velocity_22]
    type = ElementAverageValue
    variable = glide_velocity_22
  [../]
  [./tau_22]
    type = ElementAverageValue
    variable = tau_22
  [../]
  [./gss_23]
    type = ElementAverageValue
    variable = gss_23
  [../]
  [./mobile_disl_23]
    type = ElementAverageValue
    variable = mobile_disl_23
  [../]
  [./cross_slip_disl_23]
    type = ElementAverageValue
    variable = xslip_disl_23
  [../]
  [./immobile_disl_23]
    type = ElementAverageValue
    variable = immobile_disl_23
  [../]
  [./slip_increment_23]
    type = ElementAverageValue
    variable = slip_increment_23
  [../]
  [./glide_velocity_23]
    type = ElementAverageValue
    variable = glide_velocity_23
  [../]
  [./tau_23]
    type = ElementAverageValue
    variable = tau_23
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

  #petsc_options_iname = -pc_hypre_type
  #petsc_options_value = boomerang
  petsc_options = '-snes_ksp_ew'
  l_tol = 1e-2 # <--- l_tol is ignored when EW is used.
  petsc_options_iname = '-pc_type -pc_factor_mat_solver_package'
  petsc_options_value = 'lu superlu_dist'
  #petsc_options_iname = '-pc_type'
  #petsc_options_value = 'lu'

  nl_abs_tol = 1e-10
  nl_rel_tol = 1e-8
  #
  #l_max_its = 60
  #nl_max_its = 20

  dtmax = 10.0
  dtmin = 1.0e-8
  #[./TimeStepper]
  #  type = FunctionDT
  #  time_dt = '1e-2 1e-2  1e-4  1e-4'
  #  time_t  = '0    1.0   1.1   10.0'
  #[../]

  dt = 1.0e-4
  #num_steps = 15
  end_time = 10.0

  #[./TimeStepper]
  # type = IterationAdaptiveDT
  # reset_dt = true
  # dt = 0.01
  # time_t = '0.0 0.31'
  # time_dt = '0.2 5e-5'
  # growth_factor = 1.8
  # cutback_factor = 0.5
  #[../]
[]

[Outputs]
  csv = true
  exodus = true
[]
