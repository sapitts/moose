# This test is for two layer materials with different youngs modulus
# The global stress is determined by switching the stress based on level set values
# The material interface is marked by a level set function
# The two layer materials are glued together

[GlobalParams]
  order = FIRST
  family = LAGRANGE
  displacements = 'disp_x disp_y'
  volumetric_locking_correction = true
[]

[Problem]
  coord_type = RZ
  type = ReferenceResidualProblem
  extra_tag_vectors = 'refs'
  reference_vector = 'refs'
  group_variables = 'disp_x disp_y'
[]

[Mesh]
  [./generated_mesh]
    type = GeneratedMeshGenerator
    dim = 2
    nx = 1000
    ny = 50
    xmin = 0.02
    xmax = 0.022
    ymin = 0.0
    ymax = 0.0001
    elem_type = QUAD4
    # bias_x = 0.001
  [../]
  [./left_bottom]
    type = ExtraNodesetGenerator
    new_boundary = 'left_bottom'
    coord = '0.02 0.0'
    input = generated_mesh
  [../]
  [./left_top]
    type = ExtraNodesetGenerator
    new_boundary = 'left_top'
    coord = '0.02 0.0001'
    input = left_bottom
  [../]
[]

[Variables]
  [./disp_x]
  [../]
  [./disp_y]
  [../]
[]

[Functions]
  [./estimated_oxide_growth]
    type = ParsedFunction
    value = '0.288997e-2*sqrt(t*5.2775e-12)'
  [../]
  [./ls_func]
    type = ParsedFunction
    value = 'if(x<(0.288997e-2*sqrt(t*5.2775e-12)+0.02),1,-1)'
  [../]
[]

[AuxVariables]
  [./ls]
    order = FIRST
    family = LAGRANGE
  [../]
  [./temperature]
    initial_condition = 801.0
  [../]
  [./stress_xx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_yy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./stress_xy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./metal_stress_xx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./metal_stress_yy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./metal_stress_xy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./metal_strain_xx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./metal_strain_yy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./metal_strain_xy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./metal_mechanical_strain_xx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./metal_mechanical_strain_yy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./metal_mechanical_strain_xy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./oxide_stress_xx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./oxide_stress_yy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./oxide_stress_xy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./oxide_strain_xx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./oxide_strain_yy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./oxide_strain_xy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./oxide_mechanical_strain_xx]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./oxide_mechanical_strain_yy]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./oxide_mechanical_strain_xy]
    order = CONSTANT
    family = MONOMIAL
  [../]
[]

[Kernels]
  [./stress_x]
    type = ADStressDivergenceRZTensors
    component = 0
    variable = disp_x
    use_displaced_mesh = true
    extra_vector_tags = 'refs'
    # base_name = metal
  [../]
  [./stress_y]
    type = ADStressDivergenceRZTensors
    component = 1
    variable = disp_y
    use_displaced_mesh = true
    extra_vector_tags = 'refs'
    # base_name = metal
  [../]
[]

