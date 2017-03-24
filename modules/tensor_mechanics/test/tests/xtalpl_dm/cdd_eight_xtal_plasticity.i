[Mesh]
  file = eight_xtal.e
[]

[GlobalParams]
  displacements = 'ux uy uz'
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
  [./pk2]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./fp_zz]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./rotout]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./e_zz]
    order = CONSTANT
    family = MONOMIAL
  [../]

[]

[Functions]
  [./tdisp]
    type = ParsedFunction
    value = 0.01*t
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
  [./pk2]
    type = RankTwoAux
    variable = pk2
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
  [./rotout]
    type = CrystalPlasticityRotationOutAux
    variable = rotout
    execute_on = timestep_end
  [../]

[]

[BCs]
  [./symmy]
    type = PresetBC
    variable = uy
    boundary = bottom
    value = 0
  [../]
  [./symmx]
    type = PresetBC
    variable = ux
    boundary = left
    value = 0
  [../]
  [./symmz]
    type = PresetBC
    variable = uz
    boundary = back
    value = 0
  [../]
  [./tdisp]
    type = FunctionPresetBC
    variable = ux
    boundary = right
    function = tdisp
  [../]
[]

[Materials]
  [./elasticity_tensor1]
    type = ComputeElasticityTensorCP
    block = 1
    C_ijkl = '274.7e3 117.7e3 117.7e3 274.7e3 117.7e3 274.7e3 78.49e3 78.49e3 78.49e3'
#    C_ijkl = '242.0e3 150.0e3 150.0e3 242.06e3 150.0e3 242.0e3 112.0e3 112.0e3 112.0e3' # From Hirth and Loethe, 1969, pure alpha iron
    fill_method = symmetric9
  [../]
  [./stress1]
    type = ComputeCrystalPlasticityStress
    block = 1
    crystal_plasticity_update_model = 'trial_xtalpl1'
  [../]
  [./trial_xtalpl1]
    type = CrystalPlasticityCDDUpdate
    block = 1
    number_slip_systems = 48
    slip_sys_file_name = bcc_input_slip_sys.txt
    number_cross_slip_directions = 4
    number_cross_slip_planes = 12
    initial_mobile_dislocation_density = 2.0e7 #96e7 total in crystal
    initial_immobile_dislocation_density = 3.0e7 #144e7 total in crystal
    Peierls_stress = 390.0  #Alpha-iron is 11MPa
    shear_modulus = 78489
#    resistance_tol = 10
    maximum_substep_iteration = 10
#    rtol = 1e-06
#    abs_tol = 4e-6
    maxiter = 30
    maxiter_state_variable = 30
    line_search_method = CUT_HALF
    use_line_search = true
  [../]
  [./elasticity_tensor2]
    type = ComputeElasticityTensorCP
    block = 2
    C_ijkl = '274.7e3 117.7e3 117.7e3 274.7e3 117.7e3 274.7e3 78.49e3 78.49e3 78.49e3'
#    C_ijkl = '242.0e3 150.0e3 150.0e3 242.06e3 150.0e3 242.0e3 112.0e3 112.0e3 112.0e3' # From Hirth and Loethe, 1969, pure alpha iron
    fill_method = symmetric9
    euler_angle_1 = 0
    euler_angle_2 = 30.0
    euler_angle_3 = 125.0
  [../]
  [./stress2]
    type = ComputeCrystalPlasticityStress
    block = 2
    crystal_plasticity_update_model = 'trial_xtalpl2'
  [../]
  [./trial_xtalpl2]
    type = CrystalPlasticityCDDUpdate
    block = 2
    number_slip_systems = 48
    slip_sys_file_name = bcc_input_slip_sys.txt
    number_cross_slip_directions = 4
    number_cross_slip_planes = 12
    initial_mobile_dislocation_density = 2.0e7 #96e7 total in crystal
    initial_immobile_dislocation_density = 3.0e7 #144e7 total in crystal
    Peierls_stress = 390.0  #Alpha-iron is 11MPa
    shear_modulus = 78489
