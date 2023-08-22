## Ideal geometry, BCs, elastic only 2D weak plane simulation

## parameters to vary with STM
upper_left_radius = 1.4
upper_right_radius = 1.4
lower_left_radius = 1.4
lower_right_radius = 1.4
gauge_width = 1.2
gauge_height = 5.7
# min 5.446, max 5.954

num_x_nodes = 16
num_y_nodes = 16
tab_height = 5.15 # 3.75 +1.4 from tab top to gauge height
shoulder_tab_curvature = 0.3

## bc conditions
rig_gap = 1.5
upper_rig_offset = 0.0 # -0.15 to 0.15
lower_rig_offset = 0.0 # -0.15 to 0.15

### conversion constants for the tabs
lower_tab_y = '${fparse -gauge_height / 2.0 - tab_height}'
upper_tab_y = '${fparse gauge_height / 2.0 + tab_height}'

## conversion constants for the gauge section
left_gauge_x = '${fparse -gauge_width / 2.0}'
right_gauge_x = '${fparse gauge_width / 2.0}'
lower_gauge_y = '${fparse -gauge_height / 2.0}'
upper_gauge_y = '${fparse gauge_height / 2.0}'

#####################
sqrt2 = '${fparse sqrt(2.0) / 2.0}'

# geometrical constants for the lower shoulders corners
lr_radius_corner_x = '${fparse gauge_width / 2.0 + lower_right_radius}'
lr_radius_corner_y = '${fparse -gauge_height /2.0 - lower_right_radius}'
ll_radius_corner_x = '${fparse -gauge_width / 2.0 - lower_left_radius}'
ll_radius_corner_y = '${fparse -gauge_height / 2.0 - lower_left_radius}'

#  arc midpoints
lr_midpt_x = '${fparse lr_radius_corner_x - (lower_right_radius * sqrt2)}' #(cos(5.0 * pi / 4.0)
lr_midpt_y = '${fparse lower_gauge_y - (lower_right_radius * sqrt2)}' # (sin(5.0 * pi / 4.0)
ll_midpt_x = '${fparse ll_radius_corner_x + (lower_left_radius * sqrt2)}' # (cos(7.0 * pi / 4.0)
ll_midpt_y = '${fparse lower_gauge_y - (lower_left_radius * sqrt2)}' #(sin(7.0 * pi / 4.0)

#####################
## conversion constants for the upper shoulders
ur_radius_corner_x = '${fparse 0.5 * gauge_width + upper_right_radius}'
ur_radius_corner_y = '${fparse 0.5 * gauge_height + upper_right_radius}'
ul_radius_corner_x = '${fparse -0.5 * gauge_width - upper_left_radius}'
ul_radius_corner_y = '${fparse 0.5 * gauge_height + upper_left_radius}'

## arc midpoints
ur_midpt_x = '${fparse ur_radius_corner_x - (upper_right_radius * sqrt2)}' # (cos(3.0 * pi / 4.0)
ur_midpt_y = '${fparse upper_gauge_y + (upper_right_radius * sqrt2)}' # (sin(3.0 * pi / 4.0)
ul_midpt_x = '${fparse ul_radius_corner_x + (upper_left_radius * sqrt2)}'
ul_midpt_y = '${fparse upper_gauge_y + (upper_left_radius * sqrt2)}'

