[StochasticTools]
[]

[Distributions]
  [upper_rig_offset]
    type = TruncatedNormal
    mean = 0.0
    standard_deviation = 0.1
    lower_bound = -0.15
    upper_bound = 0.15
  []
  [lower_rig_offset]
    type = TruncatedNormal
    mean = 0.0
    standard_deviation = 0.1
    lower_bound = -0.15
    upper_bound = 0.15
  []
[]

[Samplers]
  [train_sample]
    type = LatinHypercube
    num_rows = 400
    distributions = 'upper_rig_offset lower_rig_offset'
    execute_on = PRE_MULTIAPP_SETUP
    seed = 2
  []
  # [evaluate_sample]
  #   type = LatinHypercube
  #   num_rows = 200
  #   distributions = 'upper_rig_offset lower_rig_offset'
  #   execute_on = PRE_MULTIAPP_SETUP
  #   seed = 5
  # []
  # [csv_sample]
  #   type = CSVSampler
  #   samples_file = 'samples.csv'
  #   column_names = 'upper_rig_offset lower_rig_offset'
  #   execute_on = 'initial timestep_end'
  # []
[]

[MultiApps]
  [base_mechanics]
    type = SamplerFullSolveMultiApp
    input_files = base_geomtry_3d_bcs.i
    mode = batch-reset #Overwrites results
    sampler = train_sample
  []
[]

[Controls]
  [geom_variation]
    type = MultiAppSamplerControl
    multi_app = base_mechanics
    sampler = train_sample
    param_names = 'upper_rig_offset lower_rig_offset'
  []
[]

[Transfers]
  [data]
    type = SamplerReporterTransfer
    from_multi_app = base_mechanics
    sampler = train_sample
    stochastic_reporter = storage
    from_reporter = 'p1_stress_yy/value p2_stress_yy/value p3_stress_yy/value p4_stress_yy/value p5_stress_yy/value p6_stress_yy/value p7_stress_yy/value p8_stress_yy/value p9_stress_yy/value max_stress_yy/value p1_vonmises_stress/value p2_vonmises_stress/value p3_vonmises_stress/value p4_vonmises_stress/value p5_vonmises_stress/value p6_vonmises_stress/value p7_vonmises_stress/value p8_vonmises_stress/value p9_vonmises_stress/value max_vonmises_stress/value'
  []
[]

