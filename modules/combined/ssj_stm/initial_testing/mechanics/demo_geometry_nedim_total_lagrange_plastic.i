## Ideal geometry, BCs, elastic only simulation

## parameters to vary with STM
upper_left_radius = 1.22614 #1.3 #1.3 #min 1.146, max 1.654
upper_right_radius = 1.394410 #1.4
lower_left_radius = 1.35597 #1.6
lower_right_radius = 1.48137 # 1.2

gauge_width = 1.184740 #1.2
# min 0.946, max 1.454
gauge_height = 5.813050 #5.7
# min 5.446, max 5.954

## constrained values (hardcoded)
num_x_nodes = 16
num_y_nodes = 16
tab_height = 5.15 # 3.75 +1.4 from tab top to gauge height
shoulder_tab_curvature = 0.3

## bc conditions
rig_gap = 1.5
upper_rig_offset = 0.0 # -0.15 to 0.15
lower_rig_offset = 0.0 # -0.15 to 0.15

## conversion constants for bottom shoulders
lr_radius_corner_x = '${fparse -1 * (0.5 * gauge_width + lower_right_radius)}'
lr_radius_corner_y = '${fparse -1 * (-0.5 * gauge_height - lower_right_radius)}'
ll_radius_corner_x = '${fparse -1 * (-0.5 * gauge_width - lower_left_radius)}'
ll_radius_corner_y = '${fparse -1 * (-0.5 * gauge_height - lower_left_radius)}'

## conversion constants for the gauge section
left_gauge_x = '${fparse -0.5 * gauge_width}'
right_gauge_x = '${fparse gauge_width / 2.0}'
lower_gauge_y = '${fparse -gauge_height / 2.0}'
upper_gauge_y = '${fparse gauge_height / 2.0}'

## conversion constants for the upper shoulders
ur_radius_corner_x = '${fparse 0.5 * gauge_width + upper_right_radius}'
ur_radius_corner_y = '${fparse 0.5 * gauge_height + upper_right_radius}'
ul_radius_corner_x = '${fparse -0.5 * gauge_width - upper_left_radius}'
ul_radius_corner_y = '${fparse 0.5 * gauge_height + upper_left_radius}'

### conversion constants for the tabs
lower_tab_y = '${fparse -0.5 * gauge_height - tab_height}'
upper_tab_y = '${fparse 0.5 * gauge_height + tab_height}'

### shoulder parameter constants
ur_dist = '${fparse upper_right_radius - (upper_right_radius * (1.0/(sqrt(2.0))))}'
ul_dist = '${fparse upper_left_radius - (upper_left_radius * (1.0/(sqrt(2.0))))}'
lr_dist = '${fparse lower_right_radius - (lower_right_radius * (1.0/(sqrt(2.0))))}'
ll_dist = '${fparse lower_left_radius - (lower_left_radius * (1.0/(sqrt(2.0))))}'

