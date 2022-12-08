# Attempt to build the bottom shoulder region with parameters from STM run
lower_left_radius = 1.35597 #1.6
lower_right_radius = 1.48137 # 1.2
gauge_width = 1.184740 #1.2
# min 0.946, max 1.454
gauge_height = 5.813050 #5.7
# min 5.446, max 5.954
## constrained values (hardcoded)
num_x_nodes = 16
num_y_nodes = 16
shoulder_tab_curvature = 0.3

## constants for each coordinate point:
lr_radius_corner_x = '${fparse 0.5 * gauge_width + lower_right_radius}'
lr_radius_corner_y = '${fparse -0.5 * gauge_height - lower_right_radius}'
ll_radius_corner_x = '${fparse -0.5 * gauge_width - lower_left_radius}'
ll_radius_corner_y = '${fparse -0.5 * gauge_height - lower_left_radius}'
ll_gauge_corner_x = '${fparse -0.5 * gauge_width}'

###########
### Identified trouble maker, in this orienation:

ll_gauge_corner_y = -2.906525 #'${fparse -1.0 * gauge_height / 2.0}' ## this is the one that doesn't work, this time..
###########

lr_gauge_corner_x = '${fparse gauge_width / 2.0}'
lr_gauge_corner_y = '${fparse -gauge_height / 2.0}'
lr_dist = '${fparse lower_right_radius - (lower_right_radius * (1.0/(sqrt(2.0))))}'
ll_dist = '${fparse lower_left_radius - (lower_left_radius * (1.0/(sqrt(2.0))))}'

[Mesh]
  [bottom_shoulder]
    type = TransfiniteMeshGenerator
    corners = '${lr_radius_corner_x} ${lr_radius_corner_y} 0.0
               ${ll_radius_corner_x} ${ll_radius_corner_y} 0.0
               ${ll_gauge_corner_x} ${ll_gauge_corner_y}  0.0
               ${lr_gauge_corner_x} ${lr_gauge_corner_y}  0.0'
    nx = ${num_x_nodes}
    ny = ${num_y_nodes}
    bottom_type = CIRCARC
    left_type = CIRCARC
    top_type = LINE
    right_type = CIRCARC
    bottom_parameter = '${shoulder_tab_curvature}'
    left_parameter = '${lr_dist}'
    right_parameter = '${ll_dist}'
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
