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
  [move_upleft_shoulder]
    type = TransformGenerator
    input = shoulder_upper_left
    transform = TRANSLATE
    vector_value = '0 ${fparse tab_height + ideal_radius + gauge_height} 0'
  []
  [rename_upper_left]
    type = RenameBoundaryGenerator
    input = move_upleft_shoulder
    old_boundary = 'right'
    new_boundary = 'cl_up_shoulder_left'
  []
  [rename_cutout_upper_left]
    type = RenameBlockGenerator
    input = 'rename_upper_left'
    old_block = '2 1'
    new_block = '10 12'
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
    vector_value = '${fparse tab_width} ${fparse tab_height + ideal_radius + gauge_height} 0'
  []
  [rename_upper_right]
    type = RenameBoundaryGenerator
    input = move_uprght_shoulder
    old_boundary = 'left'
    new_boundary = 'cl_up_shoulder_right'
  []
  [rename_cutout_upper_right]
    type = RenameBlockGenerator
    input = 'rename_upper_right'
    old_block = '2 1'
    new_block = '10 11'
  []
  [stitch_upper_shoulders]
    type = StitchedMeshGenerator
    inputs = 'rename_cutout_upper_left rename_cutout_upper_right'
    stitch_boundaries_pairs = 'cl_up_shoulder_left cl_up_shoulder_right'
  []
  [upper_shoulder_interface]
    type = SideSetsAroundSubdomainGenerator
    input = 'stitch_upper_shoulders'
    normal = '0 -1 0'
    normal_tol = 1e-8 #seems to work, might be able to pull down more
    block = 10
    new_boundary = 'upper_shoulder_interface'
  []

  [gauge_section]
    type = CartesianMeshGenerator
    dim = 2
    dx = ${gauge_width}
    ix = '22'
    dy = ${gauge_height}
    iy = '104'
  []
  [rename_gauge]
    type = RenameBlockGenerator
    input = 'gauge_section'
    old_block = '0'
    new_block = '100'
  []
  [move_gauge]
    type = TransformGenerator
    input = rename_gauge
    transform = TRANSLATE
    vector_value = '${ideal_radius} ${fparse ideal_radius + tab_height} 0'
  []
  [rename_top_gauge]
    type = RenameBoundaryGenerator
    input = move_gauge
    old_boundary = 'top'
    new_boundary = 'top_gauge_interface'
  []
  [stitch_upper_gauge]
    type = StitchedMeshGenerator
    inputs = 'upper_shoulder_interface rename_top_gauge'
    stitch_boundaries_pairs = 'upper_shoulder_interface top_gauge_interface'
  []
  [rename_bottom_gauge]
    type = SideSetsAroundSubdomainGenerator
    input = 'stitch_upper_gauge'
    normal = '0 -1 0'
    normal_tol = 1e-8 #seems to work, might be able to pull down more
    block = 100
    new_boundary = 'bottom_gauge_interface'
  []

  [shoulder_lower_left]
    type = ConcentricCircleMeshGenerator
    num_sectors = 20
    radii = '${ideal_radius}'
    rings = '1 10'
    has_outer_square = true
    pitch = '${fparse gauge_width + 2.0 * ideal_radius}'
    preserve_volumes = true
    portion = bottom_right
  []
  [move_lowleft_shoulder]
    type = TransformGenerator
    input = shoulder_lower_left
    transform = TRANSLATE
    vector_value = '0 ${fparse tab_height + ideal_radius} 0'
  []
  [rename_lower_left]
    type = RenameBoundaryGenerator
    input = move_lowleft_shoulder
    old_boundary = 'right'
    new_boundary = 'cl_low_shoulder_left'
  []
  [rename_cutout_lower_left]
    type = RenameBlockGenerator
    input = 'rename_lower_left'
    old_block = '2 1'
    new_block = '20 23'
  []
  [shoulder_lower_right]
    type = ConcentricCircleMeshGenerator
    num_sectors = 20
    radii = '${ideal_radius}'
    rings = '1 10'
    has_outer_square = true
    pitch = '${fparse gauge_width + 2.0 * ideal_radius}'
    preserve_volumes = true
    portion = bottom_left
  []
  [move_lowrght_shoulder]
    type = TransformGenerator
    input = shoulder_lower_right
    transform = TRANSLATE
    vector_value = '${fparse tab_width} ${fparse tab_height + ideal_radius} 0'
  []
  [rename_lower_right]
    type = RenameBoundaryGenerator
    input = move_lowrght_shoulder
    old_boundary = 'left'
    new_boundary = 'cl_low_shoulder_right'
  []
  [rename_cutout_lower_right]
    type = RenameBlockGenerator
    input = 'rename_lower_right'
    old_block = '2 1'
    new_block = '20 24'
  []
  [stitch_lower_shoulders]
    type = StitchedMeshGenerator
    inputs = 'rename_cutout_lower_left rename_cutout_lower_right'
    stitch_boundaries_pairs = 'cl_low_shoulder_left cl_low_shoulder_right'
  []
  [lower_shoulder_interface]
    type = SideSetsAroundSubdomainGenerator
    input = 'stitch_lower_shoulders'
    normal = '0 1 0'
    normal_tol = 1e-8 #seems to work, might be able to pull down more
    block = 20
    new_boundary = 'lower_shoulder_interface'
  []
  [stitch_lower_gauge]
    type = StitchedMeshGenerator
    inputs = 'lower_shoulder_interface rename_bottom_gauge'
    stitch_boundaries_pairs = 'lower_shoulder_interface bottom_gauge_interface'
  []
  [upper_tab_interface]
    type = SideSetsAroundSubdomainGenerator
    input = 'stitch_lower_gauge'
    normal = '0 1 0'
    normal_tol = 1e-8 #seems to work, might be able to pull down more
    block = 10
    new_boundary = 'upper_shoulder_tab_interface'
  []

  [top_tab]
    type = CartesianMeshGenerator
    dim = 2
    dx = ${tab_width}
    ix = '42'
    dy = '${fparse tab_height - gauge_width / 2.0}'
    iy = '38'
  []
  [rename_top_tab]
    type = RenameBlockGenerator
    input = 'top_tab'
    old_block = '0'
    new_block = '30'
  []
  [move_top_tab]
    type = TransformGenerator
    input = rename_top_tab
    transform = TRANSLATE
    vector_value = '0 ${fparse tab_height + 2.0 * ideal_radius + gauge_height + gauge_width / 2.0} 0'
  []
  [rename_top_tab_interface]
    type = RenameBoundaryGenerator
    input = move_top_tab
    old_boundary = 'bottom'
    new_boundary = 'bottom_tab_interface'
  []
  [stitch_upper_tab]
    type = StitchedMeshGenerator
    inputs = 'upper_tab_interface rename_top_tab_interface'
    stitch_boundaries_pairs = 'upper_shoulder_tab_interface bottom_tab_interface'
  []
  [lower_tab_interface]
    type = SideSetsAroundSubdomainGenerator
    input = 'stitch_upper_tab'
    normal = '0 -1 0'
    normal_tol = 1e-8 #seems to work, might be able to pull down more
    block = 20
    new_boundary = 'lower_shoulder_tab_interface'
  []

  [bottom_tab]
    type = CartesianMeshGenerator
    dim = 2
    dx = ${tab_width}
    ix = '42'
    dy = '${fparse tab_height - gauge_width / 2.0}'
    iy = '38'
  []
  [rename_bottom_tab]
    type = RenameBlockGenerator
    input = 'bottom_tab'
    old_block = '0'
    new_block = '40'
  []
  [rename_bottom_tab_interface]
    type = RenameBoundaryGenerator
    input = rename_bottom_tab
    old_boundary = 'top'
    new_boundary = 'top_tab_interface'
  []
  [stitch_lower_tab]
    type = StitchedMeshGenerator
    inputs = 'lower_tab_interface rename_bottom_tab_interface'
    stitch_boundaries_pairs = 'lower_shoulder_tab_interface top_tab_interface'
  []

  ## Things to include after the mesh has been completely stitched together
  [rename_sample_bottom]
    type = SideSetsAroundSubdomainGenerator
    input = 'stitch_lower_tab'
    normal = '0 -1 0'
    normal_tol = 1e-8 #seems to work, might be able to pull down more
    block = 40
    replace = true
    new_boundary = 'sample_bottom'
  []
  [rename_sample_top]
    type = SideSetsAroundSubdomainGenerator
    input = 'rename_sample_bottom'
    normal = '0 1 0'
    normal_tol = 1e-8 #seems to work, might be able to pull down more
    block = 30
    replace = true
    new_boundary = 'sample_top'
  []
  [rename_sample_block]
    type = RenameBlockGenerator
    input = 'rename_sample_top'
    old_block = '10 20 30 40 100'
    new_block = ' 0  0  0  0   0'
  []

  [upleft_shoulder_sideset]
    type = SideSetsBetweenSubdomainsGenerator
    input = rename_sample_block
    primary_block = 0
    paired_block = 12
    new_boundary = 'upper_left_shoulder'
  []
  [upright_shoulder_sideset]
    type = SideSetsBetweenSubdomainsGenerator
    input = upleft_shoulder_sideset
    primary_block = 0
    paired_block = 11
    new_boundary = 'upper_right_shoulder'
  []
  [lower_left_shoulder_sideset]
    type = SideSetsBetweenSubdomainsGenerator
    input = upright_shoulder_sideset
    primary_block = 0
    paired_block = 23
    new_boundary = 'lower_left_shoulder'
  []
  [lower_right_shoulder_sideset]
    type = SideSetsBetweenSubdomainsGenerator
    input = lower_left_shoulder_sideset
    primary_block = 0
    paired_block = 24
    new_boundary = 'lower_right_shoulder'
  []
  [delete_shoulder_cutouts]
    type = BlockDeletionGenerator
    input = 'lower_right_shoulder_sideset'
    block = '11 12 23 24'
  []
