[GlobalParams]
  displacements = 'disp_x disp_y disp_z'
[]

[Mesh]
  [cube]
    type = GeneratedMeshGenerator
    dim = 3
    nx = 8
    ny = 8
    nz = 8
    elem_type = HEX27
  []
  second_order = true
[]

[Modules/TensorMechanics/Master]
  [all]
    strain = FINITE
    incremental = true
    add_variables = true
    additional_generate_output = 'stress_zz stress_xx stress_yy vonmises_stress strain_xx strain_yy strain_zz l2norm_strain l2norm_stress'
    additional_material_output_order = FIRST
  []
[]

[BCs]
  [symmetric_y]
    type = DirichletBC
    variable = disp_y
    boundary = 'bottom'
    value = 0
  []
  [symmetric_x]
    type = DirichletBC
    variable = disp_x
    boundary = 'left'
    value = 0
  []
  [symmetric_z]
    type = DirichletBC
    variable = disp_z
    boundary = 'back'
    value = 0
  []
  [tdisp]
    type = FunctionDirichletBC
    variable = disp_z
    boundary = 'front'
    function = '8.5e-4*t' #given strain rate for the 1bar49 orientation
  []
[]

[Materials]
  [elasticity_tensor_xtal]
    type = ComputeElasticityTensorConstantRotationCP
    # C_ijkl = '521.0e3 201.0e3 201.0e3 521.0e3 201.0e3 521.0e3 160.0e3 160.0e3 160.0e3' #Lim et al (2015) JMPS
    C_ijkl = '5.224e5 2.044e5 2.044e5 5.224e5 2.044e5 5.224e5 1.606e5 1.606e5 1.606e5' # at 24C, from Lowie and Gonas (1967) J. Applied Physics
    fill_method = symmetric9
    euler_angle_1 = 35.0
    euler_angle_2 = 24.613597652978576
    euler_angle_3 = -14.036243467926473
  []
  [stress]
    type = ComputeFiniteStrainElasticStress
  []
[]

[Postprocessors]
  [stress_zz]
    type = ElementAverageValue
    variable = stress_zz
  []
  [stress_xx]
    type = ElementAverageValue
    variable = stress_xx
  []
  [stress_yy]
    type = ElementAverageValue
    variable = stress_yy
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
  solve_type = NEWTON #'PJFNK'

  petsc_options_iname = '-pc_type -pc_asm_overlap -sub_pc_type -ksp_type -ksp_gmres_restart'
  petsc_options_value = ' asm      2              lu            gmres     200'
  nl_abs_tol = 1e-10
  nl_rel_tol = 1e-8 # was 1e-10 in initial testing
  nl_max_its = 15

  dt = 0.025
  dtmin = 1.0e-3
  dtmax = 10.0
  end_time = 25.0 #250.0 # 120s needed to reach 10% strain
  timestep_tolerance = 1.0e-8
[]

[Outputs]
  exodus = true
  csv = true
  color = false
  # checkpoint = true
  perf_graph = true
[]
