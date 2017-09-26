#Ni-33CrModel alloy, without defects
[Mesh]
  type = GeneratedMesh
  dim = 3
  elem_type = HEX8
  displacements = 'ux uy uz'
  nx = 2
  xmin = 0
  xmax = 5e-3
  ny = 2
  ymin = 0
  ymax = 5e-3
  nz = 6
  zmin = 0
  zmax = 14.95e-3
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
  [./e_yy]
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
  #[./xslip_disl_0]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  [./immobile_disl_0]
    order = CONSTANT
    family = MONOMIAL
  [../]
  #[./slip_increment_0]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  #[./glide_velocity_0]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  #[./tau_0]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  [./gss_1]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_1]
    order = CONSTANT
    family = MONOMIAL
  [../]
  #[./xslip_disl_1]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  [./immobile_disl_1]
    order = CONSTANT
    family = MONOMIAL
  [../]
  #[./slip_increment_1]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  #[./glide_velocity_1]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  #[./tau_1]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  [./gss_2]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_2]
    order = CONSTANT
    family = MONOMIAL
  [../]
  #[./xslip_disl_2]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  [./immobile_disl_2]
    order = CONSTANT
    family = MONOMIAL
  [../]
  #[./slip_increment_2]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  #[./glide_velocity_2]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  #[./tau_2]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  [./gss_3]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_3]
    order = CONSTANT
    family = MONOMIAL
  [../]
  #[./xslip_disl_3]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  [./immobile_disl_3]
    order = CONSTANT
    family = MONOMIAL
  [../]
  #[./slip_increment_3]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  #[./glide_velocity_3]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  #[./tau_3]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  [./gss_4]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_4]
    order = CONSTANT
    family = MONOMIAL
  [../]
  #[./xslip_disl_4]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  [./immobile_disl_4]
    order = CONSTANT
    family = MONOMIAL
  [../]
  #[./slip_increment_4]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  #[./glide_velocity_4]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  #[./tau_4]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  [./gss_5]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_5]
    order = CONSTANT
    family = MONOMIAL
  [../]
  #[./xslip_disl_5]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  [./immobile_disl_5]
    order = CONSTANT
    family = MONOMIAL
  [../]
  #[./slip_increment_5]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  #[./glide_velocity_5]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  #[./tau_5]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  [./gss_6]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_6]
    order = CONSTANT
    family = MONOMIAL
  [../]
  #[./xslip_disl_6]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  [./immobile_disl_6]
    order = CONSTANT
    family = MONOMIAL
  [../]
  #[./slip_increment_6]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  #[./glide_velocity_6]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  #[./tau_6]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  [./gss_7]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_7]
    order = CONSTANT
    family = MONOMIAL
  [../]
  #[./xslip_disl_7]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  [./immobile_disl_7]
    order = CONSTANT
    family = MONOMIAL
  [../]
  #[./slip_increment_7]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  #[./glide_velocity_7]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  #[./tau_7]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  [./gss_8]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_8]
    order = CONSTANT
    family = MONOMIAL
  [../]
  #[./xslip_disl_8]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  [./immobile_disl_8]
    order = CONSTANT
    family = MONOMIAL
  [../]
  #[./slip_increment_8]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  #[./glide_velocity_8]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  #[./tau_8]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  [./gss_9]
    order = CONSTANT
    family = MONOMIAL
    block = 0
  [../]
  [./mobile_disl_9]
    order = CONSTANT
    family = MONOMIAL
  [../]
  #[./xslip_disl_9]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  [./immobile_disl_9]
    order = CONSTANT
    family = MONOMIAL
  [../]
  #[./slip_increment_9]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  #[./glide_velocity_9]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  #[./tau_9]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  [./gss_10]
    order = CONSTANT
    family = MONOMIAL
    block = 0
  [../]
  [./mobile_disl_10]
    order = CONSTANT
    family = MONOMIAL
  [../]
  #[./xslip_disl_10]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  [./immobile_disl_10]
    order = CONSTANT
    family = MONOMIAL
  [../]
  #[./slip_increment_10]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  #[./glide_velocity_10]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  #[./tau_10]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  [./gss_11]
    order = CONSTANT
    family = MONOMIAL
    block = 0
  [../]
  [./mobile_disl_11]
    order = CONSTANT
    family = MONOMIAL
  [../]
  #[./xslip_disl_11]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  [./immobile_disl_11]
    order = CONSTANT
    family = MONOMIAL
  [../]
  #[./slip_increment_11]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  #[./glide_velocity_11]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
  #[./tau_11]
  #  order = CONSTANT
  #  family = MONOMIAL
  #[../]
