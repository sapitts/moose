[GlobalParams]
  family = LAGRANGE
  order = SECOND
  []

[Mesh]
  file = spsdie_table1model3_2d.e
[]

[Problem]
  coord_type = RZ
[]

[Variables]
  [./temperature]
    initial_condition = 300.0
  [../]
  [./elec]
  [../]
[]

[AuxVariables]
  [./T_infinity]
    initial_condition = 300.0
  [../]
[]

[Kernels]
  [./HeatDiff]
    type = HeatConduction
    variable = temperature
  [../]
  [./HeatTdot]
    type = HeatConductionTimeDerivative
    variable = temperature
  [../]
  [./HeatSource]
    type = JouleHeatingSource
    variable = temperature
    elec = elec
  [../]
  [./electric]
    type = HeatConduction
    variable = elec
    diffusion_coefficient = electrical_conductivity
  [../]
[]

[BCs]
  [./external_surface]
    type = CoupledRadiativeHeatFluxBC
    boundary = right_die
    variable = temperature
    T_infinity = T_infinity
    emissivity = 0.85
  [../]
  # [./external_surface]
  #   type = InfiniteCylinderRadiativeBC
  #   boundary = right_die
  #   variable = temperature
  #   Tinfinity = 300
  #   boundary_radius = 0.04
  #   cylinder_radius = 1
  #   boundary_emissivity = 0.85
  # [../]
  # [./top_surface]
  #   type = CoupledConvectiveHeatFluxBC
  #   boundary = right
  #   variable = temperature
  #   T_infinity = 293
  #   htc = 45
  # [../]
  [./elec_top]
    type = DirichletBC
    variable = elec
    boundary = top_die
    value = 10
  [../]
  [./elec_bottom]
    type = DirichletBC
    variable = elec
    boundary = bottom_die
    value = 0
  [../]
[]

[Materials]
  [./heat_conductor]
    type = HeatConductionMaterial  #replace with GenericFunctionMaterial to capture the temperature dependence
    thermal_conductivity = 630
    specific_heat = 60
  [../]
  [./rho]
    type = GenericConstantMaterial
    prop_names = 'density'
    prop_values = 1.75e3
  [../]
  [./sigma]
    type = ElectricalConductivity
    temp = temperature
    ref_temp = 293.0
    ref_resistivity = 3.0e-3
    temp_coeff = 0# .03 #0.00386
    length_scale = 1
  [../]
[]

[Preconditioning]
  [./SMP]
    type = SMP
    full = true
  [../]
[]

[Executioner]
  type = Transient
  scheme = bdf2
  solve_type = PJFNK
  petsc_options_iname = '-pc_type -ksp_grmres_restart -sub_ksp_type -sub_pc_type -pc_asm_overlap'
  petsc_options_value = 'asm         101   preonly   ilu      1'
  nl_rel_tol = 1e-8
  nl_abs_tol = 1e-10
  l_tol = 1e-4
  nl_max_its = 20
  l_max_its = 50
  dt = 1
  dtmin = 1.0e-8
  end_time = 100
[]

[Outputs]
  exodus = true
  perf_graph = true
[]
