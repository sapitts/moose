[GlobalParams]
  order = FIRST
  family = LAGRANGE
  volumetric_locking_correction = true
  displacements = 'disp_x disp_y disp_z'
[]

[Mesh]
  file = simple_capsule_3d.e
[]

[Problem]
  type = ReferenceResidualProblem
  extra_tag_vectors = 'refs'
  reference_vector = 'refs'
  solution_variables = 'disp_x disp_y disp_z'
  group_variables = 'disp_x disp_y disp_z'
[]

[AuxVariables]
  [./temperature]
    initial_condition = 801.0
  [../]
  # [./hoop_inelastic_strain]
  #   order = CONSTANT
  #   family = MONOMIAL
  # [../]
  [./hoop_stress]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./mobile_dislocations]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./immobile_dislocations]
    order = CONSTANT
    family = MONOMIAL
  [../]
[]

[Modules/TensorMechanics/Master]
  [./all]
    strain = FINITE
    add_variables = true
    generate_output = 'stress_xx stress_yy stress_zz stress_xy vonmises_stress hydrostatic_stress elastic_strain_xx elastic_strain_yy elastic_strain_zz strain_xx strain_yy strain_zz thirdinv_stress'
    use_automatic_differentiation = true
    extra_vector_tags = 'refs'
    # eigenstrain_names = thermal
  [../]
[]

[AuxKernels]
  # [./temp]
  #     type = FunctionAux
  #     variable = temp
  #     function = pv_temp_ramp
  # [../]
  # [./hoop_inelastic_strain]
  #     type = RankTwoScalarAux
  #     rank_two_tensor = inelastic_strain
  #     variable = hoop_inelastic_strain
  #     scalar_type = HoopStress
  #     execute_on = timestep_end
  # [../]
  [./hoop_stress]
      type = RankTwoScalarAux
      rank_two_tensor = stress
      variable = hoop_stress
      scalar_type = HoopStress
      execute_on = timestep_end
  [../]
  [./mobile_dislocations]
    type = MaterialRealAux
    variable = mobile_dislocations
    property = mobile_dislocations
    execute_on = timestep_end
  [../]
  [./immobile_dislocations]
    type = MaterialRealAux
    variable = immobile_dislocations
    property = immobile_dislocations
    execute_on = timestep_end
  [../]
[]

[Functions]
  # [./inner_press_ramp]
  #   type = PiecewiseLinear
  #   x = '0 3600' # 86400'
  #   y = '4.75e6 10.0e6' # 15.0'
  # [../]
  # [./pv_temp_ramp]
  #   type = PiecewiseLinear
  #   x = '0   3600  86400'
  #   y = '0.0  450.0 450.0'
  # [../]
[]

[BCs]
  [./side1]
    type = PresetBC
    variable = disp_x
    boundary = 1 #left_vertical
    value = 0.0
  [../]
  [./side2]
    type = PresetBC
    variable = disp_z
    boundary = 2 #front_vertical
    value = 0.0
  [../]
  [./bottom]
    type = PresetBC
    variable = disp_y
    boundary = 3 #bottom_surface
    value = 0.0
  [../]
  [./Pressure]
    [./innerPressure]
      boundary = 4 #inside
      function = 2.0e6 #inner_press_ramp
    [../]
  [../]
[]

[Materials]
  [./elasticity_tensor_metal]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 1.93e11 ## 193 GPa
    poissons_ratio = 0.3
  [../]
  [./stress_metal]
    type = ADComputeMultipleInelasticStress
    # type = ADComputeFiniteStrainElasticStress
    inelastic_models = inelastic_stress_metal
  [../]
  [./inelastic_stress_metal]
    type = SS316HLAROMANCEStressUpdateTest
    temperature = temperature
    initial_mobile_dislocation_density = 8e+12
    initial_immobile_dislocation_density = 7e+11
    extrapolate_to_zero_stress = false
  [../]
  # [./eigenstrain_metal]
  #   type = ADComputeThermalExpansionEigenstrain
  #   stress_free_temperature = 800.0
  #   temperature = temperature
  #   thermal_expansion_coeff = 10.0e-8
  #   eigenstrain_name = 'no_pbr_eigenstrain'
  # [../]
