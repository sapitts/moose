### second approach to the segmented block building of the dogbone
### focus here on buiding the top tab and gauge section

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

[Mesh]
  [top_gauge_rectangles]
    type = CartesianMeshGenerator
    dim = 2
    dx = '${upper_left_radius} ${top_left_gauge_shoulder}' #' ${top_center_gauge_portion} ${top_right_gauge_shoulder}'
    dy = '${section_gauge_height}'
    ix = '11 3'
    iy = '20'
    subdomain_id = '21 101'
  []
  [move_top_gauge]
    type = TransformGenerator
    input = 'top_gauge_rectangles'
    transform = TRANSLATE
    vector_value = '${fparse - 0.5 * gauge_width - upper_left_radius} ${fparse 0.5 * gauge_transition_height} 0'
  []
  [rename_top_left_shoulder_centerline]
    type = SideSetsAroundSubdomainGenerator
    input = 'move_top_gauge'
    normal = '1 0 0'
    normal_tol = 1.0e-8
    block = '101'
    new_boundary = 'top_left_shoulder_centerline'
  []

  [top_center_shoulder_gauge]
    type = CartesianMeshGenerator
    dim = 2
    dx = '${top_center_gauge_portion}'
    dy = '${section_gauge_height}' #' ${pitch_length}'
    ix = '4'
    iy = '20' # 13' # 13'
  []
  [move_top_center_gauge]
    type = TransformGenerator
    input = 'top_center_shoulder_gauge'
    transform = TRANSLATE
    vector_value = '${fparse -0.5 * gauge_width + top_left_gauge_shoulder} ${fparse 0.5 * gauge_transition_height} 0'
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
  [top_right_gauge_rectangles]
    type = CartesianMeshGenerator
    dim = 2
    dx = '${top_right_gauge_shoulder} ${upper_right_radius} ' #' ${top_center_gauge_portion} ${top_right_gauge_shoulder}'
    dy = '${section_gauge_height}'
    ix = '3 11'
    iy = '20'
    subdomain_id = '102 22'
  []
  [move_top_right_gauge]
    type = TransformGenerator
    input = 'top_right_gauge_rectangles'
    transform = TRANSLATE
    vector_value = '${fparse 0.5 * gauge_width - top_right_gauge_shoulder} ${fparse 0.5 * gauge_transition_height} 0'
  []
  [rename_top_right_shoulder_centerline]
    type = SideSetsAroundSubdomainGenerator
    input = 'move_top_right_gauge'
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
    old_block = '101 202 102'
    new_block = '202 202 202'
  []
  [delete_top_shoulder_side_blocks]
    type = BlockDeletionGenerator
    input = 'rename_top_shoulder_gauge'
    block = '21 22'
  []
  [rename_top_shoulder_bottom_side]
    type = SideSetsAroundSubdomainGenerator
    input = 'delete_top_shoulder_side_blocks'
    normal = '0 -1 0'
    normal_tol = 1.0e-8
    block = '202'
    new_boundary = 'upper_gauge_section_bottom'
  []

  #################################
  #### bottom section of the gauge
  ################################
  # [bottom_gauge_rectangles]
  #   type = CartesianMeshGenerator
  #   dim = 2
  #   dx = '${lower_left_radius} ${bottom_left_gauge_shoulder}'
  #   dy = '${section_gauge_height}'
  #   ix = '11 3'
  #   iy = '20'
  #   subdomain_id = '24 104'
  # []
  # [move_bottom_gauge]
  #   type = TransformGenerator
  #   input = 'bottom_gauge_rectangles'
  #   transform = TRANSLATE
  #   vector_value = '${fparse -0.5 * gauge_width - lower_left_radius} ${fparse -1.0 * section_gauge_height - 0.5 * gauge_transition_height} 0'
  # []
  # [rename_bottom_left_shoulder_centerline]
  #   type = SideSetsAroundSubdomainGenerator
  #   input = 'move_bottom_gauge'
  #   normal = '1 0 0'
  #   normal_tol = 1.0e-8
  #   block = '104'
  #   new_boundary = 'bottom_left_shoulder_centerline'
  # []
  # [bottom_center_shoulder_gauge]
  #   type = CartesianMeshGenerator
  #   dim = 2
  #   dx = '${bottom_center_gauge_portion}'
  #   dy = '${section_gauge_height}' #'${pitch_length} ${section_gauge_height}'
  #   ix = '4'
  #   iy = '20' #'13 20'
  #   subdomain = '204' #204'
  # []
  # [move_bottom_center_gauge]
  #   type = TransformGenerator
  #   input = 'bottom_center_shoulder_gauge'
  #   transform = TRANSLATE
  #   vector_value = '${fparse -0.5 * gauge_width + bottom_left_gauge_shoulder} ${fparse -1.0 * section_gauge_height - 0.5 * gauge_transition_height} 0'
  # []
  # [rename_bottom_center_section]
  #   type = RenameBlockGenerator
  #   input = move_bottom_center_gauge
  #   old_block = '0'
  #   new_block = '204'
  # []
  # [rename_bottom_center_left]
  #   type = SideSetsAroundSubdomainGenerator
  #   input = 'rename_bottom_center_section'
  #   normal = '-1 0 0'
  #   normal_tol = '1.0e-8'
  #   block = 204
  #   new_boundary = 'bottom_center_section_left'
  # []
  # [stitch_bottom_center_left]
  #   type = StitchedMeshGenerator
  #   inputs = 'rename_bottom_left_shoulder_centerline rename_bottom_center_left'
  #   stitch_boundaries_pairs = 'bottom_left_shoulder_centerline bottom_center_section_left'
  # []
  # [rename_bottom_center_right]
  #   type = SideSetsAroundSubdomainGenerator
  #   input = 'stitch_bottom_center_left'
  #   normal = '1 0 0'
  #   normal_tol = 1.0e-8
  #   block = 204
  #   new_boundary = 'bottom_center_section_right'
  # []

  # [bottom_right_gauge_rectangles]
  #   type = CartesianMeshGenerator
  #   dim = 2
  #   dx = '${bottom_right_gauge_shoulder} ${lower_right_radius}'
  #   dy = '${section_gauge_height}'
  #   ix = '3 11'
  #   iy = '20'
  #   subdomain_id = '103 23'
  # []
  # [move_bottom_right_gauge]
  #   type = TransformGenerator
  #   input = 'bottom_right_gauge_rectangles'
  #   transform = TRANSLATE
  #   vector_value = '${fparse 0.5 * gauge_width - bottom_right_gauge_shoulder} ${fparse -1.0 * section_gauge_height - 0.5 * gauge_transition_height} 0'
  # []
  # [rename_bottom_right_shoulder_centerline]
  #   type = SideSetsAroundSubdomainGenerator
  #   input = 'move_bottom_right_gauge'
  #   normal = '-1 0 0'
  #   normal_tol = 1.0e-8
  #   block = '103'
  #   new_boundary = 'bottom_right_shoulder_centerline'
  # []
  # [stitch_bottom_center_right]
  #   type = StitchedMeshGenerator
  #   inputs = 'rename_bottom_right_shoulder_centerline rename_bottom_center_right'
  #   stitch_boundaries_pairs = 'bottom_right_shoulder_centerline bottom_center_section_right'
  # []
  # [rename_bottom_shoulder_gauge]
  #   type = RenameBlockGenerator
  #   input = 'stitch_bottom_center_right'
  #   old_block = '104 204 103'
  #   new_block = '204 204 204'
  # []
  # [delete_bottom_shoulder_side_blocks]
  #   type = BlockDeletionGenerator
  #   input = 'rename_bottom_shoulder_gauge'
  #   block = '24 23'
  # []
  # [rename_bottom_shoulder_top_side]
  #   type = SideSetsAroundSubdomainGenerator
  #   input = 'delete_bottom_shoulder_side_blocks'
  #   normal = '0 1 0'
  #   normal_tol = 1.0e-8
  #   block = '204'
  #   new_boundary = 'lower_gauge_section_top'
  # []
  # [stitch_gauge_sections]
  #   type = StitchedMeshGenerator
  #   inputs = 'rename_top_shoulder_bottom_side rename_bottom_shoulder_top_side'
  #   stitch_boundaries_pairs = 'upper_gauge_section_bottom lower_gauge_section_top'
  # []

  ####################################
  #### transition region of the gauge
  ####################################
  [transition_left]
    type = TransfiniteMeshGenerator
    corners = '${fparse -0.5 * gauge_width} ${fparse -0.5 * gauge_transition_height} 0.0
               ${fparse -0.5 * gauge_width + bottom_left_gauge_shoulder} ${fparse -0.5 * gauge_transition_height} 0.0
               ${fparse -0.5 * gauge_width + top_left_gauge_shoulder} ${fparse 0.5 * gauge_transition_height} 0
               ${fparse -0.5 * gauge_width} ${fparse 0.5 * gauge_transition_height} 0'
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
  [stitch_left_transition_region]
    type = StitchedMeshGenerator
    inputs = 'rename_transition_left rename_transition_center'
    stitch_boundaries_pairs = 'right left'
  []

  [transition_right]
    type = TransfiniteMeshGenerator
    corners = '${fparse 0.5 * gauge_width} ${fparse -0.5 * gauge_transition_height} 0.0
               ${fparse 0.5 * gauge_width - bottom_right_gauge_shoulder} ${fparse -0.5 * gauge_transition_height} 0.0
               ${fparse 0.5 * gauge_width - top_right_gauge_shoulder} ${fparse 0.5 * gauge_transition_height} 0
               ${fparse 0.5 * gauge_width} ${fparse 0.5 * gauge_transition_height} 0'
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
    inputs = 'stitch_left_transition_region rename_transition_right'
    stitch_boundaries_pairs = 'right left'
  []
  [rename_transition_region]
    type = RenameBlockGenerator
    input = 'stitch_right_transition_region'
    old_block = '205 207'
    new_block = '206 206'
  []
  [rename_transition_top_sideset]
    type = SideSetsAroundSubdomainGenerator
    input = 'rename_transition_region'
    normal = '0 1 0'
    normal_tol = 1.0e-8
    block = '206'
    new_boundary = 'transition_top'
  []
  [stitch_top_transition_region]
    type = StitchedMeshGenerator
    inputs = 'rename_top_shoulder_bottom_side rename_transition_top_sideset'
    stitch_boundaries_pairs = 'upper_gauge_section_bottom transition_top'
  []
  # [rename_transition_bottom_sideset]
  #   type = SideSetsAroundSubdomainGenerator
  #   input = 'rename_transition_top_sideset'
  #   normal = '0 -1 0'
  #   normal_tol = 1.0e-8
  #   block = '206'
  #   new_boundary = 'transition_bottom'
  # []
  # [stitch_bottom_transition_region]
  #   type = StitchedMeshGenerator
  #   inputs = 'rename_transition_bottom_sideset rename_bottom_shoulder_top_side'
  #   stitch_boundaries_pairs = 'transition_bottom lower_gauge_section_top'
  # []

  # ### this will need to be one of the last steps, since it requires
  # ### merging of the sections of the gauge and shoulder regions
  # ## add the tab on bottom
  # [rename_bottom_shoulder_gauge]
  #   type = RenameBlockGenerator
  #   input = 'stitch_bottom_center_right'
  #   old_block = '104 204 103'
  #   new_block = ' 10  10  10'
  # []

  # [delete_shoulder_cutouts]
  #   type = BlockDeletionGenerator
  #   input = 'downright_shoulder_sideset'
  #   block = '13 14 23 24' #'11 12 21 22'
  # []
  # [final_single_mesh_block]
  #   type = RenameBlockGenerator
  #   input = 'delete_shoulder_cutouts'
  #   old_block = '10 210'
  #   new_block = ' 0   0'
  # []
  # final_generator = stitch_bottom_transition_region
[]
