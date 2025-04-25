[GlobalParams]
  volumetric_locking_correction = false
  displacements = 'disp_x disp_y'
[]

[Problem]
  type = ReferenceResidualProblem
  extra_tag_vectors = 'ref'
  reference_vector = 'ref'
  # group_variables = 'disp_x disp_y'
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
    order = FIRST
    family = MONOMIAL
  []
  [axial_strain]
    order = FIRST
    family = MONOMIAL
  []
  [effective_creep_strain]
    order = FIRST
    family = MONOMIAL
  []
  [damage_index]
    order = CONSTANT
    family = MONOMIAL
  []
  [omega]
    order = CONSTANT
    family = MONOMIAL
  []
[]

[Modules/TensorMechanics/Master]
  [block]
    add_variables = true
    strain = FINITE
    incremental = true
    eigenstrain_names = 'thermal_eigenstrain'
    generate_output = 'vonmises_stress stress_xx stress_yy stress_zz hydrostatic_stress triaxiality_stress creep_strain_xx creep_strain_yy strain_xx strain_yy strain_zz'
    use_automatic_differentiation = true
    # use_finite_deform_jacobian = true
    extra_vector_tags = 'ref'
    material_output_order = FIRST
  []
[]

[AuxKernels]
  [radial_strain]
    type = ADRankTwoAux
    rank_two_tensor = total_strain
    variable = radial_strain
    index_i = 0
    index_j = 0
    execute_on = timestep_end
  []
  [axial_strain]
    type = ADRankTwoAux
    rank_two_tensor = total_strain
    variable = axial_strain
    index_i = 1
    index_j = 1
    execute_on = 'timestep_end'
  []
  [effective_creep_strain]
    type = ADMaterialRealAux
    property = effective_creep_strain
    variable = effective_creep_strain
    execute_on = timestep_end
  []
  [damage_index]
    type = ADMaterialRealAux
    variable = damage_index
    property = damage_index
    execute_on = timestep_end
  []
  [omega]
    type = ADMaterialRealAux
    variable = omega
    property = omega
    execute_on = timestep_end
  []
[]

[BCs]
  [fixed_bottom]
    type = ADDirichletBC
    variable = disp_y
    value = 0
    boundary = 'lower_grip_bottom'
    extra_vector_tags = 'ref'
  []
  [no_x]
    type = ADDirichletBC
    variable = disp_x
    boundary = 'centerline'
    value = 0.0
    extra_vector_tags = 'ref'
  []
  [upper_loading]
    type = ADFunctionNeumannBC
    use_displaced_mesh = true
    variable = disp_y
    boundary = 'upper_grip_top'
    function = 'if(t<100.0, 0.2539e6*t , 25.39e6)'
    extra_vector_tags = 'ref'
  []
[]

[Materials]
  [elasticity]
    type = ADSS316ElasticityTensor
    temperature = temperature
  []
  [radial_return_stress]
    type = ADComputeMultipleInelasticStress
    inelastic_models = 'powerlawcreep'
    # damage_model = damage
  []
  [powerlawcreep]
    type = ADSS316CreepUpdate
    temperature = temperature
    # effective_inelastic_strain_name = effective_creep_strain
    fast_neutron_flux = 0.0
  []
  [thermal_eigenstrain]
    type = ADSS316ThermalExpansionEigenstrain
    eigenstrain_name = thermal_eigenstrain
    stress_free_temperature = 295 ## from Wen's input file
    temperature = temperature
  []
  [damage]
    type = ADSteelCreepDamageOh  ## this block copied directly from Wen's notch input file
    epsilon_f = 10 #0.01
    creep_strain_names = creep_strain
    reduction_factor = 1.0e3
    use_old_damage = true
    creep_law_exponent = 10.0
    #block = '1 2'
    reduction_damage_threshold = 1
  []
[]

[Preconditioning]
  [SMP]
    type = SMP
    full = true
  []
