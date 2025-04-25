[GlobalParams]
  displacements = 'disp_x disp_y'
[]

[Mesh]
  coord_type = RZ
  [file]
    type = FileMeshGenerator
    file = twostep_gauge1in_2d.e
  []
[]

[AuxVariables]
  [temperature]
    initial_condition = 1023.15 ##750C
  []
  [radial_strain]
    order = CONSTANT
    family = MONOMIAL
  []
  [axial_strain]
    order = CONSTANT
    family = MONOMIAL
  []
  [radial_stress]
    order = CONSTANT
    family = MONOMIAL
  []
  [axial_stress]
    order = CONSTANT
    family = MONOMIAL
  []
[]

[Physics]
  [SolidMechanics]
    [QuasiStatic]
      [all]
        strain = SMALL
        new_system = true
        add_variables = true
        formulation = TOTAL
        volumetric_locking_correction = false
        generate_output = 'vonmises_stress stress_xx stress_yy stress_zz hydrostatic_stress triaxiality_stress' # creep_strain_xx creep_strain_yy'
      []
    []
  []
[]

[AuxKernels]
  [radial_strain]
    type = RankTwoAux
    rank_two_tensor = total_strain
    variable = radial_strain
    index_i = 0
    index_j = 0
    execute_on = timestep_end
  []
  [axial_strain]
    type = RankTwoAux
    rank_two_tensor = mechanical_strain
    variable = axial_strain
    index_i = 1
    index_j = 1
    execute_on = 'timestep_end'
  []
  [radial_stress]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = radial_stress
    index_i = 0
    index_j = 0
    execute_on = timestep_end
  []
  [axial_stress]
    type = RankTwoAux
    rank_two_tensor = stress
    variable = axial_stress
    index_i = 1
    index_j = 1
    execute_on = 'timestep_end'
  []
[]

[BCs]
  [fixed_bottom]
    type = DirichletBC
    variable = disp_y
    value = 0
    boundary = 'lower_grip_bottom upper_grip_top'
  []
  [no_x]
    type = DirichletBC
    variable = disp_x
    boundary = centerline
    value = 0.0
  []
  # [upper_loading]
  #   type = FunctionNeumannBC
  #   use_displaced_mesh = true
  #   variable = disp_y
  #   boundary = 'upper_grip_top'
  #   function = 'if(t<100.0, 0.2539e6*t , 25.39e6)'
  # []
[]

[NEML2]
  input = 'models/elasticity.i'
  [all]
    model = 'model'
    verbose = true
    device = 'cpu'

    moose_input_types = 'MATERIAL      VARIABLE'
    moose_inputs = '     neml2_strain  temperature'
    neml2_inputs = '     forces/E      forces/T'

    moose_output_types = 'MATERIAL   MATERIAL'
    moose_outputs = 'neml2_stress    neml2_elastic_strain'
    neml2_outputs = 'state/S         state/Ee'

    moose_derivative_types = 'MATERIAL'
    moose_derivatives = 'neml2_jacobian'
    neml2_derivatives = 'state/S forces/E'
  []
[]

[Materials]
  [convert_strain]
    type = RankTwoTensorToSymmetricRankTwoTensor
    from = 'mechanical_strain'
    to = 'neml2_strain'
  []
  [stress]
    type = ComputeLagrangianObjectiveCustomSymmetricStress
    custom_small_stress = 'neml2_stress'
    custom_small_jacobian = 'neml2_jacobian'
  []
  [convert_stress]
    type = SymmetricRankTwoTensorToRankTwoTensor
    from = 'neml2_stress'
    to = 'stress'
  []

  # [radial_return_stress]
  #   type = ADComputeMultipleInelasticStress
  #   inelastic_models = 'powerlawcreep'
  #   # damage_model = damage
  #   relative_tolerance = 1e-05
  # []
  # [powerlawcreep]
  #   type = ADPowerLawCreepStressUpdate
  #   coefficient = 2.559e-6
  #   n_exponent = 1.6
  #   m_exponent = 0.494
  #   activation_energy = 0.0
  #   # temperature = temperature
  #   acceptable_multiplier = 0.1
  #   # relative_tolerance = 1e-06
  #   # absolute_tolerance = 1e-10
  #   automatic_differentiation_return_mapping = true
  # []
  # [thermal_eigenstrain]
  #   type = ComputeThermalExpansionEigenstrain
  #   stress_free_temperature = 294.26
  #   thermal_expansion_coeff = 1.836e-5 ### from BISON manual
  #   eigenstrain_name = thermal_eigenstrain
  #   temperature = temperature
  # []
  # [damage]
  #   type = ADSteelCreepDamageOh
  #   epsilon_f = 1.6
  #   creep_strain_names = creep_strain
  #   reduction_factor = 1.0e3
  #   use_old_damage = true
  #   creep_law_exponent = 8.75
  # []
