## Ideal geometry, BCs, elastic only 2D weak plane simulation

## parameters to vary with STM
upper_left_undercut = 0.030
upper_right_undercut = 0.05
lower_left_undercut = 0.025
lower_right_undercut = 0.036
gauge_width = 1.2
gauge_height = 5.7
# min 5.446, max 5.954

shoulder_radius = 1.4
num_x_nodes = 18
num_y_nodes = 18
tab_height = 5.15 # 3.75 +1.4 from tab top to gauge height
shoulder_tab_curvature = 0.3

## bc conditions: assumed to be symmetric

### conversion constants for the tabs
# lower_tab_y = '${fparse -gauge_height / 2.0 - tab_height}'
upper_tab_y = '${fparse gauge_height / 2.0 + tab_height}'

## conversion constants for the gauge section
left_gauge_x = '${fparse -gauge_width / 2.0}'
right_gauge_x = '${fparse gauge_width / 2.0}'
lower_gauge_y = '${fparse -gauge_height / 2.0}'
upper_gauge_y = '${fparse gauge_height / 2.0}'

#####################
#### conversion constants for shoulders:
base_distance = '${fparse (2.0 - sqrt(2.0)) * shoulder_radius / 2.0}'

## undercut adjustments
offset_ul = '${fparse upper_left_undercut - base_distance}'
offset_ur = '${fparse upper_right_undercut - base_distance}'
offset_ll = '${fparse lower_left_undercut - base_distance}'
offset_lr = '${fparse lower_right_undercut - base_distance}'

#####################
# conversion constants for the shoulders
ur_radius_corner_x = '${fparse 0.5 * gauge_width + shoulder_radius}'
ur_radius_corner_y = '${fparse 0.5 * gauge_height + shoulder_radius}'
ul_radius_corner_x = '${fparse -0.5 * gauge_width - shoulder_radius}'
ul_radius_corner_y = '${fparse 0.5 * gauge_height + shoulder_radius}'

####################
# ## conversion constants for the lower shoulders
# lr_radius_corner_x = '${fparse gauge_width / 2.0 + shoulder_radius}'
# lr_radius_corner_y = '${fparse -gauge_height /2.0 - shoulder_radius}'
# ll_radius_corner_x = '${fparse -gauge_width / 2.0 - shoulder_radius}'
# ll_radius_corner_y = '${fparse -gauge_height / 2.0 - shoulder_radius}'


