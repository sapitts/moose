#Ni-33CrModel alloy, without defects
[GlobalParams]
  displacements = 'disp_x disp_y disp_z'
[]

[Mesh]
  type = GeneratedMesh
  dim = 3
  elem_type = HEX8
  nx = 2
  xmin = 0
  xmax = 1
  ny = 2
  ymin = 0
  ymax = 1
  nz = 2
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
  [./twin_volume_fraction]
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
  [./twin_shear_increment_0]
   order = CONSTANT
   family = MONOMIAL
  [../]
  [./twin_volume_frac_0]
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
  [./strength_twin_0]
   order = CONSTANT
   family = MONOMIAL
  [../]
  [./twin_tau_0]
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
  [./twin_shear_increment_1]
   order = CONSTANT
   family = MONOMIAL
  [../]
  [./twin_volume_frac_1]
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
  [./strength_twin_1]
   order = CONSTANT
   family = MONOMIAL
  [../]
  [./twin_tau_1]
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
  [./twin_shear_increment_2]
   order = CONSTANT
   family = MONOMIAL
  [../]
  [./twin_volume_frac_2]
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
  [./strength_twin_2]
   order = CONSTANT
   family = MONOMIAL
  [../]
  [./twin_tau_2]
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
  [./twin_shear_increment_3]
   order = CONSTANT
   family = MONOMIAL
  [../]
  [./twin_volume_frac_3]
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
  [./strength_twin_3]
   order = CONSTANT
   family = MONOMIAL
  [../]
  [./twin_tau_3]
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
  [./twin_shear_increment_4]
   order = CONSTANT
   family = MONOMIAL
  [../]
  [./twin_volume_frac_4]
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
  [./strength_twin_4]
   order = CONSTANT
   family = MONOMIAL
  [../]
  [./twin_tau_4]
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
  [./twin_shear_increment_5]
   order = CONSTANT
   family = MONOMIAL
  [../]
  [./twin_volume_frac_5]
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
  [./strength_twin_5]
   order = CONSTANT
   family = MONOMIAL
  [../]
  [./twin_tau_5]
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
  [./twin_shear_increment_6]
   order = CONSTANT
   family = MONOMIAL
  [../]
  [./twin_volume_frac_6]
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
  [./strength_twin_6]
   order = CONSTANT
   family = MONOMIAL
  [../]
  [./twin_tau_6]
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
  [./twin_shear_increment_7]
   order = CONSTANT
   family = MONOMIAL
  [../]
  [./twin_volume_frac_7]
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
  [./strength_twin_7]
   order = CONSTANT
   family = MONOMIAL
  [../]
  [./twin_tau_7]
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
  [./twin_shear_increment_8]
   order = CONSTANT
   family = MONOMIAL
  [../]
  [./twin_volume_frac_8]
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
  [./strength_twin_8]
   order = CONSTANT
   family = MONOMIAL
  [../]
  [./twin_tau_8]
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
  [./twin_shear_increment_9]
   order = CONSTANT
   family = MONOMIAL
  [../]
  [./twin_volume_frac_9]
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
  [./strength_twin_9]
   order = CONSTANT
   family = MONOMIAL
  [../]
  [./twin_tau_9]
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
  [./twin_shear_increment_10]
   order = CONSTANT
   family = MONOMIAL
  [../]
  [./twin_volume_frac_10]
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
  [./strength_twin_10]
   order = CONSTANT
   family = MONOMIAL
  [../]
  [./twin_tau_10]
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
  [./twin_shear_increment_11]
   order = CONSTANT
   family = MONOMIAL
  [../]
  [./twin_volume_frac_11]
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
  [./strength_twin_11]
   order = CONSTANT
   family = MONOMIAL
  [../]
  [./twin_tau_11]
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
  [./twin_volume_fraction]
    type = MaterialRealAux
    property = total_volume_fraction_twins
    variable = twin_volume_fraction
  [../]
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
  [./twin_shear_increment_0]
   type = MaterialStdVectorAux
   variable = twin_shear_increment_0
   property = twin_slip_increment
   index = 0
   execute_on = timestep_end
  [../]
  [./twin_volume_frac_0]
   type = MaterialStdVectorAux
   variable = twin_volume_frac_0
   property = twin_volume_fraction
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
  [./strength_twin_0]
   type = MaterialStdVectorAux
   variable = strength_twin_0
   property = twin_system_resistance
   index = 0
   execute_on = timestep_end
  [../]
  [./twin_tau_0]
   type = MaterialStdVectorAux
   variable = twin_tau_0
   property = applied_shear_stress_twin_system
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
  [./twin_shear_increment_1]
   type = MaterialStdVectorAux
   variable = twin_shear_increment_1
   property = twin_slip_increment
   index = 1
   execute_on = timestep_end
  [../]
  [./twin_volume_frac_1]
   type = MaterialStdVectorAux
   variable = twin_volume_frac_1
   property = twin_volume_fraction
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
  [./strength_twin_1]
   type = MaterialStdVectorAux
   variable = strength_twin_1
   property = twin_system_resistance
   index = 1
   execute_on = timestep_end
  [../]
  [./twin_tau_1]
   type = MaterialStdVectorAux
   variable = twin_tau_1
   property = applied_shear_stress_twin_system
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
  [./twin_shear_increment_2]
   type = MaterialStdVectorAux
   variable = twin_shear_increment_2
   property = twin_slip_increment
   index = 2
   execute_on = timestep_end
  [../]
  [./twin_volume_frac_2]
   type = MaterialStdVectorAux
   variable = twin_volume_frac_2
   property = twin_volume_fraction
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
  [./strength_twin_2]
   type = MaterialStdVectorAux
   variable = strength_twin_2
   property = twin_system_resistance
   index = 2
   execute_on = timestep_end
  [../]
  [./twin_tau_2]
   type = MaterialStdVectorAux
   variable = twin_tau_2
   property = applied_shear_stress_twin_system
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
  [./twin_shear_increment_3]
   type = MaterialStdVectorAux
   variable = twin_shear_increment_3
   property = twin_slip_increment
   index = 3
   execute_on = timestep_end
  [../]
  [./twin_volume_frac_3]
   type = MaterialStdVectorAux
   variable = twin_volume_frac_3
   property = twin_volume_fraction
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
  [./strength_twin_3]
   type = MaterialStdVectorAux
   variable = strength_twin_3
   property = twin_system_resistance
   index = 3
   execute_on = timestep_end
  [../]
  [./twin_tau_3]
   type = MaterialStdVectorAux
   variable = twin_tau_3
   property = applied_shear_stress_twin_system
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
  [./twin_shear_increment_4]
   type = MaterialStdVectorAux
   variable = twin_shear_increment_4
   property = twin_slip_increment
   index = 4
   execute_on = timestep_end
  [../]
  [./twin_volume_frac_4]
   type = MaterialStdVectorAux
   variable = twin_volume_frac_4
   property = twin_volume_fraction
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
  [./strength_twin_4]
   type = MaterialStdVectorAux
   variable = strength_twin_4
   property = twin_system_resistance
   index = 4
   execute_on = timestep_end
  [../]
  [./twin_tau_4]
   type = MaterialStdVectorAux
   variable = twin_tau_4
   property = applied_shear_stress_twin_system
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
  [./twin_shear_increment_5]
   type = MaterialStdVectorAux
   variable = twin_shear_increment_5
   property = twin_slip_increment
   index = 5
   execute_on = timestep_end
  [../]
  [./twin_volume_frac_5]
   type = MaterialStdVectorAux
   variable = twin_volume_frac_5
   property = twin_volume_fraction
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
  [./strength_twin_5]
   type = MaterialStdVectorAux
   variable = strength_twin_5
   property = twin_system_resistance
   index = 5
   execute_on = timestep_end
  [../]
  [./twin_tau_5]
   type = MaterialStdVectorAux
   variable = twin_tau_5
   property = applied_shear_stress_twin_system
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
  [./twin_shear_increment_6]
   type = MaterialStdVectorAux
   variable = twin_shear_increment_6
   property = twin_slip_increment
   index = 6
   execute_on = timestep_end
  [../]
  [./twin_volume_frac_6]
   type = MaterialStdVectorAux
   variable = twin_volume_frac_6
   property = twin_volume_fraction
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
  [./strength_twin_6]
   type = MaterialStdVectorAux
   variable = strength_twin_6
   property = twin_system_resistance
   index = 6
   execute_on = timestep_end
  [../]
  [./twin_tau_6]
   type = MaterialStdVectorAux
   variable = twin_tau_6
   property = applied_shear_stress_twin_system
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
  [./twin_shear_increment_7]
   type = MaterialStdVectorAux
   variable = twin_shear_increment_7
   property = twin_slip_increment
   index = 7
   execute_on = timestep_end
  [../]
  [./twin_volume_frac_7]
   type = MaterialStdVectorAux
   variable = twin_volume_frac_7
   property = twin_volume_fraction
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
  [./strength_twin_7]
   type = MaterialStdVectorAux
   variable = strength_twin_7
   property = twin_system_resistance
   index = 7
   execute_on = timestep_end
  [../]
  [./twin_tau_7]
   type = MaterialStdVectorAux
   variable = twin_tau_7
   property = applied_shear_stress_twin_system
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
  [./twin_shear_increment_8]
   type = MaterialStdVectorAux
   variable = twin_shear_increment_8
   property = twin_slip_increment
   index = 8
   execute_on = timestep_end
  [../]
  [./twin_volume_frac_8]
   type = MaterialStdVectorAux
   variable = twin_volume_frac_8
   property = twin_volume_fraction
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
  [./strength_twin_8]
   type = MaterialStdVectorAux
   variable = strength_twin_8
   property = twin_system_resistance
   index = 8
   execute_on = timestep_end
  [../]
  [./twin_tau_8]
   type = MaterialStdVectorAux
   variable = twin_tau_8
   property = applied_shear_stress_twin_system
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
  [./twin_shear_increment_9]
   type = MaterialStdVectorAux
   variable = twin_shear_increment_9
   property = twin_slip_increment
   index = 9
   execute_on = timestep_end
  [../]
  [./twin_volume_frac_9]
   type = MaterialStdVectorAux
   variable = twin_volume_frac_9
   property = twin_volume_fraction
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
  [./strength_twin_9]
   type = MaterialStdVectorAux
   variable = strength_twin_9
   property = twin_system_resistance
   index = 9
   execute_on = timestep_end
  [../]
  [./twin_tau_9]
   type = MaterialStdVectorAux
   variable = twin_tau_9
   property = applied_shear_stress_twin_system
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
  [./twin_shear_increment_10]
   type = MaterialStdVectorAux
   variable = twin_shear_increment_10
   property = twin_slip_increment
   index = 10
   execute_on = timestep_end
  [../]
  [./twin_volume_frac_10]
   type = MaterialStdVectorAux
   variable = twin_volume_frac_10
   property = twin_volume_fraction
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
  [./strength_twin_10]
   type = MaterialStdVectorAux
   variable = strength_twin_10
   property = twin_system_resistance
   index = 10
   execute_on = timestep_end
  [../]
  [./twin_tau_10]
   type = MaterialStdVectorAux
   variable = twin_tau_10
   property = applied_shear_stress_twin_system
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
  [./twin_shear_increment_11]
   type = MaterialStdVectorAux
   variable = twin_shear_increment_11
   property = twin_slip_increment
   index = 11
   execute_on = timestep_end
  [../]
  [./twin_volume_frac_11]
   type = MaterialStdVectorAux
   variable = twin_volume_frac_11
   property = twin_volume_fraction
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
  [./strength_twin_11]
   type = MaterialStdVectorAux
   variable = strength_twin_11
   property = twin_system_resistance
   index = 11
   execute_on = timestep_end
  [../]
  [./twin_tau_11]
   type = MaterialStdVectorAux
   variable = twin_tau_11
   property = applied_shear_stress_twin_system
   index = 11
   execute_on = timestep_end
  [../]
