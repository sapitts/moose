
[GlobalParams]
  displacements = 'disp_x disp_y disp_z'
[]

[Mesh]
  [cube]
    type = GeneratedMeshGenerator
    dim = 3
    nx = 10
    ny = 10
    nz = 10
    elem_type = HEX27
  []
[]

[AuxVariables]
  [temperature]
    order = FIRST
    family = LAGRANGE
  []
  [linear_void_strain]
    order = CONSTANT
    family = MONOMIAL
  []
  [e_void_xx]
    order = CONSTANT
    family = MONOMIAL
  []
  [e_void_yy]
    order = CONSTANT
    family = MONOMIAL
  []
  [e_void_zz]
    order = CONSTANT
    family = MONOMIAL
  []
  [f_void_zz]
    order = CONSTANT
    family = MONOMIAL
  []
  [e_zz]
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
  [tau_0]
    order = FIRST
    family = MONOMIAL
  []
  [tau_3]
    order = FIRST
    family = MONOMIAL
  []
  [tau_6]
    order = FIRST
    family = MONOMIAL
  []
  [tau_10]
    order = FIRST
    family = MONOMIAL
  []
  [gss_0]
    order = FIRST
    family = MONOMIAL
  []
  [gss_3]
    order = FIRST
    family = MONOMIAL
  []
  [gss_6]
    order = FIRST
    family = MONOMIAL
  []
  [gss_10]
    order = FIRST
    family = MONOMIAL
  []
  [pin_point_density_0]
    order = CONSTANT
    family = MONOMIAL
  []
  [pin_point_density_1]
    order = CONSTANT
    family = MONOMIAL
  []
  [pin_point_density_2]
    order = CONSTANT
    family = MONOMIAL
  []
  [pin_point_density_3]
    order = CONSTANT
    family = MONOMIAL
  []
[]

[Physics/SolidMechanics/QuasiStatic/all]
  strain = FINITE
  incremental = true
  add_variables = true
[]

[AuxKernels]
  [temperature]
    type = ConstantAux
    variable = temperature
    value = 773
  []
  [linear_void_strain]
    type = MaterialRealAux
    variable = linear_void_strain
    property = equivalent_linear_change
    execute_on = timestep_end
  []
  [e_void_xx]
    type = RankTwoAux
    variable = e_void_xx
    rank_two_tensor = void_eigenstrain
    index_j = 0
    index_i = 0
    execute_on = timestep_end
  []
  [e_void_yy]
    type = RankTwoAux
    variable = e_void_yy
    rank_two_tensor = void_eigenstrain
    index_j = 1
    index_i = 1
    execute_on = timestep_end
  []
  [e_void_zz]
    type = RankTwoAux
    variable = e_void_zz
    rank_two_tensor = void_eigenstrain
    index_j = 2
    index_i = 2
    execute_on = timestep_end
  []
  [f_void_zz]
    type = RankTwoAux
    variable = f_void_zz
    rank_two_tensor = volumetric_deformation_gradient
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
  [tau_0]
    type = MaterialStdVectorAux
    variable = tau_0
    property = applied_shear_stress
    index = 0
    execute_on = timestep_end
  []
  [tau_3]
    type = MaterialStdVectorAux
    variable = tau_3
    property = applied_shear_stress
    index = 3
    execute_on = timestep_end
  []
  [tau_6]
    type = MaterialStdVectorAux
    variable = tau_6
    property = applied_shear_stress
    index = 6
    execute_on = timestep_end
  []
  [tau_10]
    type = MaterialStdVectorAux
    variable = tau_10
    property = applied_shear_stress
    index = 10
    execute_on = timestep_end
  []
  [gss_0]
    type = MaterialStdVectorAux
    variable = gss_0
    property = slip_resistance
    index = 0
    execute_on = timestep_end
  []
  [gss_3]
    type = MaterialStdVectorAux
    variable = gss_3
    property = slip_resistance
    index = 3
    execute_on = timestep_end
  []
  [gss_6]
    type = MaterialStdVectorAux
    variable = gss_6
    property = slip_resistance
    index = 6
    execute_on = timestep_end
  []
  [gss_10]
    type = MaterialStdVectorAux
    variable = gss_10
    property = slip_resistance
    index = 10
    execute_on = timestep_end
  []
  [pin_point_density_0]
    type = MaterialStdVectorAux
    variable = pin_point_density_0
    property = pinning_point_density
    index = 0
    execute_on = timestep_end
  []
  [pin_point_density_1]
    type = MaterialStdVectorAux
    variable = pin_point_density_1
    property = pinning_point_density
    index = 1
    execute_on = timestep_end
  []
  [pin_point_density_2]
    type = MaterialStdVectorAux
    variable = pin_point_density_2
    property = pinning_point_density
    index = 2
    execute_on = timestep_end
  []
  [pin_point_density_3]
    type = MaterialStdVectorAux
    variable = pin_point_density_3
    property = pinning_point_density
    index = 3
    execute_on = timestep_end
  []
[]

