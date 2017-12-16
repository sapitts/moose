#Ni-33CrModel alloy, with defects from Gwalani et al. (2016)
[Mesh]
  type = FileMesh
  file = micropillar_substrate.e
[]

[Variables]
  [./ux]
  [../]
  [./uy]
  [../]
  [./uz]
  [../]z
[]

[AuxVariables]
  [./stress_zz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_yy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_xx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./von_mises_stress]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_substrate_zz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_substrate_yy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_substrate_xx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_substrate_vm]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./pk2_pillar_xx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./pk2_pillar_yy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./pk2_pillar_zz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./pk2_pillar_vm]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./pk2_base_xx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./pk2_base_yy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./pk2_base_zz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./pk2_base_vm]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./e_pillar_zz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./e_pillar_xx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./e_pillar_yy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./e_pillar_eff]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./e_base_zz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./e_base_xx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./e_base_yy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./e_base_eff]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./e_substrate_zz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./e_substrate_xx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./e_substrate_yy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./e_substrate_eff]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_pillar_0]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_pillar_0]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_base_0]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_base_0]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_pillar_1]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_pillar_1]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_base_1]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_base_1]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_pillar_2]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_pillar_2]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_base_2]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_base_2]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_pillar_3]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_pillar_3]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_base_3]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_base_3]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_pillar_4]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_pillar_4]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_base_4]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_base_4]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_pillar_5]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_pillar_5]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_base_5]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_base_5]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_pillar_6]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_pillar_6]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_base_6]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_base_6]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_pillar_7]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_pillar_7]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_base_7]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_base_7]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_pillar_8]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_pillar_8]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_base_8]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_base_8]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_pillar_9]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_pillar_9]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_base_9]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_base_9]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_pillar_10]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_pillar_10]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_base_10]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_base_10]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_pillar_11]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_pillar_11]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./gss_base_11]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_disl_base_11]
    order = CONSTANT
    family = MONOMIAL
  [../]
[]