[Mesh]
  ######################################
  #### bottom shoulders and tab section
  ######################################
  [bottom_shoulder_top_orientation]
    type = TransfiniteMeshGenerator
    corners = '${right_gauge_x} ${upper_gauge_y} 0.0
               ${left_gauge_x} ${upper_gauge_y} 0.0
               ${lr_radius_corner_x} ${lr_radius_corner_y} 0.0
               ${ll_radius_corner_x} ${ll_radius_corner_y} 0.0'
    nx = ${num_x_nodes}
    ny = ${num_y_nodes}
    bottom_type = LINE
    left_type = CIRCARC
    top_type = CIRCARC
    right_type = CIRCARC
    left_parameter = '${ll_dist}'
    right_parameter = '${lr_dist}'
    top_parameter = '${shoulder_tab_curvature}' #if you want a circ bit
  []
  [rotate_bottom_shoulders]
    type = TransformGenerator
    input = bottom_shoulder_top_orientation
    transform = ROTATE
    vector_value = '180 0 0'
  []
  [bottom_tab]
    type = TransfiniteMeshGenerator
    corners = '${fparse -lr_radius_corner_x} ${lower_tab_y} 0.0
               ${fparse -ll_radius_corner_x} ${lower_tab_y} 0.0
               ${fparse -ll_radius_corner_x} ${fparse -ll_radius_corner_y} 0.0
               ${fparse -lr_radius_corner_x} ${fparse -lr_radius_corner_y} 0.0'
    nx = ${num_x_nodes}
    ny = ${num_x_nodes}
    bottom_type = LINE
    left_type = LINE
    top_type = CIRCARC
    right_type = LINE
    top_parameter = '${fparse -shoulder_tab_curvature}'
  []
  [stitch_bottom_tab]
    type = StitchedMeshGenerator
    inputs = 'rotate_bottom_shoulders bottom_tab'
    stitch_boundaries_pairs = 'top top'
  []
  [rename_gauge_boundary]
    type = SideSetsFromNormalsGenerator
    input = stitch_bottom_tab
    normals = '0 1 0'
    fixed_normal = true
    new_boundary = 'bottom_shoulder_top'
    replace = true
  []
  [gauge]
    type = TransfiniteMeshGenerator
    corners = '${right_gauge_x} ${lower_gauge_y} 0.0
               ${left_gauge_x} ${lower_gauge_y} 0.0
               ${left_gauge_x} ${upper_gauge_y} 0.0
               ${right_gauge_x} ${upper_gauge_y} 0.0'
    nx = ${num_x_nodes}
    ny = 40
    bottom_type = LINE
    left_type = LINE
    top_type = LINE
    right_type = LINE
  []
  [stitch_bottom_gauge]
    type = StitchedMeshGenerator
    inputs = 'rename_gauge_boundary gauge'
    stitch_boundaries_pairs = 'bottom_shoulder_top bottom'
  []
  [top_shoulder]
    type = TransfiniteMeshGenerator
    corners = '${right_gauge_x} ${upper_gauge_y} 0.0
               ${left_gauge_x} ${upper_gauge_y} 0.0
               ${ul_radius_corner_x} ${ul_radius_corner_y} 0.0
               ${ur_radius_corner_x} ${ur_radius_corner_y} 0.0'
    nx = ${num_x_nodes}
    ny = ${num_y_nodes}
    bottom_type = LINE
    left_type = CIRCARC
    top_type = CIRCARC
    right_type = CIRCARC
    left_parameter = '${ur_dist}' #'Note mismatch between geometery side and parameter
    right_parameter = '${ul_dist}' #'Note mismatch between geometery side and parameter
    top_parameter = '${shoulder_tab_curvature}' #if you want a circ bit
  []
  [top_tab]
    type = TransfiniteMeshGenerator
    corners = '${ur_radius_corner_x} ${ur_radius_corner_y} 0.0
               ${ul_radius_corner_x} ${ul_radius_corner_y} 0.0
               ${ul_radius_corner_x} ${upper_tab_y} 0.0
               ${ur_radius_corner_x} ${upper_tab_y} 0.0'
    nx = ${num_x_nodes}
    ny = ${num_x_nodes}
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
    inputs = 'stitch_bottom_gauge stitch_top_tab'
    stitch_boundaries_pairs = 'top bottom'
  []

  [smoothed_final]
    type = SmoothMeshGenerator
    input = stitch_top_gauge
    iterations = 15
  []

  # [extruder]
  #   type = MeshExtruderGenerator
  #   input = smoothed_final
  #   extrusion_vector = "0 0 0.5"
  #   num_layers = 5
  #   bottom_sideset = back
  #   top_sideset = front
  # []

  #############################################
  #### add BC sidesets, mesh clean up
  #############################################
  [downleft_shoulder_sideset]
    type = ParsedGenerateSideset
    input = 'smoothed_final'
    # input = 'extruder'
    combinatorial_geometry = 'x<=(${fparse -0.5 * rig_gap + (lower_rig_offset)}) & abs((x-(${fparse -0.5 * gauge_width - lower_left_radius}))^2+(y-(${fparse -0.5*gauge_height}))^2-(${lower_left_radius})^2)<1e-2'
    new_sideset_name = 'lower_left_shoulder'
  []
  [downright_shoulder_sideset]
    type = ParsedGenerateSideset
    input = 'downleft_shoulder_sideset'
    # combinatorial_geometry = 'abs((x-(${fparse 0.5 * gauge_width + lower_right_radius}))^2+(y-(${fparse -0.5*gauge_height}))^2-(${lower_right_radius})^2)<1e-2'
    combinatorial_geometry = 'x>=(${fparse 0.5 * rig_gap + (lower_rig_offset)}) & abs((x-(${fparse 0.5 * gauge_width + lower_right_radius}))^2+(y-(${fparse -0.5*gauge_height}))^2-(${lower_right_radius})^2)<1e-2'
    new_sideset_name = 'lower_right_shoulder'
  []
  [upleft_shoulder_sideset]
    type = ParsedGenerateSideset
    input = 'downright_shoulder_sideset'
    combinatorial_geometry = 'x<=(${fparse -0.5 * rig_gap + (upper_rig_offset)}) & abs((x-(${fparse -0.5 * gauge_width - upper_left_radius}))^2+(y-(${fparse 0.5*gauge_height}))^2-(${upper_left_radius})^2)<1e-2'
    new_sideset_name = 'upper_left_shoulder'
  []
  [upright_shoulder_sideset]
    type = ParsedGenerateSideset
    input = 'upleft_shoulder_sideset'
    combinatorial_geometry = 'x>=(${fparse 0.5 * rig_gap + (upper_rig_offset)}) & abs((x-(${fparse 0.5 * gauge_width + upper_right_radius}))^2+(y-(${fparse 0.5*gauge_height}))^2-(${upper_right_radius})^2)<1e-2'
    new_sideset_name = 'upper_right_shoulder'
  []
  use_displaced_mesh = false
