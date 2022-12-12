# Attempt to build the bottom shoulder region with parameters from STM run
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
  [extruder]
    type = MeshExtruderGenerator
    input = smoothed_final
    extrusion_vector = "0 0 0.5"
    num_layers = 5
    bottom_sideset = back
    top_sideset = front
  []

  #############################################
  #### add BC sidesets, mesh clean up
  #############################################
  [downleft_shoulder_sideset]
    type = ParsedGenerateSideset
    # input = 'smoothed_final'
    input = 'extruder'
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
[]

[Variables]
  [lambda]
  []
[]

[Kernels]
  [lambda]
    type = NullKernel
    variable = lambda
  []
[]

[Executioner]
  type = Steady
[]

[Outputs]
  exodus = true
[]