[Functions]
  [./tdisp]
    type = ParsedFunction
    value = (-1.0e-4)/3.0*t
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
  [./stress_yy]
    type = RankTwoAux
    variable = stress_yy
    rank_two_tensor = stress
    index_j = 1
    index_i = 1
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
  [./von_mises_stress]
    type = RankTwoScalarAux
    variable = von_mises_stress
    rank_two_tensor = stress
    scalar_type = VonMisesStress
    execute_on = timestep_end
  [../]
  [./stress_substrate_zz]
    type = RankTwoAux
    variable = stress_substrate_zz
    rank_two_tensor = stress
    index_j = 2
    index_i = 2
    block = substrate
    execute_on = timestep_end
  [../]
  [./stress_substrate_yy]
    type = RankTwoAux
    variable = stress_substrate_yy
    rank_two_tensor = stress
    index_j = 1
    index_i = 1
    block = substrate
    execute_on = timestep_end
  [../]
  [./stress_substrate_xx]
    type = RankTwoAux
    variable = stress_substrate_xx
    rank_two_tensor = stress
    index_j = 0
    index_i = 0
    block = substrate
    execute_on = timestep_end
  [../]
  [./stress_substrate_vm]
    type = RankTwoScalarAux
    variable = stress_substrate_vm
    rank_two_tensor = stress
    scalar_type = VonMisesStress
    block = substrate
    execute_on = timestep_end
  [../]
  [./pk2_pillar_zz]
    type = RankTwoAux
    variable = pk2_pillar_zz
    rank_two_tensor = pk2
    index_j = 2
    index_i = 2
    block = pillar
    execute_on = timestep_end
  [../]
  [./pk2_pillar_yy]
    type = RankTwoAux
    variable = pk2_pillar_yy
    rank_two_tensor = pk2
    index_j = 1
    index_i = 1
    block = pillar
    execute_on = timestep_end
  [../]
  [./pk2_pillar_xx]
    type = RankTwoAux
    variable = pk2_pillar_xx
    rank_two_tensor = pk2
    index_j = 0
    index_i = 0
    block = pillar
    execute_on = timestep_end
  [../]
  [./pk2_pillar_vm]
    type = RankTwoScalarAux
    variable = pk2_pillar_vm
    rank_two_tensor = pk2
    scalar_type = VonMisesStress
    block = pillar
    execute_on = timestep_end
  [../]
  [./pk2_base_zz]
    type = RankTwoAux
    variable = pk2_base_zz
    rank_two_tensor = pk2
    index_j = 2
    index_i = 2
    block = pillar_base
    execute_on = timestep_end
  [../]
  [./pk2_base_yy]
    type = RankTwoAux
    variable = pk2_base_yy
    rank_two_tensor = pk2
    index_j = 1
    index_i = 1
    block = pillar_base
    execute_on = timestep_end
  [../]
  [./pk2_base_xx]
    type = RankTwoAux
    variable = pk2_base_xx
    rank_two_tensor = pk2
    index_j = 0
    index_i = 0
    block = pillar_base
    execute_on = timestep_end
  [../]
  [./pk2_base_vm]
    type = RankTwoScalarAux
    variable = pk2_base_vm
    rank_two_tensor = pk2
    scalar_type = VonMisesStress
    block = pillar_base
    execute_on = timestep_end
  [../]

  [./e_pillar_zz]
    type = RankTwoAux
    variable = e_pillar_zz
    rank_two_tensor = lage
    index_j = 2
    index_i = 2
    block = pillar
    execute_on = timestep_end
  [../]
  [./e_pillar_yy]
    type = RankTwoAux
    variable = e_pillar_yy
    rank_two_tensor = lage
    index_j = 1
    index_i = 1
    block = pillar
    execute_on = timestep_end
  [../]
  [./e_pillar_xx]
    type = RankTwoAux
    variable = e_pillar_xx
    rank_two_tensor = lage
    index_j = 0
    index_i = 0
    block = pillar
    execute_on = timestep_end
  [../]
  [./e_pillar_eff]
    type = RankTwoScalarAux
    variable = e_pillar_eff
    rank_two_tensor = lage
    scalar_type = EffectiveStrain
    block = pillar
    execute_on = timestep_end
  [../]
  [./e_base_zz]
    type = RankTwoAux
    variable = e_base_zz
    rank_two_tensor = lage
    index_j = 2
    index_i = 2
    block = pillar_base
    execute_on = timestep_end
  [../]
  [./e_base_yy]
    type = RankTwoAux
    variable = e_base_yy
    rank_two_tensor = lage
    index_j = 1
    index_i = 1
    block = pillar_base
    execute_on = timestep_end
  [../]
  [./e_base_xx]
    type = RankTwoAux
    variable = e_base_xx
    rank_two_tensor = lage
    index_j = 0
    index_i = 0
    block = pillar_base
    execute_on = timestep_end
  [../]
  [./e_base_eff]
    type = RankTwoScalarAux
    variable = e_base_eff
    rank_two_tensor = lage
    scalar_type = EffectiveStrain
    block = pillar_base
    execute_on = timestep_end
  [../]
  [./e_substrate_zz]
    type = RankTwoAux
    variable = e_substrate_zz
    rank_two_tensor = total_strain
    index_j = 2
    index_i = 2
    block = substrate
    execute_on = timestep_end
  [../]
  [./e_substrate_yy]
    type = RankTwoAux
    variable = e_substrate_yy
    rank_two_tensor = total_strain
    index_j = 1
    index_i = 1
    block = substrate
    execute_on = timestep_end
  [../]
  [./e_substrate_xx]
    type = RankTwoAux
    variable = e_substrate_xx
    rank_two_tensor = total_strain
    index_j = 0
    index_i = 0
    block = substrate
    execute_on = timestep_end
  [../]
  [./e_substrate_eff]
    type = RankTwoScalarAux
    variable = e_substrate_eff
    rank_two_tensor = total_strain
    scalar_type = EffectiveStrain
    block = substrate
    execute_on = timestep_end
  [../]

  [./gss_pillar_0]
    type = MaterialStdVectorAux
    variable = gss_pillar_0
    property = slip_system_resistance
    index = 0
    block = pillar
    execute_on = timestep_end
  [../]
  [./mobile_disl_pillar_0]
    type = MaterialStdVectorAux
    variable = mobile_disl_pillar_0
    property = mobile_dislocations
    index = 0
    block = pillar
    execute_on = timestep_end
  [../]
  [./gss_base_0]
    type = MaterialStdVectorAux
    variable = gss_base_0
    property = slip_system_resistance
    index = 0
    block = pillar_base
    execute_on = timestep_end
  [../]
  [./mobile_disl_base_0]
    type = MaterialStdVectorAux
    variable = mobile_disl_base_0
    property = mobile_dislocations
    index = 0
    block = pillar_base
    execute_on = timestep_end
  [../]
  [./gss_pillar_1]
    type = MaterialStdVectorAux
    variable = gss_pillar_1
    property = slip_system_resistance
    index = 1
    block = pillar
    execute_on = timestep_end
  [../]
  [./mobile_disl_pillar_1]
    type = MaterialStdVectorAux
    variable = mobile_disl_pillar_1
    property = mobile_dislocations
    index = 1
    block = pillar
    execute_on = timestep_end
  [../]
  [./gss_base_1]
    type = MaterialStdVectorAux
    variable = gss_base_1
    property = slip_system_resistance
    index = 1
    block = pillar_base
    execute_on = timestep_end
  [../]
  [./mobile_disl_base_1]
    type = MaterialStdVectorAux
    variable = mobile_disl_base_1
    property = mobile_dislocations
    index = 1
    block = pillar_base
    execute_on = timestep_end
  [../]
  [./gss_pillar_2]
    type = MaterialStdVectorAux
    variable = gss_pillar_2
    property = slip_system_resistance
    index = 2
    block = pillar
    execute_on = timestep_end
  [../]
  [./mobile_disl_pillar_2]
    type = MaterialStdVectorAux
    variable = mobile_disl_pillar_2
    property = mobile_dislocations
    index = 2
    block = pillar
    execute_on = timestep_end
  [../]
  [./gss_base_2]
    type = MaterialStdVectorAux
    variable = gss_base_2
    property = slip_system_resistance
    index = 2
    block = pillar_base
    execute_on = timestep_end
  [../]
  [./mobile_disl_base_2]
    type = MaterialStdVectorAux
    variable = mobile_disl_base_2
    property = mobile_dislocations
    index = 2
    block = pillar_base
    execute_on = timestep_end
  [../]
  [./gss_pillar_3]
    type = MaterialStdVectorAux
    variable = gss_pillar_3
    property = slip_system_resistance
    index = 3
    block = pillar
    execute_on = timestep_end
  [../]
  [./mobile_disl_pillar_3]
    type = MaterialStdVectorAux
    variable = mobile_disl_pillar_3
    property = mobile_dislocations
    index = 3
    block = pillar
    execute_on = timestep_end
  [../]
  [./gss_base_3]
    type = MaterialStdVectorAux
    variable = gss_base_3
    property = slip_system_resistance
    index = 3
    block = pillar_base
    execute_on = timestep_end
  [../]
  [./mobile_disl_base_3]
    type = MaterialStdVectorAux
    variable = mobile_disl_base_3
    property = mobile_dislocations
    index = 3
    block = pillar_base
    execute_on = timestep_end
  [../]
  [./gss_pillar_4]
    type = MaterialStdVectorAux
    variable = gss_pillar_4
    property = slip_system_resistance
    index = 4
    block = pillar
    execute_on = timestep_end
  [../]
  [./mobile_disl_pillar_4]
    type = MaterialStdVectorAux
    variable = mobile_disl_pillar_4
    property = mobile_dislocations
    index = 4
    block = pillar
    execute_on = timestep_end
  [../]
  [./gss_base_4]
    type = MaterialStdVectorAux
    variable = gss_base_4
    property = slip_system_resistance
    index = 4
    block = pillar_base
    execute_on = timestep_end
  [../]
  [./mobile_disl_base_4]
    type = MaterialStdVectorAux
    variable = mobile_disl_base_4
    property = mobile_dislocations
    index = 4
    block = pillar_base
    execute_on = timestep_end
  [../]
  [./gss_pillar_5]
    type = MaterialStdVectorAux
    variable = gss_pillar_5
    property = slip_system_resistance
    index = 5
    block = pillar
    execute_on = timestep_end
  [../]
  [./mobile_disl_pillar_5]
    type = MaterialStdVectorAux
    variable = mobile_disl_pillar_5
    property = mobile_dislocations
    index = 5
    block = pillar
    execute_on = timestep_end
  [../]
  [./gss_base_5]
    type = MaterialStdVectorAux
    variable = gss_base_5
    property = slip_system_resistance
    index = 5
    block = pillar_base
    execute_on = timestep_end
  [../]
  [./mobile_disl_base_5]
    type = MaterialStdVectorAux
    variable = mobile_disl_base_5
    property = mobile_dislocations
    index = 5
    block = pillar_base
    execute_on = timestep_end
  [../]
  [./gss_pillar_6]
    type = MaterialStdVectorAux
    variable = gss_pillar_6
    property = slip_system_resistance
    index = 6
    execute_on = timestep_end
    block = pillar
  [../]
  [./mobile_disl_pillar_6]
    type = MaterialStdVectorAux
    variable = mobile_disl_pillar_6
    property = mobile_dislocations
    index = 6
    block = pillar
    execute_on = timestep_end
  [../]
  [./gss_base_6]
    type = MaterialStdVectorAux
    variable = gss_base_6
    property = slip_system_resistance
    index = 6
    execute_on = timestep_end
    block = pillar_base
  [../]
  [./mobile_disl_base_6]
    type = MaterialStdVectorAux
    variable = mobile_disl_base_6
    property = mobile_dislocations
    index = 6
    block = pillar_base
    execute_on = timestep_end
  [../]
  [./gss_pillar_7]
    type = MaterialStdVectorAux
    variable = gss_pillar_7
    property = slip_system_resistance
    index = 7
    block = pillar
    execute_on = timestep_end
  [../]
  [./mobile_disl_pillar_7]
    type = MaterialStdVectorAux
    variable = mobile_disl_pillar_7
    property = mobile_dislocations
    index = 7
    block = pillar
    execute_on = timestep_end
  [../]
  [./gss_base_7]
    type = MaterialStdVectorAux
    variable = gss_base_7
    property = slip_system_resistance
    index = 7
    block = pillar_base
    execute_on = timestep_end
  [../]
  [./mobile_disl_base_7]
    type = MaterialStdVectorAux
    variable = mobile_disl_base_7
    property = mobile_dislocations
    index = 7
    block = pillar_base
    execute_on = timestep_end
  [../]
  [./gss_pillar_8]
    type = MaterialStdVectorAux
    variable = gss_pillar_8
    property = slip_system_resistance
    index = 8
    block = pillar
    execute_on = timestep_end
  [../]
  [./mobile_disl_pillar_8]
    type = MaterialStdVectorAux
    variable = mobile_disl_pillar_8
    property = mobile_dislocations
    index = 8
    block = pillar
    execute_on = timestep_end
  [../]
  [./gss_base_8]
    type = MaterialStdVectorAux
    variable = gss_base_8
    property = slip_system_resistance
    index = 8
    block = pillar_base
    execute_on = timestep_end
  [../]
  [./mobile_disl_base_8]
    type = MaterialStdVectorAux
    variable = mobile_disl_base_8
    property = mobile_dislocations
    index = 8
    block = pillar_base
    execute_on = timestep_end
  [../]
  [./gss_pillar_9]
    type = MaterialStdVectorAux
    variable = gss_pillar_9
    property = slip_system_resistance
    index = 9
    block = pillar
    execute_on = timestep_end
  [../]
  [./mobile_disl_pillar_9]
    type = MaterialStdVectorAux
    variable = mobile_disl_pillar_9
    property = mobile_dislocations
    index = 9
    block = pillar
    execute_on = timestep_end
  [../]
  [./gss_base_9]
    type = MaterialStdVectorAux
    variable = gss_base_9
    property = slip_system_resistance
    index = 9
    block = pillar_base
    execute_on = timestep_end
  [../]
  [./mobile_disl_base_9]
    type = MaterialStdVectorAux
    variable = mobile_disl_base_9
    property = mobile_dislocations
    index = 9
    block = pillar_base
    execute_on = timestep_end
  [../]
  [./gss_pillar_10]
    type = MaterialStdVectorAux
    variable = gss_pillar_10
    property = slip_system_resistance
    index = 10
    block = pillar
    execute_on = timestep_end
  [../]
  [./mobile_disl_pillar_10]
    type = MaterialStdVectorAux
    variable = mobile_disl_pillar_10
    property = mobile_dislocations
    index = 10
    block = pillar
    execute_on = timestep_end
  [../]
  [./gss_base_10]
    type = MaterialStdVectorAux
    variable = gss_base_10
    property = slip_system_resistance
    index = 10
    block = pillar_base
    execute_on = timestep_end
  [../]
  [./mobile_disl_base_10]
    type = MaterialStdVectorAux
    variable = mobile_disl_base_10
    property = mobile_dislocations
    index = 10
    block = pillar_base
    execute_on = timestep_end
  [../]
  [./gss_pillar_11]
    type = MaterialStdVectorAux
    variable = gss_pillar_11
    property = slip_system_resistance
    index = 11
    block = pillar
    execute_on = timestep_end
  [../]
  [./mobile_disl_pillar_11]
    type = MaterialStdVectorAux
    variable = mobile_disl_pillar_11
    property = mobile_dislocations
    index = 11
    block = pillar
    execute_on = timestep_end
  [../]
  [./gss_base_11]
    type = MaterialStdVectorAux
    variable = gss_base_11
    property = slip_system_resistance
    index = 11
    block = pillar_base
    execute_on = timestep_end
  [../]
  [./mobile_disl_base_11]
    type = MaterialStdVectorAux
    variable = mobile_disl_base_11
    property = mobile_dislocations
    index = 11
    block = pillar_base
    execute_on = timestep_end
  [../]
