# Attempt to build the bottom shoulder region with parameters from STM run

# lower_left_radius = 1.35597 #1.6
# lower_right_radius = 1.48137 # 1.2
# gauge_width = 1.184740 #1.2
# min 0.946, max 1.454
# gauge_height = 5.813050 #5.7
# min 5.446, max 5.954

## constrained values (hardcoded)
num_x_nodes = 16
num_y_nodes = 16
shoulder_tab_curvature = 0.15
# shoulder_mid_point = 2.0

## conversion cofficients
# one_minus_inverse_sqrt_two = '${fparse (1.0 - 1.0 / sqrt(2.0))}'
# dist_circ = '${fparse (1.0-sqrt(2.0)/2)}'

### calculate the shoulder arc paramater values
# lower_right_dist = '${fparse lower_right_radius - (lower_right_radius * 0.7071067811865475)}' #0.34092770669885875 #'${fparse lower_right_radius * (1.0 - sqrt(2.0)/ 2.0)}'
# lr_dist = '${fparse lower_right_radius - (lower_right_radius * (1.0/(sqrt(2.0))))}'
# ll_dist = '${fparse lower_left_radius - (lower_left_radius * (1.0/(sqrt(2.0))))}'

[Mesh]
  # [left_bottom_shoulder]
  #   type = TransfiniteMeshGenerator
  #   corners = '${fparse 0.5 * gauge_width + lower_left_radius} ${fparse -0.5 * gauge_height - lower_left_radius} 0.0
  #              0.0 ${fparse -0.5 * gauge_height - shoulder_mid_point} 0.0
  #              0.0 ${fparse -0.5 * gauge_height} 0.0
  #              ${fparse 0.5 * gauge_width} ${fparse -0.5 * gauge_height} 0.0'
  #   nx = ${num_x_nodes}
  #   ny = ${num_y_nodes}
  #   bottom_type = CIRCARC
  #   right_type = LINE
  #   top_type = LINE
  #   left_type = CIRCARC
  #   left_parameter = '0.3971544179144772'
  #   bottom_parameter = '${shoulder_tab_curvature}'
  # []
  [left_bottom_shoulder]
    type = TransfiniteMeshGenerator
    corners = '1.94834 -4.26249 0.0
               0.0 -4.90653 0.0
               0.0 -2.90652 0.0
               0.59237 -2.90652 0.0'
    nx = ${num_x_nodes}
    ny = ${num_y_nodes}
    bottom_type = CIRCARC
    right_type = LINE
    top_type = LINE
    left_type = CIRCARC
    left_parameter = '0.3971544179144772'
    bottom_parameter = '${shoulder_tab_curvature}'
  []
  # [right_bottom_shoulder]
  #   type = TransfiniteMeshGenerator
  #   corners = '${fparse 0.5 * gauge_width + lower_right_radius} ${fparse -0.5 * gauge_height - lower_right_radius} 0.0
  #              0.0 ${fparse -0.5 * gauge_height - shoulder_mid_point} 0.0
  #              0.0 ${fparse -0.5 * gauge_height} 0.0
  #              ${fparse 0.5 * gauge_width} ${fparse -0.5 * gauge_height} 0.0'
  #   nx = ${num_x_nodes}
  #   ny = ${num_y_nodes}
  #   bottom_type = CIRCARC
  #   right_type = LINE
  #   top_type = LINE
  #   left_type = CIRCARC
  #   left_parameter = '${lr_dist}' #make negative to create convex surface and avoid the inversion
  #   bottom_parameter = '${shoulder_tab_curvature}'
  # []
  # [stitch_bottom_shoulders]
  #   type = StitchedMeshGenerator
  #   inputs = 'left_bottom_shoulder right_bottom_shoulder'
  #   stitch_boundaries_pairs = 'left right'
  # []

  # [extruder]
  #   type = MeshExtruderGenerator
  #   input = right_bottom_shoulder
  #   extrusion_vector = "0 0 0.5"
  #   num_layers = 5
  #   bottom_sideset = back
  #   top_sideset = front
  # []
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
