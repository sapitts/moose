[StochasticTools]
[]

[Distributions]
  [right_circle_y]
    type = Uniform
    lower_bound = -0.1
    upper_bound = 0.1
  []
  [left_circle_y]
    type = Uniform
    lower_bound = -0.1
    upper_bound = 0.1
  []
  # [right_circle_r]
  #   type = Uniform
  #   lower_bound = 0.725
  #   upper_bound = 0.775
  # []
  # [left_circle_r]
  #   type = Uniform
  #   lower_bound = 0.725
  #   upper_bound = 0.775
  # []
  # [fillet_radius]
  #   type = Uniform
  #   lower_bound = 0.25
  #   upper_bound = 0.35
  # []
[]

[GlobalParams]
  # sampler = sample
  distributions = 'right_circle_y left_circle_y' # right_circle_r left_circle_r fillet_radius'
[]

[Samplers]
  [sample]
    type = MonteCarlo
    num_rows = 200
    # execute_on = PRE_MULTIAPP_SETUP
    execute_on = initial
  []
[]

[Surrogates]
  [pc_strain_xx_bot]
    type = PolynomialChaos
    filename = train_1param_trainer_poly_chaos_strain_xx_bot.rd #./y_position/train_1param_trainer_poly_chaos_strain_xx_bot.rd
  []
  [pc_strain_xx_center]
    type = PolynomialChaos
    filename = train_1param_trainer_poly_chaos_strain_xx_center.rd #./y_position/train_1param_trainer_poly_chaos_strain_xx_center.rd
  []
  [pc_strain_xx_top]
    type = PolynomialChaos
    filename = train_1param_trainer_poly_chaos_strain_xx_top.rd #./y_position/train_1param_trainer_poly_chaos_strain_xx_top.rd
  []
  [pc_stress_xx_bot]
    type = PolynomialChaos
    filename = train_1param_trainer_poly_chaos_stress_xx_bot.rd #./y_position/train_1param_trainer_poly_chaos_stress_xx_bot.rd
  []
  [pc_stress_xx_center]
    type = PolynomialChaos
    filename = train_1param_trainer_poly_chaos_stress_xx_center.rd #./y_position/train_1param_trainer_poly_chaos_stress_xx_center.rd
  []
  [pc_stress_xx_top]
    type = PolynomialChaos
    filename = train_1param_trainer_poly_chaos_stress_xx_top.rd #./y_position/train_1param_trainer_poly_chaos_stress_xx_top.rd
  []
[]


# Computing statistics
[Reporters]
  [eval_surrogate]
    type = EvaluateSurrogate
    model = 'pc_strain_xx_bot pc_strain_xx_center pc_strain_xx_top pc_stress_xx_bot pc_stress_xx_center pc_stress_xx_top'
    sampler = sample
    parallel_type = ROOT
  []
  [eval_surrogate_stats]
    type = PolynomialChaosReporter
    pc_name = 'pc_strain_xx_bot pc_strain_xx_center pc_strain_xx_top pc_stress_xx_bot pc_stress_xx_center pc_stress_xx_top'
    statistics = 'mean stddev'
    include_sobol = true
    # include_data = true
  []
  # [sobol]
  #   type = SobolReporter
  #   reporters = 'eval_surrogate/pc_strain_xx_bot eval_surrogate/pc_strain_xx_center eval_surrogate/pc_strain_xx_top eval_surrogate/pc_stress_xx_bot eval_surrogate/pc_stress_xx_center eval_surrogate/pc_stress_xx_top'
  #   ci_levels = '0.1 0.9'
  #   sampler = sample
  #   # ci_replicates = 100
  #   # execute_on = FINAL
  # []
[]


[Outputs]
  [csv]
    type = CSV
    execute_on = FINAL
  []
  [out]
    type = JSON
    execute_on = FINAL
  []
[]
