[Mesh]
  type = GeneratedMesh
  dim = 3
  elem_type = HEX8
  displacements = 'ux uy uz'
[]

[Variables]
  [./ux]
    block = 0
  [../]
  [./uy]
    block = 0
  [../]
  [./uz]
    block = 0
  [../]
[]

[AuxVariables]
  [./stress_zz]
    order = CONSTANT
    family = MONOMIAL
    block = 0
  [../]
  [./pk2]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./fp_zz]
    order = CONSTANT
    family = MONOMIAL
    block = 0
  [../]
  [./rotout]
    order = CONSTANT
    family = MONOMIAL
    block = 0
  [../]
  [./e_zz]
    order = CONSTANT
    family = MONOMIAL
    block = 0
  [../]
  [./gss]
    order = CONSTANT
    family = MONOMIAL
    block = 0
  [../]
  [./mobile_disl]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./immobile_disl]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./slip_increment]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./glide_velocity]
    order = CONSTANT
    family = MONOMIAL
  [../]
  [./tau]
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

[Kernels]
  [./TensorMechanics]
    displacements = 'ux uy uz'
    use_displaced_mesh = true
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
    block = 0
  [../]
  [./pk2]
    type = RankTwoAux
    variable = pk2
    rank_two_tensor = pk2
    index_j = 2
    index_i = 2
    execute_on = timestep_end
    block = 0
  [../]
  [./fp_zz]
    type = RankTwoAux
    variable = fp_zz
    rank_two_tensor = fp
    index_j = 2
    index_i = 2
    execute_on = timestep_end
    block = 0
  [../]
  [./e_zz]
    type = RankTwoAux
    variable = e_zz
    rank_two_tensor = lage
    index_j = 2
    index_i = 2
    execute_on = timestep_end
    block = 0
  [../]
  [./rotout]
    type = CrystalPlasticityRotationOutAux
    variable = rotout
    execute_on = timestep_end
    block = 0
  [../]
  [./gss]
    type = MaterialStdVectorAux
    variable = gss
    property = slip_system_resistance
    index = 0
    execute_on = timestep_end
    block = 0
  [../]
  [./mobile_disl]
    type = MaterialStdVectorAux
    variable = mobile_disl
    property = mobile_dislocations
    index = 0
    execute_on = timestep_end
  [../]
  [./immobile_disl]
    type = MaterialStdVectorAux
    variable = immobile_disl
    property = immobile_dislocations
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
  [./glide_velocity]
    type = MaterialStdVectorAux
    variable = glide_velocity
    property = dislocation_glide_velocity
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
[]

[BCs]
  [./symmy]
    type = PresetBC
    variable = uy
    boundary = bottom
    value = 0
  [../]
  [./symmx]
    type = PresetBC
    variable = ux
    boundary = left
    value = 0
  [../]
  [./symmz]
    type = PresetBC
    variable = uz
    boundary = back
    value = 0
  [../]
  [./tdisp]
    type = FunctionPresetBC
    variable = uz
    boundary = front
    function = tdisp
  [../]
[]

[Materials]
  [./elasticity_tensor]
    type = ComputeElasticityTensorCP
    block = 0
    C_ijkl = '1.684e5 1.214e5 1.214e5 1.684e5 1.214e5 1.684e5 0.754e5 0.754e5 0.754e5'
    fill_method = symmetric9
  [../]
  [./strain]
    type = ComputeFiniteStrain
    block = 0
    displacements = 'ux uy uz'
  [../]
  [./stress]
    type = ComputeCrystalPlasticityStress
    block = 0
    crystal_plasticity_update_model = 'trial_xtalpl'
  [../]
  [./trial_xtalpl]
    type = CrystalPlasticityCDDUpdate
    block = 0
    number_slip_systems = 12
    slip_sys_file_name = input_slip_sys.txt
#    Peierls_stress = 1.1e+01
    Peierls_stress = 11
    resistance_tol = 10
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
  [./rotout]
    type = ElementAverageValue
    variable = rotout
  [../]
  [./e_zz]
    type = ElementAverageValue
    variable = e_zz
  [../]
  [./gss]
    type = ElementAverageValue
    variable = gss
  [../]
  [./mobile_disl]
    type = ElementAverageValue
    variable = mobile_disl
  [../]
  [./immobile_disl]
    type = ElementAverageValue
    variable = immobile_disl
  [../]
  [./slip_increment]
    type = ElementAverageValue
    variable = slip_increment
  [../]
  [./glide_velocity]
    type = ElementAverageValue
    variable = glide_velocity
  [../]
  [./tau]
    type = ElementAverageValue
    variable = tau
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
  dt = 0.005

  #Preconditioned JFNK (default)
  solve_type = 'PJFNK'

  petsc_options_iname = -pc_hypre_type
  petsc_options_value = boomerang
  nl_abs_tol = 1e-10
  nl_rel_step_tol = 1e-10
  dtmax = 10.0
  nl_rel_tol = 1e-10
  ss_check_tol = 1e-10
  end_time = 1
  dtmin = 0.0001
  num_steps = 500
  nl_abs_step_tol = 1e-10
[]

[Outputs]
  exodus = true
[]
#
#[Problem]
#  use_legacy_uo_initialization = false
#[]
