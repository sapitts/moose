# attempt to create a dogbone mesh that can interface with the STM

tab_width = 4.0
tab_height = 3.75
ideal_radius = 1.4
gauge_width = 1.2
gauge_height = 5.7

[Mesh]
  [shoulder_upper_left]
    type = ConcentricCircleMeshGenerator
    num_sectors = 20
    radii = '${ideal_radius}'
    rings = '1 10'
    has_outer_square = true
    pitch = '${fparse gauge_width + 2.0 * ideal_radius}'
    preserve_volumes = true
    portion = top_right
  []
  [rename_upper_left]
    type = RenameBoundaryGenerator
    input = shoulder_upper_left
    old_boundary = 'right'
    new_boundary = 'cl_up_shoulder_left'
  []
  [shoulder_upper_right]
    type = ConcentricCircleMeshGenerator
    num_sectors = 20
    radii = '${ideal_radius}'
    rings = '1 10'
    has_outer_square = true
    pitch = '${fparse gauge_width + 2.0 * ideal_radius}'
    preserve_volumes = true
    portion = top_left
  []
  [move_uprght_shoulder]
    type = TransformGenerator
    input = shoulder_upper_right
    transform = TRANSLATE
    # vector_value = '${fparse gauge_width*2.0 + ideal_radius} 0 0'
    vector_value = '${fparse tab_width} 0 0'
  []
  [rename_upper_right]
    type = RenameBoundaryGenerator
    input = move_uprght_shoulder
    old_boundary = 'left'
    new_boundary = 'cl_up_shoulder_right'
  []
  [stitch_upper_shoulders]
    type = StitchedMeshGenerator
    inputs = 'rename_upper_left rename_upper_right'
    stitch_boundaries_pairs = 'cl_up_shoulder_left cl_up_shoulder_right'
  []

  # [delete]
  #   type = BlockDeletionGenerator
  #   input = stitch_upper_shoulders
  #   block = '1'
  # []
[]
