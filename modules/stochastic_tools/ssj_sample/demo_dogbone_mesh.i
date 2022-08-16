# attempt to create a dogbone mesh that can interface with the STM

tab_width = 4.0
tab_height = 3.75
ideal_radius = 1.4
gauge_width = 1.2
gauge_height = 5.7

[Mesh]
  [shoulder_upper_left]
    type = ConcentricCircleMeshGenerator
    num_sectors = 10
    radii = '${ideal_radius}'
    rings = '1'
    has_outer_square = false
    preserve_volumes = true
    portion = top_right
  []
  [shoulder_upper_right]
    type = ConcentricCircleMeshGenerator
    num_sectors = 10
    radii = '${ideal_radius}'
    rings = '1'
    has_outer_square = false
    preserve_volumes = true
    portion = top_left
  []
  [shoulder_lower_left]
    type = ConcentricCircleMeshGenerator
    num_sectors = 10
    radii = '${ideal_radius}'
    rings = '1'
    has_outer_square = false
    preserve_volumes = true
    portion = bottom_right
  []
  [shoulder_lower_right]
    type = ConcentricCircleMeshGenerator
    num_sectors = 10
    radii = '${ideal_radius}'
    rings = '1'
    has_outer_square = false
    preserve_volumes = true
    portion = bottom_left
  []
  [combine_meshes]
    type = CombinerGenerator
    inputs = 'shoulder_upper_left shoulder_upper_right shoulder_lower_left shoulder_lower_right'
    positions = '0 10.85 0 ${tab_width} 10.85 0 0 5.15 0 ${tab_width} 5.15 0'
  []

  [combined_rectangles]
    type = CartesianMeshGenerator
    input = disk
    dim = 2
    dx = '${ideal_radius} ${gauge_width} ${ideal_radius}'
    dy = '${tab_height} ${ideal_radius} ${gauge_height} ${ideal_radius} ${tab_height}'
    ix = '5 6 5'
    iy = '12 4 20 4 12'
    subdomain_id = '2 2 2
                    2 2 2
                    3 2 3
                    2 2 2
                    2 2 2'
  []
  [delete_gauge_length]
    type = BlockDeletionGenerator
    input = combined_rectangles
    block = '1 3'
  []
  # [delete_radii]
  #   type = BlockDeletionGenerator
  #   input = 'disk'
  #   block = 3
  # []

[]