[Reporters]
  [storage]
    type = StochasticReporter
    parallel_type = ROOT
  []

  [train_p1_stress_yy]
    type = EvaluateSurrogate
    model = GP_p1_stress_yy
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  # [evaluate_p1_stress_yy]
  #   type = EvaluateSurrogate
  #   model = GP_p1_stress_yy
  #   sampler = evaluate_sample
  #   evaluate_std = 'true'
  #   parallel_type = ROOT
  #   execute_on = final
  # []
  [train_p2_stress_yy]
    type = EvaluateSurrogate
    model = GP_p2_stress_yy
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  # [evaluate_p2_stress_yy]
  #   type = EvaluateSurrogate
  #   model = GP_p2_stress_yy
  #   sampler = evaluate_sample
  #   evaluate_std = 'true'
  #   parallel_type = ROOT
  #   execute_on = final
  # []
  [train_p3_stress_yy]
    type = EvaluateSurrogate
    model = GP_p3_stress_yy
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  # [evaluate_p3_stress_yy]
  #   type = EvaluateSurrogate
  #   model = GP_p3_stress_yy
  #   sampler = evaluate_sample
  #   evaluate_std = 'true'
  #   parallel_type = ROOT
  #   execute_on = final
  # []
  [train_p4_stress_yy]
    type = EvaluateSurrogate
    model = GP_p4_stress_yy
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  # [evaluate_p4_stress_yy]
  #   type = EvaluateSurrogate
  #   model = GP_p4_stress_yy
  #   sampler = evaluate_sample
  #   evaluate_std = 'true'
  #   parallel_type = ROOT
  #   execute_on = final
  # []
  [train_p5_stress_yy]
    type = EvaluateSurrogate
    model = GP_p5_stress_yy
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  # [evaluate_p5_stress_yy]
  #   type = EvaluateSurrogate
  #   model = GP_p5_stress_yy
  #   sampler = evaluate_sample
  #   evaluate_std = 'true'
  #   parallel_type = ROOT
  #   execute_on = final
  # []
  [train_p6_stress_yy]
    type = EvaluateSurrogate
    model = GP_p6_stress_yy
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  # [evaluate_p6_stress_yy]
  #   type = EvaluateSurrogate
  #   model = GP_p6_stress_yy
  #   sampler = evaluate_sample
  #   evaluate_std = 'true'
  #   parallel_type = ROOT
  #   execute_on = final
  # []
  [train_p7_stress_yy]
    type = EvaluateSurrogate
    model = GP_p7_stress_yy
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  # [evaluate_p7_stress_yy]
  #   type = EvaluateSurrogate
  #   model = GP_p7_stress_yy
  #   sampler = evaluate_sample
  #   evaluate_std = 'true'
  #   parallel_type = ROOT
  #   execute_on = final
  # []
  [train_p8_stress_yy]
    type = EvaluateSurrogate
    model = GP_p8_stress_yy
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  # [evaluate_p8_stress_yy]
  #   type = EvaluateSurrogate
  #   model = GP_p8_stress_yy
  #   sampler = evaluate_sample
  #   evaluate_std = 'true'
  #   parallel_type = ROOT
  #   execute_on = final
  # []
  [train_p9_stress_yy]
    type = EvaluateSurrogate
    model = GP_p9_stress_yy
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  # [evaluate_p9_stress_yy]
  #   type = EvaluateSurrogate
  #   model = GP_p9_stress_yy
  #   sampler = evaluate_sample
  #   evaluate_std = 'true'
  #   parallel_type = ROOT
  #   execute_on = final
  # []
  [train_max_stress_yy]
    type = EvaluateSurrogate
    model = GP_max_stress_yy
    sampler = train_sample
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  # [evaluate_max_stress_yy]
  #   type = EvaluateSurrogate
  #   model = GP_max_stress_yy
  #   sampler = evaluate_sample
  #   evaluate_std = 'true'
  #   parallel_type = ROOT
  #   execute_on = final
  # []

  # [train_p1_vonmises_stress]
  #   type = EvaluateSurrogate
  #   model = GP_p1_vonmises_stress
  #   sampler = train_sample
  #   evaluate_std = 'true'
  #   parallel_type = ROOT
  #   execute_on = final
  # []
  # [evaluate_p1_vonmises_stress]
  #   type = EvaluateSurrogate
  #   model = GP_p1_vonmises_stress
  #   sampler = evaluate_sample
  #   evaluate_std = 'true'
  #   parallel_type = ROOT
  #   execute_on = final
  # []
  # [train_p2_vonmises_stress]
  #   type = EvaluateSurrogate
  #   model = GP_p2_vonmises_stress
  #   sampler = train_sample
  #   evaluate_std = 'true'
  #   parallel_type = ROOT
  #   execute_on = final
  # []
  # [evaluate_p2_vonmises_stress]
  #   type = EvaluateSurrogate
  #   model = GP_p2_vonmises_stress
  #   sampler = evaluate_sample
  #   evaluate_std = 'true'
  #   parallel_type = ROOT
  #   execute_on = final
  # []
  # [train_p3_vonmises_stress]
  #   type = EvaluateSurrogate
  #   model = GP_p3_vonmises_stress
  #   sampler = train_sample
  #   evaluate_std = 'true'
  #   parallel_type = ROOT
  #   execute_on = final
  # []
  # [evaluate_p3_vonmises_stress]
  #   type = EvaluateSurrogate
  #   model = GP_p3_vonmises_stress
  #   sampler = evaluate_sample
  #   evaluate_std = 'true'
  #   parallel_type = ROOT
  #   execute_on = final
  # []
  # [train_p4_vonmises_stress]
  #   type = EvaluateSurrogate
  #   model = GP_p4_vonmises_stress
  #   sampler = train_sample
  #   evaluate_std = 'true'
  #   parallel_type = ROOT
  #   execute_on = final
  # []
  # [evaluate_p4_vonmises_stress]
  #   type = EvaluateSurrogate
  #   model = GP_p4_vonmises_stress
  #   sampler = evaluate_sample
  #   evaluate_std = 'true'
  #   parallel_type = ROOT
  #   execute_on = final
  # []
  # [train_p5_vonmises_stress]
  #   type = EvaluateSurrogate
  #   model = GP_p5_vonmises_stress
  #   sampler = train_sample
  #   evaluate_std = 'true'
  #   parallel_type = ROOT
  #   execute_on = final
  # []
  # [evaluate_p5_vonmises_stress]
  #   type = EvaluateSurrogate
  #   model = GP_p5_vonmises_stress
  #   sampler = evaluate_sample
  #   evaluate_std = 'true'
  #   parallel_type = ROOT
  #   execute_on = final
  # []
  # [train_p6_vonmises_stress]
  #   type = EvaluateSurrogate
  #   model = GP_p6_vonmises_stress
  #   sampler = train_sample
  #   evaluate_std = 'true'
  #   parallel_type = ROOT
  #   execute_on = final
  # []
  # [evaluate_p6_vonmises_stress]
  #   type = EvaluateSurrogate
  #   model = GP_p6_vonmises_stress
  #   sampler = evaluate_sample
  #   evaluate_std = 'true'
  #   parallel_type = ROOT
  #   execute_on = final
  # []
  # [train_p7_vonmises_stress]
  #   type = EvaluateSurrogate
  #   model = GP_p7_vonmises_stress
  #   sampler = train_sample
  #   evaluate_std = 'true'
  #   parallel_type = ROOT
  #   execute_on = final
  # []
  # [evaluate_p7_vonmises_stress]
  #   type = EvaluateSurrogate
  #   model = GP_p7_vonmises_stress
  #   sampler = evaluate_sample
  #   evaluate_std = 'true'
  #   parallel_type = ROOT
  #   execute_on = final
  # []
  # [train_p8_vonmises_stress]
  #   type = EvaluateSurrogate
  #   model = GP_p8_vonmises_stress
  #   sampler = train_sample
  #   evaluate_std = 'true'
  #   parallel_type = ROOT
  #   execute_on = final
  # []
  # [evaluate_p8_vonmises_stress]
  #   type = EvaluateSurrogate
  #   model = GP_p8_vonmises_stress
  #   sampler = evaluate_sample
  #   evaluate_std = 'true'
  #   parallel_type = ROOT
  #   execute_on = final
  # []
  # [train_p9_vonmises_stress]
  #   type = EvaluateSurrogate
  #   model = GP_p9_vonmises_stress
  #   sampler = train_sample
  #   evaluate_std = 'true'
  #   parallel_type = ROOT
  #   execute_on = final
  # []
  # [evaluate_p9_vonmises_stress]
  #   type = EvaluateSurrogate
  #   model = GP_p9_vonmises_stress
  #   sampler = evaluate_sample
  #   evaluate_std = 'true'
  #   parallel_type = ROOT
  #   execute_on = final
  # []
  # [train_max_vonmises_stress]
  #   type = EvaluateSurrogate
  #   model = GP_max_vonmises_stress
  #   sampler = train_sample
  #   evaluate_std = 'true'
  #   parallel_type = ROOT
  #   execute_on = final
  # []
  # [evaluate_max_vonmises_stress]
  #   type = EvaluateSurrogate
  #   model = GP_max_vonmises_stress
  #   sampler = evaluate_sample
  #   evaluate_std = 'true'
  #   parallel_type = ROOT
  #   execute_on = final
  # []

  # [evalute_statistics]
  #   type = StatisticsReporter
  #   reporters = 'evaluate_p1_stress_yy/GP_p1_stress_yy evaluate_p2_stress_yy/GP_p2_stress_yy evaluate_p3_stress_yy/GP_p3_stress_yy evaluate_p4_stress_yy/GP_p4_stress_yy evaluate_p5_stress_yy/GP_p5_stress_yy evaluate_p6_stress_yy/GP_p6_stress_yy evaluate_p7_stress_yy/GP_p7_stress_yy evaluate_p8_stress_yy/GP_p8_stress_yy evaluate_p9_stress_yy/GP_p9_stress_yy evaluate_max_stress_yy/GP_max_stress_yy evaluate_p1_vonmises_stress/GP_p1_vonmises_stress evaluate_p2_vonmises_stress/GP_p2_vonmises_stress evaluate_p3_vonmises_stress/GP_p3_vonmises_stress evaluate_p4_vonmises_stress/GP_p4_vonmises_stress evaluate_p5_vonmises_stress/GP_p5_vonmises_stress evaluate_p6_vonmises_stress/GP_p6_vonmises_stress evaluate_p7_vonmises_stress/GP_p7_vonmises_stress evaluate_p8_vonmises_stress/GP_p8_vonmises_stress evaluate_p9_vonmises_stress/GP_p9_vonmises_stress evaluate_max_vonmises_stress/GP_max_vonmises_stress'
  #   compute = 'mean stddev'
  #   ci_method = 'percentile'
  #   ci_levels = '0.05 0.95'
  # []
