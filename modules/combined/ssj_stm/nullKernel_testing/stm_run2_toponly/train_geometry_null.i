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
  # [lower_left_radius]
  #   type = TruncatedNormal
  #   mean = 1.4
  #   standard_deviation = 0.1
  #   lower_bound = 1.146
  #   upper_bound = 1.654
  # []
  # [lower_right_radius]
  #   type = TruncatedNormal
  #   mean = 1.4
  #   standard_deviation = 0.1
  #   lower_bound = 1.146
  #   upper_bound = 1.654
  # []
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
    type = MonteCarlo
    num_rows = 48 #1000
    # distributions = 'upper_left_radius upper_right_radius lower_left_radius lower_right_radius gauge_width gauge_height'
    distributions = 'upper_left_radius upper_right_radius gauge_width gauge_height'
    execute_on = PRE_MULTIAPP_SETUP
    seed = 251
  []
[]

[MultiApps]
  [base_mechanics]
    type = SamplerFullSolveMultiApp
    input_files = base_geometry_vary_only_top_null.i
    mode = normal
    # mode = batch-reset #Overwrites results
    sampler = train_sample
  []
[]

[Controls]
  [geom_variation]
    type = MultiAppSamplerControl
    multi_app = base_mechanics
    sampler = train_sample
    # param_names = 'upper_left_radius upper_right_radius lower_left_radius lower_right_radius gauge_width gauge_height'
    param_names = 'upper_left_radius upper_right_radius gauge_width gauge_height'
  []
[]

[Transfers]
  [data]
    type = SamplerReporterTransfer
    from_multi_app = base_mechanics
    sampler = train_sample
    stochastic_reporter = storage
    from_reporter = 'p1_stress_xx/value'
  []
[]

[Reporters]
  [storage]
    type = StochasticReporter
    parallel_type = ROOT
  []

  [train_p1_stress_xx]
    type = EvaluateSurrogate
    model = GP_p1_stress_xx
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
[]

[Trainers]
  [GP_p1_stress_xx_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    sampler = train_sample
    response = storage/data:p1_stress_xx:value
    tune_parameters = 'signal_variance length_factor'
    tuning_algorithm = 'adam'
    iter_adam = 200 #5000
    # batch_size = 200
    learning_rate_adam = 0.001
    skip_unconverged_samples = true
    converged_reporter = storage/data:converged
  []
[]

[Surrogates]
  [GP_p1_stress_xx]
    type = GaussianProcess
    trainer = GP_p1_stress_xx_trainer
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
  [hyperparams_p1_stress_xx]
    type = GaussianProcessData
    gp_name = 'GP_p1_stress_xx'
    execute_on = final
  []
[]

[Outputs]
  [out]
    type = CSV
    execute_on = FINAL
  []
[]