[]

[BCs]
  [./fixed_bot_z]
    type = PresetBC
    variable = disp_z
    boundary = back
    value = 0
  [../]
  [./fixed_bot_x]
    type = PresetBC
    variable = disp_x
    boundary = left
    value = 0
  [../]
  [./fixed_bot_y]
    type = PresetBC
    variable = disp_y
    boundary = bottom
    value = 0
  [../]
  [./tdisp]
    type = FunctionPresetBC
    variable = disp_x
    boundary = right
    function = '-1.0e-3*t'
  [../]
[]

[Materials]
  [./elasticity_tensor]
    type = ComputeElasticityTensorConstantRotationCP
    C_ijkl = '332.365e3 186.817e3 186.817e3 332.365e3 186.817e3 332.365e3 72.773e3 72.773e3 72.773e3' #Values for 298K, Blaizot et.al. 2016
    fill_method = symmetric9
    euler_angle_1 = 0
    euler_angle_2 = 45.0
    euler_angle_3 = 0
  [../]
  [./stress]
    type = ComputeCrystalPlasticityStress
    crystal_plasticity_update_model = 'trial_xtalpl'
  [../]
  [./trial_xtalpl]
    type = CrystalPlasticityCDDNiAlloyUpdate
    number_slip_systems = 12
    slip_sys_file_name = fcc_input_slip_sys.txt
    number_twin_systems = 12
    twin_system_file_name = fcc_input_twinning_systems.txt
    upper_limit_twin_volume_fraction = 0.8
    number_cross_slip_directions = 0 #6
    number_cross_slip_planes = 0 #2
    cross_slip_calculation_type = stochastic
    temperature = 298.0
    initial_immobile_dislocation_density = 7.5e7 #1.5e7 initial dislocation density in Blaizot et.al. 2016;
    initial_mobile_dislocation_density = 7.5e7 #1.5e7 initial dislocation density in Blaizot et.al. 2016;
    Baily_Hirsch_barrier_coefficient = 0.4
    dislocation_self_hardening_parameter = 1
    dislocation_latent_hardening_parameter = 1.0
    Peierls_stress = 3.639 #0.5e-4 times shear modulus
    coefficient_twin_resistance = 1.0
    coefficient_twin_hardening = 1.0
    shear_modulus = 72.773e3
    burgers_vector = 2.52e-7
    tertiary_precipitate_mean_diameter = 0.0 #2.50e-6 #Gwalani et al. (2016) Table 2, 8000 hrs aged
    tertiary_precipitate_volume_fraction = 0.0 #0.033 #Gwalani et al. (2016) Table 2, 8000 hrs aged
    orowan_bowing_hardening_coefficient = 0.0 #0.05
    tertiary_apb_shearing_coefficient = 0.0 #0.95
    stol = 0.01
    zero_tol = 1e-8
    # slip_increment_tolerance = 1.0e-3 ## Seems to be too restrictive
    maximum_substep_iteration = 2 # is 10 for BCC
    maxiter = 30
    maxiter_state_variable = 30
    line_search_method = CUT_HALF
    use_line_search = false # was using true
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
  [./twin_volume_fraction]
    type = ElementAverageValue
    variable = twin_volume_fraction
  [../]
  [./gss_0]
    type = ElementAverageValue
    variable = gss_0
  [../]
  [./mobile_disl_0]
    type = ElementAverageValue
    variable = mobile_disl_0
  [../]
  [./twin_slip_increment_0]
   type = ElementAverageValue
   variable = twin_shear_increment_0
  [../]
  [./twin_volume_frac_0]
    type = ElementAverageValue
    variable = twin_volume_frac_0
  [../]
  [./immobile_disl_0]
    type = ElementAverageValue
    variable = immobile_disl_0
  [../]
  [./tau_0]
   type = ElementAverageValue
   variable = tau_0
  [../]
  [./strength_twin_0]
   type = ElementAverageValue
   variable = strength_twin_0
  [../]
  [./twin_tau_0]
   type = ElementAverageValue
   variable = twin_tau_0
  [../]
  [./gss_1]
    type = ElementAverageValue
    variable = gss_1
  [../]
  [./mobile_disl_1]
    type = ElementAverageValue
    variable = mobile_disl_1
  [../]
  [./twin_slip_increment_1]
   type = ElementAverageValue
   variable = twin_shear_increment_1
  [../]
  [./twin_volume_frac_1]
    type = ElementAverageValue
    variable = twin_volume_frac_1
  [../]
  [./immobile_disl_1]
    type = ElementAverageValue
    variable = immobile_disl_1
  [../]
  [./tau_1]
   type = ElementAverageValue
   variable = tau_1
  [../]
  [./strength_twin_1]
   type = ElementAverageValue
   variable = strength_twin_1
  [../]
  [./twin_tau_1]
   type = ElementAverageValue
   variable = twin_tau_1
  [../]
  [./gss_2]
    type = ElementAverageValue
    variable = gss_2
  [../]
  [./mobile_disl_2]
    type = ElementAverageValue
    variable = mobile_disl_2
  [../]
  [./twin_slip_increment_2]
   type = ElementAverageValue
   variable = twin_shear_increment_2
  [../]
  [./twin_volume_frac_2]
    type = ElementAverageValue
    variable = twin_volume_frac_2
  [../]
  [./immobile_disl_2]
    type = ElementAverageValue
    variable = immobile_disl_2
  [../]
  [./tau_2]
   type = ElementAverageValue
   variable = tau_2
  [../]
  [./strength_twin_2]
   type = ElementAverageValue
   variable = strength_twin_2
  [../]
  [./twin_tau_2]
   type = ElementAverageValue
   variable = twin_tau_2
  [../]
  [./gss_3]
    type = ElementAverageValue
    variable = gss_3
  [../]
  [./mobile_disl_3]
    type = ElementAverageValue
    variable = mobile_disl_3
  [../]
  [./twin_slip_increment_3]
   type = ElementAverageValue
   variable = twin_shear_increment_3
  [../]
  [./twin_volume_frac_3]
    type = ElementAverageValue
    variable = twin_volume_frac_3
  [../]
  [./immobile_disl_3]
    type = ElementAverageValue
    variable = immobile_disl_3
  [../]
  [./tau_3]
   type = ElementAverageValue
   variable = tau_3
  [../]
  [./strength_twin_3]
   type = ElementAverageValue
   variable = strength_twin_3
  [../]
  [./twin_tau_3]
   type = ElementAverageValue
   variable = twin_tau_3
  [../]
  [./gss_4]
    type = ElementAverageValue
    variable = gss_4
  [../]
  [./mobile_disl_4]
    type = ElementAverageValue
    variable = mobile_disl_4
  [../]
  [./twin_slip_increment_4]
   type = ElementAverageValue
   variable = twin_shear_increment_4
  [../]
  [./twin_volume_frac_4]
    type = ElementAverageValue
    variable = twin_volume_frac_4
  [../]
  [./immobile_disl_4]
    type = ElementAverageValue
    variable = immobile_disl_4
  [../]
  [./tau_4]
   type = ElementAverageValue
   variable = tau_4
  [../]
  [./strength_twin_4]
   type = ElementAverageValue
   variable = strength_twin_4
  [../]
  [./twin_tau_4]
   type = ElementAverageValue
   variable = twin_tau_4
  [../]
  [./gss_5]
    type = ElementAverageValue
    variable = gss_5
  [../]
  [./mobile_disl_5]
    type = ElementAverageValue
    variable = mobile_disl_5
  [../]
  [./twin_slip_increment_5]
   type = ElementAverageValue
   variable = twin_shear_increment_5
  [../]
  [./twin_volume_frac_5]
    type = ElementAverageValue
    variable = twin_volume_frac_5
  [../]
  [./immobile_disl_5]
    type = ElementAverageValue
    variable = immobile_disl_5
  [../]
  [./tau_5]
   type = ElementAverageValue
   variable = tau_5
  [../]
  [./strength_twin_5]
   type = ElementAverageValue
   variable = strength_twin_5
  [../]
  [./twin_tau_5]
   type = ElementAverageValue
   variable = twin_tau_5
  [../]
  [./gss_6]
    type = ElementAverageValue
    variable = gss_6
  [../]
  [./mobile_disl_6]
    type = ElementAverageValue
    variable = mobile_disl_6
  [../]
  [./twin_slip_increment_6]
   type = ElementAverageValue
   variable = twin_shear_increment_6
  [../]
  [./twin_volume_frac_6]
    type = ElementAverageValue
    variable = twin_volume_frac_6
  [../]
  [./immobile_disl_6]
    type = ElementAverageValue
    variable = immobile_disl_6
  [../]
  [./tau_6]
   type = ElementAverageValue
   variable = tau_6
  [../]
  [./strength_twin_6]
   type = ElementAverageValue
   variable = strength_twin_6
  [../]
  [./twin_tau_6]
   type = ElementAverageValue
   variable = twin_tau_6
  [../]
  [./gss_7]
    type = ElementAverageValue
    variable = gss_7
  [../]
  [./mobile_disl_7]
    type = ElementAverageValue
    variable = mobile_disl_7
  [../]
  [./twin_slip_increment_7]
   type = ElementAverageValue
   variable = twin_shear_increment_7
  [../]
  [./twin_volume_frac_7]
    type = ElementAverageValue
    variable = twin_volume_frac_7
  [../]
  [./immobile_disl_7]
    type = ElementAverageValue
    variable = immobile_disl_7
  [../]
  [./tau_7]
   type = ElementAverageValue
   variable = tau_7
  [../]
  [./strength_twin_7]
   type = ElementAverageValue
   variable = strength_twin_7
  [../]
  [./twin_tau_7]
   type = ElementAverageValue
   variable = twin_tau_7
  [../]
  [./gss_8]
    type = ElementAverageValue
    variable = gss_8
  [../]
  [./mobile_disl_8]
    type = ElementAverageValue
    variable = mobile_disl_8
  [../]
  [./twin_slip_increment_8]
   type = ElementAverageValue
   variable = twin_shear_increment_8
  [../]
  [./twin_volume_frac_8]
    type = ElementAverageValue
    variable = twin_volume_frac_8
  [../]
  [./immobile_disl_8]
    type = ElementAverageValue
    variable = immobile_disl_8
  [../]
  [./tau_8]
   type = ElementAverageValue
   variable = tau_8
  [../]
  [./strength_twin_8]
   type = ElementAverageValue
   variable = strength_twin_8
  [../]
  [./twin_tau_8]
   type = ElementAverageValue
   variable = twin_tau_8
  [../]
  [./gss_9]
    type = ElementAverageValue
    variable = gss_9
  [../]
  [./mobile_disl_9]
    type = ElementAverageValue
    variable = mobile_disl_9
  [../]
  [./twin_slip_increment_9]
   type = ElementAverageValue
   variable = twin_shear_increment_9
  [../]
  [./twin_volume_frac_9]
    type = ElementAverageValue
    variable = twin_volume_frac_9
  [../]
  [./immobile_disl_9]
    type = ElementAverageValue
    variable = immobile_disl_9
  [../]
  [./tau_9]
   type = ElementAverageValue
   variable = tau_9
  [../]
  [./strength_twin_9]
   type = ElementAverageValue
   variable = strength_twin_9
  [../]
  [./twin_tau_9]
   type = ElementAverageValue
   variable = twin_tau_9
  [../]
  [./gss_10]
    type = ElementAverageValue
    variable = gss_10
  [../]
  [./mobile_disl_10]
    type = ElementAverageValue
    variable = mobile_disl_10
  [../]
  [./twin_slip_increment_10]
   type = ElementAverageValue
   variable = twin_shear_increment_10
  [../]
  [./twin_volume_frac_10]
    type = ElementAverageValue
    variable = twin_volume_frac_10
  [../]
  [./immobile_disl_10]
    type = ElementAverageValue
    variable = immobile_disl_10
  [../]
  [./tau_10]
   type = ElementAverageValue
   variable = tau_10
  [../]
  [./strength_twin_10]
   type = ElementAverageValue
   variable = strength_twin_10
  [../]
  [./twin_tau_10]
   type = ElementAverageValue
   variable = twin_tau_10
  [../]
  [./gss_11]
    type = ElementAverageValue
    variable = gss_11
  [../]
  [./mobile_disl_11]
    type = ElementAverageValue
    variable = mobile_disl_11
  [../]
  [./twin_slip_increment_11]
   type = ElementAverageValue
   variable = twin_shear_increment_11
  [../]
  [./twin_volume_frac_11]
    type = ElementAverageValue
    variable = twin_volume_frac_11
  [../]
  [./immobile_disl_11]
    type = ElementAverageValue
    variable = immobile_disl_11
  [../]
  [./tau_11]
   type = ElementAverageValue
   variable = tau_11
  [../]
  [./strength_twin_11]
   type = ElementAverageValue
   variable = strength_twin_11
  [../]
  [./twin_tau_11]
   type = ElementAverageValue
   variable = twin_tau_11
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
  petsc_options_iname = '-pc_type -pc_asm_overlap -sub_pc_type -ksp_type -ksp_gmres_restart'
  petsc_options_value = ' asm      1              lu            gmres     200'
  nl_abs_tol = 1e-6
  nl_rel_tol = 1e-4

  dtmax = 1.0e-3
  dtmin = 1.0e-12
  dt = 1.0e-3
  end_time = 100

  [./Predictor]
    type = SimplePredictor
    scale = 1.0
    skip_times_old = '0.0'
  [../]
[]

[Outputs]
  csv = true
  file_base = cdd_100load_compression_ni33cr_with_twins_1e0coeff_magnitude_compare_against_zerostress_out
  interval = 1
  exodus = true
  [pgraph]
    type = PerfGraphOutput
    execute_on = 'initial final'  # Default is "final"
    level = 3                     # Default is 1
  []
[]