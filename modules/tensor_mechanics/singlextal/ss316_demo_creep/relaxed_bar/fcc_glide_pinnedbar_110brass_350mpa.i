[GlobalParams]
  displacements = 'disp_x disp_y disp_z'
[]

[Mesh]
  [bar]
    type = GeneratedMeshGenerator
    dim = 3
    nx = 10
    ny = 10
    nz = 20
    zmax = 2
    elem_type = HEX27
  []
  [fixed_node]
    type = BoundingBoxNodeSetGenerator
    input = bar
    bottom_left = '-0.03 -0.03 0.0'
    top_right = '0.03 0.03 0.0'
    new_boundary = 'fixed_point'
  []
  [pinned_node]
    type = BoundingBoxNodeSetGenerator
    input = fixed_node
    bottom_left = '-0.03 0.97 0'
    top_right = '0.03 1.03 0'
    new_boundary = 'pinned_point'
  []
[]

[AuxVariables]
  [vonmises_stress_pk2]
    order = FIRST
    family = MONOMIAL
  []
  [eff_strain_lag]
    order = FIRST
    family = MONOMIAL
  []
  [pk2_xx]
    order = CONSTANT
    family = MONOMIAL
  []
  [fp_xx]
    order = CONSTANT
    family = MONOMIAL
  []
  [e_xx]
    order = CONSTANT
    family = MONOMIAL
  []
  [pk2_yy]
    order = CONSTANT
    family = MONOMIAL
  []
  [fp_yy]
    order = CONSTANT
    family = MONOMIAL
  []
  [e_yy]
    order = CONSTANT
    family = MONOMIAL
  []
  [pk2_zz]
    order = CONSTANT
    family = MONOMIAL
  []
  [fp_zz]
    order = CONSTANT
    family = MONOMIAL
  []
  [e_zz]
    order = CONSTANT
    family = MONOMIAL
  []
  [pinpt_density_0]
    order = CONSTANT
    family = MONOMIAL
  []
  [pinpt_density_1]
    order = CONSTANT
    family = MONOMIAL
  []
  [pinpt_density_2]
    order = CONSTANT
    family = MONOMIAL
  []
  [pinpt_density_3]
    order = CONSTANT
    family = MONOMIAL
  []
  [const_slip_increment_0]
    order = CONSTANT
    family = MONOMIAL
  []
  [const_slip_increment_1]
    order = CONSTANT
    family = MONOMIAL
  []
  [const_slip_increment_2]
    order = CONSTANT
    family = MONOMIAL
  []
  [const_slip_increment_3]
    order = CONSTANT
    family = MONOMIAL
  []
  [gss_0]
    order = CONSTANT
    family = MONOMIAL
  []
  [gss_1]
    order = CONSTANT
    family = MONOMIAL
  []
  [gss_2]
    order = CONSTANT
    family = MONOMIAL
  []
  [gss_3]
    order = CONSTANT
    family = MONOMIAL
  []
  [gss_4]
    order = CONSTANT
    family = MONOMIAL
  []
  [gss_5]
    order = CONSTANT
    family = MONOMIAL
  []
  [gss_6]
    order = CONSTANT
    family = MONOMIAL
  []
  [gss_7]
    order = CONSTANT
    family = MONOMIAL
  []
  [gss_8]
    order = CONSTANT
    family = MONOMIAL
  []
  [gss_9]
    order = CONSTANT
    family = MONOMIAL
  []
  [gss_10]
    order = CONSTANT
    family = MONOMIAL
  []
  [gss_11]
    order = CONSTANT
    family = MONOMIAL
  []
  [tau_0]
    order = FIRST
    family = MONOMIAL
  []
  [tau_1]
    order = FIRST
    family = MONOMIAL
  []
  [tau_2]
    order = FIRST
    family = MONOMIAL
  []
  [tau_3]
    order = FIRST
    family = MONOMIAL
  []
  [tau_4]
    order = FIRST
    family = MONOMIAL
  []
  [tau_5]
    order = FIRST
    family = MONOMIAL
  []
  [tau_6]
    order = FIRST
    family = MONOMIAL
  []
  [tau_7]
    order = FIRST
    family = MONOMIAL
  []
  [tau_8]
    order = FIRST
    family = MONOMIAL
  []
  [tau_9]
    order = FIRST
    family = MONOMIAL
  []
  [tau_10]
    order = FIRST
    family = MONOMIAL
  []
  [tau_11]
    order = FIRST
    family = MONOMIAL
  []
