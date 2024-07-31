[GlobalParams]
  displacements = 'disp_x disp_y disp_z'
[]

[Mesh]
  [cube]
    type = GeneratedMeshGenerator
    dim = 3
    nx = 8
    ny = 8
    nz = 16
    zmax = 2
    elem_type = HEX27
  []
[]

[AuxVariables]
  [temperature]
    initial_condition = 297.0 ##24C
  []
  [pk2_zz]
    order = FIRST
    family = MONOMIAL
  []
  [fp_zz]
    order = FIRST
    family = MONOMIAL
  []
  [e_zz]
    order = FIRST
    family = MONOMIAL
  []
  [pk2_xx]
    order = FIRST
    family = MONOMIAL
  []
  [fp_xx]
    order = FIRST
    family = MONOMIAL
  []
  [e_xx]
    order = FIRST
    family = MONOMIAL
  []
  [pk2_yy]
    order = FIRST
    family = MONOMIAL
  []
  [fp_yy]
    order = FIRST
    family = MONOMIAL
  []
  [e_yy]
    order = FIRST
    family = MONOMIAL
  []
  [vonmises_stress_cauchy]
    order = FIRST
    family = MONOMIAL
  []
  [eff_strain_green]
    order = FIRST
    family = MONOMIAL
  []
  [vonmises_stress_pk2]
    order = FIRST
    family = MONOMIAL
  []
  [eff_strain_lag]
    order = FIRST
    family = MONOMIAL
  []
  [gss_0]
    order = FIRST
    family = MONOMIAL
  []
  [dislocation_0]
    order = CONSTANT
    family = MONOMIAL
  []
  [slip_incr_0]
    order = FIRST
    family = MONOMIAL
  []
  [tau_0]
    order = FIRST
    family = MONOMIAL
  []
  [gss_1]
    order = FIRST
    family = MONOMIAL
  []
  [dislocation_1]
    order = CONSTANT
    family = MONOMIAL
  []
  [slip_incr_1]
    order = FIRST
    family = MONOMIAL
  []
  [tau_1]
    order = FIRST
    family = MONOMIAL
  []
  [gss_2]
    order = FIRST
    family = MONOMIAL
  []
  [dislocation_2]
    order = CONSTANT
    family = MONOMIAL
  []
  [slip_incr_2]
    order = FIRST
    family = MONOMIAL
  []
  [tau_2]
    order = FIRST
    family = MONOMIAL
  []
  [gss_3]
    order = FIRST
    family = MONOMIAL
  []
  [dislocation_3]
    order = CONSTANT
    family = MONOMIAL
  []
  [slip_incr_3]
    order = FIRST
    family = MONOMIAL
  []
  [tau_3]
    order = FIRST
    family = MONOMIAL
  []
  [gss_4]
    order = FIRST
    family = MONOMIAL
  []
  [dislocation_4]
    order = CONSTANT
    family = MONOMIAL
  []
  [slip_incr_4]
    order = FIRST
    family = MONOMIAL
  []
  [tau_4]
    order = FIRST
    family = MONOMIAL
  []
  [gss_5]
    order = FIRST
    family = MONOMIAL
  []
  [dislocation_5]
    order = CONSTANT
    family = MONOMIAL
  []
  [slip_incr_5]
    order = FIRST
    family = MONOMIAL
  []
  [tau_5]
    order = FIRST
    family = MONOMIAL
  []
  [gss_6]
    order = FIRST
    family = MONOMIAL
  []
  [dislocation_6]
    order = CONSTANT
    family = MONOMIAL
  []
  [slip_incr_6]
    order = FIRST
    family = MONOMIAL
  []
  [tau_6]
    order = FIRST
    family = MONOMIAL
  []
  [gss_7]
    order = FIRST
    family = MONOMIAL
  []
  [dislocation_7]
    order = CONSTANT
    family = MONOMIAL
  []
  [slip_incr_7]
    order = FIRST
    family = MONOMIAL
  []
  [tau_7]
    order = FIRST
    family = MONOMIAL
  []
  [gss_8]
    order = FIRST
    family = MONOMIAL
  []
  [dislocation_8]
    order = CONSTANT
    family = MONOMIAL
  []
  [slip_incr_8]
    order = FIRST
    family = MONOMIAL
  []
  [tau_8]
    order = FIRST
    family = MONOMIAL
  []
  [gss_9]
    order = FIRST
    family = MONOMIAL
  []
  [dislocation_9]
    order = CONSTANT
    family = MONOMIAL
  []
  [slip_incr_9]
    order = FIRST
    family = MONOMIAL
  []
  [tau_9]
    order = FIRST
    family = MONOMIAL
  []
  [gss_10]
    order = FIRST
    family = MONOMIAL
  []
  [dislocation_10]
    order = CONSTANT
    family = MONOMIAL
  []
  [slip_incr_10]
    order = FIRST
    family = MONOMIAL
  []
  [tau_10]
    order = FIRST
    family = MONOMIAL
  []
  [gss_11]
    order = FIRST
    family = MONOMIAL
  []
  [dislocation_11]
    order = CONSTANT
    family = MONOMIAL
  []
  [slip_incr_11]
    order = FIRST
    family = MONOMIAL
  []
  [tau_11]
    order = FIRST
    family = MONOMIAL
  []
  [gss_12]
    order = FIRST
    family = MONOMIAL
  []
  [dislocation_12]
    order = CONSTANT
    family = MONOMIAL
  []
  [slip_incr_12]
    order = FIRST
    family = MONOMIAL
  []
  [tau_12]
    order = FIRST
    family = MONOMIAL
  []
  [gss_13]
    order = FIRST
    family = MONOMIAL
  []
  [dislocation_13]
    order = CONSTANT
    family = MONOMIAL
  []
  [slip_incr_13]
    order = FIRST
    family = MONOMIAL
  []
  [tau_13]
    order = FIRST
    family = MONOMIAL
  []
  [gss_14]
    order = FIRST
    family = MONOMIAL
  []
  [dislocation_14]
    order = CONSTANT
    family = MONOMIAL
  []
  [slip_incr_14]
    order = FIRST
    family = MONOMIAL
  []
  [tau_14]
    order = FIRST
    family = MONOMIAL
  []
  [gss_15]
    order = FIRST
    family = MONOMIAL
  []
  [dislocation_15]
    order = CONSTANT
    family = MONOMIAL
  []
  [slip_incr_15]
    order = FIRST
    family = MONOMIAL
  []
  [tau_15]
    order = FIRST
    family = MONOMIAL
  []
  [gss_16]
    order = FIRST
    family = MONOMIAL
  []
  [dislocation_16]
    order = CONSTANT
    family = MONOMIAL
  []
  [slip_incr_16]
    order = FIRST
    family = MONOMIAL
  []
  [tau_16]
    order = FIRST
    family = MONOMIAL
  []
  [gss_17]
    order = FIRST
    family = MONOMIAL
  []
  [dislocation_17]
    order = CONSTANT
    family = MONOMIAL
  []
  [slip_incr_17]
    order = FIRST
    family = MONOMIAL
  []
  [tau_17]
    order = FIRST
    family = MONOMIAL
  []
  [gss_18]
    order = FIRST
    family = MONOMIAL
  []
  [dislocation_18]
    order = CONSTANT
    family = MONOMIAL
  []
  [slip_incr_18]
    order = FIRST
    family = MONOMIAL
  []
  [tau_18]
    order = FIRST
    family = MONOMIAL
  []
  [gss_19]
    order = FIRST
    family = MONOMIAL
  []
  [dislocation_19]
    order = CONSTANT
    family = MONOMIAL
  []
  [slip_incr_19]
    order = FIRST
    family = MONOMIAL
  []
  [tau_19]
    order = FIRST
    family = MONOMIAL
  []
  [gss_20]
    order = FIRST
    family = MONOMIAL
  []
  [dislocation_20]
    order = CONSTANT
    family = MONOMIAL
  []
  [slip_incr_20]
    order = FIRST
    family = MONOMIAL
  []
  [tau_20]
    order = FIRST
    family = MONOMIAL
  []
  [gss_21]
    order = FIRST
    family = MONOMIAL
  []
  [dislocation_21]
    order = CONSTANT
    family = MONOMIAL
  []
  [slip_incr_21]
    order = FIRST
    family = MONOMIAL
  []
  [tau_21]
    order = FIRST
    family = MONOMIAL
  []
  [gss_22]
    order = FIRST
    family = MONOMIAL
  []
  [dislocation_22]
    order = CONSTANT
    family = MONOMIAL
  []
  [slip_incr_22]
    order = FIRST
    family = MONOMIAL
  []
  [tau_22]
    order = FIRST
    family = MONOMIAL
  []
  [gss_23]
    order = FIRST
    family = MONOMIAL
  []
  [dislocation_23]
    order = CONSTANT
    family = MONOMIAL
  []
  [slip_incr_23]
    order = FIRST
    family = MONOMIAL
  []
  [tau_23]
    order = FIRST
    family = MONOMIAL
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
    type = MaterialStdVectorAux
    variable = gss_0
    property = slip_resistance
    index = 0
    execute_on = timestep_end
  []
  [dislocation_0]
    type = MaterialStdVectorAux
    variable = dislocation_0
    property = dislocation_density
    index = 0
    execute_on = timestep_end
  []
  [slip_incr_0]
    type = MaterialStdVectorAux
    variable = slip_incr_0
    property = constitutive_slip_increment
    index = 0
    execute_on = timestep_end
  []
  [tau_0]
    type = MaterialStdVectorAux
    variable = tau_0
    property = applied_shear_stress
    index = 0
    execute_on = timestep_end
  []
  [gss_1]
    type = MaterialStdVectorAux
    variable = gss_1
    property = slip_resistance
    index = 1
    execute_on = timestep_end
  []
  [dislocation_1]
    type = MaterialStdVectorAux
    variable = dislocation_1
    property = dislocation_density
    index = 1
    execute_on = timestep_end
  []
  [slip_incr_1]
    type = MaterialStdVectorAux
    variable = slip_incr_1
    property = constitutive_slip_increment
    index = 1
    execute_on = timestep_end
  []
  [tau_1]
    type = MaterialStdVectorAux
    variable = tau_1
    property = applied_shear_stress
    index = 1
    execute_on = timestep_end
  []
  [gss_2]
    type = MaterialStdVectorAux
    variable = gss_2
    property = slip_resistance
    index = 2
    execute_on = timestep_end
  []
  [dislocation_2]
    type = MaterialStdVectorAux
    variable = dislocation_2
    property = dislocation_density
    index = 2
    execute_on = timestep_end
  []
  [slip_incr_2]
    type = MaterialStdVectorAux
    variable = slip_incr_2
    property = constitutive_slip_increment
    index = 2
    execute_on = timestep_end
  []
  [tau_2]
    type = MaterialStdVectorAux
    variable = tau_2
    property = applied_shear_stress
    index = 2
    execute_on = timestep_end
  []
  [gss_3]
    type = MaterialStdVectorAux
    variable = gss_3
    property = slip_resistance
    index = 3
    execute_on = timestep_end
  []
  [dislocation_3]
    type = MaterialStdVectorAux
    variable = dislocation_3
    property = dislocation_density
    index = 3
    execute_on = timestep_end
  []
  [slip_incr_3]
    type = MaterialStdVectorAux
    variable = slip_incr_3
    property = constitutive_slip_increment
    index = 3
    execute_on = timestep_end
  []
  [tau_3]
    type = MaterialStdVectorAux
    variable = tau_3
    property = applied_shear_stress
    index = 3
    execute_on = timestep_end
  []
  [gss_4]
    type = MaterialStdVectorAux
    variable = gss_4
    property = slip_resistance
    index = 4
    execute_on = timestep_end
  []
  [dislocation_4]
    type = MaterialStdVectorAux
    variable = dislocation_4
    property = dislocation_density
    index = 4
    execute_on = timestep_end
  []
  [slip_incr_4]
    type = MaterialStdVectorAux
    variable = slip_incr_4
    property = constitutive_slip_increment
    index = 4
    execute_on = timestep_end
  []
  [tau_4]
    type = MaterialStdVectorAux
    variable = tau_4
    property = applied_shear_stress
    index = 4
    execute_on = timestep_end
  []
  [gss_5]
    type = MaterialStdVectorAux
    variable = gss_5
    property = slip_resistance
    index = 5
    execute_on = timestep_end
  []
  [dislocation_5]
    type = MaterialStdVectorAux
    variable = dislocation_5
    property = dislocation_density
    index = 5
    execute_on = timestep_end
  []
  [slip_incr_5]
    type = MaterialStdVectorAux
    variable = slip_incr_5
    property = constitutive_slip_increment
    index = 5
    execute_on = timestep_end
  []
  [tau_5]
    type = MaterialStdVectorAux
    variable = tau_5
    property = applied_shear_stress
    index = 5
    execute_on = timestep_end
  []
  [gss_6]
    type = MaterialStdVectorAux
    variable = gss_6
    property = slip_resistance
    index = 6
    execute_on = timestep_end
  []
  [dislocation_6]
    type = MaterialStdVectorAux
    variable = dislocation_6
    property = dislocation_density
    index = 6
    execute_on = timestep_end
  []
  [slip_incr_6]
    type = MaterialStdVectorAux
    variable = slip_incr_6
    property = constitutive_slip_increment
    index = 6
    execute_on = timestep_end
  []
  [tau_6]
    type = MaterialStdVectorAux
    variable = tau_6
    property = applied_shear_stress
    index = 6
    execute_on = timestep_end
  []
  [gss_7]
    type = MaterialStdVectorAux
    variable = gss_7
    property = slip_resistance
    index = 7
    execute_on = timestep_end
  []
  [dislocation_7]
    type = MaterialStdVectorAux
    variable = dislocation_7
    property = dislocation_density
    index = 7
    execute_on = timestep_end
  []
  [slip_incr_7]
    type = MaterialStdVectorAux
    variable = slip_incr_7
    property = constitutive_slip_increment
    index = 7
    execute_on = timestep_end
  []
  [tau_7]
    type = MaterialStdVectorAux
    variable = tau_7
    property = applied_shear_stress
    index = 7
    execute_on = timestep_end
  []
  [gss_8]
    type = MaterialStdVectorAux
    variable = gss_8
    property = slip_resistance
    index = 8
    execute_on = timestep_end
  []
  [dislocation_8]
    type = MaterialStdVectorAux
    variable = dislocation_8
    property = dislocation_density
    index = 8
    execute_on = timestep_end
  []
  [slip_incr_8]
    type = MaterialStdVectorAux
    variable = slip_incr_8
    property = constitutive_slip_increment
    index = 8
    execute_on = timestep_end
  []
  [tau_8]
    type = MaterialStdVectorAux
    variable = tau_8
    property = applied_shear_stress
    index = 8
    execute_on = timestep_end
  []
  [gss_9]
    type = MaterialStdVectorAux
    variable = gss_9
    property = slip_resistance
    index = 9
    execute_on = timestep_end
  []
  [dislocation_9]
    type = MaterialStdVectorAux
    variable = dislocation_9
    property = dislocation_density
    index = 9
    execute_on = timestep_end
  []
  [slip_incr_9]
    type = MaterialStdVectorAux
    variable = slip_incr_9
    property = constitutive_slip_increment
    index = 9
    execute_on = timestep_end
  []
  [tau_9]
    type = MaterialStdVectorAux
    variable = tau_9
    property = applied_shear_stress
    index = 9
    execute_on = timestep_end
  []
  [gss_10]
    type = MaterialStdVectorAux
    variable = gss_10
    property = slip_resistance
    index = 10
    execute_on = timestep_end
  []
  [dislocation_10]
    type = MaterialStdVectorAux
    variable = dislocation_10
    property = dislocation_density
    index = 10
    execute_on = timestep_end
  []
  [slip_incr_10]
    type = MaterialStdVectorAux
    variable = slip_incr_10
    property = constitutive_slip_increment
    index = 10
    execute_on = timestep_end
  []
  [tau_10]
    type = MaterialStdVectorAux
    variable = tau_10
    property = applied_shear_stress
    index = 10
    execute_on = timestep_end
  []
  [gss_11]
    type = MaterialStdVectorAux
    variable = gss_11
    property = slip_resistance
    index = 11
    execute_on = timestep_end
  []
  [dislocation_11]
    type = MaterialStdVectorAux
    variable = dislocation_11
    property = dislocation_density
    index = 11
    execute_on = timestep_end
  []
  [slip_incr_11]
    type = MaterialStdVectorAux
    variable = slip_incr_11
    property = constitutive_slip_increment
    index = 11
    execute_on = timestep_end
  []
  [tau_11]
    type = MaterialStdVectorAux
    variable = tau_11
    property = applied_shear_stress
    index = 11
    execute_on = timestep_end
  []
  [gss_12]
    type = MaterialStdVectorAux
    variable = gss_12
    property = slip_resistance
    index = 12
    execute_on = timestep_end
  []
  [dislocation_12]
    type = MaterialStdVectorAux
    variable = dislocation_12
    property = dislocation_density
    index = 12
    execute_on = timestep_end
  []
  [slip_incr_12]
    type = MaterialStdVectorAux
    variable = slip_incr_12
    property = constitutive_slip_increment
    index = 12
    execute_on = timestep_end
  []
  [tau_12]
    type = MaterialStdVectorAux
    variable = tau_12
    property = applied_shear_stress
    index = 12
    execute_on = timestep_end
  []
  [gss_13]
    type = MaterialStdVectorAux
    variable = gss_13
    property = slip_resistance
    index = 13
    execute_on = timestep_end
  []
  [dislocation_13]
    type = MaterialStdVectorAux
    variable = dislocation_13
    property = dislocation_density
    index = 13
    execute_on = timestep_end
  []
  [slip_incr_13]
    type = MaterialStdVectorAux
    variable = slip_incr_13
    property = constitutive_slip_increment
    index = 13
    execute_on = timestep_end
  []
  [tau_13]
    type = MaterialStdVectorAux
    variable = tau_13
    property = applied_shear_stress
    index = 13
    execute_on = timestep_end
  []
  [gss_14]
    type = MaterialStdVectorAux
    variable = gss_14
    property = slip_resistance
    index = 14
    execute_on = timestep_end
  []
  [dislocation_14]
    type = MaterialStdVectorAux
    variable = dislocation_14
    property = dislocation_density
    index = 14
    execute_on = timestep_end
  []
  [slip_incr_14]
    type = MaterialStdVectorAux
    variable = slip_incr_14
    property = constitutive_slip_increment
    index = 14
    execute_on = timestep_end
  []
  [tau_14]
    type = MaterialStdVectorAux
    variable = tau_14
    property = applied_shear_stress
    index = 14
    execute_on = timestep_end
  []
  [gss_15]
    type = MaterialStdVectorAux
    variable = gss_15
    property = slip_resistance
    index = 15
    execute_on = timestep_end
  []
  [dislocation_15]
    type = MaterialStdVectorAux
    variable = dislocation_15
    property = dislocation_density
    index = 15
    execute_on = timestep_end
  []
  [slip_incr_15]
    type = MaterialStdVectorAux
    variable = slip_incr_15
    property = constitutive_slip_increment
    index = 15
    execute_on = timestep_end
  []
  [tau_15]
    type = MaterialStdVectorAux
    variable = tau_15
    property = applied_shear_stress
    index = 15
    execute_on = timestep_end
  []
  [gss_16]
    type = MaterialStdVectorAux
    variable = gss_16
    property = slip_resistance
    index = 16
    execute_on = timestep_end
  []
  [dislocation_16]
    type = MaterialStdVectorAux
    variable = dislocation_16
    property = dislocation_density
    index = 16
    execute_on = timestep_end
  []
  [slip_incr_16]
    type = MaterialStdVectorAux
    variable = slip_incr_16
    property = constitutive_slip_increment
    index = 16
    execute_on = timestep_end
  []
  [tau_16]
    type = MaterialStdVectorAux
    variable = tau_16
    property = applied_shear_stress
    index = 16
    execute_on = timestep_end
  []
  [gss_17]
    type = MaterialStdVectorAux
    variable = gss_17
    property = slip_resistance
    index = 17
    execute_on = timestep_end
  []
  [dislocation_17]
    type = MaterialStdVectorAux
    variable = dislocation_17
    property = dislocation_density
    index = 17
    execute_on = timestep_end
  []
  [slip_incr_17]
    type = MaterialStdVectorAux
    variable = slip_incr_17
    property = constitutive_slip_increment
    index = 17
    execute_on = timestep_end
  []
  [tau_17]
    type = MaterialStdVectorAux
    variable = tau_17
    property = applied_shear_stress
    index = 17
    execute_on = timestep_end
  []
  [gss_18]
    type = MaterialStdVectorAux
    variable = gss_18
    property = slip_resistance
    index = 18
    execute_on = timestep_end
  []
  [dislocation_18]
    type = MaterialStdVectorAux
    variable = dislocation_18
    property = dislocation_density
    index = 18
    execute_on = timestep_end
  []
  [slip_incr_18]
    type = MaterialStdVectorAux
    variable = slip_incr_18
    property = constitutive_slip_increment
    index = 18
    execute_on = timestep_end
  []
  [tau_18]
    type = MaterialStdVectorAux
    variable = tau_18
    property = applied_shear_stress
    index = 18
    execute_on = timestep_end
  []
  [gss_19]
    type = MaterialStdVectorAux
    variable = gss_19
    property = slip_resistance
    index = 19
    execute_on = timestep_end
  []
  [dislocation_19]
    type = MaterialStdVectorAux
    variable = dislocation_19
    property = dislocation_density
    index = 19
    execute_on = timestep_end
  []
  [slip_incr_19]
    type = MaterialStdVectorAux
    variable = slip_incr_19
    property = constitutive_slip_increment
    index = 19
    execute_on = timestep_end
  []
  [tau_19]
    type = MaterialStdVectorAux
    variable = tau_19
    property = applied_shear_stress
    index = 19
    execute_on = timestep_end
  []
  [gss_20]
    type = MaterialStdVectorAux
    variable = gss_20
    property = slip_resistance
    index = 20
    execute_on = timestep_end
  []
  [dislocation_20]
    type = MaterialStdVectorAux
    variable = dislocation_20
    property = dislocation_density
    index = 20
    execute_on = timestep_end
  []
  [slip_incr_20]
    type = MaterialStdVectorAux
    variable = slip_incr_20
    property = constitutive_slip_increment
    index = 20
    execute_on = timestep_end
  []
  [tau_20]
    type = MaterialStdVectorAux
    variable = tau_20
    property = applied_shear_stress
    index = 20
    execute_on = timestep_end
  []
  [gss_21]
    type = MaterialStdVectorAux
    variable = gss_21
    property = slip_resistance
    index = 21
    execute_on = timestep_end
  []
  [dislocation_21]
    type = MaterialStdVectorAux
    variable = dislocation_21
    property = dislocation_density
    index = 21
    execute_on = timestep_end
  []
  [slip_incr_21]
    type = MaterialStdVectorAux
    variable = slip_incr_21
    property = constitutive_slip_increment
    index = 21
    execute_on = timestep_end
  []
  [tau_21]
    type = MaterialStdVectorAux
    variable = tau_21
    property = applied_shear_stress
    index = 21
    execute_on = timestep_end
  []
  [gss_22]
    type = MaterialStdVectorAux
    variable = gss_22
    property = slip_resistance
    index = 22
    execute_on = timestep_end
  []
  [dislocation_22]
    type = MaterialStdVectorAux
    variable = dislocation_22
    property = dislocation_density
    index = 22
    execute_on = timestep_end
  []
  [slip_incr_22]
    type = MaterialStdVectorAux
    variable = slip_incr_22
    property = constitutive_slip_increment
    index = 22
    execute_on = timestep_end
  []
  [tau_22]
    type = MaterialStdVectorAux
    variable = tau_22
    property = applied_shear_stress
    index = 22
    execute_on = timestep_end
  []
  [gss_23]
    type = MaterialStdVectorAux
    variable = gss_23
    property = slip_resistance
    index = 23
    execute_on = timestep_end
  []
  [dislocation_23]
    type = MaterialStdVectorAux
    variable = dislocation_23
    property = dislocation_density
    index = 23
    execute_on = timestep_end
  []
  [slip_incr_23]
    type = MaterialStdVectorAux
    variable = slip_incr_23
    property = constitutive_slip_increment
    index = 23
    execute_on = timestep_end
  []
  [tau_23]
    type = MaterialStdVectorAux
    variable = tau_23
    property = applied_shear_stress
    index = 23
    execute_on = timestep_end
  []