[]

[BCs]
  [./symm_bot_z]
    type = PresetBC
    variable = uz
    boundary = bottom
    value = 0
  [../]
  [./symm_left_x]
    type = PresetBC
    variable = ux
    boundary = left
    value = 0
  [../]
  [./symm_back_y]
    type = PresetBC
    variable = uy
    boundary = back
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
    block = 'pillar pillar_base'
  [../]
  [./strain]
    type = ComputeFiniteStrain
    displacements = 'ux uy uz'
    block = 'pillar pillar_base'
  [../]
  [./stress]
    type = ComputeCrystalPlasticityStress
    crystal_plasticity_update_model = 'trial_xtalpl'
    block = 'pillar pillar_base'
  [../]
  [./trial_xtalpl]
    type = CrystalPlasticityCDDUpdate
    block = 'pillar pillar_base'
    number_slip_systems = 12
    slip_sys_file_name = input_slip_sys.txt
    number_cross_slip_directions = 0
    number_cross_slip_planes = 0
    temperature = 298.0
    initial_immobile_dislocation_density = 1.5e7 #match initial dislocation density in Blaizot et.al. 2016
    initial_mobile_dislocation_density = 1.5e7 #match initial dislocation density in Blaizot et.al. 2016
    cluster_defect_density = 3.65e15 #Gwalani et al. (2016) Table 2, 8000 hrs aged, number defects/ analyzed volume
    cluster_defect_size = 2.50e-6 #Gwalani et al. (2016) Table 2, 8000 hrs aged
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
  [./substrate_elasticity_tensor]
    type = ComputeIsotropicElasticityTensor
    lambda = 186.817e3 #Values for 298K, Blaizot et.al. 2016
    shear_modulus = 72.773e3 #Values for 298K, Blaizot et.al. 2016
    block = substrate
  [../]
  [./substrate_strain]
    type = ComputeFiniteStrain
    displacements = 'ux uy uz'
    block = substrate
  [../]
  [./substrate_stress]
    type = ComputeFiniteStrainElasticStress
    block = substrate
  [../]
