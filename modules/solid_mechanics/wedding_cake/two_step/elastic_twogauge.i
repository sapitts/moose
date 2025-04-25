[GlobalParams]
  volumetric_locking_correction = false
  displacements = 'disp_x disp_y'
[]

# [Problem]
#   type = ReferenceResidualProblem
#   extra_tag_vectors = 'ref'
#   reference_vector = 'ref'
# []

[Mesh]
  coord_type = RZ
  [file]
    type = FileMeshGenerator
    file = twostep_gauge1in_2d.e
  []
  # [rectangle]
  #   type = GeneratedMeshGenerator
  #   dim = 2
  #   nx = 10
  #   ny = 50
  #   ymax = 5
  # []
[]

# [Variables]
# []

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
  # [effective_creep_strain]
  #   order = CONSTANT
  #   family = MONOMIAL
  # []
  # [damage_index]
  #   order = CONSTANT
  #   family = MONOMIAL
  # []
  # [omega]
  #   order = CONSTANT
  #   family = MONOMIAL
  # []
[]

[Modules/TensorMechanics/Master]
  [block]
    add_variables = true
    # decomposition_method = EigenSolution
    strain = FINITE
    incremental = true
    eigenstrain_names = 'thermal_eigenstrain'
    generate_output = 'vonmises_stress stress_xx stress_yy stress_zz hydrostatic_stress triaxiality_stress' # creep_strain_xx creep_strain_yy'
    use_automatic_differentiation = true
    # extra_vector_tags = 'ref'
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
  # [effective_creep_strain]
  #   type = ADMaterialRealAux
  #   property = effective_creep_strain
  #   variable = effective_creep_strain
  #   execute_on = timestep_end
  # []
  # [damage_index]
  #   type = ADMaterialRealAux
  #   variable = damage_index
  #   property = damage_index
  #   execute_on = timestep_end
  # []
  # [omega]
  #   type = ADMaterialRealAux
  #   variable = omega
  #   property = omega
  #   execute_on = timestep_end
  # []
[]

[BCs]
  [fixed_bottom]
    type = ADDirichletBC
    variable = disp_y
    value = 0
    boundary = 'lower_grip_bottom'
  []
  [no_x]
    type = ADDirichletBC
    variable = disp_x
    boundary = centerline
    value = 0.0
  []
  [upper_loading]
    type = ADFunctionNeumannBC
    use_displaced_mesh = true
    variable = disp_y
    boundary = 'upper_grip_top'
    function = 'if(t<100.0, 0.2539e6*t , 25.39e6)'
  []
[]

[Materials]
  [elasticity]
    type = ADSS316ElasticityTensor
    temperature = temperature
  []
  [elastic_stress]
    type = ADComputeFiniteStrainElasticStress
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
  [thermal_eigenstrain]
    type = ADSS316ThermalExpansionEigenstrain
    eigenstrain_name = thermal_eigenstrain
    stress_free_temperature = 273.15
    temperature = temperature
  []
  # [damage]
  #   type = ADSteelCreepDamageOh
  #   epsilon_f = 1.6
  #   creep_strain_names = creep_strain
  #   reduction_factor = 1.0e3
  #   use_old_damage = true
  #   creep_law_exponent = 8.75
  # []
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

  petsc_options_iname = '-ksp_type  -pc_type  -pc_factor_mat_solver_package'
  petsc_options_value = ' preonly    lu        superlu_dist'
  petsc_options = '-snes_converged_reason'
  line_search = 'none'
  l_max_its = 50
  # l_tol = 8e-3
  nl_max_its = 50
  nl_rel_tol = 1e-8
  nl_abs_tol = 1e-20
  start_time = 0
  end_time = 432000.0 ## 120 hours
  dt = 50.0
  dtmin = 1e-2
  # automatic_scaling = true
  # compute_scaling_once = false
  nl_forced_its = 2
  num_steps = 2
[]

[Postprocessors]
  [average_stress]
    type = ADElementAverageMaterialProperty
    mat_prop = stress_yy
  []
  # [creep_strain]
  #   type = ADElementAverageMaterialProperty
  #   mat_prop = effective_creep_strain
  # []
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
    variable = radial_strain
  []
  [axial_strain]
    type = ElementAverageValue
    variable = axial_strain
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
