[StochasticTools]
[]

[Distributions]
  [upper_left_radius]
    type = TruncatedNormal
    mean = 1.4
    standard_deviation = 0.1
    lower_bound = 1.146
    upper_bound = 1.654
  []
  [upper_right_radius]
    type = TruncatedNormal
    mean = 1.4
    standard_deviation = 0.1
    lower_bound = 1.146
    upper_bound = 1.654
  []
  [lower_left_radius]
    type = TruncatedNormal
    mean = 1.4
    standard_deviation = 0.1
    lower_bound = 1.146
    upper_bound = 1.654
  []
  [lower_right_radius]
    type = TruncatedNormal
    mean = 1.4
    standard_deviation = 0.1
    lower_bound = 1.146
    upper_bound = 1.654
  []
  [gauge_width]
    type = TruncatedNormal
    mean = 1.2
    standard_deviation = 0.1
    lower_bound = 1.166 # constrained by mesh generating procedure
    upper_bound = 1.454
  []
  [gauge_height]
    type = TruncatedNormal
    mean = 5.7
    standard_deviation = 0.1
    lower_bound = 5.446
    upper_bound = 5.954
  []
[]

[GlobalParams]
  sampler = quadrature
  distributions = 'upper_left_radius upper_right_radius lower_left_radius lower_right_radius gauge_width gauge_height'
[]

[Samplers]
  [quadrature]
    type = Quadrature
    order = 4 ## NEED to check on the order value, I think this was an optimization
    sparse_grid = smolyak
    execute_on = PRE_MULTIAPP_SETUP
  []
[]

[MultiApps]
  [base_mechanics]
    type = SamplerFullSolveMultiApp
    input_files = base_geometry_elastic.i
    mode = batch-reset
  []
[]

[Controls]
  [geom_variation]
    type = MultiAppSamplerControl
    multi_app = base_mechanics
    param_names = "upper_left_radius upper_right_radius" #' lower_left_radius[2] lower_right_radius[3] gauge_width[4] gauge_height[5]'
  []
[]

[Transfers]
  [data]
    type = SamplerReporterTransfer
    from_multi_app = base_mechanics
    stochastic_reporter = storage
    from_reporter = 'p1_stress_xx/value p2_stress_xx/value p3_stress_xx/value p4_stress_xx/value p5_stress_xx/value p6_stress_xx/value p7_stress_xx/value p8_stress_xx/value p9_stress_xx/value max_stress_xx/value p1_strain_yy/value p2_strain_yy/value p3_strain_yy/value p4_strain_yy/value p5_strain_yy/value p6_strain_yy/value p7_strain_yy/value p8_strain_yy/value p9_strain_yy/value max_strain_yy/value'
  []
[]

[Reporters]
  [storage]
    type = StochasticReporter
  []
[]

