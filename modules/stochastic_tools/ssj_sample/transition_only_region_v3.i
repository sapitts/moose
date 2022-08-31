### third approach to the segmented block building of the dogbone
### focus here on buiding the transition only region

## parameters to vary with STM
upper_left_radius = 1.2 #min 1.146, max 1.654
upper_right_radius = 1.4
lower_left_radius = 1.6
lower_right_radius = 1.3

gauge_width = 1.2
# min 1.166 (constrained by mesh), max 1.454
gauge_height = 5.7
# min 5.446, max 5.954

## constrained values (hardcoded)
pitch_length = 1.704
# 0.05 + 1.654 (max radius)
gauge_transition_height = 1.0 #not computed, just wanted it to not be too small
tab_height = 3.446
# 3.75 - (1.704 - 1.4)

## computed mesh parameters:
top_left_gauge_shoulder = '${fparse pitch_length - upper_left_radius}'
top_right_gauge_shoulder = '${fparse pitch_length - upper_right_radius}'
top_center_gauge_portion = '${fparse gauge_width - top_left_gauge_shoulder - top_right_gauge_shoulder}'
section_gauge_height = '${fparse (gauge_height - gauge_transition_height)/ 2.0}'
bottom_left_gauge_shoulder = '${fparse pitch_length - lower_left_radius}'
bottom_right_gauge_shoulder = '${fparse pitch_length - lower_right_radius}'
bottom_center_gauge_portion = '${fparse gauge_width - bottom_left_gauge_shoulder - bottom_right_gauge_shoulder}'

## copied from Oana's PR:
[Mesh]
  # [transition_left]
  #   type = TransfiniteMeshGenerator
  #   corners = '${fparse -0.5 * gauge_width} ${fparse -0.5 * gauge_transition_height} 0.0
  #              ${fparse -0.5 * gauge_width + bottom_left_gauge_shoulder} ${fparse -0.5 * gauge_transition_height} 0.0
  #              ${fparse -0.5 * gauge_width + top_left_gauge_shoulder} ${fparse 0.5 * gauge_transition_height} 0
  #              ${fparse -0.5 * gauge_width} ${fparse 0.5 * gauge_transition_height} 0'
  #   nx = 4
  #   ny = 9
  #   bottom = LINE
  #   top = LINE
  #   right = LINE
  #   left = LINE
  # []
  # [rename_transition_left]
  #   type = RenameBlockGenerator
  #   input = transition_left
  #   old_block = '0'
  #   new_block = '205'
  # []
  [transition_center]
    type = TransfiniteMeshGenerator
    corners = '${fparse -0.5 * gauge_width + bottom_left_gauge_shoulder} ${fparse -0.5 * gauge_transition_height} 0.0
               ${fparse 0.5 * gauge_width - bottom_right_gauge_shoulder} ${fparse -0.5 * gauge_transition_height} 0.0
               ${fparse 0.5 * gauge_width - top_right_gauge_shoulder} ${fparse 0.5 * gauge_transition_height} 0
               ${fparse -0.5 * gauge_width + top_left_gauge_shoulder} ${fparse 0.5 * gauge_transition_height} 0'
    nx = 5
    ny = 9
    bottom = LINE
    top = LINE
    right = LINE
    left = LINE
  []
  [rename_transition_center]
    type = RenameBlockGenerator
    input = transition_center
    old_block = '0'
    new_block = '206'
  []
  # [stitch_left_transition_region]
  #   type = StitchedMeshGenerator
  #   inputs = 'rename_transition_left rename_transition_center'
  #   stitch_boundaries_pairs = 'right left'
  # []
  # [rename_transition_center_right_sideset]
  #   type = SideSetsAroundSubdomainGenerator
  #   input = 'rename_transition_center'
  #   normal = '1 0 0'
  #   block = 206
  #   new_boundary = 'transition_center_right'
  # []
  # [rename_transition_blocks_left]
  #   type = RenameBlockGenerator
  #   input = stitch_left_transition_region
  #   old_block = '205 206'
  #   new_block = '206 206'
  # []

  [transition_right] #MUST maintain the the same order to have access to the boundary sideset names
    type = TransfiniteMeshGenerator
    corners = '${fparse 0.5 * gauge_width - bottom_right_gauge_shoulder} ${fparse -0.5 * gauge_transition_height} 0.0
               ${fparse 0.5 * gauge_width} ${fparse -0.5 * gauge_transition_height} 0.0
               ${fparse 0.5 * gauge_width} ${fparse 0.5 * gauge_transition_height} 0
               ${fparse 0.5 * gauge_width - top_right_gauge_shoulder} ${fparse 0.5 * gauge_transition_height} 0'
    nx = 4
    ny = 9
    bottom = LINE
    top = LINE
    right = LINE
    left = LINE
  []
  [rename_transition_right]
    type = RenameBlockGenerator
    input = transition_right
    old_block = '0'
    new_block = '207'
  []

  [stitch_right_transition_region]
    type = StitchedMeshGenerator
    inputs = 'rename_transition_right rename_transition_center'
    stitch_boundaries_pairs = ' left right'
  []
[]