[BCs]
  [symmy]
    type = DirichletBC
    variable = disp_y
    boundary = bottom
    value = 0
  []
  [symmx]
    type = DirichletBC
    variable = disp_x
    boundary = left
    value = 0
  []
  [symmz]
    type = DirichletBC
    variable = disp_z
    boundary = back
    value = 0
  []
  [hold_front]
    type = DirichletBC
    variable = disp_z
    boundary = front
    value = 0
  []
[]

[Functions]
  [void_total_density]
    type = PiecewiseLinear
    data_file = 'new_alloy800_0D_773k_1e-2flux_mm_voidDensityRadius.csv'
    format = columns
    xy_in_file_only = false
    x_index_in_file = 0
    y_index_in_file = 1
  []
  [void_average_radius]
    type = PiecewiseLinear
    data_file = 'new_alloy800_0D_773k_1e-2flux_mm_voidDensityRadius.csv'
    format = columns
    x_index_in_file = 0
    y_index_in_file = 2
    xy_in_file_only = false
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
    eigenstrain_names = void_eigenstrain
    tan_mod_type = exact
    line_search_method = CUT_HALF
    use_line_search = true
    maximum_substep_iteration = 5
    abs_tol = 1e-06
    rtol = 1e-06
  []

  [trial_xtalpl]
    type = CrystalPlasticityFCCDislocationLinkDefectHardening
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
    stol = 1.0e-2
    resistance_tol = 1.0e-2
    # zero_tol = 1e-16
    # print_state_variable_convergence_error_messages = true
    mean_spherical_void_radius = void_radius
    spherical_void_number_density = void_density
    void_hardening_coefficient = 1.0
  []
  [concentrations]
    type = GenericConstantMaterial
    prop_names = 'solute_conc             precipitate_conc    precipitate_radius'
    prop_values = '2.818586455498711e+17  597211024.5155126     1.0e-3' # in 1/mm^3, backed out from given stress, except radius which is assumed
  []

  [void_eigenstrain]
    type = ComputeCrystalPlasticityVolumetricEigenstrain
    eigenstrain_name = void_eigenstrain
    deformation_gradient_name = volumetric_deformation_gradient
    mean_spherical_void_radius = void_radius
    spherical_void_number_density = void_density
  []
  [void_density]
    type = GenericFunctionMaterial
    prop_names = void_density
    prop_values = 'void_total_density'
  []
  [void_radius]
    type = GenericFunctionMaterial
    prop_names = void_radius
    prop_values = 'void_average_radius'
  []
[]

[Postprocessors]
  [linear_void_strain]
    type = ElementAverageValue
    variable = linear_void_strain
  []
  [e_void_xx]
    type = ElementAverageValue
    variable = e_void_xx
  []
  [e_void_yy]
    type = ElementAverageValue
    variable = e_void_yy
  []
  [e_void_zz]
    type = ElementAverageValue
    variable = e_void_zz
  []
  [f_void_zz]
    type = ElementAverageValue
    variable = f_void_zz
  []
  [density]
    type = ElementAverageMaterialProperty
    mat_prop = void_density
    execute_on = TIMESTEP_END
  []
  [radius]
    type = ElementAverageMaterialProperty
    mat_prop = void_radius
    execute_on = TIMESTEP_END
  []
  [e_zz]
    type = ElementAverageValue
    variable = e_zz
  []
  [pk2_zz]
   type = ElementAverageValue
   variable = pk2_zz
  []
  [fp_zz]
    type = ElementAverageValue
    variable = fp_zz
  []
  [tau_0]
    type = ElementAverageValue
    variable = tau_0
  []
  [tau_3]
    type = ElementAverageValue
    variable = tau_3
  []
  [tau_6]
    type = ElementAverageValue
    variable = tau_6
  []
  [tau_10]
    type = ElementAverageValue
    variable = tau_10
  []
  [gss_0]
    type = ElementAverageValue
    variable = gss_0
  []
  [gss_3]
    type = ElementAverageValue
    variable = gss_3
  []
  [gss_6]
    type = ElementAverageValue
    variable = gss_6
  []
  [gss_10]
    type = ElementAverageValue
    variable = gss_10
  []
  [pin_point_density_0]
    type = ElementAverageValue
    variable = pin_point_density_0
  []
  [pin_point_density_1]
    type = ElementAverageValue
    variable = pin_point_density_1
  []
  [pin_point_density_2]
    type = ElementAverageValue
    variable = pin_point_density_2
  []
  [pin_point_density_3]
    type = ElementAverageValue
    variable = pin_point_density_3
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

  petsc_options = '-snes_converged_reason'
  petsc_options_iname = '-pc_type -pc_asm_overlap -sub_pc_type -ksp_type -ksp_gmres_restart'
  petsc_options_value = ' asm      2              lu            gmres     200'

  line_search = 'none'
  nl_abs_tol = 1e-8
  nl_rel_tol = 1e-6
  nl_forced_its = 1
  nl_max_its = 10

  dtmin = 1.0e-4
  dtmax = 500.0
  end_time  = 1.0e5

  [TimeStepper]
    type = IterationAdaptiveDT
    optimal_iterations = 6
    linear_iteration_ratio = 10
    dt = 1.0e-3
    growth_factor = 5.0
    cutback_factor = 0.5
    iteration_window = 1
  []
[]

[Outputs]
  csv = true
  exodus = true
  perf_graph = true
[]
