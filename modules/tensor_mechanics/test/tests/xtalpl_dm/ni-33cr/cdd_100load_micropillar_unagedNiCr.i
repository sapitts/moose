#Ni-33CrModel alloy, without defects
[GlobalParams]
  displacements = 'disp_x disp_y disp_z'
[]

[Mesh]
  type = FileMesh
  file = micropillar_compression.e
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
[]

[Functions]
  [./tdisp]
    type = ParsedFunction
    value = (-1.0e-4)/3.0*t
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
[]

[BCs]
  [./roller_bot_x]
    type = PresetBC
    variable = disp_x
    boundary = substrate-bottom
    value = 0
  [../]
  [./fixed_center_pt_y]
    type = PresetBC
    variable = disp_y
    boundary = floor-center-node
    value = 0
  [../]
  [./fixed_center_pt_z]
    type = PresetBC
    variable = disp_z
    boundary = floor-center-node
    value = 0
  [../]
  [./tdisp]
    type = FunctionPresetBC
    variable = disp_x
    boundary = pillar-top
    function = tdisp
  [../]
[]

[Materials]
  [./elasticity_tensor]
    type = ComputeElasticityTensorConstantRotationCP
    C_ijkl = '332.365e3 186.817e3 186.817e3 332.365e3 186.817e3 332.365e3 72.773e3 72.773e3 72.773e3' #Values for 298K, Blaizot et.al. 2016
    fill_method = symmetric9
  [../]
  [./stress]
    type = ComputeCrystalPlasticityStress
    crystal_plasticity_update_model = 'trial_xtalpl'
  [../]
  [./trial_xtalpl]
    type = CrystalPlasticityCDDNiAlloyUpdate
    number_slip_systems = 12
    slip_sys_file_name = input_slip_sys.txt
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
    shear_modulus = 72.773e3
    burgers_vector = 2.52e-7
    tertiary_precipitate_mean_diameter = 0.0 #2.50e-6 #Gwalani et al. (2016) Table 2, 8000 hrs aged
    tertiary_precipitate_volume_fraction = 0.0 #0.033 #Gwalani et al. (2016) Table 2, 8000 hrs aged
    orowan_bowing_hardening_coefficient = 0.0 #0.05
    tertiary_apb_shearing_coefficient = 0.0 #0.95
    stol = 1.0e-3
    # slip_increment_tolerance = 1.0e-3 ## Seems to be too restrictive
    maximum_substep_iteration = 10 # is 10 for BCC
    maxiter = 30
    maxiter_state_variable = 30
    line_search_method = CUT_HALF
    use_line_search = false # was using true
    tan_mod_type = exact
  [../]
[]