[]

[GlobalParams]
  displacements = 'disp_x disp_y'
  out_of_plane_strain = strain_zz
[]

[Variables]
  [strain_zz]
  []
[]

[AuxVariables]
  [nl_strain_zz]
    order = CONSTANT
    family = MONOMIAL
  []
[]

[Modules/TensorMechanics/Master]
  [all]
    planar_formulation = WEAK_PLANE_STRESS
    strain = FINITE
    incremental = true
    add_variables = true
    generate_output = 'stress_xx stress_yy stress_xy strain_xx strain_yy strain_xy elastic_strain_yy vonmises_stress' # plastic_strain_xx'
    use_automatic_differentiation = true
  []
[]

[AuxKernels]
  [strain_zz]
    type = ADRankTwoAux
    rank_two_tensor = total_strain
    variable = nl_strain_zz
    index_i = 2
    index_j = 2
  []
[]

[Materials]
  [elasticity_tensor]
    type = ADComputeIsotropicElasticityTensor
    youngs_modulus = 99e5 #assume this value is in MPa, but that would be pretty soft
    poissons_ratio = 0.35
    # constant_on = SUBDOMAIN
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
  #   strength_coefficient = 847 #K
  #   strain_hardening_exponent = 0.06 #n
  #   relative_tolerance = 1e-6
  #   absolute_tolerance = 1e-6
  # []