[]

[Functions]
  [./tdisp]
    type = ParsedFunction
    value = 1.0/3.0*t*1e-4
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
  #[./xslip_disl_0]
  #  type = MaterialStdVectorAux
  #  variable = xslip_disl_0
  #  property = cross_slip_dislocations
  #  index = 0
  #  execute_on = timestep_end
  #[../]
  [./immobile_disl_0]
    type = MaterialStdVectorAux
    variable = immobile_disl_0
    property = immobile_dislocations
    index = 0
    execute_on = timestep_end
  [../]
  #[./slip_inc_0]
  #  type = MaterialStdVectorAux
  #  variable = slip_increment_0
  #  property = plastic_slip_increment
  #  index = 0
  #  execute_on = timestep_end
  #[../]
  #[./glide_velocity_0]
  #  type = MaterialStdVectorAux
  #  variable = glide_velocity_0
  #  property = dislocation_glide_velocity
  #  index = 0
  #  execute_on = timestep_end
  #[../]
  #[./tau_0]
  #  type = MaterialStdVectorAux
  #  variable = tau_0
  #  property = applied_shear_stress
  #  index = 0
  #  execute_on = timestep_end
  #[../]
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
  #[./xslip_disl_1]
  #  type = MaterialStdVectorAux
  #  variable = xslip_disl_1
  #  property = cross_slip_dislocations
  #  index = 1
  #  execute_on = timestep_end
  #[../]
  [./immobile_disl_1]
    type = MaterialStdVectorAux
    variable = immobile_disl_1
    property = immobile_dislocations
    index = 1
    execute_on = timestep_end
  [../]
  #[./slip_inc_1]
  #  type = MaterialStdVectorAux
  #  variable = slip_increment_1
  #  property = plastic_slip_increment
  #  index = 1
  #  execute_on = timestep_end
  #[../]
  #[./glide_velocity_1]
  #  type = MaterialStdVectorAux
  #  variable = glide_velocity_1
  #  property = dislocation_glide_velocity
  #  index = 1
  #  execute_on = timestep_end
  #[../]
  #[./tau_1]
  #  type = MaterialStdVectorAux
  #  variable = tau_1
  #  property = applied_shear_stress
  #  index = 1
  #  execute_on = timestep_end
  #[../]
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
  #[./xslip_disl_2]
  #  type = MaterialStdVectorAux
  #  variable = xslip_disl_2
  #  property = cross_slip_dislocations
  #  index = 2
  #  execute_on = timestep_end
  #[../]
  [./immobile_disl_2]
    type = MaterialStdVectorAux
    variable = immobile_disl_2
    property = immobile_dislocations
    index = 2
    execute_on = timestep_end
  [../]
  #[./slip_inc_2]
  #  type = MaterialStdVectorAux
  #  variable = slip_increment_2
  #  property = plastic_slip_increment
  #  index = 2
  #  execute_on = timestep_end
  #[../]
  #[./glide_velocity_2]
  #  type = MaterialStdVectorAux
  #  variable = glide_velocity_2
  #  property = dislocation_glide_velocity
  #  index = 2
  #  execute_on = timestep_end
  #[../]
  #[./tau_2]
  #  type = MaterialStdVectorAux
  #  variable = tau_2
  #  property = applied_shear_stress
  #  index = 2
  #  execute_on = timestep_end
  #[../]
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
  #[./xslip_disl_3]
  #  type = MaterialStdVectorAux
  #  variable = xslip_disl_3
  #  property = cross_slip_dislocations
  #  index = 3
  #  execute_on = timestep_end
  #[../]
  [./immobile_disl_3]
    type = MaterialStdVectorAux
    variable = immobile_disl_3
    property = immobile_dislocations
    index = 3
    execute_on = timestep_end
  [../]
  #[./slip_inc_3]
  #  type = MaterialStdVectorAux
  #  variable = slip_increment_3
  #  property = plastic_slip_increment
  #  index = 3
  #  execute_on = timestep_end
  #[../]
  #[./glide_velocity_3]
  #  type = MaterialStdVectorAux
  #  variable = glide_velocity_3
  #  property = dislocation_glide_velocity
  #  index = 3
  #  execute_on = timestep_end
  #[../]
  #[./tau_3]
  #  type = MaterialStdVectorAux
  #  variable = tau_3
  #  property = applied_shear_stress
  #  index = 3
  #  execute_on = timestep_end
  #[../]
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
  #[./xslip_disl_4]
  #  type = MaterialStdVectorAux
  #  variable = xslip_disl_4
  #  property = cross_slip_dislocations
  #  index = 4
  #  execute_on = timestep_end
  #[../]
  [./immobile_disl_4]
    type = MaterialStdVectorAux
    variable = immobile_disl_4
    property = immobile_dislocations
    index = 4
    execute_on = timestep_end
  [../]
  #[./slip_inc_4]
  #  type = MaterialStdVectorAux
  #  variable = slip_increment_4
  #  property = plastic_slip_increment
  #  index = 4
  #  execute_on = timestep_end
  #[../]
  #[./glide_velocity_4]
  #  type = MaterialStdVectorAux
  #  variable = glide_velocity_4
  #  property = dislocation_glide_velocity
  #  index = 4
  #  execute_on = timestep_end
  #[../]
  #[./tau_4]
  #  type = MaterialStdVectorAux
  #  variable = tau_4
  #  property = applied_shear_stress
  #  index = 4
  #  execute_on = timestep_end
  #[../]
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
  #[./xslip_disl_5]
  #  type = MaterialStdVectorAux
  #  variable = xslip_disl_5
  #  property = cross_slip_dislocations
  #  index = 5
  #  execute_on = timestep_end
  #[../]
  [./immobile_disl_5]
    type = MaterialStdVectorAux
    variable = immobile_disl_5
    property = immobile_dislocations
    index = 5
    execute_on = timestep_end
  [../]
  #[./slip_inc_5]
  #  type = MaterialStdVectorAux
  #  variable = slip_increment_5
  #  property = plastic_slip_increment
  #  index = 5
  #  execute_on = timestep_end
  #[../]
  #[./glide_velocity_5]
  #  type = MaterialStdVectorAux
  #  variable = glide_velocity_5
  #  property = dislocation_glide_velocity
  #  index = 5
  #  execute_on = timestep_end
  #[../]
  #[./tau_5]
  #  type = MaterialStdVectorAux
  #  variable = tau_5
  #  property = applied_shear_stress
  #  index = 5
  #  execute_on = timestep_end
  #[../]
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
  #[./xslip_disl_6]
  #  type = MaterialStdVectorAux
  #  variable = xslip_disl_6
  #  property = cross_slip_dislocations
  #  index = 6
  #  execute_on = timestep_end
  #[../]
  [./immobile_disl_6]
    type = MaterialStdVectorAux
    variable = immobile_disl_6
    property = immobile_dislocations
    index = 6
    execute_on = timestep_end
  [../]
  #[./slip_inc_6]
  #  type = MaterialStdVectorAux
  #  variable = slip_increment_6
  #  property = plastic_slip_increment
  #  index = 6
  #  execute_on = timestep_end
  #[../]
  #[./glide_velocity_6]
  #  type = MaterialStdVectorAux
  #  variable = glide_velocity_6
  #  property = dislocation_glide_velocity
  #  index = 6
  #  execute_on = timestep_end
  #[../]
  #[./tau_6]
  #  type = MaterialStdVectorAux
  #  variable = tau_6
  #  property = applied_shear_stress
  #  index = 6
  #  execute_on = timestep_end
  #[../]
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
  #[./xslip_disl_7]
  #  type = MaterialStdVectorAux
  #  variable = xslip_disl_7
  #  property = cross_slip_dislocations
  #  index = 7
  #  execute_on = timestep_end
  #[../]
  [./immobile_disl_7]
    type = MaterialStdVectorAux
    variable = immobile_disl_7
    property = immobile_dislocations
    index = 7
    execute_on = timestep_end
  [../]
  #[./slip_inc_7]
  #  type = MaterialStdVectorAux
  #  variable = slip_increment_7
  #  property = plastic_slip_increment
  #  index = 7
  #  execute_on = timestep_end
  #[../]
  #[./glide_velocity_7]
  #  type = MaterialStdVectorAux
  #  variable = glide_velocity_7
  #  property = dislocation_glide_velocity
  #  index = 7
  #  execute_on = timestep_end
  #[../]
  #[./tau_7]
  #  type = MaterialStdVectorAux
  #  variable = tau_7
  #  property = applied_shear_stress
  #  index = 7
  #  execute_on = timestep_end
  #[../]
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
  #[./xslip_disl_8]
  #  type = MaterialStdVectorAux
  #  variable = xslip_disl_8
  #  property = cross_slip_dislocations
  #  index = 8
  #  execute_on = timestep_end
  #[../]
  [./immobile_disl_8]
    type = MaterialStdVectorAux
    variable = immobile_disl_8
    property = immobile_dislocations
    index = 8
    execute_on = timestep_end
  [../]
  #[./slip_inc_8]
  #  type = MaterialStdVectorAux
  #  variable = slip_increment_8
  #  property = plastic_slip_increment
  #  index = 8
  #  execute_on = timestep_end
  #[../]
  #[./glide_velocity_8]
  #  type = MaterialStdVectorAux
  #  variable = glide_velocity_8
  #  property = dislocation_glide_velocity
  #  index = 8
  #  execute_on = timestep_end
  #[../]
  #[./tau_8]
  #  type = MaterialStdVectorAux
  #  variable = tau_8
  #  property = applied_shear_stress
  #  index = 8
  #  execute_on = timestep_end
  #[../]
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
  #[./xslip_disl_9]
  #  type = MaterialStdVectorAux
  #  variable = xslip_disl_9
  #  property = cross_slip_dislocations
  #  index = 9
  #  execute_on = timestep_end
  #[../]
  [./immobile_disl_9]
    type = MaterialStdVectorAux
    variable = immobile_disl_9
    property = immobile_dislocations
    index = 9
    execute_on = timestep_end
  [../]
  #[./slip_inc_9]
  #  type = MaterialStdVectorAux
  #  variable = slip_increment_9
  #  property = plastic_slip_increment
  #  index = 9
  #  execute_on = timestep_end
  #[../]
  #[./glide_velocity_9]
  #  type = MaterialStdVectorAux
  #  variable = glide_velocity_9
  #  property = dislocation_glide_velocity
  #  index = 9
  #  execute_on = timestep_end
  #[../]
  #[./tau_9]
  #  type = MaterialStdVectorAux
  #  variable = tau_9
  #  property = applied_shear_stress
  #  index = 9
  #  execute_on = timestep_end
  #[../]
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
  #[./xslip_disl_10]
  #  type = MaterialStdVectorAux
  #  variable = xslip_disl_10
  #  property = cross_slip_dislocations
  #  index = 10
  #  execute_on = timestep_end
  #[../]
  [./immobile_disl_10]
    type = MaterialStdVectorAux
    variable = immobile_disl_10
    property = immobile_dislocations
    index = 10
    execute_on = timestep_end
  [../]
  #[./slip_inc_10]
  #  type = MaterialStdVectorAux
  #  variable = slip_increment_10
  #  property = plastic_slip_increment
  #  index = 10
  #  execute_on = timestep_end
  #[../]
  #[./glide_velocity_10]
  #  type = MaterialStdVectorAux
  #  variable = glide_velocity_10
  #  property = dislocation_glide_velocity
  #  index = 10
  #  execute_on = timestep_end
  #[../]
  #[./tau_10]
  #  type = MaterialStdVectorAux
  #  variable = tau_10
  #  property = applied_shear_stress
  #  index = 10
  #  execute_on = timestep_end
  #[../]
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
  #[./xslip_disl_11]
  #  type = MaterialStdVectorAux
  #  variable = xslip_disl_11
  #  property = cross_slip_dislocations
  #  index = 11
  #  execute_on = timestep_end
  #[../]
  [./immobile_disl_11]
    type = MaterialStdVectorAux
    variable = immobile_disl_11
    property = immobile_dislocations
    index = 11
    execute_on = timestep_end
  [../]
  #[./slip_inc_11]
  #  type = MaterialStdVectorAux
  #  variable = slip_increment_11
  #  property = plastic_slip_increment
  #  index = 11
  #  execute_on = timestep_end
  #[../]
  #[./glide_velocity_11]
  #  type = MaterialStdVectorAux
  #  variable = glide_velocity_11
  #  property = dislocation_glide_velocity
  #  index = 11
  #  execute_on = timestep_end
  #[../]
  #[./tau_11]
  #  type = MaterialStdVectorAux
  #  variable = tau_11
  #  property = applied_shear_stress
  #  index = 11
  #  execute_on = timestep_end
  #[../]