[Trainers]
  [poly_chaos_p1_stress_xx]
    type = PolynomialChaosTrainer
    execute_on = timestep_end
    order = 4
    response = storage/data:p1_stress_xx:value
    converged_reporter = storage/data:converged
    skip_unconverged_samples = true
  []
  [poly_chaos_p2_stress_xx]
    type = PolynomialChaosTrainer
    execute_on = timestep_end
    order = 4
    response = storage/data:p2_stress_xx:value
    converged_reporter = storage/data:converged
    skip_unconverged_samples = true
  []
  [poly_chaos_p3_stress_xx]
    type = PolynomialChaosTrainer
    execute_on = timestep_end
    order = 4
    response = storage/data:p3_stress_xx:value
    converged_reporter = storage/data:converged
    skip_unconverged_samples = true
  []
  [poly_chaos_p4_stress_xx]
    type = PolynomialChaosTrainer
    execute_on = timestep_end
    order = 4
    response = storage/data:p4_stress_xx:value
    converged_reporter = storage/data:converged
    skip_unconverged_samples = true
  []
  [poly_chaos_p5_stress_xx]
    type = PolynomialChaosTrainer
    execute_on = timestep_end
    order = 4
    response = storage/data:p5_stress_xx:value
    converged_reporter = storage/data:converged
    skip_unconverged_samples = true
  []
  [poly_chaos_p6_stress_xx]
    type = PolynomialChaosTrainer
    execute_on = timestep_end
    order = 4
    response = storage/data:p6_stress_xx:value
    converged_reporter = storage/data:converged
    skip_unconverged_samples = true
  []
  [poly_chaos_p7_stress_xx]
    type = PolynomialChaosTrainer
    execute_on = timestep_end
    order = 4
    response = storage/data:p7_stress_xx:value
    converged_reporter = storage/data:converged
    skip_unconverged_samples = true
  []
  [poly_chaos_p8_stress_xx]
    type = PolynomialChaosTrainer
    execute_on = timestep_end
    order = 4
    response = storage/data:p8_stress_xx:value
    converged_reporter = storage/data:converged
    skip_unconverged_samples = true
  []
  [poly_chaos_p9_stress_xx]
    type = PolynomialChaosTrainer
    execute_on = timestep_end
    order = 4
    response = storage/data:p9_stress_xx:value
    converged_reporter = storage/data:converged
    skip_unconverged_samples = true
  []
  [poly_chaos_max_stress_xx]
    type = PolynomialChaosTrainer
    execute_on = timestep_end
    order = 4
    response = storage/data:max_stress_xx:value
    converged_reporter = storage/data:converged
    skip_unconverged_samples = true
  []

  [poly_chaos_p1_stress_yy]
    type = PolynomialChaosTrainer
    execute_on = timestep_end
    order = 4
    response = storage/data:p1_stress_yy:value
    converged_reporter = storage/data:converged
    skip_unconverged_samples = true
  []
  [poly_chaos_p2_stress_yy]
    type = PolynomialChaosTrainer
    execute_on = timestep_end
    order = 4
    response = storage/data:p2_stress_yy:value
    converged_reporter = storage/data:converged
    skip_unconverged_samples = true
  []
  [poly_chaos_p3_stress_yy]
    type = PolynomialChaosTrainer
    execute_on = timestep_end
    order = 4
    response = storage/data:p3_stress_yy:value
    converged_reporter = storage/data:converged
    skip_unconverged_samples = true
  []
  [poly_chaos_p4_stress_yy]
    type = PolynomialChaosTrainer
    execute_on = timestep_end
    order = 4
    response = storage/data:p4_stress_yy:value
    converged_reporter = storage/data:converged
    skip_unconverged_samples = true
  []
  [poly_chaos_p5_stress_yy]
    type = PolynomialChaosTrainer
    execute_on = timestep_end
    order = 4
    response = storage/data:p5_stress_yy:value
    converged_reporter = storage/data:converged
    skip_unconverged_samples = true
  []
  [poly_chaos_p6_stress_yy]
    type = PolynomialChaosTrainer
    execute_on = timestep_end
    order = 4
    response = storage/data:p6_stress_yy:value
    converged_reporter = storage/data:converged
    skip_unconverged_samples = true
  []
  [poly_chaos_p7_stress_yy]
    type = PolynomialChaosTrainer
    execute_on = timestep_end
    order = 4
    response = storage/data:p7_stress_yy:value
    converged_reporter = storage/data:converged
    skip_unconverged_samples = true
  []
  [poly_chaos_p8_stress_yy]
    type = PolynomialChaosTrainer
    execute_on = timestep_end
    order = 4
    response = storage/data:p8_stress_yy:value
    converged_reporter = storage/data:converged
    skip_unconverged_samples = true
  []
  [poly_chaos_p9_stress_yy]
    type = PolynomialChaosTrainer
    execute_on = timestep_end
    order = 4
    response = storage/data:p9_stress_yy:value
    converged_reporter = storage/data:converged
    skip_unconverged_samples = true
  []
  [poly_chaos_max_stress_yy]
    type = PolynomialChaosTrainer
    execute_on = timestep_end
    order = 4
    response = storage/data:max_stress_yy:value
    converged_reporter = storage/data:converged
    skip_unconverged_samples = true
  []
[]

[Outputs]
  execute_on = timestep_end
  [trainer]
    type = SurrogateTrainerOutput
    trainers = 'poly_chaos_p1_stress_xx poly_chaos_p2_stress_xx poly_chaos_p3_stress_xx poly_chaos_p4_stress_xx poly_chaos_p5_stress_xx poly_chaos_p6_stress_xx poly_chaos_p7_stress_xx poly_chaos_p8_stress_xx poly_chaos_p9_stress_xx poly_chaos_max_stress_xx poly_chaos_p1_stress_yy poly_chaos_p2_stress_yy poly_chaos_p3_stress_yy poly_chaos_p4_stress_yy poly_chaos_p5_stress_yy poly_chaos_p6_stress_yy poly_chaos_p7_stress_yy poly_chaos_p8_stress_yy poly_chaos_p9_stress_yy poly_chaos_max_stress_yy'
  []
[]