[]

[BCs]
  [fixed_bottom_y]
    type = DirichletBC
    variable = disp_y
    boundary = 'back'
    value = 0.0
  []
  [fixed_bottom_x]
    type = DirichletBC
    variable = disp_x
    boundary = 'back'
    value = 0.0
  []
  [fixed_bottom_z]
    type = DirichletBC
    variable = disp_z
    boundary = 'back'
    value = 0.0
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
    number_slip_systems = 24
    slip_sys_file_name = input_slip_sys_bcc24.txt
    temperature = temperature
    initial_dislocation_density = 5.5e3 #from Brunner 2010  #4.5e8 # roughly David's measurement # 1.0e7 from Srivastava et al (2013)
    burgers_vector = 2.74e-07 # Lim et al (2015) JMPS
    dislocation_multiplication_coefficient = 1
    dipole_annihilation_distance = 2.74e-07 #given in Cereceda et al 2016 as equal to the burgers vector, CHECK THIS AGAIN LATER
    lattice_friction = 12.0 #Lim et al (2015) JMPS, High temperature value
    shear_modulus = 1.600e5 # at 24C, from Lowie and Gonas (1967) J. Applied Physics
    stol = 1.0e-3
    # print_state_variable_convergence_error_messages = true
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
  [gss_12]
    type = ElementAverageValue
    variable = gss_12
  []
  [dislocation_12]
    type = ElementAverageValue
    variable = dislocation_12
  []
  [slip_incr_12]
    type = ElementAverageValue
    variable = slip_incr_12
  []
  [tau_12]
    type = ElementAverageValue
    variable = tau_12
  []
  [gss_13]
    type = ElementAverageValue
    variable = gss_13
  []
  [dislocation_13]
    type = ElementAverageValue
    variable = dislocation_13
  []
  [slip_incr_13]
    type = ElementAverageValue
    variable = slip_incr_13
  []
  [tau_13]
    type = ElementAverageValue
    variable = tau_13
  []
  [gss_14]
    type = ElementAverageValue
    variable = gss_14
  []
  [dislocation_14]
    type = ElementAverageValue
    variable = dislocation_14
  []
  [slip_incr_14]
    type = ElementAverageValue
    variable = slip_incr_14
  []
  [tau_14]
    type = ElementAverageValue
    variable = tau_14
  []
  [gss_15]
    type = ElementAverageValue
    variable = gss_15
  []
  [dislocation_15]
    type = ElementAverageValue
    variable = dislocation_15
  []
  [slip_incr_15]
    type = ElementAverageValue
    variable = slip_incr_15
  []
  [tau_15]
    type = ElementAverageValue
    variable = tau_15
  []
  [gss_16]
    type = ElementAverageValue
    variable = gss_16
  []
  [dislocation_16]
    type = ElementAverageValue
    variable = dislocation_16
  []
  [slip_incr_16]
    type = ElementAverageValue
    variable = slip_incr_16
  []
  [tau_16]
    type = ElementAverageValue
    variable = tau_16
  []
  [gss_17]
    type = ElementAverageValue
    variable = gss_17
  []
  [dislocation_17]
    type = ElementAverageValue
    variable = dislocation_17
  []
  [slip_incr_17]
    type = ElementAverageValue
    variable = slip_incr_17
  []
  [tau_17]
    type = ElementAverageValue
    variable = tau_17
  []
  [gss_18]
    type = ElementAverageValue
    variable = gss_18
  []
  [dislocation_18]
    type = ElementAverageValue
    variable = dislocation_18
  []
  [slip_incr_18]
    type = ElementAverageValue
    variable = slip_incr_18
  []
  [tau_18]
    type = ElementAverageValue
    variable = tau_18
  []
  [gss_19]
    type = ElementAverageValue
    variable = gss_19
  []
  [dislocation_19]
    type = ElementAverageValue
    variable = dislocation_19
  []
  [slip_incr_19]
    type = ElementAverageValue
    variable = slip_incr_19
  []
  [tau_19]
    type = ElementAverageValue
    variable = tau_19
  []
  [gss_20]
    type = ElementAverageValue
    variable = gss_20
  []
  [dislocation_20]
    type = ElementAverageValue
    variable = dislocation_20
  []
  [slip_incr_20]
    type = ElementAverageValue
    variable = slip_incr_20
  []
  [tau_20]
    type = ElementAverageValue
    variable = tau_20
  []
  [gss_21]
    type = ElementAverageValue
    variable = gss_21
  []
  [dislocation_21]
    type = ElementAverageValue
    variable = dislocation_21
  []
  [slip_incr_21]
    type = ElementAverageValue
    variable = slip_incr_21
  []
  [tau_21]
    type = ElementAverageValue
    variable = tau_21
  []
  [gss_22]
    type = ElementAverageValue
    variable = gss_22
  []
  [dislocation_22]
    type = ElementAverageValue
    variable = dislocation_22
  []
  [slip_incr_22]
    type = ElementAverageValue
    variable = slip_incr_22
  []
  [tau_22]
    type = ElementAverageValue
    variable = tau_22
  []
  [gss_23]
    type = ElementAverageValue
    variable = gss_23
  []
  [dislocation_23]
    type = ElementAverageValue
    variable = dislocation_23
  []
  [slip_incr_23]
    type = ElementAverageValue
    variable = slip_incr_23
  []
  [tau_23]
    type = ElementAverageValue
    variable = tau_23
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
  nl_max_its = 15

  dt = 0.025
  dtmin = 1.0e-3
  dtmax = 10.0
  end_time = 250.0 # 120s needed to reach 10% strain
  timestep_tolerance = 1.0e-8
[]

[Outputs]
  exodus = true
  csv = true
  color = false
  # checkpoint = true
  perf_graph = true
[]
