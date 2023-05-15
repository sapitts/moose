## Ideal geometry, BCs, elastic only 2D weak plane simulation

## parameters to vary with STM
upper_left_radius = 1.22116 #1.4
upper_right_radius = 1.27811 #1.4
lower_left_radius = 1.28209 #1.4
lower_right_radius = 1.20818 #1.4
gauge_width = 1.22321 #1.2
gauge_height = 5.6963400000002 #5.7
# min 5.446, max 5.954

num_x_nodes = 16
num_y_nodes = 16
tab_height = 5.15 # 3.75 +1.4 from tab top to gauge height
shoulder_tab_curvature = 0.3

## bc conditions: assumed to be symmetric

### conversion constants for the tabs
lower_tab_y = '${fparse -gauge_height / 2.0 - tab_height}'
upper_tab_y = '${fparse gauge_height / 2.0 + tab_height}'

## conversion constants for the gauge section
left_gauge_x = '${fparse -gauge_width / 2.0}'
right_gauge_x = '${fparse gauge_width / 2.0}'
lower_gauge_y = '${fparse -gauge_height / 2.0}'
upper_gauge_y = '${fparse gauge_height / 2.0}'

#####################
#### conversion constants for bottom (lower) shoulders:
cos_pi_div4 = 0.7071067811865476

#  corners
lr_radius_corner_x = '${fparse gauge_width / 2.0 + lower_right_radius}'
lr_radius_corner_y = '${fparse -gauge_height /2.0 - lower_right_radius}'
ll_radius_corner_x = '${fparse -gauge_width / 2.0 - lower_left_radius}'
ll_radius_corner_y = '${fparse -gauge_height / 2.0 - lower_left_radius}'

#  arc midpoints
lr_midpt_x = '${fparse lr_radius_corner_x - lower_right_radius * cos_pi_div4}' #(cos(5.0 * pi / 4.0))
lr_midpt_y = '${fparse lower_gauge_y - lower_right_radius * cos_pi_div4}' #(sin(5.0 * pi / 4.0)
ll_midpt_x = '${fparse ll_radius_corner_x + lower_left_radius * cos_pi_div4}' #(cos(7.0 * pi/4.0))
ll_midpt_y = '${fparse lower_gauge_y - lower_left_radius * cos_pi_div4}' #(sin(7.0 * pi/4.0))

#####################
## conversion constants for the upper shoulders
ur_radius_corner_x = '${fparse 0.5 * gauge_width + upper_right_radius}'
ur_radius_corner_y = '${fparse 0.5 * gauge_height + upper_right_radius}'
ul_radius_corner_x = '${fparse -0.5 * gauge_width - upper_left_radius}'
ul_radius_corner_y = '${fparse 0.5 * gauge_height + upper_left_radius}'

## arc midpoints
ur_midpt_x = '${fparse ur_radius_corner_x - upper_right_radius * cos_pi_div4}' #(cos(3.0 * pi / 4.0))
ur_midpt_y = '${fparse upper_gauge_y + upper_right_radius * cos_pi_div4}' #sin(3.0 * pi / 4.0))
ul_midpt_x = '${fparse ul_radius_corner_x +upper_left_radius * cos_pi_div4}'
ul_midpt_y = '${fparse upper_gauge_y + upper_left_radius * cos_pi_div4}'

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
    left_parameter = '${ul_midpt_x} && ${ul_midpt_y} && 0.0'
    top_parameter = '${shoulder_tab_curvature}'
    right_parameter = '${ur_midpt_x} && ${ur_midpt_y} $$ 0.0'
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
    right_parameter = '${lr_midpt_x} && ${lr_midpt_y} && 0.0'
    left_parameter = '${ll_midpt_x} && ${ll_midpt_y} && 0.0'
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

  [smoothed_final]
    type = SmoothMeshGenerator
    input = stitch_bottom_gauge
    # input = upright_shoulder_sideset
    iterations = 15
  []
[]

[AuxVariables]
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
[]

[Variables]
  [lambda]
    initial_condition = 1.0
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
  [out]
    type = CSV
    execute_on = 'INITIAL FINAL FAILED'
  []
  [exodus]
    type = Exodus
    execute_on = 'INITIAL FINAL FAILED'
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

  [p1_stress_xx]
    type = PointValue
    variable = lambda
    point = '0 ${fparse 0.5 * gauge_height + 1.4} 0'
  []
[]