#    resistance_tol = 10
    maximum_substep_iteration = 10
#    rtol = 1e-06
#    abs_tol = 4e-6
    maxiter = 30
    maxiter_state_variable = 30
    line_search_method = CUT_HALF
    use_line_search = true
  [../]
  [./elasticity_tensor3]
    type = ComputeElasticityTensorCP
    block = 3
    C_ijkl = '274.7e3 117.7e3 117.7e3 274.7e3 117.7e3 274.7e3 78.49e3 78.49e3 78.49e3'
#    C_ijkl = '242.0e3 150.0e3 150.0e3 242.06e3 150.0e3 242.0e3 112.0e3 112.0e3 112.0e3' # From Hirth and Loethe, 1969, pure alpha iron
    fill_method = symmetric9
    euler_angle_1 = 40.0
    euler_angle_2 = 70.0
    euler_angle_3 = 122.0
  [../]
  [./stress3]
    type = ComputeCrystalPlasticityStress
    block = 3
    crystal_plasticity_update_model = 'trial_xtalpl3'
  [../]
  [./trial_xtalpl3]
    type = CrystalPlasticityCDDUpdate
    block = 3
    number_slip_systems = 48
    slip_sys_file_name = bcc_input_slip_sys.txt
    number_cross_slip_directions = 4
    number_cross_slip_planes = 12
    initial_mobile_dislocation_density = 2.0e7 #96e7 total in crystal
    initial_immobile_dislocation_density = 3.0e7 #144e7 total in crystal
    Peierls_stress = 390.0  #Alpha-iron is 11MPa
    shear_modulus = 78489
#    resistance_tol = 10
    maximum_substep_iteration = 10
#    rtol = 1e-06
#    abs_tol = 4e-6
    maxiter = 30
    maxiter_state_variable = 30
    line_search_method = CUT_HALF
    use_line_search = true
  [../]
  [./elasticity_tensor4]
    type = ComputeElasticityTensorCP
    block = 4
    C_ijkl = '274.7e3 117.7e3 117.7e3 274.7e3 117.7e3 274.7e3 78.49e3 78.49e3 78.49e3'
#    C_ijkl = '242.0e3 150.0e3 150.0e3 242.06e3 150.0e3 242.0e3 112.0e3 112.0e3 112.0e3' # From Hirth and Loethe, 1969, pure alpha iron
    fill_method = symmetric9
    euler_angle_1 = 80.0
    euler_angle_2 = 110.0
    euler_angle_3 = 40.0
  [../]
  [./stress4]
    type = ComputeCrystalPlasticityStress
    block = 4
    crystal_plasticity_update_model = 'trial_xtalpl4'
  [../]
  [./trial_xtalpl4]
    type = CrystalPlasticityCDDUpdate
    block = 4
    number_slip_systems = 48
    slip_sys_file_name = bcc_input_slip_sys.txt
    number_cross_slip_directions = 4
    number_cross_slip_planes = 12
    initial_mobile_dislocation_density = 2.0e7 #96e7 total in crystal
    initial_immobile_dislocation_density = 3.0e7 #144e7 total in crystal
    Peierls_stress = 390.0  #Alpha-iron is 11MPa
    shear_modulus = 78489
#    resistance_tol = 10
    maximum_substep_iteration = 10
#    rtol = 1e-06
#    abs_tol = 4e-6
    maxiter = 30
    maxiter_state_variable = 30
    line_search_method = CUT_HALF
    use_line_search = true
  [../]
  [./elasticity_tensor5]
    type = ComputeElasticityTensorCP
    block = 5
    C_ijkl = '274.7e3 117.7e3 117.7e3 274.7e3 117.7e3 274.7e3 78.49e3 78.49e3 78.49e3'
