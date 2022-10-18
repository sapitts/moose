## Ideal geometry, BCs, elastic only simulation

## parameters to vary with STM
upper_left_radius = 1.4 #1.3 #1.3 #min 1.146, max 1.654
upper_right_radius = 1.4
lower_left_radius = 1.4 #1.6
lower_right_radius = 1.4 #1.2

gauge_width = 1.2
# min 1.166 (constrained by mesh), max 1.454
gauge_height = 5.7
# min 5.446, max 5.954

rig_gap = 1.5
upper_rig_offset = 0.05 # -0.15 to 0.15
lower_rig_offset = 0.0 # -0.15 to 0.15

sample_thickness = 0.5 #0.5, 0.75, 1.0mm
thickness_elems = 4 # 4 5 6

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
    vector_value = '${fparse - 0.5 * gauge_width - upper_left_radius} ${fparse section_gauge_height + gauge_transition_height/2.0} 0'
  []
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
    dy = '${section_gauge_height} ${pitch_length}'
    ix = '4'
    iy = '20 13' # 13'
    subdomain_id = '202 202'
  []
  [move_top_center_gauge]
    type = TransformGenerator
    input = 'top_center_shoulder_gauge'
    transform = TRANSLATE
    vector_value = '${fparse -0.5 * gauge_width + top_left_gauge_shoulder} ${fparse 0.5 * gauge_transition_height} 0'
  []
  [rename_top_center_left]
    type = SideSetsAroundSubdomainGenerator
    input = 'move_top_center_gauge'
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
    vector_value = '${fparse 0.5 * gauge_width + upper_right_radius} ${fparse section_gauge_height + gauge_transition_height/2.0} 0'
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

  [cleanup_upper_spacer_blocks]
    type = BlockDeletionGenerator
    input = 'stitch_top_center_right'
    block = '21 22'
  []
  [rename_top_shoulder_gauge]
    type = RenameBlockGenerator
    input = 'cleanup_upper_spacer_blocks'
    old_block = '101 102 202'
    new_block = ' 10  10  10'
  []
  [rename_top_shoulder_bottom]
    type = SideSetsAroundSubdomainGenerator
    input = 'rename_top_shoulder_gauge'
    normal = '0.0 -1.0 0.0'
    normal_tol = 1.0e-8
    block = '10'
    new_boundary = 'upper_shoulders_bottom'
  []

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
    normal_tol = 1.0e-8
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
    normal_tol = 1.0e-8
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
    normal_tol = 1.0e-8
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
    normal_tol = 1.0e-8
    block = '10'
    new_boundary = 'lower_shoulders_top'
  []

  # ####################################
  # #### transition region of the gauge
  # ####################################
  [transition_left]
    type = TransfiniteMeshGenerator
    corners = '${fparse -0.5 * gauge_width} ${fparse 0.5 * gauge_transition_height} 0
               ${fparse -0.5 * gauge_width + top_left_gauge_shoulder} ${fparse 0.5 * gauge_transition_height} 0
               ${fparse -0.5 * gauge_width + bottom_left_gauge_shoulder} ${fparse -0.5 * gauge_transition_height} 0.0
               ${fparse -0.5 * gauge_width} ${fparse -0.5 * gauge_transition_height} 0.0'
    nx = 4
    ny = 9
    bottom_type = LINE
    top_type = LINE
    right_type = LINE
    left_type = LINE
  []
  [rename_transition_left]
    type = RenameBlockGenerator
    input = transition_left
    old_block = '0'
    new_block = '205'
  []
  [transition_center]
    type = TransfiniteMeshGenerator
    corners = '${fparse -0.5 * gauge_width + top_left_gauge_shoulder} ${fparse 0.5 * gauge_transition_height} 0
               ${fparse 0.5 * gauge_width - top_right_gauge_shoulder} ${fparse 0.5 * gauge_transition_height} 0
               ${fparse 0.5 * gauge_width - bottom_right_gauge_shoulder} ${fparse -0.5 * gauge_transition_height} 0.0
               ${fparse -0.5 * gauge_width + bottom_left_gauge_shoulder} ${fparse -0.5 * gauge_transition_height} 0.0'
    nx = 5
    ny = 9
    bottom_type = LINE
    top_type = LINE
    right_type = LINE
    left_type = LINE
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

  [transition_right] #MUST maintain the the same order to have access to the boundary sideset names
    type = TransfiniteMeshGenerator
    corners = '${fparse 0.5 * gauge_width - top_right_gauge_shoulder} ${fparse 0.5 * gauge_transition_height} 0
               ${fparse 0.5 * gauge_width} ${fparse 0.5 * gauge_transition_height} 0
               ${fparse 0.5 * gauge_width} ${fparse -0.5 * gauge_transition_height} 0.0
               ${fparse 0.5 * gauge_width - bottom_right_gauge_shoulder} ${fparse -0.5 * gauge_transition_height} 0.0'
    nx = 4
    ny = 9
    bottom_type = LINE
    top_type = LINE
    right_type = LINE
    left_type = LINE
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
    inputs = 'rename_top_shoulder_bottom rename_transition_top_sideset'
    stitch_boundaries_pairs = 'upper_shoulders_bottom transition_top'
  []

  [rename_transition_bottom_sideset]
    type = SideSetsAroundSubdomainGenerator
    input = 'stitch_top_transition_region'
    normal = '0 -1 0'
    normal_tol = 1.0e-8
    block = '206'
    new_boundary = 'transition_bottom'
  []
  [stitch_bottom_transition_region]
    type = StitchedMeshGenerator
    inputs = 'rename_transition_bottom_sideset rename_bottom_shoulder_top_side'
    stitch_boundaries_pairs = 'transition_bottom lower_shoulders_top'
  []
  [rename_shoulder_gauge_whole]
    type = RenameBlockGenerator
    input = 'stitch_bottom_transition_region'
    old_block = '206'
    new_block = ' 10'
  []

  #############################################
  #### add tabs to top and bottom of shoulders
  #############################################
  [rename_top_shoulder_top_side]
    type = SideSetsAroundSubdomainGenerator
    input = 'rename_shoulder_gauge_whole'
    normal = '0.0 1.0 0.0'
    normal_tol = 1.0e-8
    block = '10'
    new_boundary = 'upper_shoulders_top'
  []

  [top_tab]
    type = CartesianMeshGenerator
    dim = 2
    dx = '${pitch_length} ${top_center_gauge_portion} ${pitch_length}'
    ix = '13 4 13'
    dy = ' ${tab_height}'
    iy = '15'
  []
  [move_top_tab]
    type = TransformGenerator
    input = 'top_tab'
    transform = TRANSLATE
    vector_value = '${fparse - 0.5 * gauge_width - upper_left_radius} ${fparse pitch_length + section_gauge_height + 0.5 * gauge_transition_height} 0'
  []
  [rename_top_tab]
    type = RenameBlockGenerator
    input = 'move_top_tab'
    old_block = '0'
    new_block = '200'
  []
  [rename_top_tab_bottom]
    type = SideSetsAroundSubdomainGenerator
    input = 'rename_top_tab'
    normal = '0 -1 0'
    normal_tol = 1.0e-8
    block = 200
    new_boundary = 'top_tab_bottom'
  []
  [stitch_top_tab]
    type = StitchedMeshGenerator
    inputs = 'rename_top_shoulder_top_side rename_top_tab_bottom'
    stitch_boundaries_pairs = 'upper_shoulders_top top_tab_bottom'
  []

  [rename_bottom_shoulder_bottom_side]
    type = SideSetsAroundSubdomainGenerator
    input = 'stitch_top_tab'
    normal = '0 -1 0'
    normal_tol = 1.0e-8
    block = '10'
    new_boundary = 'lower_shoulders_bottom'
  []
  [bottom_tab]
    type = CartesianMeshGenerator
    dim = 2
    dx = '${pitch_length} ${bottom_center_gauge_portion} ${pitch_length}'
    ix = '13 4 13'
    dy = ' ${tab_height}'
    iy = '15'
  []
  [move_bottom_tab]
    type = TransformGenerator
    input = 'bottom_tab'
    transform = TRANSLATE
    vector_value = '${fparse - 0.5 * gauge_width - lower_left_radius} ${fparse -1.0 * tab_height - pitch_length - section_gauge_height - 0.5 * gauge_transition_height} 0'
  []
  [rename_bottom_tab]
    type = RenameBlockGenerator
    input = 'move_bottom_tab'
    old_block = '0'
    new_block = '210'
  []
  [rename_bottom_tab_top]
    type = SideSetsAroundSubdomainGenerator
    input = 'rename_bottom_tab'
    normal = '0 1 0'
    normal_tol = 1.0e-8
    block = 210
    new_boundary = 'bottom_tab_top'
  []
  [stitch_bottom_tab]
    type = StitchedMeshGenerator
    inputs = 'rename_bottom_shoulder_bottom_side rename_bottom_tab_top'
    stitch_boundaries_pairs = 'lower_shoulders_bottom bottom_tab_top'
  []

  #############################################
  #### add BC sidesets, mesh clean up
  #############################################
  [delete_shoulder_cutouts]
    type = BlockDeletionGenerator
    input = 'stitch_bottom_tab'
    # input = 'downright_shoulder_sideset'
    block = '11 12 13 14'
  []
  [final_single_mesh_block]
    type = RenameBlockGenerator
    input = 'delete_shoulder_cutouts'
    old_block = '10 200 210'
    new_block = ' 0   0   0'
  []
  [smoothed_final]
    type = SmoothMeshGenerator
    input = final_single_mesh_block
    iterations = 20
  []
  [extruder]
    type = MeshExtruderGenerator
    input = smoothed_final
    extrusion_vector = '0 0 ${sample_thickness}'
    num_layers = ${thickness_elems}
    bottom_sideset = 'back'
    top_sideset = 'front'
  []

  [downleft_shoulder_sideset]
    type = ParsedGenerateSideset
    # input = 'smoothed_final'
    input = extruder
    combinatorial_geometry = 'x<=(${fparse -0.5 * rig_gap + (lower_rig_offset)}) & abs((x-(${fparse -0.5 * gauge_width - lower_left_radius}))^2+(y-(${fparse -0.5*gauge_height}))^2-(${lower_left_radius})^2)<1e-2'
    new_sideset_name = 'lower_left_shoulder'
  []
  [downright_shoulder_sideset]
    type = ParsedGenerateSideset
    # input = 'extruder'
    input = downleft_shoulder_sideset
    # combinatorial_geometry = 'abs((x-(${fparse 0.5 * gauge_width + lower_right_radius}))^2+(y-(${fparse -0.5*gauge_height}))^2-(${lower_right_radius})^2)<1e-2'
    combinatorial_geometry = 'x>=(${fparse 0.5 * rig_gap + (lower_rig_offset)}) & abs((x-(${fparse 0.5 * gauge_width + lower_right_radius}))^2+(y-(${fparse -0.5*gauge_height}))^2-(${lower_right_radius})^2)<1e-2'
    new_sideset_name = 'lower_right_shoulder'
  []
  [upleft_shoulder_sideset]
    type = ParsedGenerateSideset
    input = 'downright_shoulder_sideset'
    combinatorial_geometry = 'x<=(${fparse -0.5 * rig_gap + (upper_rig_offset)}) & abs((x-(${fparse -0.5 * gauge_width - upper_left_radius}))^2+(y-(${fparse 0.5*gauge_height}))^2-(${upper_left_radius})^2)<1e-2'
    new_sideset_name = 'upper_left_shoulder'
  []
  [upright_shoulder_sideset]
    type = ParsedGenerateSideset
    input = 'upleft_shoulder_sideset'
    # combinatorial_geometry = 'abs((x-(${fparse 0.5 * gauge_width + lower_right_radius}))^2+(y-(${fparse -0.5*gauge_height}))^2-(${lower_right_radius})^2)<1e-2'
    combinatorial_geometry = 'x>=(${fparse 0.5 * rig_gap + (lower_rig_offset)}) & abs((x-(${fparse 0.5 * gauge_width + upper_right_radius}))^2+(y-(${fparse 0.5*gauge_height}))^2-(${upper_right_radius})^2)<1e-2'
    new_sideset_name = 'upper_right_shoulder'
  []

