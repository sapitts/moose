# Attempt to build the dogbone sample with only the transfinite generator

## parameters to vary with STM
upper_left_radius = 1.654 #1.3 #1.3 #min 1.146, max 1.654
upper_right_radius = 1.654 #1.4
lower_left_radius = 1.146 #1.6
lower_right_radius = 1.146 # 1.2

gauge_width = 1.454 #1.2
# min 0.946, max 1.454
gauge_height = 5.954 #5.7
# min 5.446, max 5.954

upper_rig_offset = 0.0 # -0.15 to 0.15
lower_rig_offset = 0.0 # -0.15 to 0.15

## constrained values (hardcoded)
tab_height = 5.15 # 3.75 +1.4 from tab top to gauge height
rig_gap = 1.5
num_x_nodes = 15
shoulder_tab_curvature = 0.3

## conversion cofficients
one_minus_inverse_sqrt_two = '${fparse 1.0 - 1.0 / sqrt(2.0)}'

[Mesh]
  ######################################
  #### top shoulders and tab section
  ######################################
  [top_shoulder]
    type = TransfiniteMeshGenerator
    corners = '${fparse 0.5 * gauge_width} ${fparse 0.5 * gauge_height} 0.0
               ${fparse -0.5 * gauge_width} ${fparse 0.5 * gauge_height} 0.0
               ${fparse -0.5 * gauge_width - upper_left_radius} ${fparse 0.5 * gauge_height + upper_left_radius} 0.0
               ${fparse 0.5 * gauge_width + upper_right_radius} ${fparse 0.5 * gauge_height + upper_right_radius} 0.0'
    nx = ${num_x_nodes}
    ny = 16
    bottom_type = LINE
    left_type = CIRCARC
    top_type = CIRCARC
    right_type = CIRCARC
    left_parameter = '${fparse upper_right_radius  * one_minus_inverse_sqrt_two}' #'Note mismatch between geometery side and parameter
    right_parameter = '${fparse upper_left_radius * one_minus_inverse_sqrt_two}' #'Note mismatch between geometery side and parameter
    top_parameter = '${fparse shoulder_tab_curvature}' #if you want a circ bit
  []
  [top_tab]
    type = TransfiniteMeshGenerator
    corners = '${fparse 0.5 * gauge_width + upper_right_radius} ${fparse 0.5 * gauge_height + upper_right_radius} 0.0
               ${fparse -0.5 * gauge_width - upper_left_radius} ${fparse 0.5 * gauge_height + upper_left_radius} 0.0
               ${fparse -0.5 * gauge_width - upper_left_radius} ${fparse 0.5 * gauge_height + tab_height} 0.0
               ${fparse 0.5 * gauge_width + upper_right_radius} ${fparse 0.5 * gauge_height + tab_height} 0.0'
    nx = ${num_x_nodes}
    ny = ${num_x_nodes}
    bottom_type = CIRCARC
    left_type = LINE
    top_type = LINE
    right_type = LINE
    bottom_parameter = '${fparse -shoulder_tab_curvature}'
  []
  [stitch_top_tab]
    type = StitchedMeshGenerator
    inputs = 'top_shoulder top_tab'
    stitch_boundaries_pairs = 'top bottom'
  []
  [gauge]
    type = TransfiniteMeshGenerator
    corners = '${fparse 0.5 * gauge_width} ${fparse -0.5 * gauge_height} 0.0
               ${fparse -0.5 * gauge_width} ${fparse -0.5 * gauge_height} 0.0
               ${fparse -0.5 * gauge_width} ${fparse 0.5 * gauge_height} 0.0
               ${fparse 0.5 * gauge_width} ${fparse 0.5 * gauge_height} 0.0'
    nx = ${num_x_nodes}
    ny = 40
    bottom_type = LINE
    left_type = LINE
    top_type = LINE
    right_type = LINE
  []
  [stitch_top_gauge]
    type = StitchedMeshGenerator
    inputs = 'stitch_top_tab gauge'
    stitch_boundaries_pairs = 'bottom top'
  []

  ######################################
  #### bottom shoulders and tab section
  ######################################
  [bottom_shoulder]
    type = TransfiniteMeshGenerator
    corners = '${fparse 0.5 * gauge_width + lower_right_radius} ${fparse -0.5 * gauge_height - lower_right_radius} 0.0
               ${fparse -0.5 * gauge_width - lower_left_radius} ${fparse -0.5 * gauge_height - lower_left_radius} 0.0
               ${fparse -0.5 * gauge_width} ${fparse -0.5 * gauge_height} 0.0
               ${fparse 0.5 * gauge_width} ${fparse -0.5 * gauge_height} 0.0'
    nx = ${num_x_nodes}
    ny = 16 #25
    bottom_type = CIRCARC
    left_type = CIRCARC
    top_type = LINE
    right_type = CIRCARC
    right_parameter = '${fparse lower_left_radius * one_minus_inverse_sqrt_two}' #'Note mismatch between geometery side and parameter
    left_parameter = '${fparse lower_right_radius * one_minus_inverse_sqrt_two}' #'Note mismatch between geometery side and parameter
    bottom_parameter = '${fparse shoulder_tab_curvature}'
  []
  [bottom_tab]
    type = TransfiniteMeshGenerator
    corners = '${fparse 0.5 * gauge_width + lower_right_radius} ${fparse -0.5 * gauge_height - tab_height} 0.0
               ${fparse -0.5 * gauge_width - lower_left_radius} ${fparse -0.5 * gauge_height - tab_height} 0.0
               ${fparse -0.5 * gauge_width - lower_left_radius} ${fparse -0.5 * gauge_height - lower_left_radius} 0.0
               ${fparse 0.5 * gauge_width + lower_right_radius} ${fparse -0.5 * gauge_height - lower_right_radius} 0.0'
    nx = ${num_x_nodes}
    ny = ${num_x_nodes}
    bottom_type = LINE
    left_type = LINE
    top_type = CIRCARC
    right_type = LINE
    top_parameter = '${fparse -shoulder_tab_curvature}'
  []
  [stitch_bottom_tab]
    type = StitchedMeshGenerator
    inputs = 'bottom_shoulder bottom_tab'
    stitch_boundaries_pairs = 'bottom top'
  []
  [stitch_bottom_gauge]
    type = StitchedMeshGenerator
    inputs = 'stitch_top_gauge stitch_bottom_tab'
    stitch_boundaries_pairs = 'bottom top'
  []

  #############################################
  #### add BC sidesets, mesh clean up
  #############################################
  [smoothed_final]
    type = SmoothMeshGenerator
    input = stitch_bottom_gauge
    iterations = 15
  []

  # [extruder]
  #   type = MeshExtruderGenerator
  #   input = smoothed_final
  #   extrusion_vector = "0 0 0.5"
  #   num_layers = 5
  #   bottom_sideset = back
  #   top_sideset = front
  # []

  [downleft_shoulder_sideset]
    type = ParsedGenerateSideset
    input = 'smoothed_final'
    # input = 'extruder'
    combinatorial_geometry = 'x<=(${fparse -0.5 * rig_gap + (lower_rig_offset)}) & abs((x-(${fparse -0.5 * gauge_width - lower_left_radius}))^2+(y-(${fparse -0.5*gauge_height}))^2-(${lower_left_radius})^2)<1e-2'
    new_sideset_name = 'lower_left_shoulder'
  []
  [downright_shoulder_sideset]
    type = ParsedGenerateSideset
    input = 'downleft_shoulder_sideset'
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
    combinatorial_geometry = 'x>=(${fparse 0.5 * rig_gap + (upper_rig_offset)}) & abs((x-(${fparse 0.5 * gauge_width + upper_right_radius}))^2+(y-(${fparse 0.5*gauge_height}))^2-(${upper_right_radius})^2)<1e-2'
    new_sideset_name = 'upper_right_shoulder'
  []
