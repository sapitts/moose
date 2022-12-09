# Counter example in which build orientation affects fparser + transfinite mesh harmony

lower_left_radius = 1.35597 #1.6
lower_right_radius = 1.48137 # 1.2
gauge_width = 1.184740 #1.2
gauge_height = 5.813050 #5.7

## constrained values (hardcoded)
num_x_nodes = 16
num_y_nodes = 16
shoulder_tab_curvature = 0.3

## conversion constants for bottom shoulders
lr_radius_corner_x = '${fparse -1 * (0.5 * gauge_width + lower_right_radius)}'
lr_radius_corner_y = '${fparse -1 * (-0.5 * gauge_height - lower_right_radius)}'
ll_radius_corner_x = '${fparse -1 * (-0.5 * gauge_width - lower_left_radius)}'
ll_radius_corner_y = '${fparse -1 * (-0.5 * gauge_height - lower_left_radius)}'

## conversion constants for the gauge section
left_gauge_x = '${fparse -0.5 * gauge_width}'
right_gauge_x = '${fparse gauge_width / 2.0}'
upper_gauge_y = '${fparse gauge_height / 2.0}'

### shoulder parameter constants
lr_dist = '${fparse lower_right_radius - (lower_right_radius * (1.0/(sqrt(2.0))))}'
ll_dist = '${fparse lower_left_radius - (lower_left_radius * (1.0/(sqrt(2.0))))}'

[Mesh]
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