[Mesh]
  ######################################
  #### bottom shoulders and tab section
  ######################################
  [bottom_shoulder]
    type = TransfiniteMeshGenerator
    corners = '${left_gauge_x} ${upper_gauge_y} 0.0
               ${right_gauge_x} ${upper_gauge_y} 0.0
               ${ur_radius_corner_x} ${ur_radius_corner_y} 0.0
               ${ul_radius_corner_x} ${ul_radius_corner_y} 0.0'
    nx = ${num_x_nodes}
    ny = ${num_y_nodes}
    bottom_type = LINE
    right_type = CIRCARC
    top_type = CIRCARC
    left_type = CIRCARC
    top_parameter = '${shoulder_tab_curvature}'
    right_parameter = '${offset_ll}'
    left_parameter = '${offset_lr}'
  []

  [bottom_tab]
    type = TransfiniteMeshGenerator
    corners = '${ul_radius_corner_x} ${ul_radius_corner_y} 0.0
               ${ur_radius_corner_x} ${ur_radius_corner_y} 0.0
               ${ur_radius_corner_x} ${upper_tab_y} 0.0
               ${ul_radius_corner_x} ${upper_tab_y} 0.0'
    nx = ${num_x_nodes}
    ny = ${num_y_nodes}
    bottom_type = CIRCARC
    left_type = LINE
    top_type = LINE
    right_type = LINE
    bottom_parameter = '${fparse -shoulder_tab_curvature}'
  []
  [stitch_bottom_tab]
    type = StitchedMeshGenerator
    inputs = 'bottom_shoulder bottom_tab'
    stitch_boundaries_pairs = 'top bottom'
  []
  [gauge]
    type = TransfiniteMeshGenerator
    corners = '${left_gauge_x} ${lower_gauge_y} 0.0
               ${right_gauge_x} ${lower_gauge_y} 0.0
               ${right_gauge_x} ${upper_gauge_y} 0.0
               ${left_gauge_x} ${upper_gauge_y} 0.0'
    nx = ${num_x_nodes}
    ny = 40
    bottom_type = LINE
    left_type = LINE
    top_type = LINE
    right_type = LINE
  []
  [stitch_bottom_gauge]
    type = StitchedMeshGenerator
    inputs = 'stitch_bottom_tab gauge'
    stitch_boundaries_pairs = 'bottom top'
  []
  [rotate_shoulder]
    type = TransformGenerator
    input = 'stitch_bottom_gauge'
    transform = ROTATE
    vector_value = '-180 0 0'
  []


  ######################################
  #### top shoulders and tab section
  ######################################
  [top_shoulder]
    type = TransfiniteMeshGenerator
    corners = '${left_gauge_x} ${upper_gauge_y} 0.0
               ${right_gauge_x} ${upper_gauge_y} 0.0
               ${ur_radius_corner_x} ${ur_radius_corner_y} 0.0
               ${ul_radius_corner_x} ${ul_radius_corner_y} 0.0'
    nx = ${num_x_nodes}
    ny = ${num_y_nodes}
    bottom_type = LINE
    left_type = CIRCARC
    top_type = CIRCARC
    right_type = CIRCARC
    left_parameter = '${offset_ul}'
    top_parameter = '${shoulder_tab_curvature}'
    right_parameter = '${offset_ur}'
  []
  [top_tab]
    type = TransfiniteMeshGenerator
    corners = '${ul_radius_corner_x} ${ul_radius_corner_y} 0.0
               ${ur_radius_corner_x} ${ur_radius_corner_y} 0.0
               ${ur_radius_corner_x} ${upper_tab_y} 0.0
               ${ul_radius_corner_x} ${upper_tab_y} 0.0'
    nx = ${num_x_nodes}
    ny = ${num_y_nodes}
    bottom_type = CIRCARC
    left_type = LINE
    top_type = LINE
    right_type = LINE
    bottom_parameter = '${fparse -shoulder_tab_curvature}'
  []
  [stitch_top_tab]
    type = StitchedMeshGenerator
    inputs = 'top_shoulder top_tab'
    stitch_boundaries_pairs = 'top bottom'
  []
  [stitch_top_gauge]
    type = StitchedMeshGenerator
    inputs = 'stitch_top_tab rotate_shoulder'
    stitch_boundaries_pairs = 'bottom bottom'
  []
  [smoothed_final]
    type = SmoothMeshGenerator
    input = stitch_top_gauge
    # input = upright_shoulder_sideset
    iterations = 15
  []

  ############################################
  ### add BC sidesets, mesh clean up
  ############################################
  [downleft_shoulder_sideset]
    type = SideSetsAroundSubdomainGenerator
    input = smoothed_final
    block = '0'
    new_boundary = 'downleft_shoulder_sideset'
    normal = '-0.5 0.866 0'
    normal_tol = 0.11
  []
  [downright_shoulder_sideset]
    type = SideSetsAroundSubdomainGenerator
    input = downleft_shoulder_sideset
    block = '0'
    new_boundary = 'downright_shoulder_sideset'
    normal = '0.5 0.866 0'
    normal_tol = 0.11
  []
  [upleft_shoulder_sideset]
    type = SideSetsAroundSubdomainGenerator
    input = downright_shoulder_sideset
    # input = smoothed_final
    block = '0'
    new_boundary = 'upleft_shoulder_sideset'
    normal = '-0.5 -0.866 0'
    normal_tol = 0.11
  []
  [upright_shoulder_sideset]
    type = SideSetsAroundSubdomainGenerator
    input = upleft_shoulder_sideset
    block = '0'
    new_boundary = 'upright_shoulder_sideset'
    normal = '0.5 -0.866 0'
    normal_tol = 0.11
  []

  use_displaced_mesh = false
[]

[GlobalParams]
  displacements = 'disp_x disp_y'
  large_kinematics = true
  stabilize_strain = true
[]

[AuxVariables]
  [upper_left_undercut]
    initial_condition = ${upper_left_undercut}
  []
  [upper_right_undercut]
    initial_condition = ${upper_right_undercut}
  []
  [lower_left_undercut]
    initial_condition = ${lower_left_undercut}
  []
  [lower_right_undercut]
    initial_condition = ${lower_right_undercut}
  []
  [gauge_width]
    initial_condition = ${gauge_width}
  []
  [gauge_height]
    initial_condition = ${gauge_height}
  []
  [nl_strain_zz]
    order = CONSTANT
    family = MONOMIAL
  []
  [strain_xx]
    order = FIRST
    family = MONOMIAL
  []
  [strain_xy]
    order = FIRST
    family = MONOMIAL
  []
  [strain_yy]
    order = FIRST
    family = MONOMIAL
  []
  [stress_xx]
    order = FIRST
    family = MONOMIAL
  []
  [stress_xy]
    order = FIRST
    family = MONOMIAL
  []
  [stress_yy]
    order = FIRST
    family = MONOMIAL
  []
  [stress_zz]
    order = FIRST
    family = MONOMIAL
  []
  [vonmises_stress]
    order = FIRST
    family = MONOMIAL
  []
[]

[Variables]
  [disp_x]
  []
  [disp_y]
  []
  [strain_zz]
  []
[]

