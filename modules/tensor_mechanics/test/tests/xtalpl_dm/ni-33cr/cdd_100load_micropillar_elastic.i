#Ni-33CrModel alloy, without defects
[GlobalParams]
  displacements = 'disp_x disp_y disp_z'
[]

[Mesh]
  type = FileMesh
  file = micropillar_compression_1pt5xph.e
[]

[AuxVariables]
  [./nodal_force_x]
    order = FIRST
    family = LAGRANGE
  [../]
  [./nodal_force_y]
    order = FIRST
    family = LAGRANGE
  [../]
  [./nodal_force_z]
    order = FIRST
    family = LAGRANGE
  [../]
  [./stress_zz]
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
  [./e_xx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_yy]
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
        save_in = 'nodal_force_x nodal_force_y nodal_force_z'
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
  [./e_zz]
    type = RankTwoAux
    variable = e_zz
    rank_two_tensor = total_strain
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
  [./e_xx]
    type = RankTwoAux
    variable = e_xx
    rank_two_tensor = total_strain
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
  [./e_yy]
    type = RankTwoAux
    variable = e_yy
    rank_two_tensor = total_strain
    index_j = 1
    index_i = 1
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
[]

[BCs]
  [./roller_bot_x]
    type = PresetBC
    variable = disp_x
    boundary = substrate-bottom
    value = 0
  [../]
  [./fixed_sides_y]
    type = PresetBC
    variable = disp_y
    boundary = 'substrate-right substrate-left'
    value = 0
  [../]
  [./fixed_sides_z]
    type = PresetBC
    variable = disp_z
    boundary = 'substrate-back substrate-front'
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
  [./elasticity_tensor_elastic]
    type = ComputeIsotropicElasticityTensor
    lambda = 186.817e6
    shear_modulus = 72.773e3
  [../]
  [./elastic_stress]
    type = ComputeFiniteStrainElasticStress
  [../]
[]

[Postprocessors]
  [./nodal_force_x_sum]
    type = NodalSum
    variable = nodal_force_x
    boundary = pillar-top
  [../]
  [./nodal_force_y_sum]
    type = NodalSum
    variable = nodal_force_y
    boundary = pillar-top
  [../]
  [./nodal_force_z_sum]
    type = NodalSum
    variable = nodal_force_z
    boundary = pillar-top
  [../]
  [./stress_zz]
    type = ElementAverageValue
    variable = stress_zz
  [../]
  [./e_zz]
    type = ElementAverageValue
    variable = e_zz
  [../]
  [./stress_xx]
    type = ElementAverageValue
    variable = stress_xx
  [../]
  [./e_xx]
    type = ElementAverageValue
    variable = e_xx
  [../]
  [./stress_yy]
    type = ElementAverageValue
    variable = stress_yy
  [../]
  [./e_yy]
    type = ElementAverageValue
    variable = e_yy
  [../]
  [./vonmises_stress_cauchy]
    type = ElementAverageValue
    variable = vonmises_stress_cauchy
  [../]
  [./effective_strain_green]
    type = ElementAverageValue
    variable = eff_strain_green
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
  interval = 50
  exodus = true
  [pgraph]
    type = PerfGraphOutput
    execute_on = 'initial final'  # Default is "final"
    level = 3                     # Default is 1
  []
[]