[]
[Executioner]
  type = Transient
  solve_type = 'NEWTON'

  petsc_options_iname = '-pc_type  -pc_factor_mat_solver_package'
  petsc_options_value = '  lu        superlu_dist'
  petsc_options = '-snes_converged_reason'
  line_search = 'none'
  l_max_its = 50
  # l_tol = 8e-3
  nl_max_its = 25
  nl_rel_tol = 1e-6
  nl_abs_tol = 5e-8
  # nl_forced_its = 3
  start_time = 0
  end_time = 432000.0 ## 120 hours
  dtmin = 1e-2
  [TimeStepper]
    type = IterationAdaptiveDT
    dt = 1.0e3
    optimal_iterations = 3
    iteration_window = 1
  []
  # automatic_scaling = true
  # compute_scaling_once = false

[]

[Postprocessors]
  [average_stress]
    type = ADElementAverageMaterialProperty
    mat_prop = stress_yy
  []
  [creep_strain]
    type = ADElementAverageMaterialProperty
    mat_prop = effective_creep_strain
  []
  [vonmises_stress]
    type = ADElementAverageMaterialProperty
    mat_prop = vonmises_stress
  []
  [triaxiality_stress]
    type = ADElementAverageMaterialProperty
    mat_prop = triaxiality_stress
  []
  [radial_strain]
    type = ElementAverageValue
    variable = strain_yy
  []
  [axial_strain]
    type = ElementAverageValue
    variable = strain_xx
  []

  [top_base_start_avg]
    type = VectorPostprocessorReductionValue
    vector_name = strain_yy
    vectorpostprocessor = top_base_start_curve
    value_type = average
  []
  [gauge1_point10_avg]
    type = VectorPostprocessorReductionValue
    vector_name = strain_yy
    vectorpostprocessor = gauge1_point10_top
    value_type = average
  []
  [gauge1_point09_avg]
    type = VectorPostprocessorReductionValue
    vector_name = strain_yy
    vectorpostprocessor = gauge1_point09
    value_type = average
  []
  [gauge1_point08_avg]
    type = VectorPostprocessorReductionValue
    vector_name = strain_yy
    vectorpostprocessor = gauge1_point08
    value_type = average
  []
  [gauge1_point07_avg]
    type = VectorPostprocessorReductionValue
    vector_name = strain_yy
    vectorpostprocessor = gauge1_point07
    value_type = average
  []
  [gauge1_point06_avg]
    type = VectorPostprocessorReductionValue
    vector_name = strain_yy
    vectorpostprocessor = gauge1_point06
    value_type = average
  []
  [gauge1_point05_avg]
    type = VectorPostprocessorReductionValue
    vector_name = strain_yy
    vectorpostprocessor = gauge1_point05_mid
    value_type = average
  []
  [gauge1_point04_avg]
    type = VectorPostprocessorReductionValue
    vector_name = strain_yy
    vectorpostprocessor = gauge1_point04
    value_type = average
  []
  [gauge1_point03_avg]
    type = VectorPostprocessorReductionValue
    vector_name = strain_yy
    vectorpostprocessor = gauge1_point03
    value_type = average
  []
  [gauge1_point02_avg]
    type = VectorPostprocessorReductionValue
    vector_name = strain_yy
    vectorpostprocessor = gauge1_point02
    value_type = average
  []
  [gauge1_point01_avg]
    type = VectorPostprocessorReductionValue
    vector_name = strain_yy
    vectorpostprocessor = gauge1_point01
    value_type = average
  []
  [gauge1_point00_avg]
    type = VectorPostprocessorReductionValue
    vector_name = strain_yy
    vectorpostprocessor = gauge1_point00
    value_type = average
  []

  [top_step_avg]
    type = VectorPostprocessorReductionValue
    vector_name = strain_yy
    vectorpostprocessor = top_transition_step
    value_type = average
  []
  [bottom_step_avg]
    type = VectorPostprocessorReductionValue
    vector_name = strain_yy
    vectorpostprocessor = bottom_transition_step
    value_type = average
  []

  [gauge2_point10_avg]
    type = VectorPostprocessorReductionValue
    vector_name = strain_yy
    vectorpostprocessor = gauge2_point10_top
    value_type = average
  []
  [gauge2_point09_avg]
    type = VectorPostprocessorReductionValue
    vector_name = strain_yy
    vectorpostprocessor = gauge2_point09
    value_type = average
  []
  [gauge2_point08_avg]
    type = VectorPostprocessorReductionValue
    vector_name = strain_yy
    vectorpostprocessor = gauge2_point08
    value_type = average
  []
  [gauge2_point07_avg]
    type = VectorPostprocessorReductionValue
    vector_name = strain_yy
    vectorpostprocessor = gauge2_point07
    value_type = average
  []
  [gauge2_point06_avg]
    type = VectorPostprocessorReductionValue
    vector_name = strain_yy
    vectorpostprocessor = gauge2_point06
    value_type = average
  []
  [gauge2_point05_avg]
    type = VectorPostprocessorReductionValue
    vector_name = strain_yy
    vectorpostprocessor = gauge2_point05_mid
    value_type = average
  []
  [gauge2_point04_avg]
    type = VectorPostprocessorReductionValue
    vector_name = strain_yy
    vectorpostprocessor = gauge2_point04
    value_type = average
  []
  [gauge2_point03_avg]
    type = VectorPostprocessorReductionValue
    vector_name = strain_yy
    vectorpostprocessor = gauge2_point03
    value_type = average
  []
  [gauge2_point02_avg]
    type = VectorPostprocessorReductionValue
    vector_name = strain_yy
    vectorpostprocessor = gauge2_point02
    value_type = average
  []
  [gauge2_point01_avg]
    type = VectorPostprocessorReductionValue
    vector_name = strain_yy
    vectorpostprocessor = gauge2_point01
    value_type = average
  []
  [gauge2_point00_avg]
    type = VectorPostprocessorReductionValue
    vector_name = strain_yy
    vectorpostprocessor = gauge2_point00
    value_type = average
  []

  [bottom_base_start_avg]
    type = VectorPostprocessorReductionValue
    vector_name = strain_yy
    vectorpostprocessor = bottom_base_start_curve
    value_type = average
  []
