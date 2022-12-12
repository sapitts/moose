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
    num_rows = 1000
    distributions = 'upper_left_radius upper_right_radius lower_left_radius lower_right_radius gauge_width gauge_height'
    execute_on = PRE_MULTIAPP_SETUP
    seed = 250
  []
  [evaluate_sample]
    type = MonteCarlo
    num_rows = 10000
    distributions = 'upper_left_radius upper_right_radius lower_left_radius lower_right_radius gauge_width gauge_height'
    execute_on = PRE_MULTIAPP_SETUP
    seed = 543
  []
[]

[MultiApps]
  [base_mechanics]
    type = SamplerFullSolveMultiApp
    input_files = base_geometry_elastic.i
    mode = batch-reset #Overwrites results
    sampler = train_sample
  []
[]

[Controls]
  [geom_variation]
    type = MultiAppSamplerControl
    multi_app = base_mechanics
    sampler = train_sample
    param_names = 'upper_left_radius upper_right_radius lower_left_radius lower_right_radius gauge_width gauge_height'
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

  [train_p1_stress_xx]
    type = EvaluateSurrogate
    model = GP_p1_stress_xx
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [evaluate_p1_stress_xx]
    type = EvaluateSurrogate
    model = GP_p1_stress_xx
    sampler = evaluate_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [train_p2_stress_xx]
    type = EvaluateSurrogate
    model = GP_p2_stress_xx
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [evaluate_p2_stress_xx]
    type = EvaluateSurrogate
    model = GP_p2_stress_xx
    sampler = evaluate_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [train_p3_stress_xx]
    type = EvaluateSurrogate
    model = GP_p3_stress_xx
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [evaluate_p3_stress_xx]
    type = EvaluateSurrogate
    model = GP_p3_stress_xx
    sampler = evaluate_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [train_p4_stress_xx]
    type = EvaluateSurrogate
    model = GP_p4_stress_xx
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [evaluate_p4_stress_xx]
    type = EvaluateSurrogate
    model = GP_p4_stress_xx
    sampler = evaluate_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [train_p5_stress_xx]
    type = EvaluateSurrogate
    model = GP_p5_stress_xx
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [evaluate_p5_stress_xx]
    type = EvaluateSurrogate
    model = GP_p5_stress_xx
    sampler = evaluate_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [train_p6_stress_xx]
    type = EvaluateSurrogate
    model = GP_p6_stress_xx
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [evaluate_p6_stress_xx]
    type = EvaluateSurrogate
    model = GP_p6_stress_xx
    sampler = evaluate_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [train_p7_stress_xx]
    type = EvaluateSurrogate
    model = GP_p7_stress_xx
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [evaluate_p7_stress_xx]
    type = EvaluateSurrogate
    model = GP_p7_stress_xx
    sampler = evaluate_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [train_p8_stress_xx]
    type = EvaluateSurrogate
    model = GP_p8_stress_xx
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [evaluate_p8_stress_xx]
    type = EvaluateSurrogate
    model = GP_p8_stress_xx
    sampler = evaluate_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [train_p9_stress_xx]
    type = EvaluateSurrogate
    model = GP_p9_stress_xx
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [evaluate_p9_stress_xx]
    type = EvaluateSurrogate
    model = GP_p9_stress_xx
    sampler = evaluate_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [train_max_stress_xx]
    type = EvaluateSurrogate
    model = GP_max_stress_xx
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [evaluate_max_stress_xx]
    type = EvaluateSurrogate
    model = GP_max_stress_xx
    sampler = evaluate_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []

  [train_p1_stress_yy]
    type = EvaluateSurrogate
    model = GP_p1_stress_yy
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [evaluate_p1_stress_yy]
    type = EvaluateSurrogate
    model = GP_p1_stress_yy
    sampler = evaluate_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [train_p2_stress_yy]
    type = EvaluateSurrogate
    model = GP_p2_stress_yy
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [evaluate_p2_stress_yy]
    type = EvaluateSurrogate
    model = GP_p2_stress_yy
    sampler = evaluate_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [train_p3_stress_yy]
    type = EvaluateSurrogate
    model = GP_p3_stress_yy
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [evaluate_p3_stress_yy]
    type = EvaluateSurrogate
    model = GP_p3_stress_yy
    sampler = evaluate_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [train_p4_stress_yy]
    type = EvaluateSurrogate
    model = GP_p4_stress_yy
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [evaluate_p4_stress_yy]
    type = EvaluateSurrogate
    model = GP_p4_stress_yy
    sampler = evaluate_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [train_p5_stress_yy]
    type = EvaluateSurrogate
    model = GP_p5_stress_yy
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [evaluate_p5_stress_yy]
    type = EvaluateSurrogate
    model = GP_p5_stress_yy
    sampler = evaluate_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [train_p6_stress_yy]
    type = EvaluateSurrogate
    model = GP_p6_stress_yy
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [evaluate_p6_stress_yy]
    type = EvaluateSurrogate
    model = GP_p6_stress_yy
    sampler = evaluate_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [train_p7_stress_yy]
    type = EvaluateSurrogate
    model = GP_p7_stress_yy
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [evaluate_p7_stress_yy]
    type = EvaluateSurrogate
    model = GP_p7_stress_yy
    sampler = evaluate_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [train_p8_stress_yy]
    type = EvaluateSurrogate
    model = GP_p8_stress_yy
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [evaluate_p8_stress_yy]
    type = EvaluateSurrogate
    model = GP_p8_stress_yy
    sampler = evaluate_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [train_p9_stress_yy]
    type = EvaluateSurrogate
    model = GP_p9_stress_yy
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [evaluate_p9_stress_yy]
    type = EvaluateSurrogate
    model = GP_p9_stress_yy
    sampler = evaluate_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [train_max_stress_yy]
    type = EvaluateSurrogate
    model = GP_max_stress_yy
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [evaluate_max_stress_yy]
    type = EvaluateSurrogate
    model = GP_max_stress_yy
    sampler = evaluate_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []

  [train_p1_vonmises_stress]
    type = EvaluateSurrogate
    model = GP_p1_vonmises_stress
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [evaluate_p1_vonmises_stress]
    type = EvaluateSurrogate
    model = GP_p1_vonmises_stress
    sampler = evaluate_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [train_p2_vonmises_stress]
    type = EvaluateSurrogate
    model = GP_p2_vonmises_stress
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [evaluate_p2_vonmises_stress]
    type = EvaluateSurrogate
    model = GP_p2_vonmises_stress
    sampler = evaluate_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [train_p3_vonmises_stress]
    type = EvaluateSurrogate
    model = GP_p3_vonmises_stress
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [evaluate_p3_vonmises_stress]
    type = EvaluateSurrogate
    model = GP_p3_vonmises_stress
    sampler = evaluate_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [train_p4_vonmises_stress]
    type = EvaluateSurrogate
    model = GP_p4_vonmises_stress
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [evaluate_p4_vonmises_stress]
    type = EvaluateSurrogate
    model = GP_p4_vonmises_stress
    sampler = evaluate_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [train_p5_vonmises_stress]
    type = EvaluateSurrogate
    model = GP_p5_vonmises_stress
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [evaluate_p5_vonmises_stress]
    type = EvaluateSurrogate
    model = GP_p5_vonmises_stress
    sampler = evaluate_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [train_p6_vonmises_stress]
    type = EvaluateSurrogate
    model = GP_p6_vonmises_stress
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [evaluate_p6_vonmises_stress]
    type = EvaluateSurrogate
    model = GP_p6_vonmises_stress
    sampler = evaluate_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [train_p7_vonmises_stress]
    type = EvaluateSurrogate
    model = GP_p7_vonmises_stress
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [evaluate_p7_vonmises_stress]
    type = EvaluateSurrogate
    model = GP_p7_vonmises_stress
    sampler = evaluate_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [train_p8_vonmises_stress]
    type = EvaluateSurrogate
    model = GP_p8_vonmises_stress
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [evaluate_p8_vonmises_stress]
    type = EvaluateSurrogate
    model = GP_p8_vonmises_stress
    sampler = evaluate_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [train_p9_vonmises_stress]
    type = EvaluateSurrogate
    model = GP_p9_vonmises_stress
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [evaluate_p9_vonmises_stress]
    type = EvaluateSurrogate
    model = GP_p9_vonmises_stress
    sampler = evaluate_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [train_max_vonmises_stress]
    type = EvaluateSurrogate
    model = GP_max_vonmises_stress
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [evaluate_max_vonmises_stress]
    type = EvaluateSurrogate
    model = GP_max_vonmises_stress
    sampler = evaluate_sample
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
    iter_adam = 5000
    batch_size = 200
    learning_rate_adam = 0.001
    skip_unconverged_samples = true
    converged_reporter = storage/data:converged
  []
  [GP_p2_stress_xx_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    sampler = train_sample
    response = storage/data:p2_stress_xx:value
    tune_parameters = 'signal_variance length_factor'
    tuning_algorithm = 'adam'
    iter_adam = 5000
    batch_size = 200
    learning_rate_adam = 0.001
    skip_unconverged_samples = true
    converged_reporter = storage/data:converged
  []
  [GP_p3_stress_xx_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    sampler = train_sample
    response = storage/data:p3_stress_xx:value
    tune_parameters = 'signal_variance length_factor'
    tuning_algorithm = 'adam'
    iter_adam = 5000
    batch_size = 200
    learning_rate_adam = 0.001
    skip_unconverged_samples = true
    converged_reporter = storage/data:converged
  []
  [GP_p4_stress_xx_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    sampler = train_sample
    response = storage/data:p1_stress_xx:value
    tune_parameters = 'signal_variance length_factor'
    tuning_algorithm = 'adam'
    iter_adam = 5000
    batch_size = 200
    learning_rate_adam = 0.001
    skip_unconverged_samples = true
    converged_reporter = storage/data:converged
  []
  [GP_p5_stress_xx_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    sampler = train_sample
    response = storage/data:p5_stress_xx:value
    tune_parameters = 'signal_variance length_factor'
    tuning_algorithm = 'adam'
    iter_adam = 5000
    batch_size = 200
    learning_rate_adam = 0.001
    skip_unconverged_samples = true
    converged_reporter = storage/data:converged
  []
  [GP_p6_stress_xx_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    sampler = train_sample
    response = storage/data:p6_stress_xx:value
    tune_parameters = 'signal_variance length_factor'
    tuning_algorithm = 'adam'
    iter_adam = 5000
    batch_size = 200
    learning_rate_adam = 0.001
    skip_unconverged_samples = true
    converged_reporter = storage/data:converged
  []
  [GP_p7_stress_xx_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    sampler = train_sample
    response = storage/data:p7_stress_xx:value
    tune_parameters = 'signal_variance length_factor'
    tuning_algorithm = 'adam'
    iter_adam = 5000
    batch_size = 200
    learning_rate_adam = 0.001
    skip_unconverged_samples = true
    converged_reporter = storage/data:converged
  []
  [GP_p8_stress_xx_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    sampler = train_sample
    response = storage/data:p8_stress_xx:value
    tune_parameters = 'signal_variance length_factor'
    tuning_algorithm = 'adam'
    iter_adam = 5000
    batch_size = 200
    learning_rate_adam = 0.001
    skip_unconverged_samples = true
    converged_reporter = storage/data:converged
  []
  [GP_p9_stress_xx_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    sampler = train_sample
    response = storage/data:p9_stress_xx:value
    tune_parameters = 'signal_variance length_factor'
    tuning_algorithm = 'adam'
    iter_adam = 5000
    batch_size = 200
    learning_rate_adam = 0.001
    skip_unconverged_samples = true
    converged_reporter = storage/data:converged
  []
  [GP_max_stress_xx_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    sampler = train_sample
    response = storage/data:max_stress_xx:value
    tune_parameters = 'signal_variance length_factor'
    tuning_algorithm = 'adam'
    iter_adam = 5000
    batch_size = 200
    learning_rate_adam = 0.001
    skip_unconverged_samples = true
    converged_reporter = storage/data:converged
  []

  [GP_p1_stress_yy_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    sampler = train_sample
    response = storage/data:p1_stress_yy:value
    tune_parameters = 'signal_variance length_factor'
    tuning_algorithm = 'adam'
    iter_adam = 5000
    batch_size = 200
    learning_rate_adam = 0.001
    skip_unconverged_samples = true
    converged_reporter = storage/data:converged
  []
  [GP_p2_stress_yy_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    sampler = train_sample
    response = storage/data:p2_stress_yy:value
    tune_parameters = 'signal_variance length_factor'
    tuning_algorithm = 'adam'
    iter_adam = 5000
    batch_size = 200
    learning_rate_adam = 0.001
    skip_unconverged_samples = true
    converged_reporter = storage/data:converged
  []
  [GP_p3_stress_yy_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    sampler = train_sample
    response = storage/data:p3_stress_yy:value
    tune_parameters = 'signal_variance length_factor'
    tuning_algorithm = 'adam'
    iter_adam = 5000
    batch_size = 200
    learning_rate_adam = 0.001
    skip_unconverged_samples = true
    converged_reporter = storage/data:converged
  []
  [GP_p4_stress_yy_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    sampler = train_sample
    response = storage/data:p4_stress_yy:value
    tune_parameters = 'signal_variance length_factor'
    tuning_algorithm = 'adam'
    iter_adam = 5000
    batch_size = 200
    learning_rate_adam = 0.001
    skip_unconverged_samples = true
    converged_reporter = storage/data:converged
  []
  [GP_p5_stress_yy_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    sampler = train_sample
    response = storage/data:p5_stress_yy:value
    tune_parameters = 'signal_variance length_factor'
    tuning_algorithm = 'adam'
    iter_adam = 5000
    batch_size = 200
    learning_rate_adam = 0.001
    skip_unconverged_samples = true
    converged_reporter = storage/data:converged
  []
  [GP_p6_stress_yy_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    sampler = train_sample
    response = storage/data:p6_stress_yy:value
    tune_parameters = 'signal_variance length_factor'
    tuning_algorithm = 'adam'
    iter_adam = 5000
    batch_size = 200
    learning_rate_adam = 0.001
    skip_unconverged_samples = true
    converged_reporter = storage/data:converged
  []
  [GP_p7_stress_yy_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    sampler = train_sample
    response = storage/data:p7_stress_yy:value
    tune_parameters = 'signal_variance length_factor'
    tuning_algorithm = 'adam'
    iter_adam = 5000
    batch_size = 200
    learning_rate_adam = 0.001
    skip_unconverged_samples = true
    converged_reporter = storage/data:converged
  []
  [GP_p8_stress_yy_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    sampler = train_sample
    response = storage/data:p8_stress_yy:value
    tune_parameters = 'signal_variance length_factor'
    tuning_algorithm = 'adam'
    iter_adam = 5000
    batch_size = 200
    learning_rate_adam = 0.001
    skip_unconverged_samples = true
    converged_reporter = storage/data:converged
  []
  [GP_p9_stress_yy_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    sampler = train_sample
    response = storage/data:p9_stress_yy:value
    tune_parameters = 'signal_variance length_factor'
    tuning_algorithm = 'adam'
    iter_adam = 5000
    batch_size = 200
    learning_rate_adam = 0.001
    skip_unconverged_samples = true
    converged_reporter = storage/data:converged
  []
  [GP_max_stress_yy_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    sampler = train_sample
    response = storage/data:max_stress_yy:value
    tune_parameters = 'signal_variance length_factor'
    tuning_algorithm = 'adam'
    iter_adam = 5000
    batch_size = 200
    learning_rate_adam = 0.001
    skip_unconverged_samples = true
    converged_reporter = storage/data:converged
  []

  [GP_p1_vonmises_stress_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    sampler = train_sample
    response = storage/data:p1_vonmises_stress:value
    tune_parameters = 'signal_variance length_factor'
    tuning_algorithm = 'adam'
    iter_adam = 5000
    batch_size = 200
    learning_rate_adam = 0.001
    skip_unconverged_samples = true
    converged_reporter = storage/data:converged
  []
  [GP_p2_vonmises_stress_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    sampler = train_sample
    response = storage/data:p2_vonmises_stress:value
    tune_parameters = 'signal_variance length_factor'
    tuning_algorithm = 'adam'
    iter_adam = 5000
    batch_size = 200
    learning_rate_adam = 0.001
    skip_unconverged_samples = true
    converged_reporter = storage/data:converged
  []
  [GP_p3_vonmises_stress_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    sampler = train_sample
    response = storage/data:p3_vonmises_stress:value
    tune_parameters = 'signal_variance length_factor'
    tuning_algorithm = 'adam'
    iter_adam = 5000
    batch_size = 200
    learning_rate_adam = 0.001
    skip_unconverged_samples = true
    converged_reporter = storage/data:converged
  []
  [GP_p4_vonmises_stress_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    sampler = train_sample
    response = storage/data:p4_vonmises_stress:value
    tune_parameters = 'signal_variance length_factor'
    tuning_algorithm = 'adam'
    iter_adam = 5000
    batch_size = 200
    learning_rate_adam = 0.001
    skip_unconverged_samples = true
    converged_reporter = storage/data:converged
  []
  [GP_p5_vonmises_stress_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    sampler = train_sample
    response = storage/data:p5_vonmises_stress:value
    tune_parameters = 'signal_variance length_factor'
    tuning_algorithm = 'adam'
    iter_adam = 5000
    batch_size = 200
    learning_rate_adam = 0.001
    skip_unconverged_samples = true
    converged_reporter = storage/data:converged
  []
  [GP_p6_vonmises_stress_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    sampler = train_sample
    response = storage/data:p6_vonmises_stress:value
    tune_parameters = 'signal_variance length_factor'
    tuning_algorithm = 'adam'
    iter_adam = 5000
    batch_size = 200
    learning_rate_adam = 0.001
    skip_unconverged_samples = true
    converged_reporter = storage/data:converged
  []
  [GP_p7_vonmises_stress_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    sampler = train_sample
    response = storage/data:p7_vonmises_stress:value
    tune_parameters = 'signal_variance length_factor'
    tuning_algorithm = 'adam'
    iter_adam = 5000
    batch_size = 200
    learning_rate_adam = 0.001
    skip_unconverged_samples = true
    converged_reporter = storage/data:converged
  []
  [GP_p8_vonmises_stress_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    sampler = train_sample
    response = storage/data:p8_vonmises_stress:value
    tune_parameters = 'signal_variance length_factor'
    tuning_algorithm = 'adam'
    iter_adam = 5000
    batch_size = 200
    learning_rate_adam = 0.001
    skip_unconverged_samples = true
    converged_reporter = storage/data:converged
  []
  [GP_p9_vonmises_stress_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    sampler = train_sample
    response = storage/data:p9_vonmises_stress:value
    tune_parameters = 'signal_variance length_factor'
    tuning_algorithm = 'adam'
    iter_adam = 5000
    batch_size = 200
    learning_rate_adam = 0.001
    skip_unconverged_samples = true
    converged_reporter = storage/data:converged
  []
  [GP_max_vonmises_stress_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    sampler = train_sample
    response = storage/data:max_vonmises_stress:value
    tune_parameters = 'signal_variance length_factor'
    tuning_algorithm = 'adam'
    iter_adam = 5000
    batch_size = 200
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
  [GP_p2_stress_xx]
    type = GaussianProcess
    trainer = GP_p2_stress_xx_trainer
  []
  [GP_p3_stress_xx]
    type = GaussianProcess
    trainer = GP_p3_stress_xx_trainer
  []
  [GP_p4_stress_xx]
    type = GaussianProcess
    trainer = GP_p4_stress_xx_trainer
  []
  [GP_p5_stress_xx]
    type = GaussianProcess
    trainer = GP_p5_stress_xx_trainer
  []
  [GP_p6_stress_xx]
    type = GaussianProcess
    trainer = GP_p6_stress_xx_trainer
  []
  [GP_p7_stress_xx]
    type = GaussianProcess
    trainer = GP_p7_stress_xx_trainer
  []
  [GP_p8_stress_xx]
    type = GaussianProcess
    trainer = GP_p8_stress_xx_trainer
  []
  [GP_p9_stress_xx]
    type = GaussianProcess
    trainer = GP_p9_stress_xx_trainer
  []
  [GP_max_stress_xx]
    type = GaussianProcess
    trainer = GP_max_stress_xx_trainer
  []

  [GP_p1_stress_yy]
    type = GaussianProcess
    trainer = GP_p1_stress_yy_trainer
  []
  [GP_p2_stress_yy]
    type = GaussianProcess
    trainer = GP_p2_stress_yy_trainer
  []
  [GP_p3_stress_yy]
    type = GaussianProcess
    trainer = GP_p3_stress_yy_trainer
  []
  [GP_p4_stress_yy]
    type = GaussianProcess
    trainer = GP_p4_stress_yy_trainer
  []
  [GP_p5_stress_yy]
    type = GaussianProcess
    trainer = GP_p5_stress_yy_trainer
  []
  [GP_p6_stress_yy]
    type = GaussianProcess
    trainer = GP_p6_stress_yy_trainer
  []
  [GP_p7_stress_yy]
    type = GaussianProcess
    trainer = GP_p7_stress_yy_trainer
  []
  [GP_p8_stress_yy]
    type = GaussianProcess
    trainer = GP_p8_stress_yy_trainer
  []
  [GP_p9_stress_yy]
    type = GaussianProcess
    trainer = GP_p9_stress_yy_trainer
  []
  [GP_max_stress_yy]
    type = GaussianProcess
    trainer = GP_max_stress_yy_trainer
  []

  [GP_p1_vonmises_stress]
    type = GaussianProcess
    trainer = GP_p1_vonmises_stress_trainer
  []
  [GP_p2_vonmises_stress]
    type = GaussianProcess
    trainer = GP_p2_vonmises_stress_trainer
  []
  [GP_p3_vonmises_stress]
    type = GaussianProcess
    trainer = GP_p3_vonmises_stress_trainer
  []
  [GP_p4_vonmises_stress]
    type = GaussianProcess
    trainer = GP_p4_vonmises_stress_trainer
  []
  [GP_p5_vonmises_stress]
    type = GaussianProcess
    trainer = GP_p5_vonmises_stress_trainer
  []
  [GP_p6_vonmises_stress]
    type = GaussianProcess
    trainer = GP_p6_vonmises_stress_trainer
  []
  [GP_p7_vonmises_stress]
    type = GaussianProcess
    trainer = GP_p7_vonmises_stress_trainer
  []
  [GP_p8_vonmises_stress]
    type = GaussianProcess
    trainer = GP_p8_vonmises_stress_trainer
  []
  [GP_p9_vonmises_stress]
    type = GaussianProcess
    trainer = GP_p9_vonmises_stress_trainer
  []
  [GP_max_vonmises_stress]
    type = GaussianProcess
    trainer = GP_max_vonmises_stress_trainer
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
  [hyperparams_p2_stress_xx]
    type = GaussianProcessData
    gp_name = 'GP_p2_stress_xx'
    execute_on = final
  []
  [hyperparams_p3_stress_xx]
    type = GaussianProcessData
    gp_name = 'GP_p3_stress_xx'
    execute_on = final
  []
  [hyperparams_p4_stress_xx]
    type = GaussianProcessData
    gp_name = 'GP_p4_stress_xx'
    execute_on = final
  []
  [hyperparams_p5_stress_xx]
    type = GaussianProcessData
    gp_name = 'GP_p5_stress_xx'
    execute_on = final
  []
  [hyperparams_p6_stress_xx]
    type = GaussianProcessData
    gp_name = 'GP_p6_stress_xx'
    execute_on = final
  []
  [hyperparams_p7_stress_xx]
    type = GaussianProcessData
    gp_name = 'GP_p7_stress_xx'
    execute_on = final
  []
  [hyperparams_p8_stress_xx]
    type = GaussianProcessData
    gp_name = 'GP_p8_stress_xx'
    execute_on = final
  []
  [hyperparams_p9_stress_xx]
    type = GaussianProcessData
    gp_name = 'GP_p9_stress_xx'
    execute_on = final
  []
  [hyperparams_max_stress_xx]
    type = GaussianProcessData
    gp_name = 'GP_max_stress_xx'
    execute_on = final
  []

  [hyperparams_p1_stress_yy]
    type = GaussianProcessData
    gp_name = 'GP_p1_stress_yy'
    execute_on = final
  []
  [hyperparams_p2_stress_yy]
    type = GaussianProcessData
    gp_name = 'GP_p2_stress_yy'
    execute_on = final
  []
  [hyperparams_p3_stress_yy]
    type = GaussianProcessData
    gp_name = 'GP_p3_stress_yy'
    execute_on = final
  []
  [hyperparams_p4_stress_yy]
    type = GaussianProcessData
    gp_name = 'GP_p4_stress_yy'
    execute_on = final
  []
  [hyperparams_p5_stress_yy]
    type = GaussianProcessData
    gp_name = 'GP_p5_stress_yy'
    execute_on = final
  []
  [hyperparams_p6_stress_yy]
    type = GaussianProcessData
    gp_name = 'GP_p6_stress_yy'
    execute_on = final
  []
  [hyperparams_p7_stress_yy]
    type = GaussianProcessData
    gp_name = 'GP_p7_stress_yy'
    execute_on = final
  []
  [hyperparams_p8_stress_yy]
    type = GaussianProcessData
    gp_name = 'GP_p8_stress_yy'
    execute_on = final
  []
  [hyperparams_p9_stress_yy]
    type = GaussianProcessData
    gp_name = 'GP_p9_stress_yy'
    execute_on = final
  []
  [hyperparams_max_stress_yy]
    type = GaussianProcessData
    gp_name = 'GP_max_stress_yy'
    execute_on = final
  []

  [hyperparams_p1_vonmises_stress]
    type = GaussianProcessData
    gp_name = 'GP_p1_vonmises_stress'
    execute_on = final
  []
  [hyperparams_p2_vonmises_stress]
    type = GaussianProcessData
    gp_name = 'GP_p2_vonmises_stress'
    execute_on = final
  []
  [hyperparams_p3_vonmises_stress]
    type = GaussianProcessData
    gp_name = 'GP_p3_vonmises_stress'
    execute_on = final
  []
  [hyperparams_p4_vonmises_stress]
    type = GaussianProcessData
    gp_name = 'GP_p4_vonmises_stress'
    execute_on = final
  []
  [hyperparams_p5_vonmises_stress]
    type = GaussianProcessData
    gp_name = 'GP_p5_vonmises_stress'
    execute_on = final
  []
  [hyperparams_p6_vonmises_stress]
    type = GaussianProcessData
    gp_name = 'GP_p6_vonmises_stress'
    execute_on = final
  []
  [hyperparams_p7_vonmises_stress]
    type = GaussianProcessData
    gp_name = 'GP_p7_vonmises_stress'
    execute_on = final
  []
  [hyperparams_p8_vonmises_stress]
    type = GaussianProcessData
    gp_name = 'GP_p8_vonmises_stress'
    execute_on = final
  []
  [hyperparams_p9_vonmises_stress]
    type = GaussianProcessData
    gp_name = 'GP_p9_vonmises_stress'
    execute_on = final
  []
  [hyperparams_max_vonmises_stress]
    type = GaussianProcessData
    gp_name = 'GP_max_vonmises_stress'
    execute_on = final
  []

  [data]
    type = SamplerData
    sampler = evaluate_sample
    execute_on = 'initial timestep_end'
  []
[]

[Outputs]
  # execute_on = timestep_end
  # [trainer]
  #   type = SurrogateTrainerOutput
  #   trainers = 'poly_chaos_p1_stress_xx poly_chaos_p2_stress_xx poly_chaos_p3_stress_xx poly_chaos_p4_stress_xx poly_chaos_p5_stress_xx poly_chaos_p6_stress_xx poly_chaos_p7_stress_xx poly_chaos_p8_stress_xx poly_chaos_p9_stress_xx poly_chaos_max_stress_xx poly_chaos_p1_stress_yy poly_chaos_p2_stress_yy poly_chaos_p3_stress_yy poly_chaos_p4_stress_yy poly_chaos_p5_stress_yy poly_chaos_p6_stress_yy poly_chaos_p7_stress_yy poly_chaos_p8_stress_yy poly_chaos_p9_stress_yy poly_chaos_max_stress_yy'
  # []
  [out]
    type = CSV
    execute_on = FINAL
  []
[]
