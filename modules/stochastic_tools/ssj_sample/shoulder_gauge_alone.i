### focus on just the shoulder section attaching to the gauge length

## parameters to vary with STM
upper_left_radius = 1.4 #min 1.146, max 1.654
upper_right_radius = 1.4

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
top_gauge_height = '${fparse (gauge_height - gauge_transition_height)/ 2.0}'

[Mesh]
  [upper_left_shoulder]
    type = ConcentricCircleMeshGenerator
    num_sectors = 20
    radii = '${upper_left_radius}'
    rings = '1 2'
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
  [top_gauge_rectangles]
    type = CartesianMeshGenerator
    dim = 2
    dx = '${upper_left_radius} ${top_left_gauge_shoulder}' #' ${top_center_gauge_portion} ${top_right_gauge_shoulder}'
    dy = '${top_gauge_height}'
    ix = '11 3'
    iy = '20'
    subdomain_id = '21 101'
  []
  [move_top_gauge]
    type = TransformGenerator
    input = 'top_gauge_rectangles'
    transform = TRANSLATE
    vector_value = '${fparse -1.0 * pitch_length - 0.5 * top_center_gauge_portion} ${fparse 0.5 * gauge_transition_height} 0'
  []
  [stitch_top_shoulders_gauge]
    type = StitchedMeshGenerator
    inputs = 'move_upleft_shoulder move_top_gauge'
    stitch_boundaries_pairs = 'bottom top'
  []
  [rename_top_left_shoulders]
    type = RenameBlockGenerator
    input = 'stitch_top_shoulders_gauge'
    old_block = '1 2'
    new_block = '11 101'
  []
  [rename_top_left_shoulder_centerline]
    type = SideSetsAroundSubdomainGenerator
    input = 'rename_top_left_shoulders'
    normal = '1 0 0'
    normal_tol = 1.0e-8
    block = '101'
    new_boundary = 'top_left_shoulder_centerline'
  []

  [top_center_shoulder_gauge]
    type = CartesianMeshGenerator
    dim = 2
    dx = '${top_center_gauge_portion}'
    dy = '${top_gauge_height} ${pitch_length}'
    ix = '4'
    iy = '20 13' # 13'
  []
  [move_top_center_gauge]
    type = TransformGenerator
    input = 'top_center_shoulder_gauge'
    transform = TRANSLATE
    # vector_value = '${fparse -0.5 * top_center_gauge_portion} ${fparse top_gauge_height + gauge_transition_height/2.0} 0'
    vector_value = '${fparse -0.5 * top_center_gauge_portion} ${fparse 0.5 * gauge_transition_height} 0'
  []
  [rename_top_center_section]
    type = RenameBlockGenerator
    input = move_top_center_gauge
    old_block = '0'
    new_block = '202'
  []
  [rename_top_center_left]
    type = SideSetsAroundSubdomainGenerator
    input = 'rename_top_center_section'
    normal = '-1 0 0'
    normal_tol = '1.0e-8'
    block = 202
    new_boundary = 'top_center_section_left'
  []
  [stitch_top_center_left]
    type = StitchedMeshGenerator
    # inputs = 'move_upleft_shoulder move_top_center_gauge'
    # stitch_boundaries_pairs = 'right left'
    inputs = 'rename_top_left_shoulder_centerline rename_top_center_left'
    stitch_boundaries_pairs = 'top_left_shoulder_centerline top_center_section_left'
  []
  [rename_top_center_right]
    type = SideSetsAroundSubdomainGenerator
    input = 'stitch_top_center_left'
    normal = '1 0 0'
    normal_tol = 1.0e-8
    block = 202
    new_boundary = 'top_center_section_right'
  []

  [upper_right_shoulder]
    type = ConcentricCircleMeshGenerator
    num_sectors = 20
    radii = '${upper_right_radius}'
    rings = '1 2'
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
  [top_right_gauge_rectangles]
    type = CartesianMeshGenerator
    dim = 2
    dx = '${top_right_gauge_shoulder} ${upper_right_radius} ' #' ${top_center_gauge_portion} ${top_right_gauge_shoulder}'
    dy = '${top_gauge_height}'
    ix = '3 11'
    iy = '20'
    subdomain_id = '102 22'
  []
  [move_top_right_gauge]
    type = TransformGenerator
    input = 'top_right_gauge_rectangles'
    transform = TRANSLATE
    # vector_value = '${fparse -1.0 * top_left_gauge_shoulder - 0.5 * top_center_gauge_portion} ${fparse 0.5 * gauge_transition_height} 0'
    vector_value = '${fparse 0.5 * top_center_gauge_portion} ${fparse 0.5 * gauge_transition_height} 0'
  []
  [stitch_top_right_shoulders_gauge]
    type = StitchedMeshGenerator
    inputs = 'move_upright_shoulder move_top_right_gauge'
    stitch_boundaries_pairs = 'bottom top'
  []
  [rename_top_right_shoulders]
    type = RenameBlockGenerator
    input = 'stitch_top_right_shoulders_gauge'
    old_block = '1 2'
    new_block = '12 102'
  []
  [rename_top_right_shoulder_centerline]
    type = SideSetsAroundSubdomainGenerator
    input = 'rename_top_right_shoulders'
    normal = '-1 0 0'
    normal_tol = 1.0e-8
    block = '102'
    new_boundary = 'top_right_shoulder_centerline'
  []
  [stitch_top_center_right]
    type = StitchedMeshGenerator
    inputs = 'rename_top_right_shoulder_centerline rename_top_center_right'
    stitch_boundaries_pairs = 'top_right_shoulder_centerline top_center_section_right'
  []

  [rename_top_shoulder_gauge]
    type = RenameBlockGenerator
    input = 'stitch_top_center_right'
    old_block = '101 102 202'
    new_block = ' 10  10  10'
  []
  # [rename_top_shoulder_bottom_side]
  #   type = SideSetsAroundSubdomainGenerator
  #   input = 'move_upleft_shoulder'
  #   normal = '0 -1 0'
  #   normal_tol = 1.0e-8
  #   block = ' 1 2'
  #   new_boundary = 'upper_shoulders_bottom'
  # []

  [upleft_shoulder_sideset]
    type = SideSetsBetweenSubdomainsGenerator
    input = rename_top_shoulder_gauge
    primary_block = 10
    paired_block = 11
    new_boundary = 'upper_left_shoulder'
  []
  [upright_shoulder_sideset]
    type = SideSetsBetweenSubdomainsGenerator
    input = upleft_shoulder_sideset
    primary_block = 10
    paired_block = 12
    new_boundary = 'upper_right_shoulder'
  []

  [delete_shoulder_cutouts]
    type = BlockDeletionGenerator
    input = 'upright_shoulder_sideset'
    block = '11 12 21 22'
  []

[]
