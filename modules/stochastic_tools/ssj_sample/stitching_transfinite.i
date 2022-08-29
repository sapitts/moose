# Need to test out the stitching of a transfinite block to a `regular` block

## parameters to vary with STM
upper_left_radius = 1.2 #min 1.146, max 1.654
upper_right_radius = 1.4
lower_left_radius = 1.5
lower_right_radius = 1.4

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

[Mesh]
  [top_gauge_left_rectangle]
    type = CartesianMeshGenerator
    dim = 2
    dx = '${top_left_gauge_shoulder}'
    dy = '${section_gauge_height}'
    ix = '3'
    iy = '20'
    subdomain_id = '101'
  []
  [move_top_left_rectangle]
    type = TransformGenerator
    input = 'top_gauge_left_rectangle'
    transform = TRANSLATE
    vector_value = '${fparse -1.0 * top_left_gauge_shoulder - 0.5 * top_center_gauge_portion} ${fparse 0.5 * gauge_transition_height} 0'
  []
  [rename_top_gauge_bottom_sideset]
    type = SideSetsAroundSubdomainGenerator
    input = 'move_top_left_rectangle'
    normal = ' 0.0 -1.0 0.0'
    normal_tol = 1.0e-8
    block = '101'
    new_boundary = 'upper_gauge_section_bottom'
  []

  [transition_left]
    type = TransfiniteMeshGenerator
    corners = '${fparse - 0.5 * gauge_width} ${fparse -0.5 * gauge_transition_height} 0.0
               ${fparse -0.5 * bottom_center_gauge_portion} ${fparse -0.5 * gauge_transition_height} 0.0
               ${fparse -0.5 * top_center_gauge_portion} ${fparse 0.5 * gauge_transition_height} 0
               ${fparse - 0.5 * gauge_width} ${fparse 0.5 * gauge_transition_height} 0'
    nx = 4
    ny = 9
    bottom = LINE
    top = LINE
    right = LINE
    left = LINE
  []
  [rename_transition_left]
    type = RenameBlockGenerator
    input = transition_left
    old_block = '0'
    new_block = '205'
  []
  [rename_transition_top_sideset]
    type = SideSetsAroundSubdomainGenerator
    input = 'rename_transition_left'
    normal = '0.0 1.0 0.0'
    normal_tol = 1.0e-8
    block = '205'
    new_boundary = 'transition_top'
  []
  [stitch_top_transition_region]
    type = StitchedMeshGenerator
    inputs = 'rename_top_gauge_bottom_sideset rename_transition_top_sideset'
    stitch_boundaries_pairs = 'upper_gauge_section_bottom transition_top'
  []

[]
