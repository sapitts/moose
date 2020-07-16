# To run this input file with a normal tensor mechanics executable, use the command
#  tensor_mechanics-opt -i fail_negative_trial_stress_2drz.i --allow-test-objects

[GlobalParams]
  displacements = 'disp_x disp_y'
[]

[Mesh]
  [./mesh]
    type = PatchMeshGenerator
    dim = 2
  [../]
[]

[Problem]s
  coord_type = RZ
[]

[AuxVariables]
  [./temperature]
    initial_condition = 900.0
  [../]
[]

[Modules/TensorMechanics/Master]
  [./all]
    strain = FINITE
    add_variables = true
    generate_output = 'stress_xx stress_xy stress_yy stress_zz strain_xx strain_xy strain_yy strain_zz'
    use_automatic_differentiation = true
  [../]
[]

[BCs]
  [./symmy]
    type = ADDirichletBC
    variable = disp_y
    boundary = bottom
    value = 0
  [../]
  [./symmx]
    type = ADDirichletBC
    variable = disp_x
    boundary = left
    value = 0
  [../]
  [./pressure_y]
    type = ADPressure
    variable = disp_y
    component = 1
    boundary = top
    constant = 2.5e6 #lowest allowable vonmises stress value is 2.01MPa
  [../]
[]

[Materials]
  [./elasticity_tensor]
    type = ADComputeIsotropicElasticityTensor
    youngs_modulus = 3.30e11
    poissons_ratio = 0.3
  [../]
  [./stress]
    type = ADComputeMultipleInelasticStress
    inelastic_models = rom_stress_prediction
  [../]
  [./rom_stress_prediction]
    type = SS316HLAROMANCEStressUpdateTest
    temperature = temperature
    extrapolate_to_zero_stress = true
    initial_mobile_dislocation_density = 9.0e12
    initial_immobile_dislocation_density = 8.6e11
    outputs = all
  [../]
[]

[Executioner]
  type = Transient
  solve_type = 'NEWTON'
  petsc_options_iname = '-ksp_type  -pc_type  -pc_factor_mat_solver_package'
  petsc_options_value = ' preonly    lu        superlu_dist'
  automatic_scaling = true
  line_search = 'none'

  l_max_its = 20
  l_tol = 1e-4
  nl_max_its = 10
  nl_abs_tol = 1e-16
  nl_rel_tol = 1e-4
  dt = 1.0e4

  num_steps = 2
[]

[Postprocessors]
  [./effective_strain_avg]
    type = ElementAverageValue
    variable = effective_creep_strain
  [../]
  [./temperature]
    type = ElementAverageValue
    variable = temperature
  [../]
  [./mobile_dislocations]
    type = ElementAverageValue
    variable = mobile_dislocations
  [../]
  [./immobile_disloactions]
    type = ElementAverageValue
    variable = immobile_dislocations
  [../]
[]

[Outputs]
  csv = true
[]