[BCs]
  [zero_displacements]
    type = DirichletBC
    variable = 'disp_y'
    boundary = 'downleft_shoulder_sideset downright_shoulder_sideset'
    value = 0.0
  []
  [tensile_displacement]
    type = FunctionDirichletBC
    variable = 'disp_y'
    boundary = 'upleft_shoulder_sideset upright_shoulder_sideset'
    function = '${fparse gauge_height * 5.0e-4} * t' #5.0e-4 mm/mm-s * 5.7 mm <- the strain rate used for TCR SSRT testing and this gauge length
  []
[]

[AuxKernels]
  [strain_xx]
    type = RankTwoAux
    rank_two_tensor = mechanical_strain
    variable = strain_xx
    index_i = 0
    index_j = 0
    execute_on = timestep_end
  []
  [strain_xy]
    type = RankTwoAux
    rank_two_tensor = mechanical_strain
    variable = strain_xy
    index_i = 0
    index_j = 1
    execute_on = timestep_end
  []
  [strain_yy]
    type = RankTwoAux
    rank_two_tensor = mechanical_strain
    variable = strain_yy
    index_i = 1
    index_j = 1
    execute_on = timestep_end
  []
  [strain_zz]
    type = RankTwoAux
    rank_two_tensor = mechanical_strain
    variable = nl_strain_zz
    index_i = 2
    index_j = 2
  []

  [stress_xx]
    type = RankTwoAux
    rank_two_tensor = cauchy_stress
    variable = stress_xx
    index_i = 0
    index_j = 0
    execute_on = timestep_end
  []
  [stress_xy]
    type = RankTwoAux
    rank_two_tensor = cauchy_stress
    variable = stress_xy
    index_i = 0
    index_j = 1
    execute_on = timestep_end
  []
  [stress_yy]
    type = RankTwoAux
    rank_two_tensor = cauchy_stress
    variable = stress_yy
    index_i = 1
    index_j = 1
    execute_on = timestep_end
  []
  [stress_zz]
    type = RankTwoAux
    rank_two_tensor = cauchy_stress
    variable = stress_zz
    index_i = 2
    index_j = 2
    execute_on = timestep_end
  []
  [vonmises_stress]
    type = RankTwoScalarAux
    rank_two_tensor = cauchy_stress
    variable = vonmises_stress
    scalar_type = VonMisesStress
    execute_on = timestep_end
  []
[]

[Kernels]
  [stress_divergence_x]
    type = TotalLagrangianStressDivergence
    variable = disp_x
    out_of_plane_strain = strain_zz
    component = 0
  []
  [stress_divergence_y]
    type = TotalLagrangianStressDivergence
    variable = disp_y
    out_of_plane_strain = strain_zz
    component = 1
  []
  [weak_plane_stress]
    type = TotalLagrangianWeakPlaneStress
    variable = strain_zz
  []
[]

[Materials]
  [elasticity_tensor]
    type = ComputeIsotropicElasticityTensor
    youngs_modulus = 9.24e4 #in MPa from BISON MATPRO relationships, assuming no cold work
    poissons_ratio = 0.363 # from BISON MATPRO relationships, assuming no cold work
  []
  [strain]
    type = ComputeLagrangianWPSStrain
    out_of_plane_strain = strain_zz
  []
  [compute_stress]
    type = ComputeLagrangianLinearElasticStress
  []
[]

[Preconditioning]
  [smp]
    type = SMP
    full = true
  []
[]

[Executioner]
  type = Transient
  solve_type = 'NEWTON'

  petsc_options_iname = '-pc_type -pc_factor_mat_solver_package' # -pc_factor_shift_type -pc_factor_shift_amount'
  petsc_options_value = ' lu       superlu_dist                ' #   NONZERO 1e-15'
  line_search = 'none'

  [TimeStepper]
    type = IterationAdaptiveDT
    dt = 5.0
    optimal_iterations = 3
    iteration_window = 2
  []
  # dt = 0.1
  dtmin = 1e-8
  end_time = 300 # to get to 15% strain in the gauge length
  nl_max_its = 30
  nl_rel_tol = 1e-8
  nl_abs_tol = 1e-10
[]


[Outputs]
  csv = true
  [exodus]
    type = Exodus
    execute_on = FAILED
  []
  color = false
  perf_graph = true
[]

