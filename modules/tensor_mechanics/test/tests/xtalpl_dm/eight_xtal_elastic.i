[Mesh]
  file = eight_xtal.e
[]

[GlobalParams]
  displacements = 'disp_x disp_y disp_z'
[]

[Functions]
  [./tdisp]
    type = ParsedFunction
    value = '0.01 * t'
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
  [./symmz]
    type = PresetBC
    variable = disp_z
    boundary = back
    value = 0
  [../]
  [./tdisp]
    type = FunctionPresetBC
    variable = disp_z
    boundary = front
    function = tdisp
  [../]
[]

[Materials]
  [./elasticity_tensor1]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 1.0e7
    poissons_ratio = 0.25
    block = 1
  [../]
  [./stress1]
    type = ComputeFiniteStrainElasticStress
    block = 1
  [../]
  [./elasticity_tensor2]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 2.0e7
    poissons_ratio = 0.25
    block = 2
  [../]
  [./stress2]
    type = ComputeFiniteStrainElasticStress
    block = 2
  [../]
  [./elasticity_tensor3]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 3.0e7
    poissons_ratio = 0.25
    block = 3
  [../]
  [./stress3]
    type = ComputeFiniteStrainElasticStress
    block = 3
  [../]
  [./elasticity_tensor4]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 4.0e7
    poissons_ratio = 0.25
    block = 4
  [../]
  [./stress4]
    type = ComputeFiniteStrainElasticStress
    block = 4
  [../]
  [./elasticity_tensor5]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 5.0e7
    poissons_ratio = 0.25
    block = 5
  [../]
  [./stress5]
    type = ComputeFiniteStrainElasticStress
    block = 5
  [../]
  [./elasticity_tensor6]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 6.0e7
    poissons_ratio = 0.25
    block = 6
  [../]
  [./stress6]
    type = ComputeFiniteStrainElasticStress
    block = 6
  [../]
  [./elasticity_tensor7]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 7.0e7
    poissons_ratio = 0.25
    block = 7
  [../]
  [./stress7]
    type = ComputeFiniteStrainElasticStress
    block = 7
  [../]
  [./elasticity_tensor8]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 8.0e7
    poissons_ratio = 0.25
    block = 8
  [../]
  [./stress8]
    type = ComputeFiniteStrainElasticStress
    block = 8
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
  dt = 0.05

  #Preconditioned JFNK (default)
  solve_type = 'PJFNK'

  petsc_options_iname = -pc_hypre_type
  petsc_options_value = boomeramg
  nl_abs_tol = 1e-10
  nl_rel_step_tol = 1e-10
  dtmax = 10.0
  nl_rel_tol = 1e-10
  ss_check_tol = 1e-10
  end_time = 1
  dtmin = 0.05
  num_steps = 10
  nl_abs_step_tol = 1e-10
[]

[Outputs]
  exodus = true
[]