[]

[Modules/TensorMechanics/Master/all]
  strain = FINITE
  incremental = true
  add_variables = true
  additional_generate_output = 'stress_zz stress_xx stress_yy vonmises_stress l2norm_strain'
  additional_material_output_order = FIRST
[]

[AuxKernels]
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
    index_j = 2
    index_i = 2
    execute_on = timestep_end
  []
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
  [pinpt_density_0]
    type = MaterialStdVectorAux
    variable = pinpt_density_0
    property = pinning_point_density
    index = 0
    execute_on = timestep_end
  []
  [pinpt_density_1]
    type = MaterialStdVectorAux
    variable = pinpt_density_1
    property = pinning_point_density
    index = 1
    execute_on = timestep_end
  []
  [pinpt_density_2]
    type = MaterialStdVectorAux
    variable = pinpt_density_2
    property = pinning_point_density
    index = 2
    execute_on = timestep_end
  []
  [pinpt_density_3]
    type = MaterialStdVectorAux
    variable = pinpt_density_3
    property = pinning_point_density
    index = 3
    execute_on = timestep_end
  []
  [const_slip_increment_0]
    type = MaterialStdVectorAux
    variable = const_slip_increment_0
    property = coplanar_constitutive_slip_increment
    index = 0
    execute_on = timestep_end
  []
  [const_slip_increment_1]
    type = MaterialStdVectorAux
    variable = const_slip_increment_1
    property = coplanar_constitutive_slip_increment
    index = 1
    execute_on = timestep_end
  []
  [const_slip_increment_2]
    type = MaterialStdVectorAux
    variable = const_slip_increment_2
    property = coplanar_constitutive_slip_increment
    index = 2
    execute_on = timestep_end
  []
  [const_slip_increment_3]
    type = MaterialStdVectorAux
    variable = const_slip_increment_3
    property = coplanar_constitutive_slip_increment
    index = 3
    execute_on = timestep_end
  []
  [gss_0]
    type = MaterialStdVectorAux
    variable = gss_0
    property = slip_resistance
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
  [gss_2]
    type = MaterialStdVectorAux
    variable = gss_2
    property = slip_resistance
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
  [gss_4]
    type = MaterialStdVectorAux
    variable = gss_4
    property = slip_resistance
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
  [gss_6]
    type = MaterialStdVectorAux
    variable = gss_6
    property = slip_resistance
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
  [gss_8]
    type = MaterialStdVectorAux
    variable = gss_8
    property = slip_resistance
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
  [gss_10]
    type = MaterialStdVectorAux
    variable = gss_10
    property = slip_resistance
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
  [tau_0]
    type = MaterialStdVectorAux
    variable = tau_0
    property = applied_shear_stress
    index = 0
    execute_on = timestep_end
  []
  [tau_1]
    type = MaterialStdVectorAux
    variable = tau_1
    property = applied_shear_stress
    index = 1
    execute_on = timestep_end
  []
  [tau_2]
    type = MaterialStdVectorAux
    variable = tau_2
    property = applied_shear_stress
    index = 2
    execute_on = timestep_end
  []
  [tau_3]
    type = MaterialStdVectorAux
    variable = tau_3
    property = applied_shear_stress
    index = 3
    execute_on = timestep_end
  []
  [tau_4]
    type = MaterialStdVectorAux
    variable = tau_4
    property = applied_shear_stress
    index = 4
    execute_on = timestep_end
  []
  [tau_5]
    type = MaterialStdVectorAux
    variable = tau_5
    property = applied_shear_stress
    index = 5
    execute_on = timestep_end
  []
  [tau_6]
    type = MaterialStdVectorAux
    variable = tau_6
    property = applied_shear_stress
    index = 6
    execute_on = timestep_end
  []
  [tau_7]
    type = MaterialStdVectorAux
    variable = tau_7
    property = applied_shear_stress
    index = 7
    execute_on = timestep_end
  []
  [tau_8]
    type = MaterialStdVectorAux
    variable = tau_8
    property = applied_shear_stress
    index = 8
    execute_on = timestep_end
  []
  [tau_9]
    type = MaterialStdVectorAux
    variable = tau_9
    property = applied_shear_stress
    index = 9
    execute_on = timestep_end
  []
  [tau_10]
    type = MaterialStdVectorAux
    variable = tau_10
    property = applied_shear_stress
    index = 10
    execute_on = timestep_end
  []
  [tau_11]
    type = MaterialStdVectorAux
    variable = tau_11
    property = applied_shear_stress
    index = 11
    execute_on = timestep_end
  []