#    C_ijkl = '242.0e3 150.0e3 150.0e3 242.06e3 150.0e3 242.0e3 112.0e3 112.0e3 112.0e3' # From Hirth and Loethe, 1969, pure alpha iron
    fill_method = symmetric9
    euler_angle_1 = 120.0
    euler_angle_2 = 193.0
    euler_angle_3 = 247.0
  [../]
  [./stress5]
    type = ComputeCrystalPlasticityStress
    block = 5
    crystal_plasticity_update_model = 'trial_xtalpl5'
  [../]
  [./trial_xtalpl5]
    type = CrystalPlasticityCDDUpdate
    block = 5
    number_slip_systems = 48
    slip_sys_file_name = bcc_input_slip_sys.txt
    number_cross_slip_directions = 4
    number_cross_slip_planes = 12
    initial_mobile_dislocation_density = 2.0e7 #96e7 total in crystal
    initial_immobile_dislocation_density = 3.0e7 #144e7 total in crystal
    Peierls_stress = 390.0  #Alpha-iron is 11MPa
    shear_modulus = 78489
#    resistance_tol = 10
    maximum_substep_iteration = 10
#    rtol = 1e-06
#    abs_tol = 4e-6
    maxiter = 30
    maxiter_state_variable = 30
    line_search_method = CUT_HALF
    use_line_search = true
  [../]
  [./elasticity_tensor6]
    type = ComputeElasticityTensorCP
    block = 6
    C_ijkl = '274.7e3 117.7e3 117.7e3 274.7e3 117.7e3 274.7e3 78.49e3 78.49e3 78.49e3'
#    C_ijkl = '242.0e3 150.0e3 150.0e3 242.06e3 150.0e3 242.0e3 112.0e3 112.0e3 112.0e3' # From Hirth and Loethe, 1969, pure alpha iron
    fill_method = symmetric9
    euler_angle_1 = 40.0
    euler_angle_2 = 30.0
    euler_angle_3 = 125.0
  [../]
  [./stress6]
    type = ComputeCrystalPlasticityStress
    block = 6
    crystal_plasticity_update_model = 'trial_xtalpl6'
  [../]
  [./trial_xtalpl6]
    type = CrystalPlasticityCDDUpdate
    block = 6
    number_slip_systems = 48
    slip_sys_file_name = bcc_input_slip_sys.txt
    number_cross_slip_directions = 4
    number_cross_slip_planes = 12
    initial_mobile_dislocation_density = 2.0e7 #96e7 total in crystal
    initial_immobile_dislocation_density = 3.0e7 #144e7 total in crystal
    Peierls_stress = 390.0  #Alpha-iron is 11MPa
    shear_modulus = 78489
#    resistance_tol = 10
    maximum_substep_iteration = 10
#    rtol = 1e-06
#    abs_tol = 4e-6
    maxiter = 30
    maxiter_state_variable = 30
    line_search_method = CUT_HALF
    use_line_search = true
  [../]
  [./elasticity_tensor7]
    type = ComputeElasticityTensorCP
    block = 7
    C_ijkl = '274.7e3 117.7e3 117.7e3 274.7e3 117.7e3 274.7e3 78.49e3 78.49e3 78.49e3'
#    C_ijkl = '242.0e3 150.0e3 150.0e3 242.06e3 150.0e3 242.0e3 112.0e3 112.0e3 112.0e3' # From Hirth and Loethe, 1969, pure alpha iron
    fill_method = symmetric9
    euler_angle_1 = 80.0
    euler_angle_2 = 70.0
    euler_angle_3 = 125.0
  [../]
  [./stress7]
    type = ComputeCrystalPlasticityStress
    block = 7
    crystal_plasticity_update_model = 'trial_xtalpl7'
  [../]
  [./trial_xtalpl7]
    type = CrystalPlasticityCDDUpdate
    block = 7
    number_slip_systems = 48
    slip_sys_file_name = bcc_input_slip_sys.txt
    number_cross_slip_directions = 4
    number_cross_slip_planes = 12
    initial_mobile_dislocation_density = 2.0e7 #96e7 total in crystal
    initial_immobile_dislocation_density = 3.0e7 #144e7 total in crystal
    Peierls_stress = 390.0  #Alpha-iron is 11MPa
    shear_modulus = 78489
