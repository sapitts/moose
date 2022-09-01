### third approach to the segmented block building of the dogbone
### focus here on stitching together the top, transition, and bottom regions

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
  ######################################
  #### top shoulders and gauge section
  ######################################
  # [upper_left_shoulder]
  #   type = ConcentricCircleMeshGenerator
  #   num_sectors = 20
  #   radii = '${upper_left_radius}'
  #   rings = '1 2'
  #   has_outer_square = true
  #   pitch = '${fparse 2.0 * pitch_length}'
  #   preserve_volumes = false
  #   portion = top_right
  # []
  # [move_upleft_shoulder]
  #   type = TransformGenerator
  #   input = 'upper_left_shoulder'
  #   transform = TRANSLATE
  #   vector_value = '${fparse - 0.5 * gauge_width - upper_left_radius} ${fparse section_gauge_height + gauge_transition_height/2.0} 0'
  # []
  # [top_gauge_rectangles]
  #   type = CartesianMeshGenerator
  #   dim = 2
  #   dx = '${upper_left_radius} ${top_left_gauge_shoulder}' #' ${top_center_gauge_portion} ${top_right_gauge_shoulder}'
  #   dy = '${section_gauge_height}'
  #   ix = '11 3'
  #   iy = '20'
  #   subdomain_id = '21 101'
  # []
  # [move_top_gauge]
  #   type = TransformGenerator
  #   input = 'top_gauge_rectangles'
  #   transform = TRANSLATE
  #   vector_value = '${fparse - 0.5 * gauge_width - upper_left_radius} ${fparse 0.5 * gauge_transition_height} 0'
  # []
  # [stitch_top_shoulders_gauge]
  #   type = StitchedMeshGenerator
  #   inputs = 'move_upleft_shoulder move_top_gauge'
  #   stitch_boundaries_pairs = 'bottom top'
  # []
  # [rename_top_left_shoulders]
  #   type = RenameBlockGenerator
  #   input = 'stitch_top_shoulders_gauge'
  #   old_block = '1 2'
  #   new_block = '11 101'
  # []
  # [rename_top_left_shoulder_centerline]
  #   type = SideSetsAroundSubdomainGenerator
  #   input = 'rename_top_left_shoulders'
  #   normal = '1 0 0'
  #   normal_tol = 1.0e-8
  #   block = '101'
  #   new_boundary = 'top_left_shoulder_centerline'
  # []

  # [top_center_shoulder_gauge]
  #   type = CartesianMeshGenerator
  #   dim = 2
  #   dx = '${top_center_gauge_portion}'
  #   dy = '${section_gauge_height} ${pitch_length}'
  #   ix = '4'
  #   iy = '20 13' # 13'
  #   subdomain_id = '202 202'
  # []
  # [move_top_center_gauge]
  #   type = TransformGenerator
  #   input = 'top_center_shoulder_gauge'
  #   transform = TRANSLATE
  #   vector_value = '${fparse -0.5 * gauge_width + top_left_gauge_shoulder} ${fparse 0.5 * gauge_transition_height} 0'
  # []
  # [rename_top_center_left]
  #   type = SideSetsAroundSubdomainGenerator
  #   input = 'move_top_center_gauge'
  #   normal = '-1 0 0'
  #   normal_tol = '1.0e-8'
  #   block = 202
  #   new_boundary = 'top_center_section_left'
  # []
  # [stitch_top_center_left]
  #   type = StitchedMeshGenerator
  #   # inputs = 'move_upleft_shoulder move_top_center_gauge'
  #   # stitch_boundaries_pairs = 'right left'
  #   inputs = 'rename_top_left_shoulder_centerline rename_top_center_left'
  #   stitch_boundaries_pairs = 'top_left_shoulder_centerline top_center_section_left'
  # []
  # [rename_top_center_right]
  #   type = SideSetsAroundSubdomainGenerator
  #   input = 'stitch_top_center_left'
  #   normal = '1 0 0'
  #   normal_tol = 1.0e-8
  #   block = 202
  #   new_boundary = 'top_center_section_right'
  # []

  # [upper_right_shoulder]
  #   type = ConcentricCircleMeshGenerator
  #   num_sectors = 20
  #   radii = '${upper_right_radius}'
  #   rings = '1 2'
  #   has_outer_square = true
  #   pitch = '${fparse 2.0 * pitch_length}'
  #   preserve_volumes = false
  #   portion = top_left
  # []
  # [move_upright_shoulder]
  #   type = TransformGenerator
  #   input = 'upper_right_shoulder'
  #   transform = TRANSLATE
  #   vector_value = '${fparse 0.5 * gauge_width + upper_right_radius} ${fparse section_gauge_height + gauge_transition_height/2.0} 0'
  # []
  # [top_right_gauge_rectangles]
  #   type = CartesianMeshGenerator
  #   dim = 2
  #   dx = '${top_right_gauge_shoulder} ${upper_right_radius} ' #' ${top_center_gauge_portion} ${top_right_gauge_shoulder}'
  #   dy = '${section_gauge_height}'
  #   ix = '3 11'
  #   iy = '20'
  #   subdomain_id = '102 22'
  # []
  # [move_top_right_gauge]
  #   type = TransformGenerator
  #   input = 'top_right_gauge_rectangles'
  #   transform = TRANSLATE
  #   vector_value = '${fparse 0.5 * gauge_width - top_right_gauge_shoulder} ${fparse 0.5 * gauge_transition_height} 0'
  # []
  # [stitch_top_right_shoulders_gauge]
  #   type = StitchedMeshGenerator
  #   inputs = 'move_upright_shoulder move_top_right_gauge'
  #   stitch_boundaries_pairs = 'bottom top'
  # []
  # [rename_top_right_shoulders]
  #   type = RenameBlockGenerator
  #   input = 'stitch_top_right_shoulders_gauge'
  #   old_block = '1 2'
  #   new_block = '12 102'
  # []
  # [rename_top_right_shoulder_centerline]
  #   type = SideSetsAroundSubdomainGenerator
  #   input = 'rename_top_right_shoulders'
  #   normal = '-1 0 0'
  #   normal_tol = 1.0e-8
  #   block = '102'
  #   new_boundary = 'top_right_shoulder_centerline'
  # []
  # [stitch_top_center_right]
  #   type = StitchedMeshGenerator
  #   inputs = 'rename_top_right_shoulder_centerline rename_top_center_right'
  #   stitch_boundaries_pairs = 'top_right_shoulder_centerline top_center_section_right'
  # []

  # [cleanup_upper_spacer_blocks]
  #   type = BlockDeletionGenerator
  #   input = 'stitch_top_center_right'
  #   block = '21 22'
  # []
  # [rename_top_shoulder_gauge]
  #   type = RenameBlockGenerator
  #   input = 'cleanup_upper_spacer_blocks'
  #   old_block = '101 102 202'
  #   new_block = ' 10  10  10'
  # []
  # [rename_top_shoulder_bottom]
  #   type = SideSetsAroundSubdomainGenerator
  #   input = 'rename_top_shoulder_gauge'
  #   normal = '0.0 -1.0 0.0'
  #   normal_tol = 1.0e-8
  #   block = '10'
  #   new_boundary = 'upper_shoulders_bottom'
  # []

  ########################################
  #### botom shoulders and gauge section
  ########################################

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
    # normal_tol = 1.0e-8
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
    # normal_tol = '1.0e-8'
    block = 204
    new_boundary = 'bottom_center_section_left'
  []
  [stitch_bottom_center_left]
    type = StitchedMeshGenerator
    inputs = 'rename_bottom_left_shoulder_centerline rename_bottom_center_left'
    stitch_boundaries_pairs = 'bottom_left_shoulder_centerline bottom_center_section_left'
  []
  [rename_bottom_center_right]
    type = SideSetsAroundSubdomainGenerator
    # input = 'rename_bottom_center_section'
    input = 'stitch_bottom_center_left'
    normal = '1 0 0'
    # normal_tol = 1.0e-4
    block = 204
    new_boundary = 'bottom_center_section_right'
  []

  [lower_right_shoulder]
    type = ConcentricCircleMeshGenerator
    num_sectors = 20
    radii = '${lower_right_radius}'
    rings = '1 2'
    has_outer_square = true
    pitch = '${fparse 2.0 * pitch_length}'
    preserve_volumes = false
    portion = bottom_left
  []
  [move_downright_shoulder]
    type = TransformGenerator
    input = 'lower_right_shoulder'
    transform = TRANSLATE
    vector_value = '${fparse 0.5 * gauge_width + lower_right_radius} ${fparse -1.0 * section_gauge_height - gauge_transition_height/2.0} 0'
  []
  [bottom_right_gauge_rectangles]
    type = CartesianMeshGenerator
    dim = 2
    dx = '${bottom_right_gauge_shoulder} ${lower_right_radius}'
    dy = '${section_gauge_height}'
    ix = '3 11'
    iy = '20'
    subdomain_id = '103 23'
  []
  [move_bottom_right_gauge]
    type = TransformGenerator
    input = 'bottom_right_gauge_rectangles'
    transform = TRANSLATE
    vector_value = '${fparse 0.5 * gauge_width - bottom_right_gauge_shoulder} ${fparse -1.0 * section_gauge_height - 0.5 * gauge_transition_height} 0'
  []
  [stitch_bottom_right_shoulders_gauge]
    type = StitchedMeshGenerator
    inputs = 'move_downright_shoulder move_bottom_right_gauge'
    stitch_boundaries_pairs = 'top bottom'
  []
  [rename_bottom_right_shoulders]
    type = RenameBlockGenerator
    input = 'stitch_bottom_right_shoulders_gauge'
    old_block = '1 2'
    new_block = '13 103'
  []
  [rename_bottom_right_shoulder_centerline]
    type = SideSetsAroundSubdomainGenerator
    input = 'rename_bottom_right_shoulders'
    normal = '-1 0 0'
    # normal_tol = 1.0e-8
    block = '103'
    new_boundary = 'bottom_right_shoulder_centerline'
  []
  [stitch_bottom_center_right]
    type = StitchedMeshGenerator
    inputs = 'rename_bottom_right_shoulder_centerline rename_bottom_center_right'
    stitch_boundaries_pairs = 'bottom_right_shoulder_centerline bottom_center_section_right'
  []

  [cleanup_lower_spacer_blocks]
    type = BlockDeletionGenerator
    input = 'stitch_bottom_center_right'
    block = '23 24'
  []
  [rename_bottom_shoulder_gauge]
    type = RenameBlockGenerator
    input = 'cleanup_lower_spacer_blocks'
    old_block = '104 204 103'
    new_block = ' 10  10  10'
  []
  [rename_bottom_shoulder_top_side]
    type = SideSetsAroundSubdomainGenerator
    input = 'rename_bottom_shoulder_gauge'
    normal = '0 1 0'
    # normal_tol = 1.0e-8
    block = '10'
    new_boundary = 'lower_shoulders_top'
  []

  # ####################################
  # #### transition region of the gauge
  # ####################################
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
  # [transition_center]
  #   type = TransfiniteMeshGenerator
  #   corners = '${fparse -0.5 * gauge_width + bottom_left_gauge_shoulder} ${fparse -0.5 * gauge_transition_height} 0.0
  #              ${fparse 0.5 * gauge_width - bottom_right_gauge_shoulder} ${fparse -0.5 * gauge_transition_height} 0.0
  #              ${fparse 0.5 * gauge_width - top_right_gauge_shoulder} ${fparse 0.5 * gauge_transition_height} 0
  #              ${fparse -0.5 * gauge_width + top_left_gauge_shoulder} ${fparse 0.5 * gauge_transition_height} 0'
  #   nx = 5
  #   ny = 9
  #   bottom = LINE
  #   top = LINE
  #   right = LINE
  #   left = LINE
  # []
  # [rename_transition_center]
  #   type = RenameBlockGenerator
  #   input = transition_center
  #   old_block = '0'
  #   new_block = '206'
  # []
  # [stitch_left_transition_region]
  #   type = StitchedMeshGenerator
  #   inputs = 'rename_transition_left rename_transition_center'
  #   stitch_boundaries_pairs = 'right left'
  # []

  # [transition_right] #MUST maintain the the same order to have access to the boundary sideset names
  #   type = TransfiniteMeshGenerator
  #   corners = '${fparse 0.5 * gauge_width - bottom_right_gauge_shoulder} ${fparse -0.5 * gauge_transition_height} 0.0
  #              ${fparse 0.5 * gauge_width} ${fparse -0.5 * gauge_transition_height} 0.0
  #              ${fparse 0.5 * gauge_width} ${fparse 0.5 * gauge_transition_height} 0
  #              ${fparse 0.5 * gauge_width - top_right_gauge_shoulder} ${fparse 0.5 * gauge_transition_height} 0'
  #   nx = 4
  #   ny = 9
  #   bottom = LINE
  #   top = LINE
  #   right = LINE
  #   left = LINE
  # []
  # [rename_transition_right]
  #   type = RenameBlockGenerator
  #   input = transition_right
  #   old_block = '0'
  #   new_block = '207'
  # []
  # [stitch_right_transition_region]
  #   type = StitchedMeshGenerator
  #   inputs = 'stitch_left_transition_region rename_transition_right'
  #   stitch_boundaries_pairs = 'right left'
  # []
  # [rename_transition_region]
  #   type = RenameBlockGenerator
  #   input = 'stitch_right_transition_region'
  #   old_block = '205 207'
  #   new_block = '206 206'
  # []
  # [rename_transition_top_sideset]
  #   type = SideSetsAroundSubdomainGenerator
  #   input = 'rename_transition_region'
  #   normal = '0 1 0'
  #   normal_tol = 1.0e-8
  #   block = '206'
  #   new_boundary = 'transition_top'
  # []
  # [stitch_top_transition_region]
  #   type = StitchedMeshGenerator
  #   inputs = 'rename_top_shoulder_bottom rename_transition_top_sideset'
  #   stitch_boundaries_pairs = 'upper_shoulders_bottom transition_top'
  # []

  # [rename_transition_bottom_sideset]
  #   type = SideSetsAroundSubdomainGenerator
  #   input = 'stitch_top_transition_region'
  #   normal = '0 -1 0'
  #   normal_tol = 1.0e-8
  #   block = '206'
  #   new_boundary = 'transition_bottom'
  # []
  # [stitch_bottom_transition_region]
  #   type = StitchedMeshGenerator
  #   inputs = 'rename_transition_bottom_sideset rename_bottom_shoulder_top_side'
  #   stitch_boundaries_pairs = 'transition_bottom lower_shoulders_top'
  # []
  # [rename_shoulder_gauge_whole]
  #   type = RenameBlockGenerator
  #   input = 'stitch_bottom_transition_region'
  #   old_block = '206'
  #   new_block = ' 10'
  # []

  #############################################
  #### add tabs to top and bottom of shoulders
  #############################################
  # [rename_top_shoulder_top_side]
  #   type = SideSetsAroundSubdomainGenerator
  #   input = 'rename_shoulder_gauge_whole'
  #   normal = '0.0 1.0 0.0'
  #   normal_tol = 1.0e-8
  #   block = '1'
  #   new_boundary = 'upper_shoulders_top'
  # []

  # [top_tab]
  #   type = CartesianMeshGenerator
  #   dim = 2
  #   dx = '${pitch_length} ${top_center_gauge_portion} ${pitch_length}'
  #   ix = '13 4 13'
  #   dy = ' ${tab_height}'
  #   iy = '15'
  # []
  # [move_top_tab]
  #   type = TransformGenerator
  #   input = 'top_tab'
  #   transform = TRANSLATE
  #   vector_value = '${fparse -1.0 * pitch_length - 0.5 * top_center_gauge_portion} ${fparse pitch_length + section_gauge_height + 0.5 * gauge_transition_height} 0'
  # []
  # [rename_top_tab]
  #   type = RenameBlockGenerator
  #   input = 'move_top_tab'
  #   old_block = '0'
  #   new_block = '200'
  # []
  # # [rename_top_tab_bottom]
  # #   type = SideSetsAroundSubdomainGenerator
  # #   input = 'rename_top_tab'
  # #   normal = '0 -1 0'
  # #   normal_tol = 1.0e-8
  # #   block = 200
  # #   new_boundary = 'top_tab_bottom'
  # # []
  # [stitch_top_tab]
  #   type = StitchedMeshGenerator
  #   inputs = 'rename_top_shoulder_bottom rename_top_tab'
  #   stitch_boundaries_pairs = 'upper_shoulders_top bottom'
  # []

  # [upleft_shoulder_sideset]
  #   type = SideSetsBetweenSubdomainsGenerator
  #   input = stitch_top_tab
  #   primary_block = 10
  #   paired_block = 11
  #   new_boundary = 'upper_left_shoulder'
  # []
  # [upright_shoulder_sideset]
  #   type = SideSetsBetweenSubdomainsGenerator
  #   input = upleft_shoulder_sideset
  #   primary_block = 10
  #   paired_block = 12
  #   new_boundary = 'upper_right_shoulder'
  # []

  # [delete_shoulder_cutouts]
  #   type = BlockDeletionGenerator
  #   input = 'upright_shoulder_sideset'
  #   block = '11 12 21 22'
  # []

  # [final_single_mesh_block]
  #   type = RenameBlockGenerator
  #   input = 'delete_shoulder_cutouts'
  #   old_block = '10 200'
  #   new_block = ' 0   0'
  # []

[]
