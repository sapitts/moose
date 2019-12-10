[GlobalParams]
  displacements = 'disp_x disp_y'
  # volumetric_locking_correction = true
[]

[Problem]
  # coord_type = RZ
  # type = ReferenceResidualProblem
  # extra_tag_vectors = 'refs'
  # reference_vector = 'refs'
  # group_variables = 'disp_x disp_y'
[]

[Mesh]
  [./generated_mesh]
    type = GeneratedMeshGenerator
    dim = 2
    nx = 20
    ny = 80
    xmin = 0.0
    xmax = 1e-4 # 0.1mm thick
    ymin = -2e-4
    ymax =  2e-4 # 10mm long
    elem_type = QUAD4
  [../]
  [./fixed]
    type = BoundingBoxNodeSetGenerator
    new_boundary = 100
    bottom_left = '0 0 0'
    top_right = '0 0 0'
    input = generated_mesh
  [../]
  [./pivot]
    type = BoundingBoxNodeSetGenerator
    new_boundary = 101
    bottom_left = '1e-4 0 0'
    top_right = '1e-4 0 0'
    input = fixed
  [../]
  uniform_refine = 3
[]

[Adaptivity]
  # [./Indicators]
  #   [./grad_oxide]
  #     type = LaplacianJumpIndicator
  #     variable = oxide
  #   [../]
  # [../]
  # [./Markers]
  #   [./oxide_marker]
  #     type = ValueThresholdMarker
  #     variable = oxide
  #     refine = 0.3
  #     coarsen = 0.1
  #     invert = false
  #   [../]
  # [../]
  [./Markers]
    [./oxide_marker]
      type = ValueRangeMarker
      variable = oxide
      lower_bound = 0.1
      upper_bound = 0.9
    [../]
  [../]
  max_h_level = 3
  marker = oxide_marker
  initial_steps = 3
[]

[Functions]
  [./estimated_oxide_growth]
    type = ParsedFunction
    value = '0.288997e-2*sqrt(t*5.2775e-12)'
  [../]
  [./profile]
    type = ParsedFunction
    value = '(1.0-tanh(pi*1e6*(x-estimated_oxide_growth)))/2.0'
    vars = estimated_oxide_growth
    vals = estimated_oxide_growth
  [../]
[]

[Modules]
  [./TensorMechanics]
    [./Master]
      [./all]
        add_variables = true
        strain = SMALL
        use_automatic_differentiation = true
        generate_output = 'stress_xx stress_yy stress_xy stress_zz strain_xx strain_yy strain_yx strain_zz elastic_strain_xx elastic_strain_yy elastic_strain_xy elastic_strain_zz vonmises_stress'
        eigenstrain_names = 'eigenstrain'
      [../]
    [../]
  [../]
[]

[AuxVariables]
  [./oxide]
  [../]
[]

[AuxKernels]
  [./oxide]
    type = FunctionAux
    variable = oxide
    function = profile
  [../]
[]

[BCs]
  [./fixed_x]
    type = ADPresetBC
    boundary = 100
    variable = disp_x
    value = 0.0
  [../]
  [./fixed_y]
    type = ADPresetBC
    boundary = 100
    variable = disp_y
    value = 0.0
  [../]
  [./pivot]
    type = ADPresetBC
    boundary = 101
    variable = disp_y
    value = 0.0
  [../]
[]

[Materials]
  [./elasticity_tensor_metal]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 1.93e11 ## 193 GPa
    poissons_ratio = 0.3
    base_name = metal
  [../]
  [./oxide_switch]
    type = ParsedMaterial
    function = oxide
    args = oxide
    f_name = oxide_switch
  [../]
  [./elasticity_tensor_oxide]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 2.72e11 ##272 GPa P. Tortorelli. Mechanical properties of chromia scales. Journal de Physique IV Colloque, 1993
    poissons_ratio = 0.3
    base_name = oxide
  [../]
  [./stress_metal]
    type = ADComputeLinearElasticStress
  [../]
  [./eigenstrain_oxide]
    type = ComputeVariableEigenstrain
    args = oxide
    eigen_base = '0.0262 0.0262 0.0262 0 0 0' #10% eigenstrain approximation
    eigenstrain_name = 'eigenstrain'
    prefactor = oxide_switch
  [../]

  [./weight1]
    type = DerivativeParsedMaterial
    function = oxide
    f_name = weight1
    args = oxide
  [../]
  [./weight2]
    type = DerivativeParsedMaterial
    function = '1.0-oxide'
    f_name = weight2
    args = oxide
  [../]
  [./elasticity_tensor]
    type = CompositeElasticityTensor
    tensors = 'oxide metal'
    weights = 'weight1 weight2'
    args = oxide
  [../]
[]

[Preconditioning]
  [./smp]
    type = SMP
    full = true
  [../]
[]

[Executioner]
  type = Transient

  solve_type = 'NEWTON'#'PJFNK'
  petsc_options_iname = '-ksp_gmres_restart -pc_type -pc_hypre_type -pc_hypre_boomeramg_max_iter'
  petsc_options_value = '201                hypre    boomeramg      8'

  line_search = 'bt' #'none' #'bt'
  automatic_scaling = true
  compute_scaling_once = false

# controls for linear iterations
  l_max_its = 20
  l_tol = 1e-3

# controls for nonlinear iterations
  nl_max_its = 100
  nl_rel_tol = 1e-5
  nl_abs_tol = 1e-11

# time control
  start_time = 0.0
  dt = 86400.0
  dtmin = 1.0e-4
  # dtmax = 10000.0
  # num_steps = 20
  end_time = 5184000
[]

[Outputs]
  exodus = true
  execute_on = timestep_end
  csv = true
  perf_graph = true
  [./console]
    type = Console
    output_linear = true
  [../]
[]