[]

[BCs]
  [./fixed_bot_z]
    type = PresetBC
    variable = uz
    boundary = bottom
    value = 0
  [../]
  [./fixed_bot_x]
    type = PresetBC
    variable = ux
    boundary = bottom
    value = 0
  [../]
  [./fixed_bot_y]
    type = PresetBC
    variable = uy
    boundary = bottom
    value = 0
  [../]
  [./tdisp]
    type = FunctionPresetBC
    variable = uz
    boundary = top
    function = tdisp
  [../]
[]

[Materials]
  [./elasticity_tensor]
    type = ComputeElasticityTensorCP
    C_ijkl = '332.365e3 186.817e3 186.817e3 332.365e3 186.817e3 332.365e3 72.773e3 72.773e3 72.773e3' #Values for 298K, Blaizot et.al. 2016
    fill_method = symmetric9
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
    number_slip_systems = 12
    slip_sys_file_name = input_slip_sys.txt
    number_cross_slip_directions = 0
    number_cross_slip_planes = 0
    temperature = 298.0
    initial_immobile_dislocation_density = 1.5e7 #match initial dislocation density in Blaizot et.al. 2016
    initial_mobile_dislocation_density = 1.5e7 #match initial dislocation density in Blaizot et.al. 2016
    cluster_defect_density = 2.63e20 #Fei(2017) experimental data, phase fraction / volume average diameter sphere
    cluster_defect_size = 7.2e-8 #Fei (2017) experimental data from 10,000 aged Ni-33Cr
    cross_slip_calculation_type = deterministic
    Peierls_stress = 3.639 #0.5e-4 times shear modulus
    shear_modulus = 72.773e3
    burgers_vector = 2.52e-7
    stol = 1.0e-3
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
  #[./cross_slip_disl_0]
  #  type = ElementAverageValue
  #  variable = xslip_disl_0
  #[../]
  [./immobile_disl_0]
    type = ElementAverageValue
    variable = immobile_disl_0
  [../]
  #[./slip_increment_0]
  #  type = ElementAverageValue
  #  variable = slip_increment_0
  #[../]
  #[./glide_velocity_0]
  #  type = ElementAverageValue
  #  variable = glide_velocity_0
  #[../]
  #[./tau_0]
  #  type = ElementAverageValue
  #  variable = tau_0
  #[../]
  [./gss_1]
    type = ElementAverageValue
    variable = gss_1
  [../]
  [./mobile_disl_1]
    type = ElementAverageValue
    variable = mobile_disl_1
  [../]
  #[./cross_slip_disl_1]
  #  type = ElementAverageValue
  #  variable = xslip_disl_1
  #[../]
  [./immobile_disl_1]
    type = ElementAverageValue
    variable = immobile_disl_1
  [../]
  #[./slip_increment_1]
  #  type = ElementAverageValue
  #  variable = slip_increment_1
  #[../]
  #[./glide_velocity_1]
  #  type = ElementAverageValue
  #  variable = glide_velocity_1
  #[../]
  #[./tau_1]
  #  type = ElementAverageValue
  #  variable = tau_1
  #[../]
  [./gss_2]
    type = ElementAverageValue
    variable = gss_2
  [../]
  [./mobile_disl_2]
    type = ElementAverageValue
    variable = mobile_disl_2
  [../]
  #[./cross_slip_disl_2]
  #  type = ElementAverageValue
  #  variable = xslip_disl_2
  #[../]
  [./immobile_disl_2]
    type = ElementAverageValue
    variable = immobile_disl_2
  [../]
  #[./slip_increment_2]
  #  type = ElementAverageValue
  #  variable = slip_increment_2
  #[../]
  #[./glide_velocity_2]
  #  type = ElementAverageValue
  #  variable = glide_velocity_2
  #[../]
  #[./tau_2]
  #  type = ElementAverageValue
  #  variable = tau_2
  #[../]
  [./gss_3]
    type = ElementAverageValue
    variable = gss_3
  [../]
  [./mobile_disl_3]
    type = ElementAverageValue
    variable = mobile_disl_3
  [../]
  #[./cross_slip_disl_3]
  #  type = ElementAverageValue
  #  variable = xslip_disl_3
  #[../]
  [./immobile_disl_3]
    type = ElementAverageValue
    variable = immobile_disl_3
  [../]
  #[./slip_increment_3]
  #  type = ElementAverageValue
  #  variable = slip_increment_3
  #[../]
  #[./glide_velocity_3]
  #  type = ElementAverageValue
  #  variable = glide_velocity_3
  #[../]
  #[./tau_3]
  #  type = ElementAverageValue
  #  variable = tau_3
  #[../]
  [./gss_4]
    type = ElementAverageValue
    variable = gss_4
  [../]
  [./mobile_disl_4]
    type = ElementAverageValue
    variable = mobile_disl_4
  [../]
  #[./cross_slip_disl_4]
  #  type = ElementAverageValue
  #  variable = xslip_disl_4
  #[../]
  [./immobile_disl_4]
    type = ElementAverageValue
    variable = immobile_disl_4
  [../]
  #[./slip_increment_4]
  #  type = ElementAverageValue
  #  variable = slip_increment_4
  #[../]
  #[./glide_velocity_4]
  #  type = ElementAverageValue
  #  variable = glide_velocity_4
  #[../]
  #[./tau_4]
  #  type = ElementAverageValue
  #  variable = tau_4
  #[../]
  [./gss_5]
    type = ElementAverageValue
    variable = gss_5
  [../]
  [./mobile_disl_5]
    type = ElementAverageValue
    variable = mobile_disl_5
  [../]
  #[./cross_slip_disl_5]
  #  type = ElementAverageValue
  #  variable = xslip_disl_5
  #[../]
  [./immobile_disl_5]
    type = ElementAverageValue
    variable = immobile_disl_5
  [../]
  #[./slip_increment_5]
  #  type = ElementAverageValue
  #  variable = slip_increment_5
  #[../]
  #[./glide_velocity_5]
  #  type = ElementAverageValue
  #  variable = glide_velocity_5
  #[../]
  #[./tau_5]
  #  type = ElementAverageValue
  #  variable = tau_5
  #[../]
  [./gss_6]
    type = ElementAverageValue
    variable = gss_6
  [../]
  [./mobile_disl_6]
    type = ElementAverageValue
    variable = mobile_disl_6
  [../]
  #[./cross_slip_disl_6]
  #  type = ElementAverageValue
  #  variable = xslip_disl_6
  #[../]
  [./immobile_disl_6]
    type = ElementAverageValue
    variable = immobile_disl_6
  [../]
  #[./slip_increment_6]
  #  type = ElementAverageValue
  #  variable = slip_increment_6
  #[../]
  #[./glide_velocity_6]
  #  type = ElementAverageValue
  #  variable = glide_velocity_6
  #[../]
  #[./tau_6]
  #  type = ElementAverageValue
  #  variable = tau_6
  #[../]
  [./gss_7]
    type = ElementAverageValue
    variable = gss_7
  [../]
  [./mobile_disl_7]
    type = ElementAverageValue
    variable = mobile_disl_7
  [../]
  #[./cross_slip_disl_7]
  #  type = ElementAverageValue
  #  variable = xslip_disl_7
  #[../]
  [./immobile_disl_7]
    type = ElementAverageValue
    variable = immobile_disl_7
  [../]
  #[./slip_increment_7]
  #  type = ElementAverageValue
  #  variable = slip_increment_7
  #[../]
  #[./glide_velocity_7]
  #  type = ElementAverageValue
  #  variable = glide_velocity_7
  #[../]
  #[./tau_7]
  #  type = ElementAverageValue
  #  variable = tau_7
  #[../]
  [./gss_8]
    type = ElementAverageValue
    variable = gss_8
  [../]
  [./mobile_disl_8]
    type = ElementAverageValue
    variable = mobile_disl_8
  [../]
  #[./cross_slip_disl_8]
  #  type = ElementAverageValue
  #  variable = xslip_disl_8
  #[../]
  [./immobile_disl_8]
    type = ElementAverageValue
    variable = immobile_disl_8
  [../]
  #[./slip_increment_8]
  #  type = ElementAverageValue
  #  variable = slip_increment_8
  #[../]
  #[./glide_velocity_8]
  #  type = ElementAverageValue
  #  variable = glide_velocity_8
  #[../]
  #[./tau_8]
  #  type = ElementAverageValue
  #  variable = tau_8
  #[../]
  [./gss_9]
    type = ElementAverageValue
    variable = gss_9
  [../]
  [./mobile_disl_9]
    type = ElementAverageValue
    variable = mobile_disl_9
  [../]
  #[./cross_slip_disl_9]
  #  type = ElementAverageValue
  #  variable = xslip_disl_9
  #[../]
  [./immobile_disl_9]
    type = ElementAverageValue
    variable = immobile_disl_9
  [../]
  #[./slip_increment_9]
  #  type = ElementAverageValue
  #  variable = slip_increment_9
  #[../]
  #[./glide_velocity_9]
  #  type = ElementAverageValue
  #  variable = glide_velocity_9
  #[../]
  #[./tau_9]
  #  type = ElementAverageValue
  #  variable = tau_9
  #[../]
  [./gss_10]
    type = ElementAverageValue
    variable = gss_10
  [../]
  [./mobile_disl_10]
    type = ElementAverageValue
    variable = mobile_disl_10
  [../]
  #[./cross_slip_disl_10]
  #  type = ElementAverageValue
  #  variable = xslip_disl_10
  #[../]
  [./immobile_disl_10]
    type = ElementAverageValue
    variable = immobile_disl_10
  [../]
  #[./slip_increment_10]
  #  type = ElementAverageValue
  #  variable = slip_increment_10
  #[../]
  #[./glide_velocity_10]
  #  type = ElementAverageValue
  #  variable = glide_velocity_10
  #[../]
  #[./tau_10]
  #  type = ElementAverageValue
  #  variable = tau_10
  #[../]
  [./gss_11]
    type = ElementAverageValue
    variable = gss_11
  [../]
  [./mobile_disl_11]
    type = ElementAverageValue
    variable = mobile_disl_11
  [../]
  #[./cross_slip_disl_11]
  #  type = ElementAverageValue
  #  variable = xslip_disl_11
  #[../]
  [./immobile_disl_11]
    type = ElementAverageValue
    variable = immobile_disl_11
  [../]
  #[./slip_increment_11]
  #  type = ElementAverageValue
  #  variable = slip_increment_11
  #[../]
  #[./glide_velocity_11]
  #  type = ElementAverageValue
  #  variable = glide_velocity_11
  #[../]
  #[./tau_11]
  #  type = ElementAverageValue
  #  variable = tau_11
  #[../]
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

  nl_abs_tol = 1e-6
  nl_rel_tol = 1e-6
  #
  #l_max_its = 60
  #nl_max_its = 20

  dtmax = 10.0
  dtmin = 1.0e-8

  dt = 1.0e-4
  #num_steps = 15
  end_time = 60.0
[]

[Outputs]
  csv = true
  interval = 10
  exodus = false
[]