[]

[GlobalParams]
  displacements = 'disp_x disp_y'
  out_of_plane_strain = strain_zz
[]

[AuxVariables]
  [nl_strain_zz]
    order = CONSTANT
    family = MONOMIAL
  []
[]

[Variables]
  [strain_zz]
  []
[]

[BCs]
  [zero_displacements]
    type = ADDirichletBC
    variable = 'disp_y'
    boundary = 'lower_left_shoulder lower_right_shoulder'
    value = 0.0
  []
  [tensile_displacement]
    type = ADFunctionDirichletBC
    variable = 'disp_y'
    boundary = 'upper_left_shoulder upper_right_shoulder'
    function = '0.08*t'
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

[Modules/TensorMechanics/Master]
  [all]
    strain = FINITE
    planar_formulation = WEAK_PLANE_STRESS
    incremental = true
    add_variables = true
    generate_output = 'stress_xy stress_zz'
    additional_generate_output = 'stress_xx stress_yy strain_xx strain_yy strain_xy vonmises_stress'
    additional_material_output_family = MONOMIAL
    additional_material_output_order = FIRST
    use_automatic_differentiation = true
  []
[]

[Materials]
  [elasticity_tensor]
    type = ADComputeIsotropicElasticityTensor
    youngs_modulus = 9.24e4 #in MPa
    poissons_ratio = 0.363
  []
  # [elastic_stress]
  #   type = ADComputeFiniteStrainElasticStress
  # []
  [radial_return_stress]
    type = ADComputeMultipleInelasticStress
    inelastic_models = 'power_law_hardening'
  []
  [power_law_hardening]
    type = ADIsotropicPowerLawHardeningStressUpdate
    strength_coefficient = 854 #MPa
    strain_hardening_exponent = 0.125 #n
    relative_tolerance = 1e-6
    absolute_tolerance = 1e-6
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

  petsc_options_iname = '-pc_type -pc_factor_mat_solver_package' # -pc_factor_shift_type -pc_factor_shift_amount'
  petsc_options_value = ' lu       superlu_dist                ' #   NONZERO 1e-15'
  line_search = 'none'

  # [TimeStepper]
  #   type = IterationAdaptiveDT
  #   dt = 0.1
  #   optimal_iterations = 8
  #   iteration_window = 2
  # []
  dt = 0.1
  dtmin = 1e-6
  end_time = 10.6875 # to get to 15% strain in the gauge length
  nl_max_its = 30
  nl_rel_tol = 1e-6
  nl_abs_tol = 1e-6
