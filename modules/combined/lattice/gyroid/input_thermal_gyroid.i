# specimen length = 12mm
# nominal specimen radius = 4.5mm
# maximum displacement 0.6mm (5% deformation)
# total time 100s, timestep size 1s
# displacement per step, 6e-3 mm
[Mesh]
  [fmg]
    type = FileMeshGenerator
    file = convert_gyroid_in.e
  []
  [top_outer_sideset]
    type = SideSetsAroundSubdomainGenerator
    input = fmg
    normal = ' 0 0 1'
    new_boundary = 'new_outer_top'
    normal_tol = 5e-3
    fixed_normal = true
    block = 1
    external_only = true
    replace = true
    # variance = 1.0e-3
  []
  [normal_inner_top]
    type = SideSetsAroundSubdomainGenerator
    input = top_outer_sideset
    normal = ' 0 0 1'
    new_boundary = 'normal_inner_top'
    normal_tol = 5e-3 #9e-5
    fixed_normal = true
    block = 0
    external_only = true
    # replace = true
    # variance = 1.0e-3
  []
  [top_inner_sideset]
    type = SideSetsFromBoundingBoxGenerator
    input = normal_inner_top
    bottom_left = '-4.06 -4.04 6'
    top_right = '4.03 4.06 6.02'
    boundaries_old = 'traction_top normal_inner_top'
    boundary_id_overlap = true
    boundary_new = 'new_inner_top'
  []
  [rename_top]
    type = RenameBoundaryGenerator
    input = top_inner_sideset
    old_boundary = 'new_outer_top new_inner_top'
    new_boundary = 'new_top new_top'
  []
  [bottom_outer_sideset]
    type = SideSetsAroundSubdomainGenerator
    input = rename_top
    normal = ' 0 0 -1'
    new_boundary = 'new_outer_bottom'
    normal_tol = 5e-3
    fixed_normal = true
    block = 1
    external_only = true
    replace = true
    # variance = 1.0e-3
  []
  [normal_inner_bottom]
    type = SideSetsAroundSubdomainGenerator
    input = bottom_outer_sideset
    normal = ' 0 0 -1'
    new_boundary = 'normal_inner_bottom'
    normal_tol = 5e-3 #9e-5
    fixed_normal = true
    block = 0
    external_only = true
    # replace = true
    # variance = 1.0e-3
  []
  [bottom_inner_sideset]
    type = SideSetsFromBoundingBoxGenerator
    input = normal_inner_bottom
    bottom_left = '-4.03 -4.04 -6.02'
    top_right = '4.05 4.06 -6'
    boundaries_old = 'traction_bottom normal_inner_bottom'
    boundary_id_overlap = true
    boundary_new = 'new_inner_bottom'
  []
  [rename_bottom]
    type = RenameBoundaryGenerator
    input = bottom_inner_sideset
    old_boundary = 'new_outer_bottom new_inner_bottom'
    new_boundary = 'new_bottom new_bottom'
  []
  construct_side_list_from_node_list = true
  # second_order = true
  # patch_update_strategy = auto
[]

[Variables]
  [temperature]
    initial_condition = 325
  []
[]

[AuxVariables]
  [height_bottom]
    order = FIRST
    family = LAGRANGE
  []
  [height_top]
    order = FIRST
    family = LAGRANGE
  []
[]

[Kernels]
  [heat_conduction]
    type = ADHeatConduction
    variable = temperature
    thermal_conductivity = 'thermal_conductivity'
  []
[]

[AuxKernels]
  [distance_bottom]
    type = NearestNodeDistanceAux
    variable = height_bottom
    boundary = new_bottom
    paired_boundary = new_top
  []
  [distance_top]
    type = NearestNodeDistanceAux
    variable = height_top
    boundary = new_top
    paired_boundary = new_bottom
  []
[]


[BCs]
  [bottom_z]
    type = ADDirichletBC
    variable = temperature
    boundary = new_bottom
    value = 300 ## K
  []
  [top_z]
    type = ADDirichletBC
    variable = temperature
    boundary = new_top
    value = 350 # K
  []
[]

[Materials]
  [thermal_properties]
    type = ADGenericConstantMaterial
    prop_names = 'thermal_conductivity'
    prop_values = 1.0 #16.3e3 ## unit conversion from 16.3 W/(m-K) to (kg-mm)/(s^3-K)
  []
  # [heat2]
  #   type = ADHeatConductionMaterial
  #   specific_heat = 0.5
  #   thermal_conductivity = 1.0
  # []
[]

[Functions]
  [cylinder_height]
    type = ParsedFunction
    expression = '(height_bottom + height_top)/2.0'
    symbol_names = ' height_bottom height_top'
    symbol_values = 'height_bottom height_top'
  []
  [temperature_diff]
    type = ParsedFunction
    expression = 'top - bottom'
    symbol_names = 'top bottom'
    symbol_values = 'top_temp bottom_temp'
  []
  [k_effective_avg_bottom]
    type = ParsedFunction
    expression = '(avg * height) / (temp_diff)'
    symbol_names = 'avg temp_diff height'
    symbol_values = 'bottom_flux_avg temperature_diff cylinder_height'
  []
  [k_effective_top]
    type = ParsedFunction
    expression = '(-avg * height) / temp_diff'
    symbol_names = 'avg temp_diff height'
    symbol_values = 'top_flux_avg temperature_diff cylinder_height'
  []
[]


[Executioner]
  type = Steady
  solve_type = 'NEWTON'
  line_search = none

  petsc_options_iname = '-pc_type -pc_hypre_type'
  petsc_options_value = 'hypre boomeramg'
[]

[Outputs]
  exodus = true
  csv = true
[]

[Postprocessors]
  [top_temp]
    type = SideAverageValue
    variable = temperature
    boundary = new_top
  []
  [bottom_temp]
    type = SideAverageValue
    variable = temperature
    boundary = new_bottom
  []
  [bottom_flux_avg]
    type = ADSideDiffusiveFluxAverage
    variable = temperature
    boundary = new_bottom
    diffusivity = thermal_conductivity
  []
  [top_flux_avg]
    type = ADSideDiffusiveFluxAverage
    variable = temperature
    boundary = new_top
    diffusivity = thermal_conductivity
  []

  [height_top]
    type = SideAverageValue
    variable = height_top
    boundary = new_top
  []
  [height_bottom]
    type = SideAverageValue
    variable = height_bottom
    boundary = new_bottom
  []
  [height_bot_max]
    type = SideExtremeValue
    variable = height_bottom
    boundary = new_bottom
    value_type = max
  []
  [height_bot_min]
    type = SideExtremeValue
    variable = height_bottom
    boundary = new_bottom
    value_type = min
  []
  [height_top_max]
    type = SideExtremeValue
    variable = height_top
    boundary = new_top
    value_type = max
  []
  [height_top_min]
    type = SideExtremeValue
    variable = height_top
    boundary = new_top
    value_type = min
  []

  [edge]
    type = FunctionValuePostprocessor
    function = cylinder_height
  []

  [k_eff_avg_bottom]
    type = FunctionValuePostprocessor
    function = k_effective_avg_bottom
  []
  [k_eff_avg_top]
    type = FunctionValuePostprocessor
    function = k_effective_top
  []
[]
