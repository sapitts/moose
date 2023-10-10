# specimen length = 12mm
# nominal specimen radius = 4.5mm
# maximum displacement 0.6mm (5% deformation)
# total time 100s, timestep size 1s
# displacement per step, 6e-3 mm
[Mesh]
  [fmg]
    type = FileMeshGenerator
    file = convert_solid_in.e
  []
  [top_sideset]
    type = SideSetsFromNormalsGenerator
    input = fmg
    normals = ' 0 0 1'
    new_boundary = 'new_top'
    tolerance = 5e-3
    fixed_normal = true
    # variance = 1.0e-3
  []
  [bottom_sideset]
    type = SideSetsFromNormalsGenerator
    input = top_sideset
    normals = ' 0 0 -1'
    new_boundary = 'new_bottom'
    tolerance = 5e-3
    fixed_normal = true
    # variance = 1.0e-3
  []
  # second_order = true
  # patch_update_strategy = auto
[]

[Variables]
  [temperature]
    initial_condition = 300
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
    prop_values = 16.3e3 ## unit conversion from 16.3 W/(m-K) to (kg-mm)/(s^3-K)
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
  [k_effective_int]
    type = ParsedFunction
    expression = '(flux * height) / (temp_diff)'
    symbol_names = 'flux temp_diff height'
    symbol_values = 'outlet_minus_z temperature_diff cylinder_height'
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

  [outlet_minus_z]
    type = ADSideDiffusiveFluxIntegral
    variable = temperature
    boundary = 'new_bottom'
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

  [k_eff_int_bottom]
    type = FunctionValuePostprocessor
    function = k_effective_int
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