[Postprocessors]
  [./stress_zz_pillar]
    type = ElementAverageValue
    variable = stress_zz
    block = pillar
  [../]
  [./stress_zz_substrate]
    type = ElementAverageValue
    variable = stress_zz
    block = substrate
  [../]
  [./pk2_zz_pillar]
    type = ElementAverageValue
    variable = pk2_zz
    block = pillar
  [../]
  [./pk2_zz_substrate]
    type = ElementAverageValue
    variable = pk2_zz
    block = substrate
  [../]
  [./fp_zz_pillar]
    type = ElementAverageValue
    variable = fp_zz
    block = pillar
  [../]
  [./fp_zz_substrate]
    type = ElementAverageValue
    variable = fp_zz
    block = substrate
  [../]
  [./e_zz_pillar]
    type = ElementAverageValue
    variable = e_zz
    block = pillar
  [../]
  [./e_zz_substrate]
    type = ElementAverageValue
    variable = e_zz
    block = substrate
  [../]
  [./stress_xx_pillar]
    type = ElementAverageValue
    variable = stress_xx
    block = pillar
  [../]
  [./stress_xx_substrate]
    type = ElementAverageValue
    variable = stress_xx
    block = substrate
  [../]
  [./pk2_xx_pillar]
    type = ElementAverageValue
    variable = pk2_xx
    block = pillar
  [../]
  [./pk2_xx_substrate]
    type = ElementAverageValue
    variable = pk2_xx
    block = substrate
  [../]
  [./pk2_xx_total]
    type = ElementAverageValue
    variable = pk2_xx
  [../]
  [./fp_xx_pillar]
    type = ElementAverageValue
    variable = fp_xx
    block = pillar
  [../]
  [./fp_xx_substrate]
    type = ElementAverageValue
    variable = fp_xx
    block = substrate
  [../]
  [./e_xx_pillar]
    type = ElementAverageValue
    variable = e_xx
    block = pillar
  [../]
  [./e_xx_substrate]
    type = ElementAverageValue
    variable = e_xx
    block = substrate
  [../]
  [./e_xx_total]
    type = ElementAverageValue
    variable = e_xx
  [../]
  [./stress_yy_pillar]
    type = ElementAverageValue
    variable = stress_yy
    block = pillar
  [../]
  [./stress_yy_substrate]
    type = ElementAverageValue
    variable = stress_yy
    block = substrate
  [../]
  [./pk2_yy_pillar]
    type = ElementAverageValue
    variable = pk2_yy
    block = pillar
  [../]
  [./pk2_yy_substrate]
    type = ElementAverageValue
    variable = pk2_yy
    block = substrate
  [../]
  [./fp_yy_pillar]
    type = ElementAverageValue
    variable = fp_yy
    block = pillar
  [../]
  [./fp_yy_substrate]
    type = ElementAverageValue
    variable = fp_yy
    block = substrate
  [../]
  [./e_yy]
    type = ElementAverageValue
    variable = e_yy
    block = pillar
  [../]
  [./e_yy_substrate]
    type = ElementAverageValue
    variable = e_yy
    block = substrate
  [../]
  [./vonmises_stress_cauchy_pillar]
    type = ElementAverageValue
    variable = vonmises_stress_cauchy
    block = pillar
  [../]
  [./vonmises_stress_cauchy_substrate]
    type = ElementAverageValue
    variable = vonmises_stress_cauchy
    block = substrate
  [../]
  [./vonmises_stress_cauchy_total]
    type = ElementAverageValue
    variable = vonmises_stress_cauchy
  [../]
  [./effective_strain_green_pillar]
    type = ElementAverageValue
    variable = eff_strain_green
    block = pillar
  [../]
  [./effective_strain_green_substrate]
    type = ElementAverageValue
    variable = eff_strain_green
    block = substrate
  [../]
  [./effective_strain_green_total]
    type = ElementAverageValue
    variable = eff_strain_green
  [../]
  [./vonmises_stress_pk2_pillar]
    type = ElementAverageValue
    variable = vonmises_stress_pk2
    block = pillar
  [../]
  [./vonmises_stress_pk2_substrate]
    type = ElementAverageValue
    variable = vonmises_stress_pk2
    block = substrate
  [../]
  [./vonmises_stress_pk2_total]
    type = ElementAverageValue
    variable = vonmises_stress_pk2
  [../]
  [./effective_strain_pillar]
    type = ElementAverageValue
    variable = eff_strain_lag
    block = pillar
  [../]
  [./effective_strain_substrate]
    type = ElementAverageValue
    variable = eff_strain_lag
    block = substrate
  [../]
  [./effective_strain_total]
    type = ElementAverageValue
    variable = eff_strain_lag
  [../]
  [./gss_0_pillar]
    type = ElementAverageValue
    variable = gss_0
    block = pillar
  [../]
  [./gss_0_substrate]
    type = ElementAverageValue
    variable = gss_0
    block = substrate
  [../]
  [./mobile_disl_0_pillar]
    type = ElementAverageValue
    variable = mobile_disl_0
    block = pillar
  [../]
  [./mobile_disl_0_substrate]
    type = ElementAverageValue
    variable = mobile_disl_0
    block = substrate
  [../]
  # [./cross_slip_disl_0]
  #  type = ElementAverageValue
  #  variable = xslip_disl_0
  # [../]
  [./immobile_disl_0_pillar]
    type = ElementAverageValue
    variable = immobile_disl_0
    block = pillar
  [../]
  [./immobile_disl_0_substrate]
    type = ElementAverageValue
    variable = immobile_disl_0
    block = substrate
  [../]
  [./tau_0_pillar]
   type = ElementAverageValue
   variable = tau_0
   block = pillar
  [../]
  [./tau_0_substrate]
   type = ElementAverageValue
   variable = tau_0
   block = substrate
  [../]
  [./gss_1_pillar]
    type = ElementAverageValue
    variable = gss_1
    block = pillar
  [../]
  [./gss_1_substrate]
    type = ElementAverageValue
    variable = gss_1
    block = substrate
  [../]
  [./mobile_disl_1_pillar]
    type = ElementAverageValue
    variable = mobile_disl_1
    block = pillar
  [../]
  [./mobile_disl_1_substrate]
    type = ElementAverageValue
    variable = mobile_disl_1
    block = substrate
  [../]
  # [./cross_slip_disl_1]
  #  type = ElementAverageValue
  #  variable = xslip_disl_1
  # [../]
  [./immobile_disl_1_pillar]
    type = ElementAverageValue
    variable = immobile_disl_1
    block = pillar
  [../]
  [./immobile_disl_1_substrate]
    type = ElementAverageValue
    variable = immobile_disl_1
    block = substrate
  [../]
  [./tau_1_pillar]
   type = ElementAverageValue
   variable = tau_1
   block = pillar
  [../]
  [./tau_1_substrate]
   type = ElementAverageValue
   variable = tau_1
   block = substrate
  [../]
  [./gss_2_pillar]
    type = ElementAverageValue
    variable = gss_2
    block = pillar
  [../]
  [./gss_2_substrate]
    type = ElementAverageValue
    variable = gss_2
    block = substrate
  [../]
  [./mobile_disl_2_pillar]
    type = ElementAverageValue
    variable = mobile_disl_2
    block = pillar
  [../]
  [./mobile_disl_2_substrate]
    type = ElementAverageValue
    variable = mobile_disl_2
    block = substrate
  [../]
  # [./cross_slip_disl_2]
  #  type = ElementAverageValue
  #  variable = xslip_disl_2
  # [../]
  [./immobile_disl_2_pillar]
    type = ElementAverageValue
    variable = immobile_disl_2
    block = pillar
  [../]
  [./immobile_disl_2_substrate]
    type = ElementAverageValue
    variable = immobile_disl_2
    block = substrate
  [../]
  [./tau_2]
    type = ElementAverageValue
    variable = tau_2
    block = pillar
  [../]
  [./tau_2_substrate]
    type = ElementAverageValue
    variable = tau_2
    block = substrate
  [../]
  [./gss_3_pillar]
    type = ElementAverageValue
    variable = gss_3
    block = pillar
  [../]
  [./gss_3_substrate]
    type = ElementAverageValue
    variable = gss_3
    block = substrate
  [../]
  [./mobile_disl_3_pillar]
    type = ElementAverageValue
    variable = mobile_disl_3
    block = pillar
  [../]
  [./mobile_disl_3_substrate]
    type = ElementAverageValue
    variable = mobile_disl_3
    block = substrate
  [../]
  # [./cross_slip_disl_3]
  #  type = ElementAverageValue
  #  variable = xslip_disl_3
  # [../]
  [./immobile_disl_3_pillar]
    type = ElementAverageValue
    variable = immobile_disl_3
    block = pillar
  [../]
  [./immobile_disl_3_substrate]
    type = ElementAverageValue
    variable = immobile_disl_3
    block = substrate
  [../]
  [./tau_3_pillar]
   type = ElementAverageValue
   variable = tau_3
   block = pillar
  [../]
  [./tau_3_substrate]
   type = ElementAverageValue
   variable = tau_3
   block = substrate
  [../]
  [./gss_4_pillar]
    type = ElementAverageValue
    variable = gss_4
    block = pillar
  [../]
  [./gss_4_substrate]
    type = ElementAverageValue
    variable = gss_4
    block = substrate
  [../]
  [./mobile_disl_4_pillar]
    type = ElementAverageValue
    variable = mobile_disl_4
    block = pillar
  [../]
  [./mobile_disl_4_substrate]
    type = ElementAverageValue
    variable = mobile_disl_4
    block = substrate
  [../]
  # [./cross_slip_disl_4]
  #  type = ElementAverageValue
  #  variable = xslip_disl_4
  # [../]
  [./immobile_disl_4_pillar]
    type = ElementAverageValue
    variable = immobile_disl_4
    block = pillar
  [../]
  [./immobile_disl_4_substrate]
    type = ElementAverageValue
    variable = immobile_disl_4
    block = substrate
  [../]
  [./tau_4_pillar]
    type = ElementAverageValue
    variable = tau_4
    block = pillar
  [../]
  [./tau_4_substrate]
    type = ElementAverageValue
    variable = tau_4
    block = substrate
  [../]
  [./gss_5_pillar]
    type = ElementAverageValue
    variable = gss_5
    block = pillar
  [../]
  [./gss_5_substrate]
    type = ElementAverageValue
    variable = gss_5
    block = substrate
  [../]
  [./mobile_disl_5_pillar]
    type = ElementAverageValue
    variable = mobile_disl_5
    block = pillar
  [../]
  [./mobile_disl_5_substrate]
    type = ElementAverageValue
    variable = mobile_disl_5
    block = substrate
  [../]
  # [./cross_slip_disl_5]
  #  type = ElementAverageValue
  #  variable = xslip_disl_5
  # [../]
  [./immobile_disl_5_pillar]
    type = ElementAverageValue
    variable = immobile_disl_5
    block = pillar
  [../]
  [./immobile_disl_5_substrate]
    type = ElementAverageValue
    variable = immobile_disl_5
    block = substrate
  [../]
  [./tau_5_pillar]
    type = ElementAverageValue
    variable = tau_5
    block = pillar
  [../]
  [./tau_5_substrate]
    type = ElementAverageValue
    variable = tau_5
    block = substrate
  [../]
  [./gss_6_pillar]
    type = ElementAverageValue
    variable = gss_6
    block = pillar
  [../]
  [./gss_6_substrate]
    type = ElementAverageValue
    variable = gss_6
    block = substrate
  [../]
  [./mobile_disl_6_pillar]
    type = ElementAverageValue
    variable = mobile_disl_6
    block = pillar
  [../]
  [./mobile_disl_6_substrate]
    type = ElementAverageValue
    variable = mobile_disl_6
    block = substrate
  [../]
  # [./cross_slip_disl_6]
  #  type = ElementAverageValue
  #  variable = xslip_disl_6
  # [../]
  [./immobile_disl_6_pillar]
    type = ElementAverageValue
    variable = immobile_disl_6
    block = pillar
  [../]
  [./immobile_disl_6_substrate]
    type = ElementAverageValue
    variable = immobile_disl_6
    block = substrate
  [../]
  [./tau_6_pillar]
   type = ElementAverageValue
    variable = tau_6
    block = pillar
  [../]
  [./tau_6_substrate]
   type = ElementAverageValue
    variable = tau_6
    block = substrate
  [../]
  [./gss_7_pillar]
    type = ElementAverageValue
    variable = gss_7
    block = pillar
  [../]
  [./gss_7_substrate]
    type = ElementAverageValue
    variable = gss_7
    block = substrate
  [../]
  [./mobile_disl_7_pillar]
    type = ElementAverageValue
    variable = mobile_disl_7
    block = pillar
  [../]
  [./mobile_disl_7_substrate]
    type = ElementAverageValue
    variable = mobile_disl_7
    block = substrate
  [../]
  # [./cross_slip_disl_7]
  #  type = ElementAverageValue
  #  variable = xslip_disl_7
  # [../]
  [./immobile_disl_7_pillar]
    type = ElementAverageValue
    variable = immobile_disl_7
    block = pillar
  [../]
  [./immobile_disl_7_substrate]
    type = ElementAverageValue
    variable = immobile_disl_7
    block = substrate
  [../]
  [./tau_7_pillar]
    type = ElementAverageValue
    variable = tau_7
    block = pillar
  [../]
  [./tau_7_substrate]
    type = ElementAverageValue
    variable = tau_7
    block = substrate
  [../]
  [./gss_8_pillar]
    type = ElementAverageValue
    variable = gss_8
    block = pillar
  [../]
  [./gss_8_substrate]
    type = ElementAverageValue
    variable = gss_8
    block = substrate
  [../]
  [./mobile_disl_8_pillar]
    type = ElementAverageValue
    variable = mobile_disl_8
    block = pillar
  [../]
  [./mobile_disl_8_substrate]
    type = ElementAverageValue
    variable = mobile_disl_8
    block = substrate
  [../]
  # [./cross_slip_disl_8]
  #  type = ElementAverageValue
  #  variable = xslip_disl_8
  # [../]
  [./immobile_disl_8_pillar]
    type = ElementAverageValue
    variable = immobile_disl_8
    block = pillar
  [../]
  [./immobile_disl_8_substrate]
    type = ElementAverageValue
    variable = immobile_disl_8
    block = substrate
  [../]
  [./tau_8_pillar]
    type = ElementAverageValue
    variable = tau_8
    block = pillar
  [../]
  [./tau_8_substrate]
    type = ElementAverageValue
    variable = tau_8
    block = substrate
  [../]
  [./gss_9_pillar]
    type = ElementAverageValue
    variable = gss_9
    block = pillar
  [../]
  [./gss_9_substrate]
    type = ElementAverageValue
    variable = gss_9
    block = substrate
  [../]
  [./mobile_disl_9_pillar]
    type = ElementAverageValue
    variable = mobile_disl_9
    block = pillar
  [../]
  [./mobile_disl_9_substrate]
    type = ElementAverageValue
    variable = mobile_disl_9
    block = substrate
  [../]
  # [./cross_slip_disl_9]
  #  type = ElementAverageValue
  #  variable = xslip_disl_9
  # [../]
  [./immobile_disl_9_pillar]
    type = ElementAverageValue
    variable = immobile_disl_9
    block = pillar
  [../]
  [./immobile_disl_9_substrate]
    type = ElementAverageValue
    variable = immobile_disl_9
    block = substrate
  [../]
  [./tau_9_pillar]
    type = ElementAverageValue
    variable = tau_9
    block = pillar
  [../]
  [./tau_9_substrate]
    type = ElementAverageValue
    variable = tau_9
    block = substrate
  [../]
  [./gss_10_pillar]
    type = ElementAverageValue
    variable = gss_10
    block = pillar
  [../]
  [./gss_10_substrate]
    type = ElementAverageValue
    variable = gss_10
    block = substrate
  [../]
  [./mobile_disl_10_pillar]
    type = ElementAverageValue
    variable = mobile_disl_10
    block = pillar
  [../]
  [./mobile_disl_10_substrate]
    type = ElementAverageValue
    variable = mobile_disl_10
    block = substrate
  [../]
  # [./cross_slip_disl_10]
  #  type = ElementAverageValue
  #  variable = xslip_disl_10
  # [../]
  [./immobile_disl_10_pillar]
    type = ElementAverageValue
    variable = immobile_disl_10
    block = pillar
  [../]
  [./immobile_disl_10_substrate]
    type = ElementAverageValue
    variable = immobile_disl_10
    block = substrate
  [../]
  [./tau_10_pillar]
    type = ElementAverageValue
    variable = tau_10
    block = pillar
  [../]
  [./tau_10_substrate]
    type = ElementAverageValue
    variable = tau_10
    block = substrate
  [../]
  [./gss_11_pillar]
    type = ElementAverageValue
    variable = gss_11
    block = pillar
  [../]
  [./gss_11_substrate]
    type = ElementAverageValue
    variable = gss_11
    block = substrate
  [../]
  [./mobile_disl_11_pillar]
    type = ElementAverageValue
    variable = mobile_disl_11
    block = pillar
  [../]
  [./mobile_disl_11_substrate]
    type = ElementAverageValue
    variable = mobile_disl_11
    block = substrate
  [../]
  # [./cross_slip_disl_11]
  #  type = ElementAverageValue
  #  variable = xslip_disl_11
  # [../]
  [./immobile_disl_11_pillar]
    type = ElementAverageValue
    variable = immobile_disl_11
    block = pillar
  [../]
  [./immobile_disl_11_substrate]
    type = ElementAverageValue
    variable = immobile_disl_11
    block = substrate
  [../]
  [./tau_11_pillar]
    type = ElementAverageValue
    variable = tau_11
    block = pillar
  [../]
  [./tau_11_substrate]
    type = ElementAverageValue
    variable = tau_11
    block = substrate
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
  dtmin = 1.0e-6
  dt = 1.0e-3
  end_time = 120.0
[]

[Outputs]
  csv = true
  # interval = 50
  exodus = true
  print_perf_log = true
[]
