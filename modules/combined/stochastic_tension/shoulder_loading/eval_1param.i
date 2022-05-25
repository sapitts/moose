[StochasticTools]
[]

[Distributions]
  [right_circle_y]
    type = Uniform
    lower_bound = -0.1
    upper_bound = 0.1
  []
  # [left_circle_y]
  #   type = Uniform
  #   lower_bound = -0.1
  #   upper_bound = 0.1
  # []
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
  distributions = 'right_circle_y' # left_circle_y' # right_circle_r left_circle_r fillet_radius'
[]

[Samplers]
  [sample]
    type = MonteCarlo
    num_rows = 200
    execute_on = PRE_MULTIAPP_SETUP
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
    type = StatisticsReporter
    reporters = 'eval_surrogate/pc_strain_xx_bot eval_surrogate/pc_strain_xx_center eval_surrogate/pc_strain_xx_top eval_surrogate/pc_stress_xx_bot eval_surrogate/pc_stress_xx_center eval_surrogate/pc_stress_xx_top'
    compute = 'stddev'
    # ci_method = 'percentile'
    # ci_levels = '0.05 0.95'
  []
  # [eval_surrogate_sobol]
  #   type = PolynomialChaosReporter
  #   pc_name = 'pc_strain_xx_bot pc_strain_xx_center pc_strain_xx_top pc_stress_xx_bot pc_stress_xx_center pc_stress_xx_top'
  #   statistics = 'mean stddev'
  #   include_data = true
  #   include_sobol = true
  #   execute_on = TIMESTEP_END
  # []
[]

# [Reporters]
#   [eval_strain_xx_bot]
#     type = EvaluateSurrogate
#     model = pc_strain_xx_bot
#   []
#   [eval_strain_xx_center]
#     type = EvaluateSurrogate
#     model = pc_strain_xx_center
#   []
#   [eval_strain_xx_top]
#     type = EvaluateSurrogate
#     model = pc_strain_xx_top
#   []
#   [eval_stress_xx_bot]
#     type = EvaluateSurrogate
#     model = pc_stress_xx_bot
#   []
#   [eval_stress_xx_center]
#     type = EvaluateSurrogate
#     model = pc_stress_xx_center
#   []
#   [eval_stress_xx_top]
#     type = EvaluateSurrogate
#     model = pc_stress_xx_top
#   []
# []

# [VectorPostprocessors]
#   [stats_strain_xx_bot]
#     type = PolynomialChaosStatistics
#     pc_name = pc_strain_xx_bot
#     compute = 'mean stddev'
#   []
#   [sobol_strain_xx_bot]
#     type = PolynomialChaosSobolStatistics
#     pc_name = pc_strain_xx_bot
#     sensitivity_order = 'first second total'
#   []
#   [stats_strain_xx_center]
#     type = PolynomialChaosStatistics
#     pc_name = pc_strain_xx_center
#     compute = 'mean stddev'
#   []
#   [sobol_strain_xx_center]
#     type = PolynomialChaosSobolStatistics
#     pc_name = pc_strain_xx_center
#     sensitivity_order = 'first second total'
#   []
#   [stats_strain_xx_top]
#     type = PolynomialChaosStatistics
#     pc_name = pc_strain_xx_top
#     compute = 'mean stddev'
#   []
#   [sobol_strain_xx_top]
#     type = PolynomialChaosSobolStatistics
#     pc_name = pc_strain_xx_top
#     sensitivity_order = 'first second total'
#   []
#   [stats_stress_xx_bot]
#     type = PolynomialChaosStatistics
#     pc_name = pc_stress_xx_bot
#     compute = 'mean stddev'
#   []
#   [sobol_stress_xx_bot]
#     type = PolynomialChaosSobolStatistics
#     pc_name = pc_stress_xx_bot
#     sensitivity_order = 'first second total'
#   []
#   [stats_stress_xx_center]
#     type = PolynomialChaosStatistics
#     pc_name = pc_stress_xx_center
#     compute = 'mean stddev'
#   []
#   [sobol_stress_xx_center]
#     type = PolynomialChaosSobolStatistics
#     pc_name = pc_stress_xx_center
#     sensitivity_order = 'first second total'
#   []
#   [stats_stress_xx_top]
#     type = PolynomialChaosStatistics
#     pc_name = pc_stress_xx_top
#     compute = 'mean stddev'
#   []
#   [sobol_stress_xx_top]
#     type = PolynomialChaosSobolStatistics
#     pc_name = pc_stress_xx_top
#     sensitivity_order = 'first second total'
#   []
# []

[Outputs]
  csv = true
  execute_on = timestep_end
[]
