[StochasticTools]
[]

[Distributions]
  [upper_left_undercut]
    type = TruncatedNormal
    mean = 0.0249  #values collected by Drew
    standard_deviation = 0.011
    lower_bound = 0.0
    upper_bound = 0.0508
  []
  [upper_right_undercut]
    type = TruncatedNormal
    mean = 0.0249
    standard_deviation = 0.011
    lower_bound = 0.0
    upper_bound = 0.0508
  []
  [lower_left_undercut]
    type = TruncatedNormal
    mean = 0.0249
    standard_deviation = 0.011
    lower_bound = 0.0
    upper_bound = 0.0508
  []
  [lower_right_undercut]
    type = TruncatedNormal
    mean = 0.0249
    standard_deviation = 0.011
    lower_bound = 0.0
    upper_bound = 0.0508
  []
  [gauge_width]
    type = TruncatedNormal
    mean = 1.2
    standard_deviation = 0.1
    lower_bound = 0.946
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

[Samplers]
  [train_sample]
    type = LatinHypercube
    num_rows = 1000
    distributions = 'upper_left_undercut upper_right_undercut lower_left_undercut lower_right_undercut gauge_width gauge_height'
    execute_on = PRE_MULTIAPP_SETUP
    seed = 1123
  []
    # [csv_sample]
  #   type = CSVSampler
  #   samples_file = 'samples.csv'
  #   column_names = 'upper_left_undercut upper_right_undercut lower_left_undercut lower_right_undercut gauge_width gauge_height'
  #   execute_on = 'initial timestep_end'
  # []
[]

[MultiApps]
  [base_mechanics]
    type = SamplerFullSolveMultiApp
    input_files = base_shoulder_undercut_elastic2d.i
    mode = batch-reset #Overwrites results
    sampler = train_sample
  []
[]

[Controls]
  [geom_variation]
    type = MultiAppSamplerControl
    multi_app = base_mechanics
    sampler = train_sample
    param_names = 'upper_left_undercut upper_right_undercut lower_left_undercut lower_right_undercut gauge_width gauge_height'
    # param_names = 'upper_left_undercut upper_right_undercut gauge_width gauge_height'
  []
[]

[Transfers]
  [data]
    type = SamplerReporterTransfer
    from_multi_app = base_mechanics
    sampler = train_sample
    stochastic_reporter = storage
    from_reporter = 'p1_stress_xx/value p2_stress_xx/value p3_stress_xx/value p4_stress_xx/value p5_stress_xx/value p6_stress_xx/value p7_stress_xx/value p8_stress_xx/value p9_stress_xx/value max_stress_xx/value p1_stress_yy/value p2_stress_yy/value p3_stress_yy/value p4_stress_yy/value p5_stress_yy/value p6_stress_yy/value p7_stress_yy/value p8_stress_yy/value p9_stress_yy/value max_stress_yy/value p1_vonmises_stress/value p2_vonmises_stress/value p3_vonmises_stress/value p4_vonmises_stress/value p5_vonmises_stress/value p6_vonmises_stress/value p7_vonmises_stress/value p8_vonmises_stress/value p9_vonmises_stress/value max_vonmises_stress/value'
  []
[]

[Reporters]
  [storage]
    type = StochasticReporter
    parallel_type = ROOT
  []

  [train_p5_stress_yy]
    type = EvaluateSurrogate
    model = GP_p5_stress_yy
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
[]

[Trainers]
  [GP_p5_stress_yy_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    show_optimization_details = true
    sampler = train_sample
    response = storage/data:p5_stress_yy:value
    tune_parameters = 'signal_variance length_factor noise_variance'
    tuning_algorithm = 'adam'
    iter_adam = 2000
   # batch_size = 100
    learning_rate_adam = 1.0e-4
    skip_unconverged_samples = true
    converged_reporter = storage/data:converged
  []
[]

[Surrogates]
  [GP_p5_stress_yy]
    type = GaussianProcess
    trainer = GP_p5_stress_yy_trainer
  []
[]

[Covariance]
  [covar]
    type = SquaredExponentialCovariance
    signal_variance = 1.0 #Use a signal variance of 1 in the kernel
    noise_variance = 1e-4 #A small amount of noise can help with numerical stability
    length_factor = '1.0 1.0 1.0 1.0 1.0 1.0' #Select a length factor for each parameter
  []
[]

[VectorPostprocessors]
  [hyperparams_p5_stress_yy]
    type = GaussianProcessData
    gp_name = 'GP_p5_stress_yy'
    execute_on = final
  []
[]

[Outputs]
  file_base = generate_data_2d_shoulders
  [out]
    type = CSV
    execute_on = FINAL
  []
  [stout]
    type = SurrogateTrainerOutput
    # trainers = 'GP_p1_stress_yy GP_p2_stress_yy GP_p3_stress_yy GP_p4_stress_yy GP_p5_stress_yy GP_p6_stress_yy GP_p7_stress_yy GP_p8_stress_yy GP_p9_stress_yy GP_max_stress_yy GP_p1_vonmises_stress GP_p2_vonmises_stress GP_p3_vonmises_stress GP_p4_vonmises_stress GP_p5_vonmises_stress GP_p6_vonmises_stress GP_p7_vonmises_stress GP_p8_vonmises_stress GP_p9_vonmises_stress GP_max_vonmises_stress'
    trainers = 'GP_p5_stress_yy_trainer'
    execute_on = FINAL
  []
[]