[]

[Outputs]
  csv = true
  exodus = true
  color = false
  perf_graph = true
[]

[Postprocessors]
  [p1_vonmises_stress]
    type = PointValue
    variable = vonmises_stress
    point = '0 ${fparse 0.5 * gauge_height + 1.4} 0'
  []
  [p2_vonmises_stress]
    type = PointValue
    variable = vonmises_stress
    point = '0 ${fparse 0.5 * gauge_height} 0'
  []
  [p3_vonmises_stress]
    type = PointValue
    variable = vonmises_stress
    point = '0 ${fparse 0.25 * gauge_height} 0'
  []
  [p4_vonmises_stress]
    type = PointValue
    variable = vonmises_stress
    point = '${fparse -0.5*gauge_width} 0 0'
  []
  [p5_vonmises_stress]
    type = PointValue
    variable = vonmises_stress
    point = '0 0 0'
  []
  [p6_vonmises_stress]
    type = PointValue
    variable = vonmises_stress
    point = '${fparse 0.5*gauge_width} 0 0'
  []
  [p7_vonmises_stress]
    type = PointValue
    variable = vonmises_stress
    point = '0 ${fparse -0.25 * gauge_height} 0'
  []
  [p8_vonmises_stress]
    type = PointValue
    variable = vonmises_stress
    point = '0 ${fparse -0.5 * gauge_height} 0'
  []
  [p9_vonmises_stress]
    type = PointValue
    variable = vonmises_stress
    point = ' 0 ${fparse -0.5 * gauge_height - 1.4} 0'
  []

  [p1_stress_xx]
    type = PointValue
    variable = stress_xx
    point = '0 ${fparse 0.5 * gauge_height + 1.4} 0'
  []
  [p2_stress_xx]
    type = PointValue
    variable = stress_xx
    point = '0 ${fparse 0.5 * gauge_height} 0'
  []
  [p3_stress_xx]
    type = PointValue
    variable = stress_xx
    point = '0 ${fparse 0.25 * gauge_height} 0'
  []
  [p4_stress_xx]
    type = PointValue
    variable = stress_xx
    point = '${fparse -0.5*gauge_width} 0 0'
  []
  [p5_stress_xx]
    type = PointValue
    variable = stress_xx
    point = '0 0 0'
  []
  [p6_stress_xx]
    type = PointValue
    variable = stress_xx
    point = '${fparse 0.5*gauge_width} 0 0'
  []
  [p7_stress_xx]
    type = PointValue
    variable = stress_xx
    point = '0 ${fparse -0.25 * gauge_height} 0'
  []
  [p8_stress_xx]
    type = PointValue
    variable = stress_xx
    point = '0 ${fparse -0.5 * gauge_height} 0'
  []
  [p9_stress_xx]
    type = PointValue
    variable = stress_xx
    point = ' 0 ${fparse -0.5 * gauge_height - 1.4} 0'
  []

  [p1_strain_xx]
    type = PointValue
    variable = strain_xx
    point = '0 ${fparse 0.5 * gauge_height + 1.4} 0'
  []
  [p2_strain_xx]
    type = PointValue
    variable = strain_xx
    point = '0 ${fparse 0.5 * gauge_height} 0'
  []
  [p3_strain_xx]
    type = PointValue
    variable = strain_xx
    point = '0 ${fparse 0.25 * gauge_height} 0'
  []
  [p4_strain_xx]
    type = PointValue
    variable = strain_xx
    point = '${fparse -0.5*gauge_width} 0 0'
  []
  [p5_strain_xx]
    type = PointValue
    variable = strain_xx
    point = '0 0 0'
  []
  [p6_strain_xx]
    type = PointValue
    variable = strain_xx
    point = '${fparse 0.5*gauge_width} 0 0'
  []
  [p7_strain_xx]
    type = PointValue
    variable = strain_xx
    point = '0 ${fparse -0.25 * gauge_height} 0'
  []
  [p8_strain_xx]
    type = PointValue
    variable = strain_xx
    point = '0 ${fparse -0.5 * gauge_height} 0'
  []
  [p9_strain_xx]
    type = PointValue
    variable = strain_xx
    point = ' 0 ${fparse -0.5 * gauge_height - 1.4} 0'
  []

  [p1_strain_yy]
    type = PointValue
    variable = strain_yy
    point = '0 ${fparse 0.5 * gauge_height + 1.4} 0'
  []
  [p2_strain_yy]
    type = PointValue
    variable = strain_yy
    point = '0 ${fparse 0.5 * gauge_height} 0'
  []
  [p3_strain_yy]
    type = PointValue
    variable = strain_yy
    point = '0 ${fparse 0.25 * gauge_height} 0'
  []
  [p4_strain_yy]
    type = PointValue
    variable = strain_yy
    point = '${fparse -0.5*gauge_width} 0 0'
  []
  [p5_strain_yy]
    type = PointValue
    variable = strain_yy
    point = '0 0 0'
  []
  [p6_strain_yy]
    type = PointValue
    variable = strain_yy
    point = '${fparse 0.5*gauge_width} 0 0'
  []
  [p7_strain_yy]
    type = PointValue
    variable = strain_yy
    point = '0 ${fparse -0.25 * gauge_height} 0'
  []
  [p8_strain_yy]
    type = PointValue
    variable = strain_yy
    point = '0 ${fparse -0.5 * gauge_height} 0'
  []
  [p9_strain_yy]
    type = PointValue
    variable = strain_yy
    point = ' 0 ${fparse -0.5 * gauge_height - 1.4} 0'
  []

  [max_vonmises_stress]
    type = ElementExtremeValue
    variable = vonmises_stress
    value_type = max
  []
  [max_stress_xx]
    type = ElementExtremeValue
    variable = stress_xx
    value_type = max
  []
  [max_strain_xx]
    type = ElementExtremeValue
    variable = strain_xx
    value_type = max
  []
  [max_strain_yy]
    type = ElementExtremeValue
    variable = strain_yy
    value_type = max
  []
[]