#    resistance_tol = 10
    maximum_substep_iteration = 10
#    rtol = 1e-06
#    abs_tol = 4e-6
    maxiter = 30
    maxiter_state_variable = 30
    line_search_method = CUT_HALF
    use_line_search = true
  [../]
  [./elasticity_tensor8]
    type = ComputeElasticityTensorCP
    block = 8
    C_ijkl = '274.7e3 117.7e3 117.7e3 274.7e3 117.7e3 274.7e3 78.49e3 78.49e3 78.49e3'
#    C_ijkl = '242.0e3 150.0e3 150.0e3 242.06e3 150.0e3 242.0e3 112.0e3 112.0e3 112.0e3' # From Hirth and Loethe, 1969, pure alpha iron
    fill_method = symmetric9
    euler_angle_1 = 120.0
    euler_angle_2 = 30.0
    euler_angle_3 = 125.0
  [../]
  [./stress8]
    type = ComputeCrystalPlasticityStress
    block = 8
    crystal_plasticity_update_model = 'trial_xtalpl8'
  [../]
  [./trial_xtalpl8]
    type = CrystalPlasticityCDDUpdate
    block = 8
    number_slip_systems = 48
    slip_sys_file_name = bcc_input_slip_sys.txt
    number_cross_slip_directions = 4
    number_cross_slip_planes = 12
    initial_mobile_dislocation_density = 2.0e7 #96e7 total in crystal
    initial_immobile_dislocation_density = 3.0e7 #144e7 total in crystal
    Peierls_stress = 390.0  #Alpha-iron is 11MPa
    shear_modulus = 78489
#    resistance_tol = 10
    maximum_substep_iteration = 10
#    rtol = 1e-06
#    abs_tol = 4e-6
    maxiter = 30
    maxiter_state_variable = 30
    line_search_method = CUT_HALF
    use_line_search = true
  [../]
[]

[Postprocessors]
  [./stress_zz]
    type = ElementAverageValue
    variable = stress_zz
  [../]
  [./pk2]
    type = ElementAverageValue
    variable = pk2
  [../]
  [./fp_zz]
    type = ElementAverageValue
    variable = fp_zz
  [../]
  [./rotout]
    type = ElementAverageValue
    variable = rotout
  [../]
  [./e_zz]
    type = ElementAverageValue
    variable = e_zz
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
  dt = 0.01
  [./TimeStepper]
    type = FunctionDT
    time_dt = '1e-1 1e-1  1e-2 1e-2'
    time_t  = '0    3.0   5.0  10.0'
  [../]

  #Preconditioned JFNK (default)
  solve_type = 'PJFNK'

  #petsc_options_iname = -pc_hypre_type
  #petsc_options_value = boomerang
  petsc_options = '-snes_ksp_ew'
  l_tol = 1e-2 # <--- l_tol is ignored when EW is used.
  petsc_options_iname = '-pc_type -pc_factor_mat_solver_package'
  petsc_options_value = 'lu superlu_dist'
  #petsc_options_iname = '-pc_type'
  #petsc_options_value = 'lu'

  nl_abs_tol = 1e-10
  nl_rel_step_tol = 1e-10
  dtmax = 10.0
  nl_rel_tol = 1e-10
  ss_check_tol = 1e-10
  end_time = 10.0
  dtmin = 1.0e-5
#  num_steps = 2
  nl_abs_step_tol = 1e-10
[]

[Outputs]
  csv = true
  exodus = true
[]
