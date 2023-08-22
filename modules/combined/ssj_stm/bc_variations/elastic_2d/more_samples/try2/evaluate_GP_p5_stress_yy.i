# using the input that Brennan provided

[StochasticTools]
[]

[Samplers]
  [data_train]
    type = CSVSampler
    samples_file = 'gptraining_2d_bcs_data_training_0002.csv'
    execute_on = 'initial'
  []
[]

[Surrogates]
  [gp_surrogate]
    type = GaussianProcess
    filename = 'gptraining_2d_bcs_GP_p5_stress_yy_trainer.rd'
  []
[]

[Reporters]
  [surrogate_eval]
    type = EvaluateSurrogate
    sampler = data_train
    model = gp_surrogate
    evaluate_std = 'true'
    parallel_type = ROOT
  []
[]

[Outputs]
  csv = true
  execute_on = FINAL
[]