[]

[VectorPostprocessors]
  [top_base_start_curve]
    type = LineValueSampler
    variable = 'strain_yy'
    sort_by = x
    start_point = '1.0e-6 0.0590886 0'
    end_point = '0.00300796 0.0590886 0'
    num_points = 10
  []
  [gauge1_point10_top]
    type = LineValueSampler
    variable = 'strain_yy'
    sort_by = x
    start_point = '1.0e-6 0.057899 0'
    end_point = '0.0028575 0.057899 0'
    num_points = 10

  []
  [gauge1_point09]
    type = LineValueSampler
    variable = 'strain_yy'
    sort_by = x
    start_point = '1.0e-6 0.055359 0'
    end_point = '0.0028575 0.055359 0'
    num_points = 10
  []
  [gauge1_point08]
    type = LineValueSampler
    variable = 'strain_yy'
    sort_by = x
    start_point = '1.0e-6 0.052819 0'
    end_point = '0.0028575 0.052819 0'
    num_points = 10
  []
  [gauge1_point07]
    type = LineValueSampler
    variable = 'strain_yy'
    sort_by = x
    start_point = '1.0e-6 0.050279 0'
    end_point = '0.0028575 0.050279 0'
    num_points = 10
  []
  [gauge1_point06]
    type = LineValueSampler
    variable = 'strain_yy'
    sort_by = x
    start_point = '1.0e-6 0.047739 0'
    end_point = '0.0028575 0.047739 0'
    num_points = 10
  []
  [gauge1_point05_mid]
    type = LineValueSampler
    variable = 'strain_yy'
    sort_by = x
    start_point = '1.0e-6 0.045199 0'
    end_point = '0.0028575 0.045199 0'
    num_points = 10
  []
  [gauge1_point04]
    type = LineValueSampler
    variable = 'strain_yy'
    sort_by = x
    start_point = '1.0e-6 0.042659 0'
    end_point = '0.0028575 0.042659 0'
    num_points = 10
  []
  [gauge1_point03]
    type = LineValueSampler
    variable = 'strain_yy'
    sort_by = x
    start_point = '1.0e-6 0.040119 0'
    end_point = '0.0028575 0.040119 0'
    num_points = 10
  []
  [gauge1_point02]
    type = LineValueSampler
    variable = 'strain_yy'
    sort_by = x
    start_point = '1.0e-6 0.037579 0'
    end_point = '0.0028575 0.037579 0'
    num_points = 10
  []
  [gauge1_point01]
    type = LineValueSampler
    variable = 'strain_yy'
    sort_by = x
    start_point = '1.0e-6 0.035039 0'
    end_point = '0.0028575 0.035039 0'
    num_points = 10
  []
  [gauge1_point00]
    type = LineValueSampler
    variable = 'strain_yy'
    sort_by = x
    start_point = '1.0e-6 0.035039 0'
    end_point = '0.0028575 0.035039 0'
    num_points = 10
  []

  [top_transition_step]
    type = LineValueSampler
    variable = 'strain_yy'
    sort_by = x
    start_point = '1.0e-6 0.031991 0'
    end_point = '0.00296333 0.031991 0'
    num_points = 10
  []
  [bottom_transition_step]
    type = LineValueSampler
    variable = 'strain_yy'
    sort_by = x
    start_point = '1.0e-6 0.031483 0'
    end_point = '0.00306916 0.031483 0'
    num_points = 10
  []

  [gauge2_point10_top]
    type = LineValueSampler
    variable = 'strain_yy'
    sort_by = x
    start_point = '1.0e-6 0.030975 0'
    end_point = '0.003175 0.030975 0'
    num_points = 10
  []
  [gauge2_point09]
    type = LineValueSampler
    variable = 'strain_yy'
    sort_by = x
    start_point = '1.0e-6 0.028435 0'
    end_point = '0.003175 0.028435 0'
    num_points = 10
    outputs = none
  []
  [gauge2_point08]
    type = LineValueSampler
    variable = 'strain_yy'
    sort_by = x
    start_point = '1.0e-6 0.025895 0'
    end_point = '0.003175 0.025895 0'
    num_points = 10
  []
  [gauge2_point07]
    type = LineValueSampler
    variable = 'strain_yy'
    sort_by = x
    start_point = '1.0e-6 0.023355 0'
    end_point = '0.003175 0.023355 0'
    num_points = 10
  []
  [gauge2_point06]
    type = LineValueSampler
    variable = 'strain_yy'
    sort_by = x
    start_point = '1.0e-6 0.020815 0'
    end_point = '0.003175 0.020815 0'
    num_points = 10
  []
  [gauge2_point05_mid]
    type = LineValueSampler
    variable = 'strain_yy'
    sort_by = x
    start_point = '1.0e-6 0.018275 0'
    end_point = '0.003175 0.018275 0'
    num_points = 10
  []
  [gauge2_point04]
    type = LineValueSampler
    variable = 'strain_yy'
    sort_by = x
    start_point = '1.0e-6 0.015735 0'
    end_point = '0.003175 0.015735 0'
    num_points = 10
  []
  [gauge2_point03]
    type = LineValueSampler
    variable = 'strain_yy'
    sort_by = x
    start_point = '1.0e-6 0.013195 0'
    end_point = '0.003175 0.013195 0'
    num_points = 10
  []
  [gauge2_point02]
    type = LineValueSampler
    variable = 'strain_yy'
    sort_by = x
    start_point = '1.0e-6 0.010655 0'
    end_point = '0.003175 0.010655 0'
    num_points = 10
  []
  [gauge2_point01]
    type = LineValueSampler
    variable = 'strain_yy'
    sort_by = x
    start_point = '1.0e-6 0.008115 0'
    end_point = '0.003175 0.008115 0'
    num_points = 10
  []
  [gauge2_point00]
    type = LineValueSampler
    variable = 'strain_yy'
    sort_by = x
    start_point = '1.0e-6 0.005575 0'
    end_point = '0.003175 0.005575 0'
    num_points = 10
  []

  [bottom_base_start_curve]
    type = LineValueSampler
    variable = 'strain_yy'
    sort_by = x
    start_point = '1.0e-6 0.00432665 0'
    end_point = '0.00334114 0.00432665 0'
    num_points = 10
  []

  [vertical_axial_strain]
    type = LineValueSampler
    variable = strain_yy
    sort_by = y
    start_point = '0.00171884 0.059013 0'
    end_point = '0.00190922 0.004384 0'
    num_points = 250
    outputs = vertical_line_sampler
  []
[]

[Outputs]
  perf_graph = true
  exodus = true
  color = true
  csv = true
  [vertical_line_sampler]
    type = CSV
    sync_times = '18000 72000 144000 216000 288000 360000 421000 432000'
  []
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

[Problem]
  register_objects_from = 'BlackBearApp'
  library_path = '/Users/pittsa/projects/blackbear/lib'
  library_name = 'libblackbear-opt.la'
[]
