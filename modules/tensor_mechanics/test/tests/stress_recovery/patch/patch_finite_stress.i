[GlobalParams]
  displacements = 'disp_x disp_y'
[]

[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 10
  ny = 10
  elem_type = QUAD9
  uniform_refine = 0
[]

[Variables]
  [disp_x]
    order = Second
    family = LAGRANGE
  []
  [disp_y]
    order = Second
    family = LAGRANGE
  []
[]

[AuxVariables]
  [stress_xx]
    order = Second
    family = MONOMIAL
  []
  [stress_yy]
    order = Second
    family = MONOMIAL
  []
  [stress_xx_recovered]
    order = Second
    family = LAGRANGE
  []
  [stress_yy_recovered]
    order = Second
    family = LAGRANGE
  []
[]

[AuxKernels]
  [stress_xx]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xx
    index_i = 0
    index_j = 0
    execute_on = 'timestep_end'
  []
  [stress_yy]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_yy
    index_i = 1
    index_j = 1
    execute_on = 'timestep_end'
  []
  [stress_xx_recovered]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xx_recovered
    index_i = 0
    index_j = 0
    execute_on = 'timestep_end'
  []
  [stress_yy_recovered]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_yy_recovered
    index_i = 1
    index_j = 1
    execute_on = 'timestep_end'
  []
[]

[Kernels]
  [solid_x]
    type = StressDivergenceTensors
    variable = disp_x
    component = 0
  []
  [solid_y]
    type = StressDivergenceTensors
    variable = disp_y
    component = 1
  []
[]

[Materials]
  [strain]
    type = ComputeFiniteStrain
  []
  [Cijkl]
    type = ComputeIsotropicElasticityTensor
    poissons_ratio = 0.3
    youngs_modulus = 2.1e+5
  []
  [stress]
    type = ComputeFiniteStrainElasticStress
  []
[]

[BCs]
  [top_xdisp]
    type = FunctionPresetBC
    variable = disp_y
    boundary = 'top'
    function = 0
  []
  [top_ydisp]
    type = FunctionPresetBC
    variable = disp_y
    boundary = 'top'
    function = t
  []
  [bottom_xdisp]
    type = FunctionPresetBC
    variable = disp_x
    boundary = 'bottom'
    function = 0
  []
  [bottom_ydisp]
    type = FunctionPresetBC
    variable = disp_y
    boundary = 'bottom'
    function = 0
  []
[]

[Postprocessors]
  [stress_xx]
    type = ElementAverageValue
    variable = stress_xx
  []
  [stress_yy]
    type = ElementAverageValue
    variable = stress_yy
  []
  [stress_xx_recovered]
    type = ElementAverageValue
    variable = stress_xx_recovered
  []
  [stress_yy_recovered]
    type = ElementAverageValue
    variable = stress_yy_recovered
  []
[]

[Preconditioning]
  [smp]
    type = SMP
    full = true
    ksp_norm = default
  []
[]

[Executioner]
  type = Transient
  solve_type = NEWTON
  petsc_options_iname = '-ksp_type -pc_type'
  petsc_options_value = 'preonly   lu'
  nl_abs_tol = 1e-8
  nl_rel_tol = 1e-8
  l_max_its = 100
  nl_max_its = 30
  dt = 0.01
  dtmin = 1e-11
  start_time = 0
  end_time = 0.05
[]

[Outputs]
  exodus = true
  print_linear_residuals = false
  console = true
[]
