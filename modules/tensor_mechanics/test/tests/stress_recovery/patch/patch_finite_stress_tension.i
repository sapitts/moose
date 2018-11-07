[GlobalParams]
  displacements = 'disp_x disp_y'
[]

[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 20
  ny = 20
  elem_type = QUAD4
[]

[Variables]
  [disp_x]
  []
  [disp_y]
  []
[]

[AuxVariables]
  [stress_xx_first_monomial]
    order = first
    family = MONOMIAL
  []
  [stress_yy_first_monomial]
    order = first
    family = MONOMIAL
  []
  [stress_xy_first_monomial]
    order = first
    family = MONOMIAL
  []
  [stress_xx_const_monomial]
    order = constant
    family = MONOMIAL
  []
  [stress_yy_const_monomial]
    order = constant
    family = MONOMIAL
  []
  [stress_xy_const_monomial]
    order = constant
    family = MONOMIAL
  []
  [stress_xx_recovered]
    order = first
    family = LAGRANGE
  []
  [stress_yy_recovered]
    order = first
    family = LAGRANGE
  []
  [stress_xy_recovered]
    order = first
    family = LAGRANGE
  []
  [strain_xx_first_monomial]
    order = first
    family = MONOMIAL
  []
  [strain_yy_first_monomial]
    order = first
    family = MONOMIAL
  []
  [strain_xy_first_monomial]
    order = first
    family = MONOMIAL
  []
  [strain_xx_const_monomial]
    order = constant
    family = MONOMIAL
  []
  [strain_yy_const_monomial]
    order = constant
    family = MONOMIAL
  []
  [strain_xy_const_monomial]
    order = constant
    family = MONOMIAL
  []
  [strain_xx_recovered]
    order = first
    family = LAGRANGE
  []
  [strain_yy_recovered]
    order = first
    family = LAGRANGE
  []
  [strain_xy_recovered]
    order = first
    family = LAGRANGE
  []
[]

[AuxKernels]
  [stress_xx_first_monomial]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xx_first_monomial
    index_i = 0
    index_j = 0
    execute_on = 'timestep_end'
  []
  [stress_yy_first_monomial]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_yy_first_monomial
    index_i = 1
    index_j = 1
    execute_on = 'timestep_end'
  []
  [stress_xy_first_monomial]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xy_first_monomial
    index_i = 0
    index_j = 1
    execute_on = 'timestep_end'
  []
  [stress_xx_const_monomial]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xx_const_monomial
    index_i = 0
    index_j = 0
    execute_on = 'timestep_end'
  []
  [stress_yy_const_monomial]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_yy_const_monomial
    index_i = 1
    index_j = 1
    execute_on = 'timestep_end'
  []
  [stress_xy_const_monomial]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xy_const_monomial
    index_i = 0
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
  [stress_xy_recovered]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = stress_xy_recovered
    index_i = 0
    index_j = 1
    execute_on = 'timestep_end'
  []
  [strain_xx_first_monomial]
    type = RankTwoAux
    rank_two_tensor = total_strain
    variable = strain_xx_first_monomial
    index_i = 0
    index_j = 0
    execute_on = 'timestep_end'
  []
  [strain_yy_first_monomial]
    type = RankTwoAux
    rank_two_tensor = total_strain
    variable = strain_yy_first_monomial
    index_i = 1
    index_j = 1
    execute_on = 'timestep_end'
  []
  [strain_xy_first_monomial]
    type = RankTwoAux
    rank_two_tensor = total_strain
    variable = strain_xy_first_monomial
    index_i = 0
    index_j = 1
    execute_on = 'timestep_end'
  []
  [strain_xx_const_monomial]
    type = RankTwoAux
    rank_two_tensor = total_strain
    variable = strain_xx_const_monomial
    index_i = 0
    index_j = 0
    execute_on = 'timestep_end'
  []
  [strain_yy_const_monomial]
    type = RankTwoAux
    rank_two_tensor = total_strain
    variable = strain_yy_const_monomial
    index_i = 1
    index_j = 1
    execute_on = 'timestep_end'
  []
  [strain_xy_const_monomial]
    type = RankTwoAux
    rank_two_tensor = total_strain
    variable = strain_xy_const_monomial
    index_i = 0
    index_j = 1
    execute_on = 'timestep_end'
  []
  [strain_xx_recovered]
    type = RankTwoAux
    rank_two_tensor = total_strain
    variable = strain_xx_recovered
    index_i = 0
    index_j = 0
    execute_on = 'timestep_end'
  []
  [strain_yy_recovered]
    type = RankTwoAux
    rank_two_tensor = total_strain
    variable = strain_yy_recovered
    index_i = 1
    index_j = 1
    execute_on = 'timestep_end'
  []
  [strain_xy_recovered]
    type = RankTwoAux
    rank_two_tensor = total_strain
    variable = strain_xy_recovered
    index_i = 0
    index_j = 1
    execute_on = 'timestep_end'
  []

[]

[Kernels]
  [solid_x]
    type = StressDivergenceTensors
    variable = disp_x
    component = 0
    use_displaced_mesh = true
  []
  [solid_y]
    type = StressDivergenceTensors
    variable = disp_y
    component = 1
    use_displaced_mesh = true
  []
[]

[Materials]
  [strain]
    type = ComputeFiniteStrain
  []
  [Cijkl]
    type = ComputeIsotropicElasticityTensor
    poissons_ratio = 0.3
    youngs_modulus = 2.1e10
  []
  [stress]
    type = ComputeFiniteStrainElasticStress
  []
[]

[BCs]
  [top_y_disp]
    type = FunctionPresetBC
    variable = disp_y
    boundary = 'top'
    function = t
  []
  [bottom_xdisp]
    type = PresetBC
    variable = disp_x
    boundary = 'left'
    value = 0
  []
  [bottom_ydisp]
    type = PresetBC
    variable = disp_y
    boundary = 'bottom'
    value = 0
  []
[]

[Postprocessors]
  [stress_xx_first_monomial]
    type = ElementAverageValue
    variable = stress_xx_first_monomial
  []
  [stress_yy_first_monomial]
    type = ElementAverageValue
    variable = stress_yy_first_monomial
  []
  [stress_xy_first_monomial]
    type = ElementAverageValue
    variable = stress_xy_first_monomial
  []
  [stress_xx_const_monomial]
    type = ElementAverageValue
    variable = stress_xx_const_monomial
  []
  [stress_yy_const_monomial]
    type = ElementAverageValue
    variable = stress_yy_const_monomial
  []
  [stress_xy_const_monomial]
    type = ElementAverageValue
    variable = stress_xy_const_monomial
  []
  [stress_xx_recovered]
    type = ElementAverageValue
    variable = stress_xx_recovered
  []
  [stress_yy_recovered]
    type = ElementAverageValue
    variable = stress_yy_recovered
  []
  [stress_xy_recovered]
    type = ElementAverageValue
    variable = stress_xy_recovered
  []
  [strain_xx_first_monomial]
    type = ElementAverageValue
    variable = strain_xx_first_monomial
  []
  [strain_yy_first_monomial]
    type = ElementAverageValue
    variable = strain_yy_first_monomial
  []
  [strain_xy_first_monomial]
    type = ElementAverageValue
    variable = strain_xy_first_monomial
  []
  [strain_xx_const_monomial]
    type = ElementAverageValue
    variable = strain_xx_const_monomial
  []
  [strain_yy_const_monomial]
    type = ElementAverageValue
    variable = strain_yy_const_monomial
  []
  [strain_xy_const_monomial]
    type = ElementAverageValue
    variable = strain_xy_const_monomial
  []
  [strain_xx_recovered]
    type = ElementAverageValue
    variable = strain_xx_recovered
  []
  [strain_yy_recovered]
    type = ElementAverageValue
    variable = strain_yy_recovered
  []
  [strain_xy_recovered]
    type = ElementAverageValue
    variable = strain_xy_recovered
  []
  [./alive_time]
    type = PerformanceData
    event = ALIVE
  [../]
[]

[Preconditioning]
  [smp]
    type = SMP
    full = true
  []
[]

[Executioner]
  type = Transient
  solve_type = PJFNK
  nl_abs_tol = 1e-8
  nl_rel_tol = 1e-8
  l_max_its = 30
  nl_max_its = 30
  dt = 0.01
  dtmin = 1e-11
  start_time = 0
  end_time = 0.1
[]

[Outputs]
  perf_graph = true
  file_base = patch_finite_stress_tension_8proc_out
  exodus = true
  csv = true
  print_linear_residuals = false
[]