[]

[Functions]
  [ramp_hold]
    type = ParsedFunction
    expression = 'if(t < 10, -35.0*t , -350.0)'
  []
[]

[BCs]
  [pinned_x]
    type = DirichletBC
    variable = disp_x
    boundary = 'fixed_point pinned_point'
    value = 0.0
  []
  [pinned_y]
    type = DirichletBC
    variable = disp_y
    boundary = 'fixed_point'
    value = 0.0
  []
  [fixed_bottom_z]
    type = DirichletBC
    variable = disp_z
    boundary = 'back'
    value = 0.0
  []
  [pressure_z]
    type = Pressure
    variable = disp_z
    boundary = 'front'
    function = 'ramp_hold'
  []
[]

[Materials]
  [elasticity_tensor]
    type = ComputeElasticityTensorCP
    C_ijkl = '1.98e5 1.25e5 1.25e5 1.98e5 1.25e5 1.98e5 1.22e5 1.22e5 1.22e5'
    fill_method = symmetric9
    euler_angle_1 = 35.0
    euler_angle_2 = 45.0
  []
  [stress]
    type = ComputeMultipleCrystalPlasticityStress
    crystal_plasticity_models = 'trial_xtalpl'
    tan_mod_type = exact
    line_search_method = CUT_HALF
    use_line_search = true
    maximum_substep_iteration = 4
    # print_state_variable_convergence_error_messages = true
  []
  [trial_xtalpl]
    type = CrystalPlasticityFCCDislocationLinkHuCocksUpdate
    number_slip_systems = 12
    slip_sys_file_name = input_slip_sys.txt
    number_coplanar_groups = 4
    shear_modulus = 1.22e5 #in MPa, from Hu et al 2016 IJP
    burgers_vector = 2.5e-7 #in mm, from Hu et al 2016 IJP
    initial_pinning_point_density = 2.4e7 ## in 1/mm^2, from Hu et al 2016 IJP
    coefficient_self_plane_evolution = 5.0e8 ## in 1/mm^2, from Hu et al 2016 IJP
    coefficient_latent_plane_evolution = 2.5e9 ## in 1/mm^2, from Hu et al 2016 IJP
    forest_dislocation_hardening_coefficient = 0.35 #unitless, Madec et al 2002 via Hu et al 2016 IJP
    solute_hardening_coefficient = 0.00457 #unitless, Hu et al 2016 IJP
    solute_concentration = solute_conc
    precipitate_number_density = precipitate_conc
    mean_precipitate_radius = precipitate_radius
    precipitate_hardening_coefficient = 0.84 #unitless, Foreman and Makin 1966 via Hu et al 2016 IJP
    stol = 5.0e-3
    resistance_tol = 5.0e-3
    zero_tol = 1e-16
    # print_state_variable_convergence_error_messages = true
  []
  [concentrations]
    type = GenericConstantMaterial
    prop_names = 'solute_conc             precipitate_conc    precipitate_radius'
    prop_values = '2.818586455498711e+17  597211024.5155126     1.0e-3' # in 1/mm^3, backed out from given stress, except radius which is assumed
  []
[]