[AuxKernels]
  [./ls_function]
    type = FunctionAux
    variable = ls
    function = ls_func
  [../]
  [./temperature]
    type = ConstantAux
    variable = temperature
    value = 801.0
    execute_on = 'initial timestep_end'
  [../]
  [./stress_xx]
    type = RankTwoAux
    rank_two_tensor = stress
    index_i = 0
    index_j = 0
    variable = stress_xx
  [../]
  [./stress_yy]
    type = RankTwoAux
    rank_two_tensor = stress
    index_i = 1
    index_j = 1
    variable = stress_yy
  [../]
  [./stress_xy]
    type = RankTwoAux
    rank_two_tensor = stress
    index_i = 0
    index_j = 1
    variable = stress_xy
  [../]
  [./metal_stress_xx]
    type = RankTwoAux
    rank_two_tensor = metal_stress
    index_i = 0
    index_j = 0
    variable = metal_stress_xx
  [../]
  [./metal_stress_yy]
    type = RankTwoAux
    rank_two_tensor = metal_stress
    index_i = 1
    index_j = 1
    variable = metal_stress_yy
  [../]
  [./metal_stress_xy]
    type = RankTwoAux
    rank_two_tensor = metal_stress
    index_i = 0
    index_j = 1
    variable = metal_stress_xy
  [../]
  [./metal_strain_xx]
    type = RankTwoAux
    rank_two_tensor = metal_total_strain
    index_i = 0
    index_j = 0
    variable = metal_strain_xx
  [../]
  [./metal_strain_yy]
    type = RankTwoAux
    rank_two_tensor = metal_total_strain
    index_i = 1
    index_j = 1
    variable = metal_strain_yy
  [../]
  [./metal_strain_xy]
    type = RankTwoAux
    rank_two_tensor = metal_total_strain
    index_i = 0
    index_j = 1
    variable = metal_strain_xy
  [../]
  [./metal_mechanical_strain_xx]
    type = RankTwoAux
    rank_two_tensor = metal_mechanical_strain
    index_i = 0
    index_j = 0
    variable = metal_mechanical_strain_xx
  [../]
  [./metal_mechanical_strain_yy]
    type = RankTwoAux
    rank_two_tensor = metal_mechanical_strain
    index_i = 1
    index_j = 1
    variable = metal_mechanical_strain_yy
  [../]
  [./metal_mechanical_strain_xy]
    type = RankTwoAux
    rank_two_tensor = metal_mechanical_strain
    index_i = 0
    index_j = 1
    variable = metal_mechanical_strain_xy
  [../]
  [./oxide_stress_xx]
    type = RankTwoAux
    rank_two_tensor = oxide_stress
    index_i = 0
    index_j = 0
    variable = oxide_stress_xx
  [../]
  [./oxide_stress_yy]
    type = RankTwoAux
    rank_two_tensor = oxide_stress
    index_i = 1
    index_j = 1
    variable = oxide_stress_yy
  [../]
  [./oxide_stress_xy]
    type = RankTwoAux
    rank_two_tensor = oxide_stress
    index_i = 0
    index_j = 1
    variable = oxide_stress_xy
  [../]
  [./oxide_strain_xx]
    type = RankTwoAux
    rank_two_tensor = oxide_total_strain
    index_i = 0
    index_j = 0
    variable = oxide_strain_xx
  [../]
  [./oxide_strain_yy]
    type = RankTwoAux
    rank_two_tensor = oxide_total_strain
    index_i = 1
    index_j = 1
    variable = oxide_strain_yy
  [../]
  [./oxide_strain_xy]
    type = RankTwoAux
    rank_two_tensor = oxide_total_strain
    index_i = 0
    index_j = 1
    variable = oxide_strain_xy
  [../]
  [./oxide_mechanical_strain_xx]
    type = RankTwoAux
    rank_two_tensor = oxide_mechanical_strain
    index_i = 0
    index_j = 0
    variable = oxide_mechanical_strain_xx
  [../]
  [./oxide_mechanical_strain_yy]
    type = RankTwoAux
    rank_two_tensor = oxide_mechanical_strain
    index_i = 1
    index_j = 1
    variable = oxide_mechanical_strain_yy
  [../]
  [./oxide_mechanical_strain_xy]
    type = RankTwoAux
    rank_two_tensor = oxide_mechanical_strain
    index_i = 0
    index_j = 1
    variable = oxide_mechanical_strain_xy
  [../]
[]

[Constraints]
  [./dispx_constraint]
    type = XFEMSingleVariableConstraint
    use_displaced_mesh = false
    variable = disp_x
    use_penalty = false
    alpha = 1e14#12 #8
    geometric_cut_userobject = 'level_set_cut_uo'
  [../]
  [./dispy_constraint]
    type = XFEMSingleVariableConstraint
    use_displaced_mesh = false
    variable = disp_y
    alpha = 1e14 # 12 #8
    geometric_cut_userobject = 'level_set_cut_uo'
  [../]
  # [./bottom_section_plane]
  #   type = EqualValueBoundaryConstraint
  #   variable = disp_y
  #   master = 184  # node on boundary
  #   slave = top     # boundary
  #   penalty = 1.e+15
  # [../]
  # [./top]
  #   type = EqualValueBoundaryConstraint
  #   variable = disp_y
  #   slave = 'top' #sideset on top boundary
  #   penalty = 1e+14
  #   formulation = kinematic
  # [../]
