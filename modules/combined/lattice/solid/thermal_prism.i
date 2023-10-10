# specimen length = 12mm
# nominal specimen radius = 4.5mm
# maximum displacement 0.6mm (5% deformation)
# total time 100s, timestep size 1s
# displacement per step, 6e-3 mm
[Mesh]
  [line]
    type = GeneratedMeshGenerator
    dim = 3
    nx = 100
    ny = 25
    nz = 25
    xmax = 12
    ymax = 4
    zmax = 5
  []
  second_order = true
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
    boundary = left
    paired_boundary = right
  []
  [distance_top]
    type = NearestNodeDistanceAux
    variable = height_top
    boundary = right
    paired_boundary = left
  []
[]


[BCs]
  [bottom_z]
    type = ADDirichletBC
    variable = temperature
    boundary = left
    value = 300 ## K
  []
  [top_z]
    type = ADDirichletBC
    variable = temperature
    boundary = right
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
    boundary = right
  []
  [bottom_temp]
    type = SideAverageValue
    variable = temperature
    boundary = left
  []
  [bottom_flux_avg]
    type = ADSideDiffusiveFluxAverage
    variable = temperature
    boundary = left
    diffusivity = thermal_conductivity
  []
  [top_flux_avg]
    type = ADSideDiffusiveFluxAverage
    variable = temperature
    boundary = right
    diffusivity = thermal_conductivity
  []

  [outlet_minus_z]
    type = ADSideDiffusiveFluxIntegral
    variable = temperature
    boundary = 'left'
    diffusivity = thermal_conductivity
  []

  [height_top]
    type = SideAverageValue
    variable = height_top
    boundary = right
  []
  [height_bottom]
    type = SideAverageValue
    variable = height_bottom
    boundary = left
  []
  [height_max]
    type = SideExtremeValue
    variable = height_bottom
    boundary = left
    value_type = max
  []
  [height_min]
    type = SideExtremeValue
    variable = height_bottom
    boundary = left
    value_type = min
  []
  [edge]
    type = FunctionValuePostprocessor
    function = cylinder_height
  []
  [diff_temperature]
    type = FunctionValuePostprocessor
    function = temperature_diff
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
