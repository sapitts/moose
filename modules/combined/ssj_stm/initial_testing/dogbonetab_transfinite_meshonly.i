# Attempt to build the dogbone sample with only the transfinite generator

## parameters to vary with STM
upper_left_radius = 1.22614 #1.3 #1.3 #min 1.146, max 1.654
upper_right_radius = 1.394410 #1.4
lower_left_radius = 1.35597 #1.6
lower_right_radius = 1.48137 # 1.2

gauge_width = 1.184740 #1.2
# min 0.946, max 1.454
gauge_height = 5.813050 #5.7
# min 5.446, max 5.954

upper_rig_offset = 0.0 # -0.15 to 0.15
lower_rig_offset = 0.0 # -0.15 to 0.15

## constrained values (hardcoded)
tab_height = 5.15 # 3.75 +1.4 from tab top to gauge height
rig_gap = 1.5
num_x_nodes = 15
num_y_nodes = 16
shoulder_tab_curvature = 0.3

## conversion cofficients
one_minus_inverse_sqrt_two = '${fparse 1.0 - 1.0 / sqrt(2.0)}'
factor_dist = 0.29289321881345254
one_plus_inverse_sqrt_two = '${fparse 1.0 + 1.0 / sqrt(2.0)}'
dist_circ = '${fparse (1.0-sqrt(2.0)/2)}'