[]

[GlobalParams]
  displacements = 'disp_x disp_y'
  large_kinematics = true
  stabilize_strain = true
[]

[AuxVariables]
  [nl_strain_zz]
    order = CONSTANT
    family = MONOMIAL
  []
  [upper_left_radius]
    initial_condition = ${upper_left_radius}
  []
  [upper_right_radius]
    initial_condition = ${upper_right_radius}
  []
  [lower_left_radius]
    initial_condition = ${lower_left_radius}
  []
  [lower_right_radius]
    initial_condition = ${lower_right_radius}
  []
  [gauge_width]
    initial_condition = ${gauge_width}
  []
  [gauge_height]
    initial_condition = ${gauge_height}
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
    function = '0.08*t'
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
    type = ComputeLagrangianWrappedStress
  []
  [radial_return_stress]
    type = ComputeMultipleInelasticStress
    inelastic_models = 'power_law_hardening'
  []
  [power_law_hardening]
    type = IsotropicPowerLawHardeningStressUpdate
    strength_coefficient = 914 #MPa, Link et al NED (1998), Figure 4 pg 385
    strain_hardening_exponent = 0.014 #n Cinbiz et al JNM (2016) pg 158
    relative_tolerance = 1e-6
    absolute_tolerance = 1e-6
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
    dt = 1.0e-3
    optimal_iterations = 8
    iteration_window = 2
  []
  # dt = 0.1
  dtmin = 1e-8
  end_time = 10.6875 # to get to 15% strain in the gauge length
  nl_max_its = 30
  nl_rel_tol = 1e-6
  nl_abs_tol = 1e-6
[]

[Outputs]
  csv = true
  [exodus]
    type = Exodus
    execute_on = 'TIMESTEP_END' #'INITIAL FINAL FAILED'
  []
  color = false
  perf_graph = true
[]

[Postprocessors]
  [from_parent_upper_left_radius]
    type = AverageNodalVariableValue
    variable = upper_left_radius
    execute_on = INITIAL
  []
  [from_parent_upper_right_radius]
    type = AverageNodalVariableValue
    variable = upper_right_radius
    execute_on = INITIAL
  []
  [from_parent_lower_left_radius]
    type = AverageNodalVariableValue
    variable = lower_left_radius
    execute_on = INITIAL
  []
  [from_parent_lower_right_radius]
    type = AverageNodalVariableValue
    variable = lower_right_radius
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
