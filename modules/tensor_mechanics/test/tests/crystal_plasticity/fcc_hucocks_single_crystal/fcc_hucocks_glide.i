[GlobalParams]
  displacements = 'disp_x disp_y disp_z'
[]

[Mesh]
  type = GeneratedMesh
  dim = 3
  nx = 2
  ny = 2
  nz = 2
  elem_type = HEX8
[]

[AuxVariables]
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
[]

[Modules/TensorMechanics/Master/all]
  strain = FINITE
  incremental = true
  add_variables = true
  generate_output = stress_zz
[]

[AuxKernels]
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
  [tdisp]
    type = FunctionDirichletBC
    variable = disp_z
    boundary = front
    function = '0.01*t'
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
    print_state_variable_convergence_error_messages = true
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
    print_state_variable_convergence_error_messages = true
  []
  [concentrations]
    type = GenericConstantMaterial
    prop_names = 'solute_conc             precipitate_conc    precipitate_radius'
    prop_values = '2.818586455498711e+17  597211024.5155126     1.0e-3' # in 1/mm^3, backed out from given stress, except radius which is assumed
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
[]

[Preconditioning]
  [smp]
    type = SMP
    full = true
  []
[]

[Executioner]
  type = Transient
  solve_type = 'PJFNK'

  petsc_options_iname = '-pc_type -pc_asm_overlap -sub_pc_type -ksp_type -ksp_gmres_restart'
  petsc_options_value = ' asm      2              lu            gmres     200'
  nl_abs_tol = 1e-10
  nl_rel_tol = 1e-10
  nl_abs_step_tol = 1e-10

  dt = 0.05
  dtmin = 1.0e-6
  dtmax = 10.0
  end_time  = 1
[]

[Outputs]
  exodus = true
  csv = true
[]
