## MWE for dbg assert with stitched mesh

## parameters to vary with STM
upper_left_radius = 1.3 #min 1.146, max 1.654
upper_right_radius = 1.4
lower_left_radius = 1.6
lower_right_radius = 1.2

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

  ########################################
  ##   bottom shoulders and gauge section
  #######################################

  [lower_left_shoulder]
    type = ConcentricCircleMeshGenerator
    num_sectors = 20
    radii = '${lower_left_radius}'
    rings = '1 2'
    has_outer_square = true
    pitch = '${fparse 2.0 * pitch_length}'
    preserve_volumes = false
    portion = bottom_right
  []
  [move_downleft_shoulder]
    type = TransformGenerator
    input = 'lower_left_shoulder'
    transform = TRANSLATE
    vector_value = '${fparse - 0.5 * gauge_width - lower_left_radius} ${fparse -1.0 * section_gauge_height - gauge_transition_height/2.0} 0'
  []
  [bottom_gauge_rectangles]
    type = CartesianMeshGenerator
    dim = 2
    dx = '${lower_left_radius} ${bottom_left_gauge_shoulder}'
    dy = '${section_gauge_height}'
    ix = '11 3'
    iy = '20'
    subdomain_id = '24 104'
  []
  [move_bottom_gauge]
    type = TransformGenerator
    input = 'bottom_gauge_rectangles'
    transform = TRANSLATE
    vector_value = '${fparse - 0.5 * gauge_width - lower_left_radius} ${fparse -1.0 * section_gauge_height - 0.5 * gauge_transition_height} 0'
  []
  [stitch_left_bottom_shoulders_gauge]
    type = StitchedMeshGenerator
    inputs = 'move_downleft_shoulder move_bottom_gauge'
    stitch_boundaries_pairs = 'top bottom'
  []
  [rename_bottom_left_shoulders]
    type = RenameBlockGenerator
    input = 'stitch_left_bottom_shoulders_gauge'
    old_block = '1 2'
    new_block = '14 104'
  []
  [rename_bottom_left_shoulder_centerline]
    type = SideSetsAroundSubdomainGenerator
    input = 'rename_bottom_left_shoulders'
    normal = '1 0 0'
    normal_tol = 1.0e-8
    block = '104'
    new_boundary = 'bottom_left_shoulder_centerline'
  []

  [bottom_center_shoulder_gauge]
    type = CartesianMeshGenerator
    dim = 2
    dx = '${bottom_center_gauge_portion}'
    dy = '${pitch_length} ${section_gauge_height}'
    ix = '4'
    iy = '13 20'
    subdomain_id = '204 204'
  []
  [move_bottom_center_gauge]
    type = TransformGenerator
    input = 'bottom_center_shoulder_gauge'
    transform = TRANSLATE
    vector_value = '${fparse -0.5 * gauge_width + bottom_left_gauge_shoulder} ${fparse -1.0 * section_gauge_height - pitch_length - 0.5 * gauge_transition_height} 0'
  []
  [rename_bottom_center_left]
    type = SideSetsAroundSubdomainGenerator
    input = 'move_bottom_center_gauge'
    normal = '-1 0 0'
    normal_tol = '1.0e-8'
    block = 204
    new_boundary = 'bottom_center_section_left'
  []
  [stitch_bottom_center_left]
    type = StitchedMeshGenerator
    inputs = 'rename_bottom_left_shoulder_centerline rename_bottom_center_left'
    stitch_boundaries_pairs = 'bottom_left_shoulder_centerline bottom_center_section_left'
  []
[]
