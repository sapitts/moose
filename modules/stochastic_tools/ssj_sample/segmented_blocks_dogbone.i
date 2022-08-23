### top of the varying shoulder radii dogone mesh for stm

## parameters to vary with STM
upper_left_radius = 1.4 #min 1.146, max 1.654
upper_right_radius = 1.4

gauge_width = 1.2
# min 1.166 (constrained by mesh), max 1.454
gauge_height = 5.7
# min 5.446, max 5.954

## nominal values
ideal_radius = 1.4
ideal_tab_height = 3.75
ideal_tab_width = 4.0

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
top_gauge_height = '${fparse (gauge_height - gauge_transition_height)/ 2.0}'

[Mesh]
  [upper_left_shoulder]
    type = ConcentricCircleMeshGenerator
    num_sectors = 20
    radii = '${upper_left_radius}'
    rings = '1 4'
    has_outer_square = true
    pitch = '${fparse 2.0 * pitch_length}'
    preserve_volumes = false
    portion = top_right
  []
  [move_upleft_shoulder]
    type = TransformGenerator
    input = 'upper_left_shoulder'
    transform = TRANSLATE
    vector_value = '${fparse -1.0 * pitch_length - 0.5 * top_center_gauge_portion} ${fparse top_gauge_height + gauge_transition_height/2.0} 0'
  []
  [upper_center_shoulder_gauge]
    type = CartesianMeshGenerator
    dim = 2
    dx = '${top_center_gauge_portion}'
    ix = '6'
    dy = '${pitch_length}'
    iy = '15'
  []
  [move_upper_center_gauge]
    type = TransformGenerator
    input = 'upper_center_shoulder_gauge'
    transform = TRANSLATE
    vector_value = '${fparse -0.5 * top_center_gauge_portion} ${fparse top_gauge_height + gauge_transition_height/2.0} 0'
  []
  [stitch_top_left_shoulder]
    type = StitchedMeshGenerator
    inputs = 'move_upleft_shoulder move_upper_center_gauge'
    stitch_boundaries_pairs = 'right left'
  []
  [rename_top_left_shoulder]
    type = RenameBlockGenerator
    input = 'stitch_top_left_shoulder'
    old_block = ' 0  1  2'
    new_block = '10  11 10'
  []
  [rename_upper_center_right_side]
    type = SideSetsAroundSubdomainGenerator
    input = 'rename_top_left_shoulder'
    normal = '1 0 0'
    normal_tol = 1.0e-8
    block = 10
    new_boundary = 'top_center_right_side'
  []

  [upper_right_shoulder]
    type = ConcentricCircleMeshGenerator
    num_sectors = 20
    radii = '${upper_right_radius}'
    rings = '1 4'
    has_outer_square = true
    pitch = '${fparse 2.0 * pitch_length}'
    preserve_volumes = false
    portion = top_left
  []
  [move_upright_shoulder]
    type = TransformGenerator
    input = 'upper_right_shoulder'
    transform = TRANSLATE
    vector_value = '${fparse pitch_length + 0.5 * top_center_gauge_portion} ${fparse top_gauge_height + gauge_transition_height/2.0} 0'
  []
  [stitch_top_right_shoulder]
    type = StitchedMeshGenerator
    inputs = 'rename_upper_center_right_side move_upright_shoulder'
    stitch_boundaries_pairs = 'top_center_right_side left'
  []
  [rename_top_full_shoulders]
    type = RenameBlockGenerator
    input = 'stitch_top_right_shoulder'
    old_block = ' 1  2'
    new_block = '12  10'
  []
  # [rename_top_shoulders_top_side]
  #   type = SideSetsAroundSubdomainGenerator
  #   input = 'rename_top_full_shoulders'
  #   normal = '0 1 0'
  #   normal_tol = 1.0e-8
  #   block = 10
  #   new_boundary = 'top_shoulders_top_side'
  # []

  # [top_tab_rectangles]
  #   type = CartesianMeshGenerator
  #   dim = 2
  #   dx = '${pitch_length} ${top_center_gauge_portion} ${pitch_length}'
  #   dy = '${tab_height}'
  #   ix = '15 6 15'
  #   iy = '18'
  # []
  # [move_top_combined_tab]
  #   type = TransformGenerator
  #   input = 'top_tab_rectangles'
  #   transform = TRANSLATE
  #   vector_value = '${fparse -1.0 * pitch_length -0.5 * top_center_gauge_portion} ${fparse top_gauge_height + gauge_transition_height/2.0 + pitch_length} 0'
  # []
  # [stitch_top_shoulders_tab]
  #   type = StitchedMeshGenerator
  #   inputs = 'rename_top_shoulders_top_side move_top_combined_tab'
  #   stitch_boundaries_pairs = 'top_shoulders_top_side bottom'
  # []
  # [rename_top_shoulders_tab]
  #   type = RenameBlockGenerator
  #   input = 'stitch_top_shoulders_tab'
  #   old_block = ' 0'
  #   new_block = '10'
  # []

  # [rename_top_shoulder_bottom_side]
  #   type = SideSetsAroundSubdomainGenerator
  #   input = 'rename_top_full_shoulders'
  #   normal = '0 -1 0'
  #   normal_tol = 1.0e-8
  #   block = 10
  #   new_boundary = 'top_shoulders_bottom_side'
  # []

  # [top_gauge_rectangles]
  #   type = CartesianMeshGenerator
  #   dim = 2
  #   dx = '${top_left_gauge_shoulder} ${top_center_gauge_portion} ${top_right_gauge_shoulder}'
  #   dy = '${top_gauge_height}'
  #   ix = '5 6 5'
  #   iy = '20'
  # []
  # [move_top_gauge]
  #   type = TransformGenerator
  #   input = 'top_gauge_rectangles'
  #   transform = TRANSLATE
  #   vector_value = '${fparse -1.0 * top_left_gauge_shoulder - 0.5 * top_center_gauge_portion} ${fparse 0.5 * gauge_transition_height} 0'
  # []
  # [stitch_top_shoulders_gauge]
  #   type = StitchedMeshGenerator
  #   inputs = 'rename_top_shoulder_bottom_side move_top_gauge'
  #   stitch_boundaries_pairs = 'top_shoulders_bottom_side top'
  #   show_info = true
  # []
[]
