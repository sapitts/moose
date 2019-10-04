[Mesh]
  type = GeneratedMesh
  dim = 2
  xmin = 0
  xmax = 1
  ymin = 0
  ymax = 1
  nx = 16
  ny = 16
[]

[Variables]
  [./phi]
  [../]
[]

[AuxVariables]
  [./vel_x]
    initial_condition = 0.01
  [../]
  [./vel_y]
    initial_condition = 0
  [../]
[]

[ICs]
  [./phi_ic]
    type = FunctionIC
    function = phi_exact
    variable = phi
  [../]
[]

[Functions]
  # [./phi_exact]
  #   type = LevelSetOlssonBubble
  #   epsilon = 0.05
  #   center = '0.5 0.5 0'
  #   radius = 0.15
  # [../]
  # [./sweep_function]
  #   type = ParsedFunction
  #   value = 'if(x<0.5,1,0)'
  # [../]
  [./phi_exact]
    type = ParsedFunction
    value = 'a*sin(pi*x/b)*cos(pi*x)'
    vars = 'a b'
    vals = '1 1'
  [../]
[]

[BCs]
  # [./Periodic]
  #   [./all]
  #     variable = phi
  #     auto_direction = 'y'
  #   [../]
  # [../]
  [./left_phi]
    type = DirichletBC
    variable = phi
    boundary = left
    value = 0.5
  [../]
  [./right_phi]
    type = DirichletBC
    variable = phi
    boundary = right
    value = 0
  [../]
[]

[Kernels]
  [./time]
    type = TimeDerivative
    variable = phi
  [../]
  [./advection]
    type = LevelSetAdvection
    velocity_x = vel_x
    variable = phi
  [../]
[]

[Postprocessors]
  [./cfl]
    type = LevelSetCFLCondition
    velocity_x = vel_x
    velocity_y = vel_y
    execute_on = 'initial'
  [../]
[]

[Executioner]
  type = Transient
  solve_type = PJFNK
  start_time = 0
  dtmax = 0.01
  end_time = 2
  scheme = crank-nicolson
  petsc_options_iname = '-pc_type -pc_sub_type'
  petsc_options_value = 'asm      ilu'
  [./TimeStepper]
    type = PostprocessorDT
    postprocessor = cfl
    scale = 0.8
  [../]
[]

[Outputs]
  csv = true
  exodus = true
[]