[]

[Postprocessors]
  [./stress_zz]
    type = ElementAverageValue
    variable = stress_zz
  [../]
  [./stress_yy]
    type = ElementAverageValue
    variable = stress_yy
  [../]
  [./stress_xx]
    type = ElementAverageValue
    variable = stress_xx
  [../]
  [./von_mises_stress]
    type = ElementAverageValue
    variable = von_mises_stress
  [../]
  [./stress_substrate_zz]
    type = ElementAverageValue
    variable = stress_substrate_zz
  [../]
  [./stress_substrate_yy]
    type = ElementAverageValue
    variable = stress_substrate_yy
  [../]
  [./stress_substrate_xx]
    type = ElementAverageValue
    variable = stress_substrate_xx
  [../]
  [./stress_substrate_vm]
    type = ElementAverageValue
    variable = stress_substrate_vm
  [../]

  [./pk2_pillar_zz]
    type = ElementAverageValue
    variable = pk2_pillar_zz
  [../]
  [./pk2_pillar_yy]
    type = ElementAverageValue
    variable = pk2_pillar_yy
  [../]
  [./pk2_pillar_xx]
    type = ElementAverageValue
    variable = pk2_pillar_xx
  [../]
  [./pk2_pillar_vm]
    type = ElementAverageValue
    variable = pk2_pillar_vm
  [../]
  [./pk2_base_zz]
    type = ElementAverageValue
    variable = pk2_base_zz
  [../]
  [./pk2_base_yy]
    type = ElementAverageValue
    variable = pk2_base_yy
  [../]
  [./pk2_base_xx]
    type = ElementAverageValue
    variable = pk2_base_xx
  [../]
  [./pk2_base_vm]
    type = ElementAverageValue
    variable = pk2_base_vm
  [../]

  [./e_substrate_zz]
    type = ElementAverageValue
    variable = e_substrate_zz
  [../]
  [./e_substrate_yy]
    type = ElementAverageValue
    variable = e_substrate_yy
  [../]
  [./e_substrate_xx]
    type = ElementAverageValue
    variable = e_substrate_xx
  [../]
  [./e_substrate_ff]
    type = ElementAverageValue
    variable = e_substrate_eff
  [../]
  [./e_pillar_zz]
    type = ElementAverageValue
    variable = e_pillar_zz
  [../]
  [./e_pillar_yy]
    type = ElementAverageValue
    variable = e_pillar_yy
  [../]
  [./e_pillar_xx]
    type = ElementAverageValue
    variable = e_pillar_xx
  [../]
  [./e_pillar_eff]
    type = ElementAverageValue
    variable = e_pillar_eff
  [../]
  [./e_base_zz]
    type = ElementAverageValue
    variable = e_base_zz
  [../]
  [./e_base_yy]
    type = ElementAverageValue
    variable = e_base_yy
  [../]
  [./e_base_xx]
    type = ElementAverageValue
    variable = e_base_xx
  [../]
  [./e_base_eff]
    type = ElementAverageValue
    variable = e_base_eff
  [../]

  [./gss_pillar_0]
    type = ElementAverageValue
    variable = gss_pillar_0
  [../]
  [./mobile_disl_pillar_0]
    type = ElementAverageValue
    variable = mobile_disl_pillar_0
  [../]
  [./gss_base_0]
    type = ElementAverageValue
    variable = gss_base_0
  [../]
  [./mobile_disl_base_0]
    type = ElementAverageValue
    variable = mobile_disl_base_0
  [../]
  [./gss_pillar_1]
    type = ElementAverageValue
    variable = gss_pillar_1
  [../]
  [./mobile_disl_pillar_1]
    type = ElementAverageValue
    variable = mobile_disl_pillar_1
  [../]
  [./gss_base_1]
    type = ElementAverageValue
    variable = gss_base_1
  [../]
  [./mobile_disl_base_1]
    type = ElementAverageValue
    variable = mobile_disl_base_1
  [../]
  [./gss_pillar_2]
    type = ElementAverageValue
    variable = gss_pillar_2
  [../]
  [./mobile_disl_pillar_2]
    type = ElementAverageValue
    variable = mobile_disl_pillar_2
  [../]
  [./gss_base_2]
    type = ElementAverageValue
    variable = gss_base_2
  [../]
  [./mobile_disl_base_2]
    type = ElementAverageValue
    variable = mobile_disl_base_2
  [../]
  [./gss_pillar_3]
    type = ElementAverageValue
    variable = gss_pillar_3
  [../]
  [./mobile_disl_pillar_3]
    type = ElementAverageValue
    variable = mobile_disl_pillar_3
  [../]
  [./gss_base_3]
    type = ElementAverageValue
    variable = gss_base_3
  [../]
  [./mobile_disl_base_3]
    type = ElementAverageValue
    variable = mobile_disl_base_3
  [../]
  [./gss_pillar_4]
    type = ElementAverageValue
    variable = gss_pillar_4
  [../]
  [./mobile_disl_pillar_4]
    type = ElementAverageValue
    variable = mobile_disl_pillar_4
  [../]
  [./gss_base_4]
    type = ElementAverageValue
    variable = gss_base_4
  [../]
  [./mobile_disl_base_4]
    type = ElementAverageValue
    variable = mobile_disl_base_4
  [../]
  [./gss_pillar_5]
    type = ElementAverageValue
    variable = gss_pillar_5
  [../]
  [./mobile_disl_pillar_5]
    type = ElementAverageValue
    variable = mobile_disl_pillar_5
  [../]
  [./gss_base_5]
    type = ElementAverageValue
    variable = gss_base_5
  [../]
  [./mobile_disl_base_5]
    type = ElementAverageValue
    variable = mobile_disl_base_5
  [../]
  [./gss_pillar_6]
    type = ElementAverageValue
    variable = gss_pillar_6
  [../]
  [./mobile_disl_pillar_6]
    type = ElementAverageValue
    variable = mobile_disl_pillar_6
  [../]
  [./gss_base_6]
    type = ElementAverageValue
    variable = gss_base_6
  [../]
  [./mobile_disl_base_6]
    type = ElementAverageValue
    variable = mobile_disl_base_6
  [../]
  [./gss_pillar_7]
    type = ElementAverageValue
    variable = gss_pillar_7
  [../]
  [./mobile_disl_pillar_7]
    type = ElementAverageValue
    variable = mobile_disl_pillar_7
  [../]
  [./gss_base_7]
    type = ElementAverageValue
    variable = gss_base_7
  [../]
  [./mobile_disl_base_7]
    type = ElementAverageValue
    variable = mobile_disl_base_7
  [../]
  [./gss_pillar_8]
    type = ElementAverageValue
    variable = gss_pillar_8
  [../]
  [./mobile_disl_pillar_8]
    type = ElementAverageValue
    variable = mobile_disl_pillar_8
  [../]
  [./gss_base_8]
    type = ElementAverageValue
    variable = gss_base_8
  [../]
  [./mobile_disl_base_8]
    type = ElementAverageValue
    variable = mobile_disl_base_8
  [../]
  [./gss_pillar_9]
    type = ElementAverageValue
    variable = gss_pillar_9
  [../]
  [./mobile_disl_pillar_9]
    type = ElementAverageValue
    variable = mobile_disl_pillar_9
  [../]
  [./gss_base_9]
    type = ElementAverageValue
    variable = gss_base_9
  [../]
  [./mobile_disl_base_9]
    type = ElementAverageValue
    variable = mobile_disl_base_9
  [../]
  [./gss_pillar_10]
    type = ElementAverageValue
    variable = gss_pillar_10
  [../]
  [./mobile_disl_pillar_10]
    type = ElementAverageValue
    variable = mobile_disl_pillar_10
  [../]
  [./gss_base_10]
    type = ElementAverageValue
    variable = gss_pillar_10
  [../]
  [./mobile_disl_base_10]
    type = ElementAverageValue
    variable = mobile_disl_base_10
  [../]
  [./gss_pillar_11]
    type = ElementAverageValue
    variable = gss_pillar_11
  [../]
  [./mobile_disl_pillar_11]
    type = ElementAverageValue
    variable = mobile_disl_pillar_11
  [../]
  [./gss_base_11]
    type = ElementAverageValue
    variable = gss_base_11
  [../]
  [./mobile_disl_base_11]
    type = ElementAverageValue
    variable = mobile_disl_base_11
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

  nl_abs_tol = 1e-6
  nl_rel_tol = 1e-6
  #
  #l_max_its = 60
  #nl_max_its = 20

  dtmax = 10.0
  dtmin = 1.0e-8

  dt = 1.0e-4
  #num_steps = 15
  end_time = 120.0
[]

[Outputs]
  csv = true
  interval = 25
  exodus = true
[]