[]

[GlobalParams]
  displacements = 'disp_x disp_y disp_z'
[]

[BCs]
  [zero_displacements_y]
    type = ADDirichletBC
    variable = disp_y
    boundary = 'lower_left_shoulder lower_right_shoulder'
    value = 0.0
  []
  [zero_displacements_z]
    type = ADDirichletBC
    variable = disp_z
    boundary = 'lower_left_shoulder lower_right_shoulder upper_left_shoulder upper_right_shoulder'
    value = 0.0
  []
  [tensile_displacement]
    type = ADFunctionDirichletBC
    variable = disp_y
    boundary = 'upper_left_shoulder upper_right_shoulder'
    function = '0.08*t'
  []
[]

[Modules/TensorMechanics/Master]
  [all]
    strain = FINITE
    incremental = true
    add_variables = true
    generate_output = 'stress_xx stress_yy stress_xy stress_yz stress_zx stress_zz strain_xx strain_yy strain_zz strain_xy vonmises_stress'
    use_automatic_differentiation = true
  []
[]

[Materials]
  [elasticity_tensor]
    type = ADComputeIsotropicElasticityTensor
    youngs_modulus = 9.24e4 #in MPa
    poissons_ratio = 0.363
  []
  [elastic_stress]
    type = ADComputeFiniteStrainElasticStress
  []
  # [radial_return_stress]
  #   type = ADComputeMultipleInelasticStress
  #   inelastic_models = 'power_law_hardening'
  # []
  # [power_law_hardening]
  #   type = ADIsotropicPowerLawHardeningStressUpdate
  #   strength_coefficient = 854 #MPa
  #   strain_hardening_exponent = 0.125 #n
  #   relative_tolerance = 1e-6
  #   absolute_tolerance = 1e-6
  # []