[]

[Preconditioning]
  [./smp]
    type = SMP
    full = true
  [../]
[]

[Executioner]
  type = Transient

  solve_type = 'NEWTON'#'PJFNK'
  petsc_options_iname = '-ksp_gmres_restart -pc_type -pc_hypre_type -pc_hypre_boomeramg_max_iter'
  petsc_options_value = '201                hypre    boomeramg      8'

  line_search = 'bt' #'none' #'bt'
  automatic_scaling = true

  nl_rel_tol = 1e-8
  nl_abs_tol = 1e-18
  l_max_its = 30
  nl_max_its = 30
  end_time = 500.0 #86400.0
  l_tol = 1e-3
  dtmax = 1e2
  dt = 0.5

  # [./TimeStepper]
  #   type = IterationAdaptiveDT
  #   dt = 100
  #   time_t = '3600 86400'
  #   time_dt = '100  100'
  #   optimal_iterations = 15
  #   iteration_window = 5
  #   growth_factor = 1.4
  #   cutback_factor = 0.7
  # [../]

  # [./Predictor]
  #   type = SimplePredictor
  #   scale = 1.0
  # [../]
[]

[Postprocessors]
  [./sigma_xx]
    type = ElementAverageValue
    variable = stress_xx
  [../]
  [./sigma_yy]
    type = ElementAverageValue
    variable = stress_yy
  [../]
  [./sigma_zz]
    type = ElementAverageValue
    variable = stress_zz
  [../]
  [./vonmises]
    type = ElementAverageValue
    variable = vonmises_stress
  [../]
  [./pressure]
    type = ElementAverageValue
    variable = hydrostatic_stress
  [../]
  [./invariant3]
    type = ElementAverageValue
    variable = thirdinv_stress
  [../]
  [./dt]
    type = TimestepSize
  [../]
  [./elastic_strain_xx]
    type = ElementAverageValue
    variable = elastic_strain_xx
  [../]
  [./elastic_strain_yy]
    type = ElementAverageValue
    variable = elastic_strain_yy
  [../]
  [./elastic_strain_zz]
    type = ElementAverageValue
    variable = elastic_strain_zz
  [../]
  [./total_strain_xx]
    type = ElementAverageValue
    variable = strain_xx
  [../]
  [./total_strain_yy]
    type = ElementAverageValue
    variable = strain_yy
  [../]
  [./total_strain_zz]
    type = ElementAverageValue
    variable = strain_zz
  [../]
  # [./hoop_inelastic_strain]
  #   type = ElementAverageValue
  #   variable = hoop_inelastic_strain
  # [../]
  [./hoop_stress]
    type = ElementAverageValue
    variable = hoop_stress
  [../]
  [./yaxis_elongation]
    type = NodalMaxValue
    variable = disp_y
    boundary = 1
  [../]
  [./xaxis_elongation]
    type = NodalMaxValue
    variable = disp_x
    boundary = 2
  [../]
  [./mobile_dislocations]
    type = ElementAverageValue
    variable = mobile_dislocations
  [../]
  [./immobile_dislocations]
    type = ElementAverageValue
    variable = immobile_dislocations
  [../]
  [./num_lin_it]
    type = NumLinearIterations
  [../]
  [./num_nonlin_it]
    type = NumNonlinearIterations
  [../]
  [./total_lin_it]
    type = CumulativeValuePostprocessor
    postprocessor = num_lin_it
  [../]
  [./total_nonlin_it]
    type = CumulativeValuePostprocessor
    postprocessor = num_nonlin_it
  [../]
  [./alive_time]
    type = PerfGraphData
    section_name = Root
    data_type = TOTAL
  [../]
[]

[Outputs]
  print_linear_residuals = true
  perf_graph = true
  csv = true
  [./out]
    type = Exodus
    elemental_as_nodal = true
  [../]
  [./console]
    type = Console
    max_rows = 25
  [../]
[]
