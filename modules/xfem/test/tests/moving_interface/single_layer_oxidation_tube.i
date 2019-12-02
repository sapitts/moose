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
  solution_variables = 'disp_x disp_y'
  group_variables = 'disp_x disp_y'
[]

[Mesh]
  [generated_mesh]
    type = GeneratedMeshGenerator
    dim = 2
    nx = 16
    ny = 80
    xmin = 0.02
    xmax = 0.022
    ymin = 0.0
    ymax = 0.05
    elem_type = QUAD4
  []
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
    value = '0.288997*sqrt(t*5.2775e-12)'
  [../]
[]

[AuxVariables]
  [./ls]
    order = FIRST
    family = LAGRANGE
  [../]
  [./temperature]
    initial_condition = 850.0
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
    base_name = oxide
    extra_vector_tags = 'refs'
  [../]
  [./stress_y]
    type = ADStressDivergenceRZTensors
    component = 1
    variable = disp_y
    use_displaced_mesh = true
    base_name = oxide
    extra_vector_tags = 'refs'
  [../]
[]

[AuxKernels]
  # [./ls_function]
  #   type = FunctionAux
  #   variable = ls
  #   function = ls_func
  # [../]
  [./temperature]
    type = ConstantAux
    variable = temperature
    value = 801.0
    execute_on = 'initial timestep_end'
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

# [Constraints]
#   [./dispx_constraint]
#     type = XFEMSingleVariableConstraint
#     use_displaced_mesh = false
#     variable = disp_x
#     alpha = 1e8
#     geometric_cut_userobject = 'level_set_cut_uo'
#   [../]
#   [./dispy_constraint]
#     type = XFEMSingleVariableConstraint
#     use_displaced_mesh = false
#     variable = disp_y
#     alpha = 1e8
#     geometric_cut_userobject = 'level_set_cut_uo'
#   [../]
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
# []

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
    function = '1.0e3*t'
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
[]

# [XFEM]
#   qrule = volfrac
#   output_cut_plane = true
# []
#
# [UserObjects]
#   [./level_set_cut_uo]
#     type = LevelSetCutUserObject
#     level_set_var = ls
#     heal_always = true
#   [../]
# []

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
  compute_scaling_once = true

# controls for linear iterations
  l_max_its = 20
  l_tol = 1e-3

# controls for nonlinear iterations
  nl_max_its = 100
  nl_rel_tol = 1e-8
  nl_abs_tol = 1e-8

# time control
  start_time = 0.0
  dt = 1.0e-9
  dtmin = 1.0e-9
  dtmax = 1.0
  end_time = 1.0

  max_xfem_update = 1
[]

[Outputs]
  exodus = true
  # execute_on = timestep_end
  csv = true
  perf_graph = true
  [./console]
    type = Console
    output_linear = true
  [../]
[]