[]

[BCs]
  [bottom_shoulders]
    type = DirichletBC
    variable = disp_y
    boundary = 'lower_left_shoulder lower_right_shoulder'
    value = 0
  []
  [pulled_top_shoulders]
    type = FunctionDirichletBC
    variable = disp_y
    boundary = 'upper_left_shoulder upper_right_shoulder'
    function = 1e-1*t
  []
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

  petsc_options_iname = '-pc_type -pc_factor_mat_solver_package -pc_factor_shift_type -pc_factor_shift_amount'
  petsc_options_value = 'lu    superlu_dist NONZERO 1e-13'
  line_search = 'none'

  # [TimeStepper]
  #   type = IterationAdaptiveDT
  #   dt = 0.1
  #   optimal_iterations = 8
  #   iteration_window = 2
  # []
  dt = 0.1
  dtmin = 1e-6
  end_time = 50
  nl_max_its = 30
  nl_rel_tol = 1e-6
  nl_abs_tol = 1e-6
[]

[Outputs]
  # file_base = ./output
  execute_on = 'initial timestep_end'
  exodus = true
  csv = true
  # [check_point]
  #   type = Checkpoint
  #   interval = 10
  # []
[]

[Postprocessors]
  [stress_xx_center]
    type = PointValue
    variable = stress_xx
    point = '${fparse tab_width/2.0} ${fparse tab_height + ideal_radius + gauge_height / 2.0}  0'
    use_displaced_mesh = false
  []
  # [stress_xx_top]
  #   type = PointValue
  #   variable = stress_xx
  #   point = '0 0.6 0'
  #   use_displaced_mesh = false
  # []
  # [stress_xx_left]
  #   type = PointValue
  #   variable = stress_xx
  #   point = '-0.6 0 0'
  #   use_displaced_mesh = false
  # []
  # [stress_xx_right]
  #   type = PointValue
  #   variable = stress_xx
  #   point = '0.6 0 0'
  #   use_displaced_mesh = false
  # []
  # [stress_xx_bot]
  #   type = PointValue
  #   variable = stress_xx
  #   point = '0 -0.6 0'
  #   use_displaced_mesh = false
  # []
  # [strain_xx_center]
  #   type = PointValue
  #   variable = plastic_strain_xx
  #   point = '0 0 0'
  #   use_displaced_mesh = false
  # []
  # [strain_xx_top]
  #   type = PointValue
  #   variable = plastic_strain_xx
  #   point = '0 0.6 0'
  #   use_displaced_mesh = false
  # []
  # [strain_xx_bot]
  #   type = PointValue
  #   variable = plastic_strain_xx
  #   point = '0 -0.6 0'
  #   use_displaced_mesh = false
  # []
  # [strain_xx_left]
  #   type = PointValue
  #   variable = plastic_strain_xx
  #   point = '-0.6 0 0'
  #   use_displaced_mesh = false
  # []
  # [strain_xx_right]
  #   type = PointValue
  #   variable = plastic_strain_xx
  #   point = '0.6 0 0'
  #   use_displaced_mesh = false
  # []
  [stress_xx_max]
    type = ElementExtremeValue
    variable = stress_xx
    value_type = max
    use_displaced_mesh = false
  []
[]
