# specimen length = 12mm
# nominal specimen radius = 4.5mm
# maximum displacement 0.6mm (5% deformation)
# total time 100s, timestep size 1s
# displacement per step, 6e-3 mm
[Mesh]
  [line]
    type = GeneratedMeshGenerator
    dim = 2
    nx = 100
    xmax = 12
    ymax = 4
  []
  second_order = true
  # patch_update_strategy = auto
[]

[Variables]
  [temperature]
    initial_condition = 300
  []
[]

[Kernels]
  [heat_conduction]
    type = ADHeatConduction
    variable = temperature
    thermal_conductivity = 'thermal_conductivity'
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
    expression = 'volume / ((area_bottom + area_top)/2.0)'
    symbol_names = 'volume area_bottom area_top'
    symbol_values = 'volume area_bottom area_top'
  []
  [temperature_diff]
    type = ParsedFunction
    expression = 'top - bottom'
    symbol_names = 'top bottom'
    symbol_values = 'top_temp bottom_temp'
  []
  [k_effective_avg]
    type = ParsedFunction
    expression = '(avg * height) / (temp_diff)'
    symbol_names = 'avg area temp_diff height'
    symbol_values = 'bottom_flux_avg area_bottom temperature_diff cylinder_height'
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
    execute_on = 'TIMESTEP_END initial'
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

  [top_flux]
    type = ADSideDiffusiveFluxIntegral
    variable = temperature
    boundary = 'right'
    diffusivity = thermal_conductivity
  []
  [outlet_minus_z]
    type = ADSideDiffusiveFluxIntegral
    variable = temperature
    boundary = 'left'
    diffusivity = thermal_conductivity
  []
  [area_bottom]
    type = AreaPostprocessor
    boundary = left
    execute_on = 'INITIAL TIMESTEP_end'
  []
  [area_top]
    type = AreaPostprocessor
    boundary = right
    execute_on = 'INITIAL TIMESTEP_end'
  []
  [volume]
    type = VolumePostprocessor
    execute_on = 'INITIAL TIMESTEP_END'
  []

  [edge]
    type = FunctionValuePostprocessor
    function = cylinder_height
  []
  # [diff_temperature]
  #   type = FunctionValuePostprocessor
  #   function = temperature_diff
  # []

  [k_eff_int_bottom]
    type = FunctionValuePostprocessor
    function = k_effective_int
  []
  [k_eff_avg_bottom]
    type = FunctionValuePostprocessor
    function = k_effective_avg
  []
  [k_eff_avg_top]
    type = FunctionValuePostprocessor
    function = k_effective_top
  []
[]
