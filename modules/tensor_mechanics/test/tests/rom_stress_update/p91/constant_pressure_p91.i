[GlobalParams]
  displacements = 'disp_x disp_y'
[]

[Mesh]
  [./mesh]
    type = PatchMeshGenerator
    dim = 2
  [../]
[]

[Problem]
  coord_type = RZ
[]

[AuxVariables]
  [./temperature]
    initial_condition = 850.0 #hard fail when equals the window
  [../]
  [./precipitate_density]
    initial_condition = 0.001
  [../]
  [./triaxiality_stress]
    order = FIRST
    family = MONOMIAL
  [../]
  [./vonmises_stress]
    order = FIRST
    family = MONOMIAL
  [../]
  [./effective_inelastic_strain]
    order = FIRST
    family = MONOMIAL
  [../]
  [./mobile_dislocations]
    order = FIRST
    family = MONOMIAL
  [../]
  [./immobile_dislocations]
    order = FIRST
    family = MONOMIAL
  [../]
  [./ROM_failure]
    order = CONSTANT
    family = MONOMIAL
  [../]
[]

[Modules/TensorMechanics/Master]
  [./all]
    strain = FINITE
    add_variables = true
    generate_output = 'stress_xx stress_xy stress_yy stress_zz strain_xx strain_xy strain_yy strain_zz'
    use_automatic_differentiation = true
  [../]
[]

[AuxKernels]
  [./triaxiality_stress]
    type = ADRankTwoScalarAux
    variable = triaxiality_stress
    rank_two_tensor = stress
    scalar_type = TriaxialityStress
  [../]
  [./vonmises_stress]
    type = ADRankTwoScalarAux
    variable = vonmises_stress
    rank_two_tensor = stress
    scalar_type = VonMisesStress
  [../]
  [./effective_inelastic_strain]
    type = ADMaterialRealAux
    variable = effective_inelastic_strain
    property = effective_creep_strain
  [../]
  [./mobile_dislocations]
    type = ADMaterialRealAux
    variable = mobile_dislocations
    property = mobile_dislocations
  [../]
  [./immobile_dislocations]
    type = ADMaterialRealAux
    variable = immobile_dislocations
    property = immobile_dislocations
  [../]
  [./ROM_failure]
    type = MaterialRealAux
    variable = ROM_failure
    property = ROM_failure
  [../]
[]

[BCs]
  [./symmx]
    type = ADDirichletBC
    variable = disp_x
    boundary = left
    value = 0
  [../]
  [./symmy]
    type = ADDirichletBC
    variable = disp_y
    boundary = bottom
    value = 0
  [../]
  [./pressure_y]
    type = ADPressure
    variable = disp_y
    component = 1
    boundary = top
    constant = 1.0e8  #considering a horizontal tube segment, as it were
  [../]
[]

[Materials]
  [./elasticity_tensor]
    type = ADComputeIsotropicElasticityTensor
    youngs_modulus = 1.68e11 #at 600C, from neml
    poissons_ratio = 0.31
  [../]
  [./stress]
    type = ADComputeMultipleInelasticStress
    inelastic_models = rom_stress_prediction
  [../]
  [./rom_stress_prediction]
    type = P91LAROMANCEStressUpdate
    temperature = temperature
    extrapolate_to_zero_stress = false
    environmental_factor = precipitate_density
    initial_mobile_dislocation_density = 5.0e12
    initial_immobile_dislocation_density = 1.0e13
  [../]
[]

[Preconditioning]
  [./SMP]
    type = SMP
    full = true
  [../]
[]

[Executioner]
  type = Transient
  solve_type = 'NEWTON'
  petsc_options_iname = '-ksp_type  -pc_type  -pc_factor_mat_solver_package'
  petsc_options_value = ' preonly    lu        superlu_dist'
  automatic_scaling = true
  line_search = 'none'

  l_max_its = 20
  l_tol = 1e-4
  nl_max_its = 10
  nl_abs_tol = 1e-16
  nl_rel_tol = 1e-4
  dt = 100.0
  end_time = 100.0
[]

[Postprocessors]
  [./effective_strain_avg]
    type = ElementAverageValue
    variable = effective_inelastic_strain
  [../]
  [./max_effective_strain]
    type = ElementExtremeValue
    variable = effective_inelastic_strain
    value_type = max
  [../]
  [./vonmises_stress]
    type = ElementAverageValue
    variable = vonmises_stress
  [../]
  [./max_vonmises_stress]
    type = ElementExtremeValue
    variable = vonmises_stress
    value_type = max
  [../]
  [./max_ROM_failure]
    type = ElementExtremeValue
    variable = ROM_failure
    value_type = max
  [../]
  [./triaxiality_stress]
    type = ElementAverageValue
    variable = triaxiality_stress
  [../]
  [./max_triaxiality_stress]
    type = ElementExtremeValue
    variable = triaxiality_stress
    value_type = max
  [../]
  [./temperature]
    type = ElementAverageValue
    variable = temperature
  [../]
  [./mobile_dislocations]
    type = ElementAverageValue
    variable = mobile_dislocations
  [../]
  [./max_mobile_dislocations]
    type = ElementExtremeValue
    variable = mobile_dislocations
    value_type = max
  [../]
  [./min_mobile_dislocations]
    type = ElementExtremeValue
    variable = mobile_dislocations
    value_type = min
  [../]
  [./immobile_dislocations]
    type = ElementAverageValue
    variable = immobile_dislocations
  [../]
  [./max_immobile_dislocations]
    type = ElementExtremeValue
    variable = immobile_dislocations
  [../]
  [./min_immobile_dislocations]
    type = ElementExtremeValue
    variable = immobile_dislocations
    value_type = min
  [../]
  [./stress_xx]
    type = ElementAverageValue
    variable = stress_xx
  [../]
  [./stress_xy]
    type = ElementAverageValue
    variable = stress_xy
  [../]
  [./stress_yy]
    type = ElementAverageValue
    variable = stress_yy
  [../]
  [./stress_zz]
    type = ElementAverageValue
    variable = stress_zz
  [../]
  [./strain_xx]
    type = ElementAverageValue
    variable = strain_xx
  [../]
  [./strain_xy]
    type = ElementAverageValue
    variable = strain_xy
  [../]
  [./strain_yy]
    type = ElementAverageValue
    variable = strain_yy
  [../]
  [./strain_zz]
    type = ElementAverageValue
    variable = strain_zz
  [../]
[]

[UserObjects]
  [./terminator]
    type = Terminator
    expression = 'max_ROM_failure > 0.0'
  [../]
[]

[Outputs]
  csv = true
  exodus = true
  perf_graph = true
[]
