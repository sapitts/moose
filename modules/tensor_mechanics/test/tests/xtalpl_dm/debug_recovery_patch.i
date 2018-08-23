[GlobalParams]
  displacements = 'disp_x disp_y'
[]

[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 2
  ny = 2
[]

[AuxVariables]
  [./stress_xx_recovered]
    order = FIRST
    family = LAGRANGE
  [../]
  # [./stress_yy_recovered]
  #   order = FIRST
  #   family = MONOMIAL
  # [../]
  [./stress_zz]
    order = FIRST
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
  [./stress_xx_recovered]
    type = RankTwoAux
    patch_polynomial_order = first
    rank_two_tensor = stress
    variable = stress_xx_recovered
    index_i = 0
    index_j = 0
    execute_on = 'nonlinear'
  [../]
  # [./stress_yy_recovered]
  #   type = RankTwoAux
  #   patch_polynomial_order = first
  #   rank_two_tensor = stress
  #   variable = stress_yy_recovered
  #   index_i = 1
  #   index_j = 1
  #   execute_on = 'timestep_end'
  # [../]
  [./stress_zz]
    type = RankTwoAux
    variable = stress_zz
    rank_two_tensor = stress
    index_j = 2
    index_i = 2
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
  [./tdisp]
    type = FunctionPresetBC
    variable = disp_y
    boundary = top
    function = tdisp
  [../]
[]

[Materials]
  [./elasticity_tensor]
    type = ComputeElasticityTensorConstantRotationCP
    C_ijkl = '1.684e5 1.214e5 1.214e5 1.684e5 1.214e5 1.684e5 0.754e5 0.754e5 0.754e5'
    fill_method = symmetric9
    euler_angle_1 = 90
    euler_angle_2 = 90
    euler_angle_3 = 0
  [../]
  [./stress]
    type = ComputeCrystalPlasticityStress
    crystal_plasticity_update_model = 'trial_xtalpl'
  [../]
  [./trial_xtalpl]
    type = CrystalPlasticityKalidindiUpdate
    number_slip_systems = 12
    slip_sys_file_name = fcc_input_slip_sys.txt
  [../]
[]

[Postprocessors]
  [./stress_zz]
    type = ElementAverageValue
    variable = stress_zz
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
  solve_type = 'PJFNK'

  l_tol = 1e-3
  petsc_options_iname = '-pc_type -pc_asm_overlap -sub_pc_type -ksp_type -ksp_gmres_restart'
  petsc_options_value = ' asm      2              lu            gmres     200'
  nl_abs_tol = 1e-10
  nl_rel_tol = 1e-10

  num_steps = 2
  dt = 0.05
  # end_time = 10
  dtmin = 0.01
  dtmax = 10.0
[]

[Outputs]
  exodus = true
[]