[]

[BCs]
  [./roller_y]
    type = ADPresetBC
    boundary = 'bottom top'
    variable = disp_y
    value = 0.0
  [../]
  # [./topy]
  #   type = FunctionPresetBC
  #   boundary = top
  #   variable = disp_y
  #   function = '0.03*t'
  # [../]
  # [./roller_x]
  #   type = PresetBC
  #   boundary = left
  #   variable = disp_x
  #   value = 0.0
  # [../]
  [./inner_pressure]
    type = ADPressure
    variable = disp_x
    function = '1.0e6'
    component = 0
    boundary = 'left'
  [../]
  # [./Pressure]
  #   [./outer_pressure] #  apply Ar pressure on clad outer wall
  #     boundary = right
  #     function = '0.0'
  #   [../]
  #   [./inner_pressure] #  apply He pressure on clad inner wall
  #     boundary = 'left'
  #     function = '1.0e3*t'
  #   [../]
  # [../]
[]

[Materials]
  [./elasticity_tensor_metal]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 1.93e11 ## 193 GPa
    poissons_ratio = 0.3
    base_name = metal
  [../]
  [./strain_metal]
    type = ADComputeAxisymmetricRZFiniteStrain
    base_name = metal
    eigenstrain_names = 'no_eigenstrain'
  [../]
  [./stress_metal]
    # type = ADComputeMultipleInelasticStress
    type = ADComputeFiniteStrainElasticStress
    base_name = metal
    # inelastic_models = inelastic_stress_metal
  [../]
  # [./inelastic_stress_metal]
  #   type = SS316HLAROMANCEStressUpdateTest
  #   base_name = metal
  #   temperature = temperature
  # [../]
  [./eigenstrain_metal]
    type = ADComputeThermalExpansionEigenstrain
    stress_free_temperature = 800.0
    temperature = temperature
    thermal_expansion_coeff = 0.0 ## faking it out so that I can see the switch in the eigenstrains
    base_name = metal
    eigenstrain_name = 'no_eigenstrain'
  [../]
  [./elasticity_tensor_oxide]
    type = ComputeIsotropicElasticityTensor
    base_name = oxide
    youngs_modulus = 2.72e11 ##272 GPa P. Tortorelli. Mechanical properties of chromia scales. Journal de Physique IV Colloque, 1993
    poissons_ratio = 0.3
  [../]
  [./strain_oxide]
    type = ADComputeAxisymmetricRZFiniteStrain
    base_name = oxide
    eigenstrain_names = 'oxidation_eigenstrain'
  [../]
  [./stress_oxide]
    # type = ADComputeMultipleInelasticStress
    type = ADComputeFiniteStrainElasticStress
    base_name = oxide
    # inelastic_models = inelastic_stress_oxide
  [../]
  # [./inelastic_stress_oxide]
  #   type = SS316HLAROMANCEStressUpdateTest
  #   base_name = oxide
  #   temperature = temperature
  # [../]
  [./eigenstrain_oxide]
    type = ADComputeOxidationEigenstrain
    pillings_bedworth_ratio = 2.01 ## from pure Cr
    oxide_thickness_growth_rate = estimated_oxide_growth
    base_name = oxide
    eigenstrain_name = 'oxidation_eigenstrain'
  [../]
  [./combined_stress]
    type = ADLevelSetBiMaterialRankTwo
    levelset_positive_base = 'oxide'
    levelset_negative_base = 'metal'
    level_set_var = ls
    prop_name = stress
  [../]
[]

[XFEM]
  qrule = volfrac
  output_cut_plane = true
[]

[UserObjects]
  [./level_set_cut_uo]
    type = LevelSetCutUserObject
    level_set_var = ls
    heal_always = true
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
  dt = 1200.0
  dtmin = 1.0e-4
  dtmax = 10000.0
  end_time = 604800.0

  # [./TimeStepper]
  #   type = IterationAdaptiveDT
  #   dt = 50
  #   optimal_iterations = 12
  #   iteration_window = 2
  #   linear_iteration_ratio = 100
  # [../]

  update_xfem_at_timestep_begin = true
  max_xfem_update = 0
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
