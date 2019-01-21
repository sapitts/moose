[GlobalParams]
  displacements = 'disp_x disp_y disp_z'
[]

[Mesh]
  type = GeneratedMesh
  dim = 3
  elem_type = HEX8
  nx = 6
  xmin = 0
  xmax = 1
  ny = 6
  ymin = 0
  ymax = 1
  nz = 6
  zmin = 0
  zmax = 1
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
  [./xslip_disl_9]
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
  [./xslip_disl_10]
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
  [./xslip_disl_11]
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
  [./tau_23]
    order = CONSTANT
    family = MONOMIAL
  [../]
[]

[Functions]
  [./tdisp]
    type = ParsedFunction
    value = 3.3e-4*t
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
    variable = disp_y
    boundary = bottom
    value = 0
  [../]
  [./symmx]
    type = PresetBC
    variable = disp_x
    boundary = left
    value = 0
  [../]
  [./symmz]
    type = PresetBC
    variable = disp_z
    boundary = back
    value = 0
  [../]
  [./tdisp]
    type = FunctionPresetBC
    variable = disp_x
    boundary = right
    function = tdisp
  [../]
[]

[Materials]
  [./elasticity_tensor]
    type = ComputeElasticityTensorConstantRotationCP
    C_ijkl = '242.0e3 150.0e3 150.0e3 242.0e3 150.0e3 242.0e3 112.0e3 112.0e3 112.0e3'
    fill_method = symmetric9
  [../]
  [./stress]
    type = ComputeCrystalPlasticityStress
    crystal_plasticity_update_model = 'trial_xtalpl'
  [../]
  [./trial_xtalpl]
    type = CrystalPlasticityCDDBCCFeUpdate
    number_slip_systems = 24
    slip_sys_file_name = bcc_24_input_slip_sys.txt
    number_cross_slip_directions = 4
    number_cross_slip_planes = 6
    temperature = 298.0 #25C
    initial_immobile_dislocation_density = 2.5e5 #Lee(2010) pure Fe, Table 1
    initial_mobile_dislocation_density = 2.5e5 #Lee(2010) pure Fe, Table 1
    dislocation_latent_hardening_parameter = 0.2
    alpha_1 = 0.030
    alpha_2 = 0.5
    alpha_3 = 0.002
    alpha_4 = 0.002
    alpha_5 = 0.015
    alpha_6 = 1.0
    Peierls_stress = 15.0 #Alpha-iron is 11MPa
    strain_rate_sensitivity_exponent = 0.015
    shear_modulus = 80.0e3
    apply_anisotropic_strength = false
    stol = 0.1
    cross_slip_calculation_type = stochastic
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
  solve_type = PJFNK

  l_tol = 1e-5
  petsc_options_iname = '-pc_type -pc_asm_overlap -sub_pc_type -ksp_type -ksp_gmres_restart'
  petsc_options_value = ' asm      1              lu            gmres     200'
  nl_abs_tol = 1e-6
  nl_rel_tol = 1e-4

  dtmax = 1.0e-3
  dtmin = 1.0e-6
  dt = 1.0e-3
  end_time = 305.0 ## for 2e-4 rate: 500.0
[]

[Outputs]
  csv = true
  interval = 50
  exodus = false
  perf_graph = true
  [./checkpoint]
    type = Checkpoint
    interval = 50
    num_files = 2
  [../]
[]
