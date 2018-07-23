[GlobalParams]
  displacements = 'disp_x disp_y disp_z'
[]

[Mesh]
  type = GeneratedMesh
  dim = 3
  elem_type = HEX8
  nx = 2
  ny = 2
  nz = 2
[]

[AuxVariables]
  [./stress_zz]
    order = FIRST
    family = MONOMIAL
  [../]
  [./pk2]
    order = FIRST
    family = MONOMIAL
  [../]
  [./fp_zz]
    order = FIRST
    family = MONOMIAL
  [../]
  [./e_zz]
    order = FIRST
    family = MONOMIAL
  [../]
  [./gss]
    order = FIRST
    family = MONOMIAL
  [../]
  [./slip_increment]
   order = FIRST
   family = MONOMIAL
  [../]
  [./tau]
   order = FIRST
   family = MONOMIAL
  [../]
  [./euler_angle1]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./euler_angle2]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./euler_angle3]
    order = CONSTANT
    family = MONOMIAL
  [../]
[]

[Functions]
  [./tdisp]
    type = ParsedFunction
    value = 0.01*t
  [../]
[]

[Modules]
  [./TensorMechanics]
    [./Master]
      [./all]
        strain = FINITE
        add_variables = true
      [../]
    [../]
  [../]
[]

[AuxKernels]
  [./stress_zz]
    type = RankTwoAux
    variable = stress_zz
    rank_two_tensor = stress
    index_j = 2
    index_i = 2
    execute_on = timestep_end
  [../]
  [./pk2]
   type = RankTwoAux
   variable = pk2
   rank_two_tensor = pk2
   index_j = 2
   index_i = 2
   execute_on = timestep_end
  [../]
  [./fp_zz]
    type = RankTwoAux
    variable = fp_zz
    rank_two_tensor = fp
    index_j = 2
    index_i = 2
    execute_on = timestep_end
  [../]
  [./e_zz]
    type = RankTwoAux
    variable = e_zz
    rank_two_tensor = lage
    index_j = 2
    index_i = 2
    execute_on = timestep_end
  [../]
  [./gss]
   type = MaterialStdVectorAux
   variable = gss
   property = slip_system_resistance
   index = 0
   execute_on = timestep_end
  [../]
  [./slip_inc]
   type = MaterialStdVectorAux
   variable = slip_increment
   property = plastic_slip_increment
   index = 0
   execute_on = timestep_end
  [../]
  [./tau]
   type = MaterialStdVectorAux
   variable = tau
   property = applied_shear_stress
   index = 0
   execute_on = timestep_end
  [../]
  [./euler_angle1]
    type = MaterialRealVectorValueAux
    variable = euler_angle1
    property = Euler_angles
    component = 0
    execute_on = timestep_end
  [../]
  [./euler_angle2]
    type = MaterialRealVectorValueAux
    variable = euler_angle2
    property = Euler_angles
    component = 1
    execute_on = timestep_end
  [../]
  [./euler_angle3]
    type = MaterialRealVectorValueAux
    variable = euler_angle3
    property = Euler_angles
    component = 2
    execute_on = timestep_end
  [../]
[]

[BCs]
  [./symmy]
    type = PresetBC
    variable = disp_y
    boundary = bottom
    value = 0
  [../]
  [./symmx]
    type = PresetBC
    variable = disp_x
    boundary = left
    value = 0
  [../]
  [./symmz]
    type = PresetBC
    variable = disp_z
    boundary = back
    value = 0
  [../]
  [./tdisp]
    type = FunctionPresetBC
    variable = disp_z
    boundary = front
    function = tdisp
  [../]
[]

[Materials]
  [./elasticity_tensor]
    type = ComputeElasticityTensorConstantRotationCP
    C_ijkl = '1.684e5 1.214e5 1.214e5 1.684e5 1.214e5 1.684e5 0.754e5 0.754e5 0.754e5'
    fill_method = symmetric9
    euler_angle_1 = 90
    euler_angle_2 = 90
    euler_angle_3 = 0
  [../]
  [./stress]
    type = ComputeCrystalPlasticityStress
    crystal_plasticity_update_model = 'trial_xtalpl'
  [../]
  [./trial_xtalpl]
    type = CrystalPlasticityKalidindiUpdate
    number_slip_systems = 12
    slip_sys_file_name = fcc_input_slip_sys.txt
    # use_displaced_mesh = true
  [../]
[]

[Postprocessors]
  [./stress_zz]
    type = ElementAverageValue
    variable = stress_zz
  [../]
  [./pk2]
   type = ElementAverageValue
   variable = pk2
  [../]
  [./fp_zz]
    type = ElementAverageValue
    variable = fp_zz
  [../]
  [./e_zz]
    type = ElementAverageValue
    variable = e_zz
  [../]
  [./gss]
    type = ElementAverageValue
    variable = gss
  [../]
  [./slip_increment]
   type = ElementAverageValue
   variable = slip_increment
  [../]
  [./tau]
   type = ElementAverageValue
   variable = tau
  [../]
  [./euler_angle1]
    type = ElementAverageValue
    variable = euler_angle1
  [../]
  [./euler_angle2]
    type = ElementAverageValue
    variable = euler_angle2
  [../]
  [./euler_angle3]
    type = ElementAverageValue
    variable = euler_angle3
  [../]
[]

[Preconditioning]
  [./smp]
    type = SMP
    full = true
  [../]
[]

[Executioner]
  type = Transient
  solve_type = 'PJFNK'

  l_tol = 1e-3
  petsc_options_iname = '-pc_type -pc_asm_overlap -sub_pc_type -ksp_type -ksp_gmres_restart'
  petsc_options_value = ' asm      2              lu            gmres     200'
  nl_abs_tol = 1e-10
  nl_rel_tol = 1e-10

  dt = 0.05
  end_time = 10
  dtmin = 0.01
  dtmax = 10.0
[]

[Outputs]
  exodus = true
[]