[Mesh]
  ######################################
  #### top shoulders and tab section
  ######################################
  # [top_shoulder]
  #   type = TransfiniteMeshGenerator
  #   corners = '${fparse 0.5 * gauge_width} ${fparse 0.5 * gauge_height} 0.0
  #              ${fparse -0.5 * gauge_width} ${fparse 0.5 * gauge_height} 0.0
  #              ${fparse -0.5 * gauge_width - upper_left_radius} ${fparse 0.5 * gauge_height + upper_left_radius} 0.0
  #              ${fparse 0.5 * gauge_width + upper_right_radius} ${fparse 0.5 * gauge_height + upper_right_radius} 0.0'
  #   nx = ${num_x_nodes}
  #   ny = ${num_y_nodes}
  #   bottom_type = LINE
  #   left_type = CIRCARC
  #   top_type = CIRCARC
  #   right_type = CIRCARC
  #   left_parameter = '${fparse upper_right_radius  * one_minus_inverse_sqrt_two}' #'Note mismatch between geometery side and parameter
  #   right_parameter = '${fparse upper_left_radius * one_minus_inverse_sqrt_two}' #'Note mismatch between geometery side and parameter
  #   top_parameter = '${fparse shoulder_tab_curvature}' #if you want a circ bit
  # []
  # [top_tab]
  #   type = TransfiniteMeshGenerator
  #   corners = '${fparse 0.5 * gauge_width + upper_right_radius} ${fparse 0.5 * gauge_height + upper_right_radius} 0.0
  #              ${fparse -0.5 * gauge_width - upper_left_radius} ${fparse 0.5 * gauge_height + upper_left_radius} 0.0
  #              ${fparse -0.5 * gauge_width - upper_left_radius} ${fparse 0.5 * gauge_height + tab_height} 0.0
  #              ${fparse 0.5 * gauge_width + upper_right_radius} ${fparse 0.5 * gauge_height + tab_height} 0.0'
  #   nx = ${num_x_nodes}
  #   ny = ${num_x_nodes}
  #   bottom_type = CIRCARC
  #   left_type = LINE
  #   top_type = LINE
  #   right_type = LINE
  #   bottom_parameter = '${fparse -shoulder_tab_curvature}'
  # []
  # [stitch_top_tab]
  #   type = StitchedMeshGenerator
  #   inputs = 'top_shoulder top_tab'
  #   stitch_boundaries_pairs = 'top bottom'
  # []
  # [gauge]
  #   type = TransfiniteMeshGenerator
  #   corners = '${fparse 0.5 * gauge_width} ${fparse -0.5 * gauge_height} 0.0
  #              ${fparse -0.5 * gauge_width} ${fparse -0.5 * gauge_height} 0.0
  #              ${fparse -0.5 * gauge_width} ${fparse 0.5 * gauge_height} 0.0
  #              ${fparse 0.5 * gauge_width} ${fparse 0.5 * gauge_height} 0.0'
  #   nx = ${num_x_nodes}
  #   ny = 40
  #   bottom_type = LINE
  #   left_type = LINE
  #   top_type = LINE
  #   right_type = LINE
  # []
  # [stitch_top_gauge]
  #   type = StitchedMeshGenerator
  #   inputs = 'stitch_top_tab gauge'
  #   stitch_boundaries_pairs = 'bottom top'
  # []

  # ######################################
  # #### bottom shoulders and tab section
  # ######################################
  [bottom_shoulder]
    type = TransfiniteMeshGenerator
    corners = '${fparse 0.5 * gauge_width + lower_right_radius} ${fparse -0.5 * gauge_height - lower_right_radius} 0.0
               ${fparse -0.5 * gauge_width - lower_left_radius} ${fparse -0.5 * gauge_height - lower_left_radius} 0.0
               ${fparse -0.5 * gauge_width} ${fparse -0.5 * gauge_height} 0.0
               ${fparse 0.5 * gauge_width} ${fparse -0.5 * gauge_height} 0.0'
    nx = ${num_x_nodes}
    ny = ${num_y_nodes}
    bottom_type = CIRCARC
    left_type = CIRCARC
    top_type = LINE
    right_type = CIRCARC
    left_parameter = '${fparse lower_right_radius * dist_circ}'
    # right_parameter = '${fparse lower_left_radius * dist_circ}'
    # right_parameter = 0.3971544179144772
    bottom_parameter = '${fparse shoulder_tab_curvature}'
  []
  # [bottom_tab]
  #   type = TransfiniteMeshGenerator
  #   corners = '${fparse 0.5 * gauge_width + lower_right_radius} ${fparse -0.5 * gauge_height - tab_height} 0.0
  #              ${fparse -0.5 * gauge_width - lower_left_radius} ${fparse -0.5 * gauge_height - tab_height} 0.0
  #              ${fparse -0.5 * gauge_width - lower_left_radius} ${fparse -0.5 * gauge_height - lower_left_radius} 0.0
  #              ${fparse 0.5 * gauge_width + lower_right_radius} ${fparse -0.5 * gauge_height - lower_right_radius} 0.0'
  #   nx = ${num_x_nodes}
  #   ny = ${num_x_nodes}
  #   bottom_type = LINE
  #   left_type = LINE
  #   top_type = CIRCARC
  #   right_type = LINE
  #   top_parameter = '${fparse -shoulder_tab_curvature}'
  # []
  # [stitch_bottom_tab]
  #   type = StitchedMeshGenerator
  #   inputs = 'bottom_shoulder bottom_tab'
  #   stitch_boundaries_pairs = 'bottom top'
  # []
  # [stitch_bottom_gauge]
  #   type = StitchedMeshGenerator
  #   inputs = 'stitch_top_gauge stitch_bottom_tab'
  #   stitch_boundaries_pairs = 'bottom top'
  # []

  # [smoothed_final]
  #   type = SmoothMeshGenerator
  #   input = stitch_bottom_gauge
  #   iterations = 15
  # []

  # [extruder]
  #   type = MeshExtruderGenerator
  #   input = stitch_bottom_tab
  #   extrusion_vector = "0 0 0.5"
  #   num_layers = 5
  #   bottom_sideset = back
  #   top_sideset = front
  # []

  #############################################
  #### add BC sidesets, mesh clean up
  #############################################
  # [downleft_shoulder_sideset]
  #   type = ParsedGenerateSideset
  #   # input = 'smoothed_final'
  #   input = 'extruder'
  #   combinatorial_geometry = 'x<=(${fparse -0.5 * rig_gap + (lower_rig_offset)}) & abs((x-(${fparse -0.5 * gauge_width - lower_left_radius}))^2+(y-(${fparse -0.5*gauge_height}))^2-(${lower_left_radius})^2)<1e-2'
  #   new_sideset_name = 'lower_left_shoulder'
  # []
  # [downright_shoulder_sideset]
  #   type = ParsedGenerateSideset
  #   input = 'downleft_shoulder_sideset'
  #   # combinatorial_geometry = 'abs((x-(${fparse 0.5 * gauge_width + lower_right_radius}))^2+(y-(${fparse -0.5*gauge_height}))^2-(${lower_right_radius})^2)<1e-2'
  #   combinatorial_geometry = 'x>=(${fparse 0.5 * rig_gap + (lower_rig_offset)}) & abs((x-(${fparse 0.5 * gauge_width + lower_right_radius}))^2+(y-(${fparse -0.5*gauge_height}))^2-(${lower_right_radius})^2)<1e-2'
  #   new_sideset_name = 'lower_right_shoulder'
  # []
  # [upleft_shoulder_sideset]
  #   type = ParsedGenerateSideset
  #   input = 'downright_shoulder_sideset'
  #   combinatorial_geometry = 'x<=(${fparse -0.5 * rig_gap + (upper_rig_offset)}) & abs((x-(${fparse -0.5 * gauge_width - upper_left_radius}))^2+(y-(${fparse 0.5*gauge_height}))^2-(${upper_left_radius})^2)<1e-2'
  #   new_sideset_name = 'upper_left_shoulder'
  # []
  # [upright_shoulder_sideset]
  #   type = ParsedGenerateSideset
  #   input = 'upleft_shoulder_sideset'
  #   combinatorial_geometry = 'x>=(${fparse 0.5 * rig_gap + (upper_rig_offset)}) & abs((x-(${fparse 0.5 * gauge_width + upper_right_radius}))^2+(y-(${fparse 0.5*gauge_height}))^2-(${upper_right_radius})^2)<1e-2'
  #   new_sideset_name = 'upper_right_shoulder'
  # []
[]