[]

[Trainers]
  [GP_p1_stress_yy_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    show_optimization_details = true
    sampler = train_sample
    response = storage/data:p1_stress_yy:value
    tune_parameters = 'signal_variance length_factor noise_variance'
    tuning_algorithm = 'adam'
    iter_adam = 2000
    # batch_size = 100
    learning_rate_adam = 0.01
    skip_unconverged_samples = true
    converged_reporter = storage/data:converged
  []
  [GP_p2_stress_yy_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    show_optimization_details = true
    sampler = train_sample
    response = storage/data:p2_stress_yy:value
    tune_parameters = 'signal_variance length_factor noise_variance'
    tuning_algorithm = 'adam'
    iter_adam = 2000
    # batch_size = 100
    learning_rate_adam = 0.01
    skip_unconverged_samples = true
    converged_reporter = storage/data:converged
  []
  [GP_p3_stress_yy_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    show_optimization_details = true
    sampler = train_sample
    response = storage/data:p3_stress_yy:value
    tune_parameters = 'signal_variance length_factor noise_variance'
    tuning_algorithm = 'adam'
    iter_adam = 2000
    # batch_size = 100
    learning_rate_adam = 0.01
    skip_unconverged_samples = true
    converged_reporter = storage/data:converged
  []
  [GP_p4_stress_yy_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    show_optimization_details = true
    sampler = train_sample
    response = storage/data:p4_stress_yy:value
    tune_parameters = 'signal_variance length_factor noise_variance'
    tuning_algorithm = 'adam'
    iter_adam = 2000
    # batch_size = 100
    learning_rate_adam = 0.01
    skip_unconverged_samples = true
    converged_reporter = storage/data:converged
  []
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
    learning_rate_adam = 0.01
    skip_unconverged_samples = true
    converged_reporter = storage/data:converged
  []
  [GP_p6_stress_yy_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    show_optimization_details = true
    sampler = train_sample
    response = storage/data:p6_stress_yy:value
    tune_parameters = 'signal_variance length_factor noise_variance'
    tuning_algorithm = 'adam'
    iter_adam = 2000
    # batch_size = 100
    learning_rate_adam = 0.01
    skip_unconverged_samples = true
    converged_reporter = storage/data:converged
  []
  [GP_p7_stress_yy_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    show_optimization_details = true
    sampler = train_sample
    response = storage/data:p7_stress_yy:value
    tune_parameters = 'signal_variance length_factor noise_variance'
    tuning_algorithm = 'adam'
    iter_adam = 2000
    # batch_size = 100
    learning_rate_adam = 0.01
    skip_unconverged_samples = true
    converged_reporter = storage/data:converged
  []
  [GP_p8_stress_yy_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    show_optimization_details = true
    sampler = train_sample
    response = storage/data:p8_stress_yy:value
    tune_parameters = 'signal_variance length_factor noise_variance'
    tuning_algorithm = 'adam'
    iter_adam = 2000
    # batch_size = 100
    learning_rate_adam = 0.01
    skip_unconverged_samples = true
    converged_reporter = storage/data:converged
  []
  [GP_p9_stress_yy_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    show_optimization_details = true
    sampler = train_sample
    response = storage/data:p9_stress_yy:value
    tune_parameters = 'signal_variance length_factor noise_variance'
    tuning_algorithm = 'adam'
    iter_adam = 2000
    # batch_size = 100
    learning_rate_adam = 0.01
    skip_unconverged_samples = true
    converged_reporter = storage/data:converged
  []
  [GP_max_stress_yy_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    show_optimization_details = true
    sampler = train_sample
    response = storage/data:max_stress_yy:value
    tune_parameters = 'signal_variance length_factor noise_variance'
    tuning_algorithm = 'adam'
    iter_adam = 2000
    # batch_size = 100
    learning_rate_adam = 0.01
    skip_unconverged_samples = true
    converged_reporter = storage/data:converged
  []

  # [GP_p1_vonmises_stress_trainer]
  #   type = GaussianProcessTrainer
  #   execute_on = timestep_end
  #   covariance_function = 'covar' #Choose a squared exponential for the kernel
  #   standardize_params = 'true' #Center and scale the training params
  #   standardize_data = 'true' #Center and scale the training data
  #   show_optimization_details = true
  #   sampler = train_sample
  #   response = storage/data:p1_vonmises_stress:value
  #   tune_parameters = 'signal_variance length_factor noise_variance'
  #   tuning_algorithm = 'adam'
  #   iter_adam = 20000
  #   batch_size = 100
  #   learning_rate_adam = 5.0e-4
  #   skip_unconverged_samples = true
  #   converged_reporter = storage/data:converged
  # []
  # [GP_p2_vonmises_stress_trainer]
  #   type = GaussianProcessTrainer
  #   execute_on = timestep_end
  #   covariance_function = 'covar' #Choose a squared exponential for the kernel
  #   standardize_params = 'true' #Center and scale the training params
  #   standardize_data = 'true' #Center and scale the training data
  #   show_optimization_details = true
  #   sampler = train_sample
  #   response = storage/data:p2_vonmises_stress:value
  #   tune_parameters = 'signal_variance length_factor noise_variance'
  #   tuning_algorithm = 'adam'
  #   iter_adam = 20000
  #   batch_size = 100
  #   learning_rate_adam = 5.0e-4
  #   skip_unconverged_samples = true
  #   converged_reporter = storage/data:converged
  # []
  # [GP_p3_vonmises_stress_trainer]
  #   type = GaussianProcessTrainer
  #   execute_on = timestep_end
  #   covariance_function = 'covar' #Choose a squared exponential for the kernel
  #   standardize_params = 'true' #Center and scale the training params
  #   standardize_data = 'true' #Center and scale the training data
  #   show_optimization_details = true
  #   sampler = train_sample
  #   response = storage/data:p3_vonmises_stress:value
  #   tune_parameters = 'signal_variance length_factor noise_variance'
  #   tuning_algorithm = 'adam'
  #   iter_adam = 20000
  #   batch_size = 100
  #   learning_rate_adam = 5.0e-4
  #   skip_unconverged_samples = true
  #   converged_reporter = storage/data:converged
  # []
  # [GP_p4_vonmises_stress_trainer]
  #   type = GaussianProcessTrainer
  #   execute_on = timestep_end
  #   covariance_function = 'covar' #Choose a squared exponential for the kernel
  #   standardize_params = 'true' #Center and scale the training params
  #   standardize_data = 'true' #Center and scale the training data
  #   show_optimization_details = true
  #   sampler = train_sample
  #   response = storage/data:p4_vonmises_stress:value
  #   tune_parameters = 'signal_variance length_factor noise_variance'
  #   tuning_algorithm = 'adam'
  #   iter_adam = 20000
  #   batch_size = 100
  #   learning_rate_adam = 5.0e-4
  #   skip_unconverged_samples = true
  #   converged_reporter = storage/data:converged
  # []
  # [GP_p5_vonmises_stress_trainer]
  #   type = GaussianProcessTrainer
  #   execute_on = timestep_end
  #   covariance_function = 'covar' #Choose a squared exponential for the kernel
  #   standardize_params = 'true' #Center and scale the training params
  #   standardize_data = 'true' #Center and scale the training data
  #   show_optimization_details = true
  #   sampler = train_sample
  #   response = storage/data:p5_vonmises_stress:value
  #   tune_parameters = 'signal_variance length_factor noise_variance'
  #   tuning_algorithm = 'adam'
  #   iter_adam = 20000
  #   batch_size = 100
  #   learning_rate_adam = 5.0e-4
  #   skip_unconverged_samples = true
  #   converged_reporter = storage/data:converged
  # []
  # [GP_p6_vonmises_stress_trainer]
  #   type = GaussianProcessTrainer
  #   execute_on = timestep_end
  #   covariance_function = 'covar' #Choose a squared exponential for the kernel
  #   standardize_params = 'true' #Center and scale the training params
  #   standardize_data = 'true' #Center and scale the training data
  #   show_optimization_details = true
  #   sampler = train_sample
  #   response = storage/data:p6_vonmises_stress:value
  #   tune_parameters = 'signal_variance length_factor noise_variance'
  #   tuning_algorithm = 'adam'
  #   iter_adam = 20000
  #   batch_size = 100
  #   learning_rate_adam = 5.0e-4
  #   skip_unconverged_samples = true
  #   converged_reporter = storage/data:converged
  # []
  # [GP_p7_vonmises_stress_trainer]
  #   type = GaussianProcessTrainer
  #   execute_on = timestep_end
  #   covariance_function = 'covar' #Choose a squared exponential for the kernel
  #   standardize_params = 'true' #Center and scale the training params
  #   standardize_data = 'true' #Center and scale the training data
  #   show_optimization_details = true
  #   sampler = train_sample
  #   response = storage/data:p7_vonmises_stress:value
  #   tune_parameters = 'signal_variance length_factor noise_variance'
  #   tuning_algorithm = 'adam'
  #   iter_adam = 20000
  #   batch_size = 100
  #   learning_rate_adam = 5.0e-4
  #   skip_unconverged_samples = true
  #   converged_reporter = storage/data:converged
  # []
  # [GP_p8_vonmises_stress_trainer]
  #   type = GaussianProcessTrainer
  #   execute_on = timestep_end
  #   covariance_function = 'covar' #Choose a squared exponential for the kernel
  #   standardize_params = 'true' #Center and scale the training params
  #   standardize_data = 'true' #Center and scale the training data
  #   show_optimization_details = true
  #   sampler = train_sample
  #   response = storage/data:p8_vonmises_stress:value
  #   tune_parameters = 'signal_variance length_factor noise_variance'
  #   tuning_algorithm = 'adam'
  #   iter_adam = 20000
  #   batch_size = 100
  #   learning_rate_adam = 5.0e-4
  #   skip_unconverged_samples = true
  #   converged_reporter = storage/data:converged
  # []
  # [GP_p9_vonmises_stress_trainer]
  #   type = GaussianProcessTrainer
  #   execute_on = timestep_end
  #   covariance_function = 'covar' #Choose a squared exponential for the kernel
  #   standardize_params = 'true' #Center and scale the training params
  #   standardize_data = 'true' #Center and scale the training data
  #   show_optimization_details = true
  #   sampler = train_sample
  #   response = storage/data:p9_vonmises_stress:value
  #   tune_parameters = 'signal_variance length_factor noise_variance'
  #   tuning_algorithm = 'adam'
  #   iter_adam = 20000
  #   batch_size = 100
  #   learning_rate_adam = 5.0e-4
  #   skip_unconverged_samples = true
  #   converged_reporter = storage/data:converged
  # []
  # [GP_max_vonmises_stress_trainer]
  #   type = GaussianProcessTrainer
  #   execute_on = timestep_end
  #   covariance_function = 'covar' #Choose a squared exponential for the kernel
  #   standardize_params = 'true' #Center and scale the training params
  #   standardize_data = 'true' #Center and scale the training data
  #   show_optimization_details = true
  #   sampler = train_sample
  #   response = storage/data:max_vonmises_stress:value
  #   tune_parameters = 'signal_variance length_factor noise_variance'
  #   tuning_algorithm = 'adam'
  #   iter_adam = 20000
  #   batch_size = 100
  #   learning_rate_adam = 5.0e-4
  #   skip_unconverged_samples = true
  #   converged_reporter = storage/data:converged
  # []
[]

[Surrogates]
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

  # [GP_p1_vonmises_stress]
  #   type = GaussianProcess
  #   trainer = GP_p1_vonmises_stress_trainer
  # []
  # [GP_p2_vonmises_stress]
  #   type = GaussianProcess
  #   trainer = GP_p2_vonmises_stress_trainer
  # []
  # [GP_p3_vonmises_stress]
  #   type = GaussianProcess
  #   trainer = GP_p3_vonmises_stress_trainer
  # []
  # [GP_p4_vonmises_stress]
  #   type = GaussianProcess
  #   trainer = GP_p4_vonmises_stress_trainer
  # []
  # [GP_p5_vonmises_stress]
  #   type = GaussianProcess
  #   trainer = GP_p5_vonmises_stress_trainer
  # []
  # [GP_p6_vonmises_stress]
  #   type = GaussianProcess
  #   trainer = GP_p6_vonmises_stress_trainer
  # []
  # [GP_p7_vonmises_stress]
  #   type = GaussianProcess
  #   trainer = GP_p7_vonmises_stress_trainer
  # []
  # [GP_p8_vonmises_stress]
  #   type = GaussianProcess
  #   trainer = GP_p8_vonmises_stress_trainer
  # []
  # [GP_p9_vonmises_stress]
  #   type = GaussianProcess
  #   trainer = GP_p9_vonmises_stress_trainer
  # []
  # [GP_max_vonmises_stress]
  #   type = GaussianProcess
  #   trainer = GP_max_vonmises_stress_trainer
  # []

[]

[Covariance]
  [covar]
    type = SquaredExponentialCovariance
    signal_variance = 1.0 #Use a signal variance of 1 in the kernel
    noise_variance = 1e-4 #A small amount of noise can help with numerical stability
    length_factor = '1.0 1.0' #Select a length factor for each parameter
  []
[]

[VectorPostprocessors]
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

  # [hyperparams_p1_vonmises_stress]
  #   type = GaussianProcessData
  #   gp_name = 'GP_p1_vonmises_stress'
  #   execute_on = final
  # []
  # [hyperparams_p2_vonmises_stress]
  #   type = GaussianProcessData
  #   gp_name = 'GP_p2_vonmises_stress'
  #   execute_on = final
  # []
  # [hyperparams_p3_vonmises_stress]
  #   type = GaussianProcessData
  #   gp_name = 'GP_p3_vonmises_stress'
  #   execute_on = final
  # []
  # [hyperparams_p4_vonmises_stress]
  #   type = GaussianProcessData
  #   gp_name = 'GP_p4_vonmises_stress'
  #   execute_on = final
  # []
  # [hyperparams_p5_vonmises_stress]
  #   type = GaussianProcessData
  #   gp_name = 'GP_p5_vonmises_stress'
  #   execute_on = final
  # []
  # [hyperparams_p6_vonmises_stress]
  #   type = GaussianProcessData
  #   gp_name = 'GP_p6_vonmises_stress'
  #   execute_on = final
  # []
  # [hyperparams_p7_vonmises_stress]
  #   type = GaussianProcessData
  #   gp_name = 'GP_p7_vonmises_stress'
  #   execute_on = final
  # []
  # [hyperparams_p8_vonmises_stress]
  #   type = GaussianProcessData
  #   gp_name = 'GP_p8_vonmises_stress'
  #   execute_on = final
  # []
  # [hyperparams_p9_vonmises_stress]
  #   type = GaussianProcessData
  #   gp_name = 'GP_p9_vonmises_stress'
  #   execute_on = final
  # []
  # [hyperparams_max_vonmises_stress]
  #   type = GaussianProcessData
  #   gp_name = 'GP_max_vonmises_stress'
  #   execute_on = final
  # []

  # [data_evaluate]
  #   type = SamplerData
  #   sampler = evaluate_sample
  #   execute_on = 'initial timestep_end'
  # []
  [data_training]
    type = SamplerData
    sampler = train_sample
    execute_on = 'INITIAL TIMESTEP_END'
  []
[]

[Outputs]
  [out]
    type = CSV
    execute_on = FINAL
  []
[]