[Postprocessors]
  [from_parent_upper_left_undercut]
    type = AverageNodalVariableValue
    variable = upper_left_undercut
    execute_on = INITIAL
  []
  [from_parent_upper_right_undercut]
    type = AverageNodalVariableValue
    variable = upper_right_undercut
    execute_on = INITIAL
  []
  [from_parent_lower_left_undercut]
    type = AverageNodalVariableValue
    variable = lower_left_undercut
    execute_on = INITIAL
  []
  [from_parent_lower_right_undercut]
    type = AverageNodalVariableValue
    variable = lower_right_undercut
    execute_on = INITIAL
  []
  [from_parent_gauge_width]
    type = AverageNodalVariableValue
    variable = gauge_width
    execute_on = INITIAL
  []
  [from_parent_gauge_height]
    type = AverageNodalVariableValue
    variable = gauge_height
    execute_on = INITIAL
  []

  [p1_vonmises_stress]
    type = PointValue
    variable = vonmises_stress
    point = '0 ${fparse 0.5 * gauge_height + 1.4} 0'
  []
  [p2_vonmises_stress]
    type = PointValue
    variable = vonmises_stress
    point = '0 ${fparse 0.5 * gauge_height} 0'
  []
  [p3_vonmises_stress]
    type = PointValue
    variable = vonmises_stress
    point = '0 ${fparse 0.25 * gauge_height} 0'
  []
  [p4_vonmises_stress]
    type = PointValue
    variable = vonmises_stress
    point = '${fparse -0.5*gauge_width} 0 0'
  []
  [p5_vonmises_stress]
    type = PointValue
    variable = vonmises_stress
    point = '0 0 0'
  []
  [p6_vonmises_stress]
    type = PointValue
    variable = vonmises_stress
    point = '${fparse 0.5 * gauge_width} 0 0'
  []
  [p7_vonmises_stress]
    type = PointValue
    variable = vonmises_stress
    point = '0 ${fparse -0.25 * gauge_height} 0'
  []
  [p8_vonmises_stress]
    type = PointValue
    variable = vonmises_stress
    point = '0 ${fparse -0.5 * gauge_height} 0'
  []
  [p9_vonmises_stress]
    type = PointValue
    variable = vonmises_stress
    point = '0 ${fparse -0.5 * gauge_height - 1.4} 0'
  []

  [p1_stress_xx]
    type = PointValue
    variable = stress_xx
    point = '0 ${fparse 0.5 * gauge_height + 1.4} 0'
  []
  [p2_stress_xx]
    type = PointValue
    variable = stress_xx
    point = '0 ${fparse 0.5 * gauge_height} 0'
  []
  [p3_stress_xx]
    type = PointValue
    variable = stress_xx
    point = '0 ${fparse 0.25 * gauge_height} 0'
  []
  [p4_stress_xx]
    type = PointValue
    variable = stress_xx
    point = '${fparse -0.5*gauge_width} 0 0'
  []
  [p5_stress_xx]
    type = PointValue
    variable = stress_xx
    point = '0 0 0'
  []
  [p6_stress_xx]
    type = PointValue
    variable = stress_xx
    point = '${fparse 0.5 * gauge_width} 0 0'
  []
  [p7_stress_xx]
    type = PointValue
    variable = stress_xx
    point = '0 ${fparse -0.25 * gauge_height} 0'
  []
  [p8_stress_xx]
    type = PointValue
    variable = stress_xx
    point = '0 ${fparse -0.5 * gauge_height} 0'
  []
  [p9_stress_xx]
    type = PointValue
    variable = stress_xx
    point = '0 ${fparse -0.5 * gauge_height - 1.4} 0'
  []

  [p1_stress_yy]
    type = PointValue
    variable = stress_yy
    point = '0 ${fparse 0.5 * gauge_height + 1.4} 0'
  []
  [p2_stress_yy]
    type = PointValue
    variable = stress_yy
    point = '0 ${fparse 0.5 * gauge_height} 0'
  []
  [p3_stress_yy]
    type = PointValue
    variable = stress_yy
    point = '0 ${fparse 0.25 * gauge_height} 0'
  []
  [p4_stress_yy]
    type = PointValue
    variable = stress_yy
    point = '${fparse -0.5*gauge_width} 0 0'
  []
  [p5_stress_yy]
    type = PointValue
    variable = stress_yy
    point = '0 0 0'
  []
  [p6_stress_yy]
    type = PointValue
    variable = stress_yy
    point = '${fparse 0.5*gauge_width} 0 0'
  []
  [p7_stress_yy]
    type = PointValue
    variable = stress_yy
    point = '0 ${fparse -0.25 * gauge_height} 0'
  []
  [p8_stress_yy]
    type = PointValue
    variable = stress_yy
    point = '0 ${fparse -0.5 * gauge_height} 0'
  []
  [p9_stress_yy]
    type = PointValue
    variable = stress_yy
    point = '0 ${fparse -0.5 * gauge_height - 1.4} 0'
  []

  [max_vonmises_stress]
    type = ElementExtremeValue
    variable = vonmises_stress
    value_type = max
  []
  [max_stress_xx]
    type = ElementExtremeValue
    variable = stress_xx
    value_type = max
  []
  [max_stress_yy]
    type = ElementExtremeValue
    variable = stress_yy
    value_type = max
  []

[]
