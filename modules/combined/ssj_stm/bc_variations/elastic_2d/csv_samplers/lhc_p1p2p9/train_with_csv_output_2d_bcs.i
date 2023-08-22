[StochasticTools]
[]

# [Distributions]
#   [upper_rig_offset]
#     type = TruncatedNormal
#     mean = 0.0
#     standard_deviation = 0.1
#     lower_bound = -0.15
#     upper_bound = 0.15
#   []
#   [lower_rig_offset]
#     type = TruncatedNormal
#     mean = 0.0
#     standard_deviation = 0.1
#     lower_bound = -0.15
#     upper_bound = 0.15
#   []
# []

[Samplers]
  # [train_sample]
  #   type = LatinHypercube
  #   num_rows = 400
  #   distributions = 'upper_rig_offset lower_rig_offset'
  #   execute_on = PRE_MULTIAPP_SETUP
  #   seed = 250
  # []
  [csv_original_bc_distributions]
    type = CSVSampler
    samples_file = 'bc_distributions.csv'
    column_names = 'train_sample_0 train_sample_1'
    execute_on = LINEAR
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
    sampler = csv_original_bc_distributions
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [train_p2_stress_yy]
    type = EvaluateSurrogate
    model = GP_p2_stress_yy
    sampler = csv_original_bc_distributions
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []
  [train_p9_stress_yy]
    type = EvaluateSurrogate
    model = GP_p9_stress_yy
    sampler = csv_original_bc_distributions
    evaluate_std = 'true'
    parallel_type = ROOT
    execute_on = final
  []

  # [train_p1_vonmises_stress]
  #   type = EvaluateSurrogate
  #   model = GP_p1_vonmises_stress
  #   sampler = train_sample
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
  # [train_p9_vonmises_stress]
  #   type = EvaluateSurrogate
  #   model = GP_p9_vonmises_stress
  #   sampler = train_sample
  #   evaluate_std = 'true'
  #   parallel_type = ROOT
  #   execute_on = final
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
    sampler = csv_original_bc_distributions
    response = tm_results_reader/data:p1_stress_yy:value
    tune_parameters = 'signal_variance length_factor noise_variance'
    tuning_algorithm = 'adam'
    iter_adam = 2000
    # batch_size = 100
    learning_rate_adam = 0.01
    # skip_unconverged_samples = true
    # converged_reporter = storage/data:converged
  []
  [GP_p2_stress_yy_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    show_optimization_details = true
    sampler = csv_original_bc_distributions
    response = tm_results_reader/data:p2_stress_yy:value
    tune_parameters = 'signal_variance length_factor noise_variance'
    tuning_algorithm = 'adam'
    iter_adam = 2000
    # batch_size = 100
    learning_rate_adam = 0.01
    # skip_unconverged_samples = true
    # converged_reporter = storage/data:converged
  []
  [GP_p9_stress_yy_trainer]
    type = GaussianProcessTrainer
    execute_on = timestep_end
    covariance_function = 'covar' #Choose a squared exponential for the kernel
    standardize_params = 'true' #Center and scale the training params
    standardize_data = 'true' #Center and scale the training data
    show_optimization_details = true
    sampler = csv_original_bc_distributions
    response = tm_results_reader/data:p9_stress_yy:value
    tune_parameters = 'signal_variance length_factor noise_variance'
    tuning_algorithm = 'adam'
    iter_adam = 2000
    # batch_size = 100
    learning_rate_adam = 0.01
    # skip_unconverged_samples = true
    # converged_reporter = storage/data:converged
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
  #   iter_adam = 5000
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
  #   iter_adam = 5000
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
  #   iter_adam = 5000
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
  [GP_p9_stress_yy]
    type = GaussianProcess
    trainer = GP_p9_stress_yy_trainer
  []

  # [GP_p1_vonmises_stress]
  #   type = GaussianProcess
  #   trainer = GP_p1_vonmises_stress_trainer
  # []
  # [GP_p2_vonmises_stress]
  #   type = GaussianProcess
  #   trainer = GP_p2_vonmises_stress_trainer
  # []
  # [GP_p9_vonmises_stress]
  #   type = GaussianProcess
  #   trainer = GP_p9_vonmises_stress_trainer
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
  [tm_results_reader]
    type = CSVReader
    csv_file = 'subApp_results.csv'
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
  [hyperparams_p9_stress_yy]
    type = GaussianProcessData
    gp_name = 'GP_p9_stress_yy'
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
  # [hyperparams_p9_vonmises_stress]
  #   type = GaussianProcessData
  #   gp_name = 'GP_p9_vonmises_stress'
  #   execute_on = final
  # []

  [data_training]
    type = SamplerData
    sampler = csv_original_bc_distributions
    execute_on = 'INITIAL TIMESTEP_END'
  []
[]

[Outputs]
  [out]
    type = CSV
    execute_on = FINAL
  []
[]
