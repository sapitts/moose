[StochasticTools]
[]

[Distributions]
  # [upper_left_undercut]
  #   type = TruncatedNormal
  #   mean = 0.0249  #values collected by Drew
  #   standard_deviation = 0.011
  #   lower_bound = 0.0
  #   upper_bound = 0.0508
  # []
  # [upper_right_undercut]
  #   type = TruncatedNormal
  #   mean = 0.0249
  #   standard_deviation = 0.011
  #   lower_bound = 0.0
  #   upper_bound = 0.0508
  # []
  # [lower_left_undercut]
  #   type = TruncatedNormal
  #   mean = 0.0249
  #   standard_deviation = 0.011
  #   lower_bound = 0.0
  #   upper_bound = 0.0508
  # []
  # [lower_right_undercut]
  #   type = TruncatedNormal
  #   mean = 0.0249
  #   standard_deviation = 0.011
  #   lower_bound = 0.0
  #   upper_bound = 0.0508
  # []
  # [gauge_width]
  #   type = TruncatedNormal
  #   mean = 1.2
  #   standard_deviation = 0.1
  #   lower_bound = 0.946
  #   upper_bound = 1.454
  # []
  # [gauge_height]
  #   type = TruncatedNormal
  #   mean = 5.7
  #   standard_deviation = 0.1
  #   lower_bound = 5.446
  #   upper_bound = 5.954
  # []

  [upper_left_undercut_norm]
    type = Normal
    mean = 0.0249
    standard_deviation = 0.011
  []
  [upper_right_undercut_norm]
    type = Normal
    mean = 0.0249
    standard_deviation = 0.011
  []
  [lower_left_undercut_norm]
    type = Normal
    mean = 0.0249
    standard_deviation = 0.011
  []
  [lower_right_undercut_norm]
    type = Normal
    mean = 0.0249
    standard_deviation = 0.011
  []
  [gauge_width_norm]
    type = Normal
    mean = 1.2
    standard_deviation = 0.1
  []
  [gauge_height_norm]
    type = Normal
    mean = 5.7
    standard_deviation = 0.1
  []
[]

[Samplers]
  [csv_geometry_distributions]
    type = CSVSampler
    samples_file = 'generate_data_2d_shoulders_data_training_0002.csv'
    column_names = 'train_sample_0 train_sample_1 train_sample_2 train_sample_3 train_sample_4 train_sample_5'
    execute_on = LINEAR
  []
[]

[Trainers]
  [pc_train]
    type = PolynomialChaosTrainer
    order = 4
    distributions = 'upper_left_undercut_norm upper_right_undercut_norm lower_left_undercut_norm lower_right_undercut_norm gauge_width_norm gauge_height_norm'
    sampler = csv_geometry_distributions
    response = 'tm_results_reader/data:p4_stress_yy:value'
  []
[]

[Surrogates]
  [pc_surrogate]
    type = PolynomialChaos
    trainer = pc_train
  []
[]

[Reporters]
  [sobol]
    type = PolynomialChaosReporter
    pc_name = pc_surrogate
    include_sobol = true
  []
[]

[VectorPostprocessors]
  [tm_results_reader]
    type = CSVReader
    csv_file = 'generate_data_2d_shoulders_storage_0002.csv'
  []
[]

[Outputs]
  json = true
  csv = true
  execute_on = FINAL
[]