[Postprocessors]
  [vonmises_stress_cauchy]
    type = ElementAverageValue
    variable = vonmises_stress
  []
  [effective_strain_green]
    type = ElementAverageValue
    variable = l2norm_strain
  []
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
  [e_zz]
    type = ElementAverageValue
    variable = e_zz
  []
  [pinpt_density_0]
    type = ElementAverageValue
    variable = pinpt_density_0
  []
  [pinpt_density_1]
   type = ElementAverageValue
   variable = pinpt_density_1
  []
  [pinpt_density_2]
    type = ElementAverageValue
    variable = pinpt_density_2
  []
  [pinpt_density_3]
   type = ElementAverageValue
   variable = pinpt_density_3
  []
  [const_slip_increment_0]
    type = ElementAverageValue
    variable = const_slip_increment_0
  []
  [const_slip_increment_1]
    type = ElementAverageValue
    variable = const_slip_increment_1
  []
  [const_slip_increment_2]
    type = ElementAverageValue
    variable = const_slip_increment_2
  []
  [const_slip_increment_3]
    type = ElementAverageValue
    variable = const_slip_increment_3
  []
  [gss_0]
    type = ElementAverageValue
    variable = gss_0
  []
  [gss_1]
    type = ElementAverageValue
    variable = gss_1
  []
  [gss_2]
    type = ElementAverageValue
    variable = gss_2
  []
  [gss_3]
    type = ElementAverageValue
    variable = gss_3
  []
  [gss_4]
    type = ElementAverageValue
    variable = gss_4
  []
  [gss_5]
    type = ElementAverageValue
    variable = gss_5
  []
  [gss_6]
    type = ElementAverageValue
    variable = gss_6
  []
  [gss_7]
    type = ElementAverageValue
    variable = gss_7
  []
  [gss_8]
    type = ElementAverageValue
    variable = gss_8
  []
  [gss_9]
    type = ElementAverageValue
    variable = gss_9
  []
  [gss_10]
    type = ElementAverageValue
    variable = gss_10
  []
  [gss_11]
    type = ElementAverageValue
    variable = gss_11
  []
  [tau_0]
    type = ElementAverageValue
    variable = tau_0
  []
  [tau_1]
    type = ElementAverageValue
    variable = tau_1
  []
  [tau_2]
    type = ElementAverageValue
    variable = tau_2
  []
  [tau_3]
    type = ElementAverageValue
    variable = tau_3
  []
  [tau_4]
    type = ElementAverageValue
    variable = tau_4
  []
  [tau_5]
    type = ElementAverageValue
    variable = tau_5
  []
  [tau_6]
    type = ElementAverageValue
    variable = tau_6
  []
  [tau_7]
    type = ElementAverageValue
    variable = tau_7
  []
  [tau_8]
    type = ElementAverageValue
    variable = tau_8
  []
  [tau_9]
    type = ElementAverageValue
    variable = tau_9
  []
  [tau_10]
    type = ElementAverageValue
    variable = tau_10
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
    petsc_options = '-snes_converged_reason'
  []
[]

[Debug]
  show_var_residual_norms = true
[]

[Executioner]
  type = Transient
  solve_type = 'NEWTON'
  petsc_options = '-snes_converged_reason'
  petsc_options_iname = '-pc_type -pc_asm_overlap -sub_pc_type -ksp_type -ksp_gmres_restart'
  petsc_options_value = ' asm      2              lu            gmres     200'
  # petsc_options_iname = '-pc_type -pc_hypre_type'
  # petsc_options_value = 'hypre    boomeramg'
  line_search = 'none'
  nl_abs_tol = 1e-10
  nl_rel_tol = 1e-6
  # nl_abs_step_tol = 1e-10
  nl_forced_its = 1

  dt = 10.0
  dtmin = 1.0e-6
  dtmax = 100.0
  # num_steps = 2
   end_time  = 18000.0 ## 5 hours
[]

[Outputs]
  exodus = true
  csv = true
  perf_graph = true
  [cp]
    type = Checkpoint
    num_files = 2
  []
[]
