[GlobalParams]
  order = SECOND
  family = LAGRANGE
  displacements = 'disp_x disp_y'
[]

[Problem]
  coord_type = RZ
  type = ReferenceResidualProblem
  extra_tag_vectors = 'ref'
  reference_vector = 'ref'
[]

[Mesh]
  [pipe]
    type = GeneratedMeshGenerator
    dim = 2
    xmin = 3.5325e-3  #Laromance will read these as in meters
    xmax = 4.3125e-3  #Laromance will read these as in meters
    ymin = 0          #Laromance will read these as in meters
    ymax = 0.01e-3    #Laromance will read these as in meters
    nx = 10
    ny = 1
    elem_type = quad9
  []
[]

[Modules/TensorMechanics/Master]
  [all]
    strain = FINITE
    add_variables = true
    generate_output = 'max_principal_stress max_principal_strain vonmises_stress
                      strain_xx strain_yy strain_zz
                      stress_xx stress_yy stress_zz'
    use_automatic_differentiation = true
    extra_vector_tags = 'ref'
  []
[]

[AuxVariables]
  [saved_x]
  []
  [saved_y]
  []
  [temperature]
    initial_condition = 872.9 #hard fail when equals the window
  []
  [precipitate_density]  # a laromance p91 requirement
    initial_condition = 0.001
  []
  [sint]
    order = CONSTANT
    family = MONOMIAL
  []
  [effective_inelastic_strain]
    order = FIRST
    family = MONOMIAL
  []
  [mobile_dislocations]
    order = FIRST
    family = MONOMIAL
  []
  [immobile_dislocations]
    order = FIRST
    family = MONOMIAL
  []
  [ROM_failure]
    order = CONSTANT
    family = MONOMIAL
  []
[]

[Functions]
  [inner_pressure]
    type = PiecewiseLinear
    x = '0 5000 2e8'  #time
    y = '0.0 1.0e6 1.0e6'  #pressure in Pa
   # y = '0.0 1.0 1.0'  #pressure in MPa
    scale_factor = 15
  []
  [timefunc]
    type = ParsedFunction
    value = t
  []
[]

[AuxKernels]
  [sint]
    type = ADRankTwoScalarAux
    rank_two_tensor = stress
    variable = sint
    scalar_type = stressIntensity
    execute_on = timestep_end
  []
  [vonmises_stress]
    type = ADRankTwoScalarAux
    variable = vonmises_stress
    rank_two_tensor = stress
    scalar_type = VonMisesStress
  []
  [effective_inelastic_strain]
    type = ADMaterialRealAux
    variable = effective_inelastic_strain
    property = effective_creep_strain
  []
  [mobile_dislocations]
    type = ADMaterialRealAux
    variable = mobile_dislocations
    property = mobile_dislocations
  []
  [immobile_dislocations]
    type = ADMaterialRealAux
    variable = immobile_dislocations
    property = immobile_dislocations
  []
  [ROM_failure]
    type = MaterialRealAux
    variable = ROM_failure
    property = ROM_failure
  []
[]

[BCs]
#  [fixTop]
#    type = DirichletBC
#    variable = disp_y
#    boundary = top
#    value = 0.0
#  []
  [fixBottom]
    type = DirichletBC
    variable = disp_y
    boundary = bottom
    value = 0.0
    preset=true
  []
  [Pressure]
    [inside]
      boundary = left
      function = inner_pressure
    []
  []
[]

[Materials]
  [elasticity_tensor]
    type = ADComputeIsotropicElasticityTensor
    youngs_modulus = 1.68e11 #at 600C, from neml
    poissons_ratio = 0.31
  []
  [stress]
    type = ADComputeMultipleInelasticStress
    inelastic_models = rom_stress_prediction
  []
  [rom_stress_prediction]
    type = P91LAROMANCEStressUpdate
    temperature = temperature
    extrapolate_to_zero_stress = true  #the default is true, but sometimes you can get into a bad state with the strain when the stress is allowed to go below the limit
    environmental_factor = precipitate_density
    initial_mobile_dislocation_density = 5.0e12
    initial_immobile_dislocation_density = 1.0e13
  []
[]

[Executioner]
  type = Transient
  solve_type = 'NEWTON'
  petsc_options_iname = '-pc_type -pc_factor_mat_solver_package'
  petsc_options_value = 'lu       superlu_dist'
  line_search = 'none'
  automatic_scaling = true

  l_max_its = 20
  l_tol = 1e-4
  nl_max_its = 10
  nl_abs_tol = 1e-16
  nl_rel_tol = 1e-4
  dt = 100.0
  # n_startup_steps = 2 #shouldn't be needed here
  end_time = 1000. #3.0e9
  dtmin = 1
  dtmax = 3e7
  #num_steps = 20

  [./Predictor]
    type = SimplePredictor
    scale = 1.0
  [../]
[]

[Postprocessors]
  [./num_lin_it]
    type = NumLinearIterations
  [../]
  [./num_nonlin_it]
    type = NumNonlinearIterations
  [../]
  [./tot_lin_it]
    type = CumulativeValuePostprocessor
    postprocessor = num_lin_it
  [../]
  [./tot_nonlin_it]
    type = CumulativeValuePostprocessor
    postprocessor = num_nonlin_it
  [../]

  [./end_time]
    type = 'FunctionValuePostprocessor'
    function = timefunc
  [../]

  [./max_strain_xx]
    type = ElementExtremeValue
    variable = strain_xx
    value_type = max
  [../]
  [./max_strain_yy]
    type = ElementExtremeValue
    variable = strain_yy
    value_type = max
  [../]
  [./max_strain_zz]
    type = ElementExtremeValue
    variable = strain_zz
    value_type = max
  [../]

  [./max_principal_strain]
    type = ElementExtremeValue
    variable = max_principal_strain
    value_type = max
  [../]
  [./max_principal_stress]
    type = ElementExtremeValue
    variable = max_principal_stress
    value_type = max
  [../]
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
[]

[UserObjects]
  [max_strain]
    type = Terminator
    expression = 'max_principal_strain > 0.01'
  []
[]

[Outputs]
  exodus = off
  csv = false
[]
