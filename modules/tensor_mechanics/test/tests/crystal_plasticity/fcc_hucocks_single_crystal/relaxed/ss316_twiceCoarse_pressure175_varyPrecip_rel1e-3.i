[GlobalParams]
  displacements = 'disp_x disp_y disp_z'
[]

[Mesh]
  [bar]
    type = GeneratedMeshGenerator
    dim = 3
    nx = 4
    ny = 4
    nz = 8
    zmax = 2
    elem_type = HEX27
  []
  [fixed_node]
    type = BoundingBoxNodeSetGenerator
    input = bar
    bottom_left = '-0.05 -0.05 0.0'
    top_right = '0.05 0.05 0.0'
    new_boundary = 'fixed_point'
  []
  [pinned_node]
    type = BoundingBoxNodeSetGenerator
    input = fixed_node
    bottom_left = '-0.05 0.95 0'
    top_right = '0.05 1.05 0'
    new_boundary = 'pinned_point'
  []
[]


[AuxVariables]
  [radius_precipitate]
    order = CONSTANT
    family = MONOMIAL
  []
  [number_density_precipitate]
    order = CONSTANT
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
  [pinpt_density_0]
    order = FIRST
    family = MONOMIAL
  []
  [pinpt_density_1]
    order = FIRST
    family = MONOMIAL
  []
  [pinpt_density_2]
    order = FIRST
    family = MONOMIAL
  []
  [pinpt_density_3]
    order = FIRST
    family = MONOMIAL
  []
  [const_slip_increment_0]
    order = FIRST
    family = MONOMIAL
  []
  [const_slip_increment_1]
    order = FIRST
    family = MONOMIAL
  []
  [const_slip_increment_2]
    order = FIRST
    family = MONOMIAL
  []
  [const_slip_increment_3]
    order = FIRST
    family = MONOMIAL
  []
  [gss_0]
    order = FIRST
    family = MONOMIAL
  []
  [gss_1]
    order = FIRST
    family = MONOMIAL
  []
  [gss_2]
    order = FIRST
    family = MONOMIAL
  []
  [gss_3]
    order = FIRST
    family = MONOMIAL
  []
  [gss_4]
    order = FIRST
    family = MONOMIAL
  []
  [gss_5]
    order = FIRST
    family = MONOMIAL
  []
  [gss_6]
    order = FIRST
    family = MONOMIAL
  []
  [gss_7]
    order = FIRST
    family = MONOMIAL
  []
  [gss_8]
    order = FIRST
    family = MONOMIAL
  []
  [gss_9]
    order = FIRST
    family = MONOMIAL
  []
  [gss_10]
    order = FIRST
    family = MONOMIAL
  []
  [gss_11]
    order = FIRST
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
  [radius_precipitate]
    type = MaterialRealAux
    variable = radius_precipitate
    property = precipitate_radius
  []
  [number_density_precipitate]
    type = MaterialRealAux
    variable = number_density_precipitate
    property = precipitate_conc
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
  [pressure_ramp_hold]
    type = ParsedFunction
    expression = 'if(t<0.5, -350.0*t, -175.0)'
  []
  [number_density_function]
    type = ParsedFunction
    expression = '1.98e7*(t)^2 - 4.89e7*(t) +6.05e8' #fits a rough parabola shape that dips in the middle
  []
  [radius_function]
    type = ParsedFunction
    expression = 'if(t<0.25, 1.0e-3, -1.66e-4*(t^3)+1.26e-3*(t^2)-1.91e-3*t+1.38e-3)'
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
    function = 'pressure_ramp_hold'
  []
[]

[Materials]
  [elasticity_tensor]
    type = ComputeElasticityTensorCP
    C_ijkl = '1.98e5 1.25e5 1.25e5 1.98e5 1.25e5 1.98e5 1.22e5 1.22e5 1.22e5'
    fill_method = symmetric9
  []
  [stress]
    type = ComputeMultipleCrystalPlasticityStress
    crystal_plasticity_models = 'trial_xtalpl'
    tan_mod_type = exact
    maximum_substep_iteration = 10
    # print_state_variable_convergence_error_messages = true
  []
  [trial_xtalpl]
    type = CrystalPlasticityFCCDislocationLinkHuCocksUpdate
    number_slip_systems = 12
    slip_sys_file_name = input_slip_sys.txt
    number_coplanar_groups = 4
    shear_modulus = 1.22e5 #in MPa, from Hu et al 2016 IJP
    burgers_vector = 2.5e-7 #in mm, from Hu et al 2016 IJP
    initial_pinning_point_density = 2.2e7 ## in 1/mm^2, from Hu et al 2016 IJP
    coefficient_self_plane_evolution = 5.0e8 ## in 1/mm^2, from Hu et al 2016 IJP
    coefficient_latent_plane_evolution = 2.5e9 ## in 1/mm^2, from Hu et al 2016 IJP
    forest_dislocation_hardening_coefficient = 0.35 #unitless, Madec et al 2002 via Hu et al 2016 IJP
    solute_hardening_coefficient = 0.00457 #unitless, Hu et al 2016 IJP
    solute_concentration = solute_conc
    precipitate_number_density = precipitate_conc
    mean_precipitate_radius = precipitate_radius
    precipitate_hardening_coefficient = 0.84 #unitless, Foreman and Makin 1966 via Hu et al 2016 IJP
    # print_state_variable_convergence_error_messages = true
    resistance_tol = 0.05
    stol = 0.2
  []
  [concentrations]
    type = GenericConstantMaterial
    prop_names = 'solute_conc'
    prop_values = '2.818586455498711e+17 ' # in 1/mm^3, backed out from given stress
  []
  [precipitate_conc]
    type = GenericFunctionMaterial
    prop_names = 'precipitate_conc' # in 1/mm^3, backed out from given stress
    prop_values = 'number_density_function'
  []
  [precipitate_radius]
    type = GenericFunctionMaterial
    prop_names = precipitate_radius #in mm, assumed value
    prop_values = 'radius_function'
  []
[]

[Postprocessors]
  [radius_precipitate]
    type = ElementAverageValue
    variable = radius_precipitate
  []
  [number_density_precipitate]
    type = ElementAverageValue
    variable = number_density_precipitate
  []
  [vonmises_stress_cauchy]
    type = ElementAverageValue
    variable = vonmises_stress
  []
  [effective_strain_green]
    type = ElementAverageValue
    variable = l2norm_strain
  []
  [vonmises_stress_pk2]
    type = ElementAverageValue
    variable = vonmises_stress_pk2
  []
  [effective_strain]
    type = ElementAverageValue
    variable = eff_strain_lag
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
  []
[]

[Executioner]
  type = Transient
  solve_type = 'NEWTON'

  petsc_options_iname = '-pc_type -pc_asm_overlap -sub_pc_type -ksp_type -ksp_gmres_restart'
  petsc_options_value = ' asm      2              lu            gmres     200'
  nl_abs_tol = 1e-8
  nl_rel_tol = 1e-3
  # nl_abs_step_tol = 1e-10
  nl_max_its = 50
  l_max_its = 50

  dt = 0.05
  dtmin = 1.0e-6
  dtmax = 1.0
  end_time  = 3.5
  timestep_tolerance = 1e-8
[]

[Outputs]
  exodus = true
  csv = true
  perf_graph = true
  color = false
  checkpoint = true
[]
