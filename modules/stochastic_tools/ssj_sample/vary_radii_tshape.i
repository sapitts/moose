# attempt to create a dogbone mesh that can interface with the STM

upper_left_radius = 1.2
upper_right_radius = 1.5

gauge_width = 1.2 #1.454 #0.946 #1.2
gauge_height = 5.7 #5.446 #5.954 #5.7

## nominal values
ideal_radius = 1.4
ideal_tab_height = 3.75
ideal_tab_width = 4.0

## computed mesh parameters:
upper_left_tab_width = '${fparse upper_right_radius + gauge_width/2.0}'
upper_right_tab_width = '${fparse upper_right_radius + gauge_width/2.0}'

base_tab_height = '${fparse ideal_tab_height + ideal_radius - gauge_width/2.0}'
upper_left_tab_height = '${fparse base_tab_height - upper_left_radius}'
upper_right_tab_height = '${fparse base_tab_height - upper_right_radius}'

[Mesh]
  [shoulder_upper_left]
    type = ConcentricCircleMeshGenerator
    num_sectors = 20
    radii = '${upper_left_radius}'
    rings = '1 10'
    has_outer_square = true
    pitch = '${fparse 2.0 * upper_left_tab_width}'
    preserve_volumes = false
    portion = top_right
  []
  [move_upleft_shoulder]
    type = TransformGenerator
    input = shoulder_upper_left
    transform = TRANSLATE
    vector_value = '${fparse -1.0 * upper_left_tab_width} ${fparse gauge_height/2.0} 0'
  []
  [rename_cutout_upper_left]
    type = RenameBlockGenerator
    input = 'move_upleft_shoulder'
    old_block = '2 1'
    new_block = '10 12'
  []
  [top_left_tab]
    type = CartesianMeshGenerator
    dim = 2
    dx = ${upper_left_tab_width}
    ix = '21'
    dy = ${upper_left_tab_height}
    iy = '19'
  []
  [move_top_left_tab]
    type = TransformGenerator
    input = top_left_tab
    transform = TRANSLATE
    vector_value = '${fparse -1.0 * upper_left_tab_width} ${fparse gauge_height/2.0 + upper_left_tab_width} 0'
  []
  [rename_top_left_tab]
    type = RenameBlockGenerator
    input = 'move_top_left_tab'
    old_block = '0'
    new_block = '10'
  []
  [stitch_top_left_tab]
    type = StitchedMeshGenerator
    inputs = 'rename_cutout_upper_left rename_top_left_tab'
    stitch_boundaries_pairs = 'top bottom'
    algorithm = EXHAUSTIVE
  []
  [rename_upper_left_centerline]
    type = SideSetsAroundSubdomainGenerator
    input = 'stitch_top_left_tab'
    normal = '1 0 0'
    normal_tol = 1e-8
    block = 10
    new_boundary = 'cl_up_shoulder_left'
  []

  [shoulder_upper_right]
    type = ConcentricCircleMeshGenerator
    num_sectors = 20
    radii = '${upper_right_radius}'
    rings = '1 10'
    has_outer_square = true
    pitch = '${fparse 2.0 * upper_right_tab_width}'
    preserve_volumes = false ## to avoid the seg fault change to true for one of these circles
    portion = top_left
  []
  [move_uprght_shoulder]
    type = TransformGenerator
    input = shoulder_upper_right
    transform = TRANSLATE
    vector_value = '${upper_right_tab_width} ${fparse gauge_height/2.0} 0'
  []
  [rename_cutout_upper_right]
    type = RenameBlockGenerator
    input = 'move_uprght_shoulder'
    old_block = '2 1'
    new_block = '105 11'
  []
  [top_right_tab]
    type = CartesianMeshGenerator
    dim = 2
    dx = ${upper_right_tab_width}
    ix = '21'
    dy = ${upper_right_tab_height}
    iy = '19'
  []
  [move_top_right_tab]
    type = TransformGenerator
    input = top_right_tab
    transform = TRANSLATE
    vector_value = '0 ${fparse gauge_height/2.0 + upper_right_tab_width} 0'
  []
  [rename_top_right_tab]
    type = RenameBlockGenerator
    input = 'move_top_right_tab'
    old_block = '0'
    new_block = '105'
  []
  [stitch_top_right_tab]
    type = StitchedMeshGenerator
    inputs = 'rename_cutout_upper_right rename_top_right_tab'
    stitch_boundaries_pairs = 'top bottom'
    algorithm = EXHAUSTIVE
  []
  [rename_upper_right_centerline]
    type = SideSetsAroundSubdomainGenerator
    input = 'stitch_top_right_tab'
    normal = '-1 0 0'
    normal_tol = 1e-8
    block = '105'
    new_boundary = 'cl_up_shoulder_right'
  []

  [stitch_upper_shoulders]
    type = StitchedMeshGenerator
    inputs = 'rename_upper_left_centerline rename_upper_right_centerline'
    stitch_boundaries_pairs = 'cl_up_shoulder_left cl_up_shoulder_right'
    algorithm = EXHAUSTIVE
  []
  [rename_upper_shoulders]
    type = RenameBlockGenerator
    input = 'stitch_upper_shoulders'
    old_block = '10 105'
    new_block = '10  10'
  []
  [upper_shoulder_interface]
    type = SideSetsAroundSubdomainGenerator
    input = 'rename_upper_shoulders'
    normal = '0 -1 0'
    normal_tol = 1e-8 #seems to work, might be able to pull down more
    block = '10'
    new_boundary = 'upper_shoulder_interface'
  []

  # [gauge_section]
  #   type = CartesianMeshGenerator
  #   dim = 2
  #   dx = ${gauge_width}
  #   ix = '22'
  #   dy = ${gauge_height}
  #   iy = '104'
  # []
  # [rename_gauge]
  #   type = RenameBlockGenerator
  #   input = 'gauge_section'
  #   old_block = '0'
  #   new_block = '100'
  # []
  # [move_gauge]
  #   type = TransformGenerator
  #   input = rename_gauge
  #   transform = TRANSLATE_CENTER_ORIGIN
  # []
  # [rename_top_gauge]
  #   type = RenameBoundaryGenerator
  #   input = move_gauge
  #   old_boundary = 'top'
  #   new_boundary = 'top_gauge_interface'
  # []
  # [stitch_upper_gauge]
  #   type = StitchedMeshGenerator
  #   inputs = 'upper_shoulder_interface rename_top_gauge'
  #   stitch_boundaries_pairs = 'upper_shoulder_interface top_gauge_interface'
  #   algorithm = EXHAUSTIVE
  # []

  # ## Things to include after the mesh has been completely stitched together
  # [rename_sample_bottom]
  #   type = SideSetsAroundSubdomainGenerator
  #   input = 'stitch_lower_tab'
  #   normal = '0 -1 0'
  #   normal_tol = 1e-8 #seems to work, might be able to pull down more
  #   block = 40
  #   replace = true
  #   new_boundary = 'sample_bottom'
  # []
  # [rename_sample_top]
  #   type = SideSetsAroundSubdomainGenerator
  #   input = 'rename_sample_bottom'
  #   normal = '0 1 0'
  #   normal_tol = 1e-8 #seems to work, might be able to pull down more
  #   block = 30
  #   replace = true
  #   new_boundary = 'sample_top'
  # []
  # [rename_sample_block]
  #   type = RenameBlockGenerator
  #   input = 'stitch_upper_gauge'
  #   old_block = '10 100' #'10 20 30 40 100'
  #   new_block = ' 0  0' #  0  0   0'
  # []

  # [upleft_shoulder_sideset]
  #   type = SideSetsBetweenSubdomainsGenerator
  #   input = rename_sample_block
  #   primary_block = 0
  #   paired_block = 12
  #   new_boundary = 'upper_left_shoulder'
  # []
  # [upright_shoulder_sideset]
  #   type = SideSetsBetweenSubdomainsGenerator
  #   input = upleft_shoulder_sideset
  #   primary_block = 0
  #   paired_block = 11
  #   new_boundary = 'upper_right_shoulder'
  # []
  # [delete_shoulder_cutouts]
  #   type = BlockDeletionGenerator
  #   input = 'upright_shoulder_sideset'
  #   block = '11 12' # 23 24'
  # []
[]