[]

[Preconditioning]
  [smp]
    type = SMP
    full = true
  []
[]

[Executioner]
  type = Transient
  solve_type = 'NEWTON'

  petsc_options_iname = '-pc_type -pc_factor_mat_solver_package' # -pc_factor_shift_type -pc_factor_shift_amount'
  petsc_options_value = ' lu       superlu_dist' #                  NONZERO 1e-15'
  line_search = 'none'

  # [TimeStepper]
  #   type = IterationAdaptiveDT
  #   dt = 0.1
  #   optimal_iterations = 8
  #   iteration_window = 2
  # []
  dt = 0.1
  dtmin = 1e-6
  end_time = 10
  nl_max_its = 30
  nl_rel_tol = 1e-6
  nl_abs_tol = 1e-6
[]

[Outputs]
  csv = true
  exodus = true
[]

[Postprocessors]
  [p1_vonmises_stress]
    type = PointValue
    variable = vonmises_stress
    point = '0 ${fparse 0.5 * gauge_height + 1.4} ${fparse sample_thickness/2.0}'
  []
  [p2_vonmises_stress]
    type = PointValue
    variable = vonmises_stress
    point = '0 ${fparse 0.5 * gauge_height} ${fparse sample_thickness/2.0}'
  []
  [p3_vonmises_stress]
    type = PointValue
    variable = vonmises_stress
    point = '0 ${fparse 0.25 * gauge_height} ${fparse sample_thickness/2.0}'
  []
  [p4_vonmises_stress]
    type = PointValue
    variable = vonmises_stress
    point = '${fparse -0.5*gauge_width} 0 ${fparse sample_thickness/2.0}'
  []
  [p5_vonmises_stress]
    type = PointValue
    variable = vonmises_stress
    point = '0 0 ${fparse sample_thickness/2.0}'
  []
  [p6_vonmises_stress]
    type = PointValue
    variable = vonmises_stress
    point = '${fparse 0.5*gauge_width} 0 ${fparse sample_thickness/2.0}'
  []
  [p7_vonmises_stress]
    type = PointValue
    variable = vonmises_stress
    point = '0 ${fparse -0.25 * gauge_height} ${fparse sample_thickness/2.0}'
  []
  [p8_vonmises_stress]
    type = PointValue
    variable = vonmises_stress
    point = '0 ${fparse -0.5 * gauge_height} ${fparse sample_thickness/2.0}'
  []
  [p9_vonmises_stress]
    type = PointValue
    variable = vonmises_stress
    point = ' 0 ${fparse -0.5 * gauge_height = 1.4} ${fparse sample_thickness/2.0}'
  []

  [max_vonmises_stress]
    type = ElementExtremeValue
    variable = vonmises_stress
    value_type = max
  []
[]