[]

[Executioner]
  type = Transient
  solve_type = 'NEWTON'

  petsc_options_iname = '-pc_type  -pc_factor_mat_solver_package'
  petsc_options_value = ' lu        superlu_dist'
  petsc_options = '-snes_converged_reason'
  line_search = 'none'
  residual_and_jacobian_together = true

  l_max_its = 50
  nl_max_its = 50
  # nl_rel_tol = 1e-8
  nl_abs_tol = 6e-9
  start_time = 0
  end_time = 432000.0 ## 120 hours
  dt = 50.0
  dtmin = 1e-2
  nl_forced_its = 2
  num_steps = 2
[]

[Postprocessors]
    [average_stress]
      type = ElementAverageMaterialProperty
      mat_prop = stress_yy
    []
    # [creep_strain]
    #   type = ADElementAverageMaterialProperty
    #   mat_prop = effective_creep_strain
    # []
    [vonmises_stress]
      type = ElementAverageMaterialProperty
      mat_prop = vonmises_stress
    []
    [triaxiality_stress]
      type = ElementAverageMaterialProperty
      mat_prop = triaxiality_stress
    []
  [radial_strain]
    type = ElementAverageValue
    variable = radial_strain
  []
  [axial_strain]
    type = ElementAverageValue
    variable = axial_strain
  []
  [radial_stress]
    type = ElementAverageValue
    variable = radial_stress
  []
  [axial_stress]
    type = ElementAverageValue
    variable = axial_stress
  []
[]

# [VectorPostprocessors]
#   [vonmises_stress_line]
#     type = LineValueSampler
#     variable = 'vonmises_stress'
#     sort_by = x
#     start_point = '0 0.006251 0'
#     #end_point = '0.004013 0.006350 0'
#     #end_point = '0.005283 0.006350 0'
#     # end_point = '0.002743 0.006350 0'
#     #end_point = '0.00386 0.006350 0'
#     end_point = '0.00513 0.006350 0'
#     outputs = 'vonmises_stress_line'
#     num_points = 100
#   []
#   [triaxiality_stress_line]
#     type = LineValueSampler
#     variable = 'triaxiality_stress'
#     sort_by = x
#     start_point = '0 0.006251 0'
#     #end_point = '0.004013 0.006350 0'
#     # #end_point = '0.005283 0.006350 0'
#     # end_point = '0.002743 0.006350 0'
#     #end_point = '0.00386 0.006350 0'
#     end_point = '0.00513 0.006350 0'
#     outputs = 'triaxiality_stress_line'
#     num_points = 100
#   []
# []

[Outputs]
  perf_graph = true
  exodus = true
  color = true
  csv = true
  # file_base = 'powerlawcreep_twogauge_750C_eigenstrain_multiplier'
  # [vonmises_stress_line]
  #   type = CSV
  #   file_base = vonmises_stress_notch_5s
  #   execute_on = 'FINAL'
  # []
  # [triaxiality_stress_line]
  #   type = CSV
  #   file_base = triaxiality_stress_notch_5s
  #   execute_on = 'FINAL'
  # []
[]