[Mesh]
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
    left_parameter = '${ul_midpt_x} ; ${ul_midpt_y} ; 0.0'
    top_parameter = '${shoulder_tab_curvature}'
    right_parameter = '${ur_midpt_x} ; ${ur_midpt_y} ; 0.0'
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
  [stitch_top_gauge]
    type = StitchedMeshGenerator
    inputs = 'stitch_top_tab gauge'
    stitch_boundaries_pairs = 'bottom top'
  []

  ######################################
  #### bottom shoulders and tab section
  ######################################
  [bottom_shoulder]
    type = TransfiniteMeshGenerator
    corners = '${ll_radius_corner_x} ${ll_radius_corner_y} 0.0
               ${lr_radius_corner_x} ${lr_radius_corner_y} 0.0
               ${right_gauge_x} ${lower_gauge_y}  0.0
               ${left_gauge_x} ${lower_gauge_y}  0.0'
    nx = ${num_x_nodes}
    ny = ${num_y_nodes}
    bottom_type = CIRCARC
    right_type = CIRCARC
    top_type = LINE
    left_type = CIRCARC
    bottom_parameter = '${shoulder_tab_curvature}'
    right_parameter = '${lr_midpt_x} ; ${lr_midpt_y} ; 0.0'
    left_parameter = '${ll_midpt_x} ; ${ll_midpt_y} ; 0.0'
  []
  [bottom_tab]
    type = TransfiniteMeshGenerator
    corners = '${ll_radius_corner_x} ${lower_tab_y} 0.0
               ${lr_radius_corner_x} ${lower_tab_y} 0.0
               ${lr_radius_corner_x} ${lr_radius_corner_y} 0.0
               ${ll_radius_corner_x} ${ll_radius_corner_y} 0.0'
    nx = ${num_x_nodes}
    ny = ${num_y_nodes}
    bottom_type = LINE
    left_type = LINE
    top_type = CIRCARC
    right_type = LINE
    top_parameter = '${fparse -shoulder_tab_curvature}'
  []
  [stitch_bottom_tab]
    type = StitchedMeshGenerator
    inputs = 'bottom_shoulder bottom_tab'
    stitch_boundaries_pairs = 'bottom top'
  []
  [stitch_bottom_gauge]
    type = StitchedMeshGenerator
    inputs = 'stitch_top_gauge stitch_bottom_tab'
    stitch_boundaries_pairs = 'bottom top'
  []

  [upleft_shoulder_sideset]
    type = ParsedGenerateSideset
    input = 'stitch_bottom_gauge'
    # input = 'downright_shoulder_sideset'
    combinatorial_geometry = 'x<=(${fparse -0.5 * rig_gap + (upper_rig_offset)}) & abs((x-(${ul_radius_corner_x}))^2+(y-(${upper_gauge_y}))^2-(${upper_left_radius})^2)<1e-2'
    new_sideset_name = 'upper_left_shoulder'
  []
  [upright_shoulder_sideset]
    type = ParsedGenerateSideset
    # input = 'top_shoulder'
    input = 'upleft_shoulder_sideset'
    combinatorial_geometry = 'x>=(${fparse 0.5 * rig_gap + upper_rig_offset}) & abs((x-(${ur_radius_corner_x}))^2+(y-(${upper_gauge_y}))^2-(${upper_right_radius})^2)<1e-2'
    new_sideset_name = 'upper_right_shoulder'
  []
  [downleft_shoulder_sideset]
    type = ParsedGenerateSideset
    input = 'upright_shoulder_sideset'
    # input = 'smoothed_final'
    # input = 'extruder'
    combinatorial_geometry = 'x<=(${fparse -0.5 * rig_gap + (lower_rig_offset)}) & abs((x-(${ll_radius_corner_x}))^2+(y-(${lower_gauge_y}))^2-(${lower_left_radius})^2)<1e-2'
    new_sideset_name = 'lower_left_shoulder'
  []
  [downright_shoulder_sideset]
    type = ParsedGenerateSideset
    input = 'downleft_shoulder_sideset'
    combinatorial_geometry = 'x>=(${fparse 0.5 * rig_gap + (lower_rig_offset)}) & abs((x-(${lr_radius_corner_x}))^2+(y-(${lower_gauge_y}))^2-(${lower_right_radius})^2)<1e-2'
    new_sideset_name = 'lower_right_shoulder'
  []

  [smoothed_final]
    type = SmoothMeshGenerator
    # input = stitch_bottom_gauge
    input = downright_shoulder_sideset
    iterations = 15
  []
  use_displaced_mesh = false
[]

[GlobalParams]
  displacements = 'disp_x disp_y'
  large_kinematics = true
  stabilize_strain = true
[]

[AuxVariables]
  [upper_rig_offset]
    initial_condition = ${upper_rig_offset}
  []
  [lower_rig_offset]
    initial_condition = ${lower_rig_offset}
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
    boundary = 'lower_left_shoulder lower_right_shoulder'
    value = 0.0
  []
  [tensile_displacement]
    type = FunctionDirichletBC
    variable = 'disp_y'
    boundary = 'upper_left_shoulder upper_right_shoulder'
    function = '2.85e-3*t' #5.0e-4 mm/mm-s * 5.7 mm <- the strain rate used for TCR SSRT testing and this gauge length
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
  # [exodus]
  #   type = Exodus
  #   # execute_on = 'INITIAL FINAL FAILED'
  # []
  color = false
  perf_graph = true
[]

[Postprocessors]
  [from_parent_upper_rig_offset]
    type = AverageNodalVariableValue
    variable = upper_rig_offset
    execute_on = INITIAL
  []
  [from_parent_lower_rig_offset]
    type = AverageNodalVariableValue
    variable = lower_rig_offset
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
