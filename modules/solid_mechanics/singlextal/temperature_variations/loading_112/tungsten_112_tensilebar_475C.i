tempC = 475 ## value of the testing temperature in celcius

###
# Then compute the expected elasticity constants here, to avoid cluttering the input file later
# using expressions from Lowrie and Gonas (1967) J. Applied Physics
#   expressions converted from dyn/cm^-2 to MPa
c11 = ${fparse 5.2349e5 - 4.5967e1 * tempC - 5.467e-3 * tempC * tempC}
c12 = ${fparse 2.0445e5 - 0.3403e1 * tempC - 3.249e-3 * tempC * tempC}
c44 = ${fparse 1.6028e5 - 1.0320e1 * tempC - 2.054e-3 * tempC * tempC}
gmod = ${fparse 1.6028e5 - 1.456e1 * tempC - 3.28e-3 * tempC * tempC}

#################################

[GlobalParams]
  displacements = 'disp_x disp_y disp_z'
[]

[Mesh]
  [cube]
    type = GeneratedMeshGenerator
    dim = 3
    nx = 8
    ny = 8
    nz = 16
    zmax = 2
    elem_type = HEX27
  []
[]

[AuxVariables]
  [temperature]
    initial_condition = ${fparse tempC + 273}
  []
  [pk2_zz]
    order = FIRST
    family = MONOMIAL
  []
  [fp_zz]
    order = FIRST
    family = MONOMIAL
  []
  [e_zz]
    order = FIRST
    family = MONOMIAL
  []
  [pk2_xx]
    order = FIRST
    family = MONOMIAL
  []
  [fp_xx]
    order = FIRST
    family = MONOMIAL
  []
  [e_xx]
    order = FIRST
    family = MONOMIAL
  []
  [pk2_yy]
    order = FIRST
    family = MONOMIAL
  []
  [fp_yy]
    order = FIRST
    family = MONOMIAL
  []
  [e_yy]
    order = FIRST
    family = MONOMIAL
  []
  [vonmises_stress_cauchy]
    order = FIRST
    family = MONOMIAL
  []
  [eff_strain_green]
    order = FIRST
    family = MONOMIAL
  []
  [vonmises_stress_pk2]
    order = FIRST
    family = MONOMIAL
  []
  [eff_strain_lag]
    order = FIRST
    family = MONOMIAL
  []
  [gss_0]
    order = FIRST
    family = MONOMIAL
  []
  [dislocation_0]
    order = CONSTANT
    family = MONOMIAL
  []
  [slip_incr_0]
    order = FIRST
    family = MONOMIAL
  []
  [tau_0]
    order = FIRST
    family = MONOMIAL
  []
  [gss_1]
    order = FIRST
    family = MONOMIAL
  []
  [dislocation_1]
    order = CONSTANT
    family = MONOMIAL
  []
  [slip_incr_1]
    order = FIRST
    family = MONOMIAL
  []
  [tau_1]
    order = FIRST
    family = MONOMIAL
  []
  [gss_2]
    order = FIRST
    family = MONOMIAL
  []
  [dislocation_2]
    order = CONSTANT
    family = MONOMIAL
  []
  [slip_incr_2]
    order = FIRST
    family = MONOMIAL
  []
  [tau_2]
    order = FIRST
    family = MONOMIAL
  []
  [gss_3]
    order = FIRST
    family = MONOMIAL
  []
  [dislocation_3]
    order = CONSTANT
    family = MONOMIAL
  []
  [slip_incr_3]
    order = FIRST
    family = MONOMIAL
  []
  [tau_3]
    order = FIRST
    family = MONOMIAL
  []
  [gss_4]
    order = FIRST
    family = MONOMIAL
  []
  [dislocation_4]
    order = CONSTANT
    family = MONOMIAL
  []
  [slip_incr_4]
    order = FIRST
    family = MONOMIAL
  []
  [tau_4]
    order = FIRST
    family = MONOMIAL
  []
  [gss_5]
    order = FIRST
    family = MONOMIAL
  []
  [dislocation_5]
    order = CONSTANT
    family = MONOMIAL
  []
  [slip_incr_5]
    order = FIRST
    family = MONOMIAL
  []
  [tau_5]
    order = FIRST
    family = MONOMIAL
  []
  [gss_6]
    order = FIRST
    family = MONOMIAL
  []
  [dislocation_6]
    order = CONSTANT
    family = MONOMIAL
  []
  [slip_incr_6]
    order = FIRST
    family = MONOMIAL
  []
  [tau_6]
    order = FIRST
    family = MONOMIAL
  []
  [gss_7]
    order = FIRST
    family = MONOMIAL
  []
  [dislocation_7]
    order = CONSTANT
    family = MONOMIAL
  []
  [slip_incr_7]
    order = FIRST
    family = MONOMIAL
  []
  [tau_7]
    order = FIRST
    family = MONOMIAL
  []
  [gss_8]
    order = FIRST
    family = MONOMIAL
  []
  [dislocation_8]
    order = CONSTANT
    family = MONOMIAL
  []
  [slip_incr_8]
    order = FIRST
    family = MONOMIAL
  []
  [tau_8]
    order = FIRST
    family = MONOMIAL
  []
  [gss_9]
    order = FIRST
    family = MONOMIAL
  []
  [dislocation_9]
    order = CONSTANT
    family = MONOMIAL
  []
  [slip_incr_9]
    order = FIRST
    family = MONOMIAL
  []
  [tau_9]
    order = FIRST
    family = MONOMIAL
  []
  [gss_10]
    order = FIRST
    family = MONOMIAL
  []
  [dislocation_10]
    order = CONSTANT
    family = MONOMIAL
  []
  [slip_incr_10]
    order = FIRST
    family = MONOMIAL
  []
  [tau_10]
    order = FIRST
    family = MONOMIAL
  []
  [gss_11]
    order = FIRST
    family = MONOMIAL
  []
  [dislocation_11]
    order = CONSTANT
    family = MONOMIAL
  []
  [slip_incr_11]
    order = FIRST
    family = MONOMIAL
  []
  [tau_11]
    order = FIRST
    family = MONOMIAL
  []
[]

[Physics/SolidMechanics/QuasiStatic/all]
  strain = FINITE
  incremental = true
  add_variables = true
  additional_generate_output = 'stress_zz stress_xx stress_yy vonmises_stress'
  additional_material_output_order = FIRST
[]

[AuxKernels]
  [pk2_zz]
    type = RankTwoAux
    variable = pk2_zz
    rank_two_tensor = second_piola_kirchhoff_stress
    index_j = 2
    index_i = 2
    execute_on = timestep_end
  []
  [fp_zz]
    type = RankTwoAux
    variable = fp_zz
    rank_two_tensor = plastic_deformation_gradient
    index_j = 2
    index_i = 2
    execute_on = timestep_end
  []
  [e_zz]
    type = RankTwoAux
    variable = e_zz
    rank_two_tensor = total_lagrangian_strain
    index_j = 2
    index_i = 2
    execute_on = timestep_end
  []
  [pk2_xx]
    type = RankTwoAux
    variable = pk2_xx
    rank_two_tensor = second_piola_kirchhoff_stress
    index_j = 0
    index_i = 0
    execute_on = timestep_end
  []
  [fp_xx]
    type = RankTwoAux
    variable = fp_xx
    rank_two_tensor = plastic_deformation_gradient
    index_j = 0
    index_i = 0
    execute_on = timestep_end
  []
  [e_xx]
    type = RankTwoAux
    variable = e_xx
    rank_two_tensor = total_lagrangian_strain
    index_j = 0
    index_i = 0
    execute_on = timestep_end
  []
  [pk2_yy]
    type = RankTwoAux
    variable = pk2_yy
    rank_two_tensor = second_piola_kirchhoff_stress
    index_j = 1
    index_i = 1
    execute_on = timestep_end
  []
  [fp_yy]
    type = RankTwoAux
    variable = fp_yy
    rank_two_tensor = plastic_deformation_gradient
    index_j = 1
    index_i = 1
    execute_on = timestep_end
  []
  [e_yy]
    type = RankTwoAux
    variable = e_yy
    rank_two_tensor = total_lagrangian_strain
    index_j = 1
    index_i = 1
    execute_on = timestep_end
  []
  [vonmises_stress_cauchy]
    type = RankTwoScalarAux
    variable = vonmises_stress_cauchy
    rank_two_tensor = stress
    scalar_type = VonMisesStress
    execute_on = timestep_end
  []
  [effective_strain_green]
    type = RankTwoScalarAux
    variable = eff_strain_green
    rank_two_tensor = total_strain
    scalar_type = VonMisesStress
    execute_on = timestep_end
  []
  [vonmises_stress_pk2]
    type = RankTwoScalarAux
    variable = vonmises_stress_pk2
    rank_two_tensor = second_piola_kirchhoff_stress
    scalar_type = VonMisesStress
    execute_on = timestep_end
  []
  [effective_strain_lag]
    type = RankTwoScalarAux
    variable = eff_strain_lag
    rank_two_tensor = total_lagrangian_strain
    scalar_type = VonMisesStress
    execute_on = timestep_end
  []
  [gss_0]
    type = MaterialStdVectorAux
    variable = gss_0
    property = slip_resistance
    index = 0
    execute_on = timestep_end
  []
  [dislocation_0]
    type = MaterialStdVectorAux
    variable = dislocation_0
    property = dislocation_density
    index = 0
    execute_on = timestep_end
  []
  [slip_incr_0]
    type = MaterialStdVectorAux
    variable = slip_incr_0
    property = constitutive_slip_increment
    index = 0
    execute_on = timestep_end
  []
  [tau_0]
    type = MaterialStdVectorAux
    variable = tau_0
    property = applied_shear_stress
    index = 0
    execute_on = timestep_end
  []
  [gss_1]
    type = MaterialStdVectorAux
    variable = gss_1
    property = slip_resistance
    index = 1
    execute_on = timestep_end
  []
  [dislocation_1]
    type = MaterialStdVectorAux
    variable = dislocation_1
    property = dislocation_density
    index = 1
    execute_on = timestep_end
  []
  [slip_incr_1]
    type = MaterialStdVectorAux
    variable = slip_incr_1
    property = constitutive_slip_increment
    index = 1
    execute_on = timestep_end
  []
  [tau_1]
    type = MaterialStdVectorAux
    variable = tau_1
    property = applied_shear_stress
    index = 1
    execute_on = timestep_end
  []
  [gss_2]
    type = MaterialStdVectorAux
    variable = gss_2
    property = slip_resistance
    index = 2
    execute_on = timestep_end
  []
  [dislocation_2]
    type = MaterialStdVectorAux
    variable = dislocation_2
    property = dislocation_density
    index = 2
    execute_on = timestep_end
  []
  [slip_incr_2]
    type = MaterialStdVectorAux
    variable = slip_incr_2
    property = constitutive_slip_increment
    index = 2
    execute_on = timestep_end
  []
  [tau_2]
    type = MaterialStdVectorAux
    variable = tau_2
    property = applied_shear_stress
    index = 2
    execute_on = timestep_end
  []
  [gss_3]
    type = MaterialStdVectorAux
    variable = gss_3
    property = slip_resistance
    index = 3
    execute_on = timestep_end
  []
  [dislocation_3]
    type = MaterialStdVectorAux
    variable = dislocation_3
    property = dislocation_density
    index = 3
    execute_on = timestep_end
  []
  [slip_incr_3]
    type = MaterialStdVectorAux
    variable = slip_incr_3
    property = constitutive_slip_increment
    index = 3
    execute_on = timestep_end
  []
  [tau_3]
    type = MaterialStdVectorAux
    variable = tau_3
    property = applied_shear_stress
    index = 3
    execute_on = timestep_end
  []
  [gss_4]
    type = MaterialStdVectorAux
    variable = gss_4
    property = slip_resistance
    index = 4
    execute_on = timestep_end
  []
  [dislocation_4]
    type = MaterialStdVectorAux
    variable = dislocation_4
    property = dislocation_density
    index = 4
    execute_on = timestep_end
  []
  [slip_incr_4]
    type = MaterialStdVectorAux
    variable = slip_incr_4
    property = constitutive_slip_increment
    index = 4
    execute_on = timestep_end
  []
  [tau_4]
    type = MaterialStdVectorAux
    variable = tau_4
    property = applied_shear_stress
    index = 4
    execute_on = timestep_end
  []
  [gss_5]
    type = MaterialStdVectorAux
    variable = gss_5
    property = slip_resistance
    index = 5
    execute_on = timestep_end
  []
  [dislocation_5]
    type = MaterialStdVectorAux
    variable = dislocation_5
    property = dislocation_density
    index = 5
    execute_on = timestep_end
  []
  [slip_incr_5]
    type = MaterialStdVectorAux
    variable = slip_incr_5
    property = constitutive_slip_increment
    index = 5
    execute_on = timestep_end
  []
  [tau_5]
    type = MaterialStdVectorAux
    variable = tau_5
    property = applied_shear_stress
    index = 5
    execute_on = timestep_end
  []
  [gss_6]
    type = MaterialStdVectorAux
    variable = gss_6
    property = slip_resistance
    index = 6
    execute_on = timestep_end
  []
  [dislocation_6]
    type = MaterialStdVectorAux
    variable = dislocation_6
    property = dislocation_density
    index = 6
    execute_on = timestep_end
  []
  [slip_incr_6]
    type = MaterialStdVectorAux
    variable = slip_incr_6
    property = constitutive_slip_increment
    index = 6
    execute_on = timestep_end
  []
  [tau_6]
    type = MaterialStdVectorAux
    variable = tau_6
    property = applied_shear_stress
    index = 6
    execute_on = timestep_end
  []
  [gss_7]
    type = MaterialStdVectorAux
    variable = gss_7
    property = slip_resistance
    index = 7
    execute_on = timestep_end
  []
  [dislocation_7]
    type = MaterialStdVectorAux
    variable = dislocation_7
    property = dislocation_density
    index = 7
    execute_on = timestep_end
  []
  [slip_incr_7]
    type = MaterialStdVectorAux
    variable = slip_incr_7
    property = constitutive_slip_increment
    index = 7
    execute_on = timestep_end
  []
  [tau_7]
    type = MaterialStdVectorAux
    variable = tau_7
    property = applied_shear_stress
    index = 7
    execute_on = timestep_end
  []
  [gss_8]
    type = MaterialStdVectorAux
    variable = gss_8
    property = slip_resistance
    index = 8
    execute_on = timestep_end
  []
  [dislocation_8]
    type = MaterialStdVectorAux
    variable = dislocation_8
    property = dislocation_density
    index = 8
    execute_on = timestep_end
  []
  [slip_incr_8]
    type = MaterialStdVectorAux
    variable = slip_incr_8
    property = constitutive_slip_increment
    index = 8
    execute_on = timestep_end
  []
  [tau_8]
    type = MaterialStdVectorAux
    variable = tau_8
    property = applied_shear_stress
    index = 8
    execute_on = timestep_end
  []
  [gss_9]
    type = MaterialStdVectorAux
    variable = gss_9
    property = slip_resistance
    index = 9
    execute_on = timestep_end
  []
  [dislocation_9]
    type = MaterialStdVectorAux
    variable = dislocation_9
    property = dislocation_density
    index = 9
    execute_on = timestep_end
  []
  [slip_incr_9]
    type = MaterialStdVectorAux
    variable = slip_incr_9
    property = constitutive_slip_increment
    index = 9
    execute_on = timestep_end
  []
  [tau_9]
    type = MaterialStdVectorAux
    variable = tau_9
    property = applied_shear_stress
    index = 9
    execute_on = timestep_end
  []
  [gss_10]
    type = MaterialStdVectorAux
    variable = gss_10
    property = slip_resistance
    index = 10
    execute_on = timestep_end
  []
  [dislocation_10]
    type = MaterialStdVectorAux
    variable = dislocation_10
    property = dislocation_density
    index = 10
    execute_on = timestep_end
  []
  [slip_incr_10]
    type = MaterialStdVectorAux
    variable = slip_incr_10
    property = constitutive_slip_increment
    index = 10
    execute_on = timestep_end
  []
  [tau_10]
    type = MaterialStdVectorAux
    variable = tau_10
    property = applied_shear_stress
    index = 10
    execute_on = timestep_end
  []
  [gss_11]
    type = MaterialStdVectorAux
    variable = gss_11
    property = slip_resistance
    index = 11
    execute_on = timestep_end
  []
  [dislocation_11]
    type = MaterialStdVectorAux
    variable = dislocation_11
    property = dislocation_density
    index = 11
    execute_on = timestep_end
  []
  [slip_incr_11]
    type = MaterialStdVectorAux
    variable = slip_incr_11
    property = constitutive_slip_increment
    index = 11
    execute_on = timestep_end
  []
  [tau_11]
    type = MaterialStdVectorAux
    variable = tau_11
    property = applied_shear_stress
    index = 11
    execute_on = timestep_end
  []
[]

[BCs]
  [fixed_bottom_y]
    type = DirichletBC
    variable = disp_y
    boundary = 'back'
    value = 0.0
  []
  [fixed_bottom_x]
    type = DirichletBC
    variable = disp_x
    boundary = 'back'
    value = 0.0
  []
  [fixed_bottom_z]
    type = DirichletBC
    variable = disp_z
    boundary = 'back'
    value = 0.0
  []
  [tdisp]
    type = FunctionDirichletBC
    variable = disp_z
    boundary = 'front'
    function = '1.0e-3*t' #corresponds to the applied strain rate in Sept 2024 elevated temperature testing
  []
[]

[Materials]
  [elasticity_tensor_xtal]
    type = ComputeElasticityTensorCP
    C_ijkl = '${c11} ${c12} ${c12} ${c11} ${c12} ${c11} ${c44} ${c44} ${c44}' # from Lowrie and Gonas (1967) J. Applied Physics
    fill_method = symmetric9
    euler_angle_1 = 0.0
    euler_angle_2 = 35.264
    euler_angle_3 = 45.0
  []
  [stress]
    type = ComputeMultipleCrystalPlasticityStress
    crystal_plasticity_models = 'trial_xtalpl'
    tan_mod_type = exact
    maximum_substep_iteration = 5
    # print_state_variable_convergence_error_messages = true
  []
  [trial_xtalpl]
    type = CrystalPlasticityTungstenGlideUpdate
    number_slip_systems = 12
    slip_sys_file_name = input_slip_sys_bcc12.txt
    temperature = temperature
    initial_dislocation_density = 1.0e5 # Argon and Maloof 1966 #5.5e3 from Brunner 2010  #4.5e8 # roughly David's measurement # 1.0e7 from Srivastava et al (2013), assumed equal to mobile
    burgers_vector = 2.74e-07 # Lim et al (2015) JMPS
    dislocation_multiplication_coefficient = 1
    dipole_annihilation_distance = 2.74e-07 #given in Cereceda et al 2016 as equal to the burgers vector, CHECK THIS AGAIN LATER
    lattice_friction = 12.0 #Lim et al (2015) JMPS, High temperature value
    shear_modulus = ${gmod} # calculated from Lowrie and Gonas (1967) J. Applied Physics
    stol = 1.0e-3
    # print_state_variable_convergence_error_messages = true
  []
[]

[Postprocessors]
  [value_c11]
    type = ConstantPostprocessor
    value = ${c11}
  []
  [value_c12]
    type = ConstantPostprocessor
    value = ${c12}
  []
  [value_c44]
    type = ConstantPostprocessor
    value = ${c44}
  []
  [value_gmod]
    type = ConstantPostprocessor
    value = ${gmod}
  []
  [stress_zz]
    type = ElementAverageValue
    variable = stress_zz
  []
  [pk2_zz]
    type = ElementAverageValue
    variable = pk2_zz
  []
  [fp_zz]
    type = ElementAverageValue
    variable = fp_zz
  []
  #[rot_out_001]
  #  type = ElementAverageValue
  #  variable = rot_out_001
  #[]
  [e_zz]
    type = ElementAverageValue
    variable = e_zz
  []
  [stress_xx]
    type = ElementAverageValue
    variable = stress_xx
  []
  [pk2_xx]
    type = ElementAverageValue
    variable = pk2_xx
  []
  [fp_xx]
    type = ElementAverageValue
    variable = fp_xx
  []
  [e_xx]
    type = ElementAverageValue
    variable = e_xx
  []
  [stress_yy]
    type = ElementAverageValue
    variable = stress_yy
  []
  [pk2_yy]
    type = ElementAverageValue
    variable = pk2_yy
  []
  [fp_yy]
    type = ElementAverageValue
    variable = fp_yy
  []
  [e_yy]
    type = ElementAverageValue
    variable = e_yy
  []
  [vonmises_stress_cauchy]
    type = ElementAverageValue
    variable = vonmises_stress_cauchy
  []
  [effective_strain_green]
    type = ElementAverageValue
    variable = eff_strain_green
  []
  [vonmises_stress_pk2]
    type = ElementAverageValue
    variable = vonmises_stress_pk2
  []
  [effective_strain]
    type = ElementAverageValue
    variable = eff_strain_lag
  []
  [gss_0]
    type = ElementAverageValue
    variable = gss_0
  []
  [dislocation_0]
    type = ElementAverageValue
    variable = dislocation_0
  []
  [slip_incr_0]
    type = ElementAverageValue
    variable = slip_incr_0
  []
  [tau_0]
    type = ElementAverageValue
    variable = tau_0
  []
  [gss_1]
    type = ElementAverageValue
    variable = gss_1
  []
  [dislocation_1]
    type = ElementAverageValue
    variable = dislocation_1
  []
  [slip_incr_1]
    type = ElementAverageValue
    variable = slip_incr_1
  []
  [tau_1]
    type = ElementAverageValue
    variable = tau_1
  []
  [gss_2]
    type = ElementAverageValue
    variable = gss_2
  []
  [dislocation_2]
    type = ElementAverageValue
    variable = dislocation_2
  []
  [slip_incr_2]
    type = ElementAverageValue
    variable = slip_incr_2
  []
  [tau_2]
    type = ElementAverageValue
    variable = tau_2
  []
  [gss_3]
    type = ElementAverageValue
    variable = gss_3
  []
  [dislocation_3]
    type = ElementAverageValue
    variable = dislocation_3
  []
  [slip_incr_3]
    type = ElementAverageValue
    variable = slip_incr_3
  []
  [tau_3]
    type = ElementAverageValue
    variable = tau_3
  []
  [gss_4]
    type = ElementAverageValue
    variable = gss_4
  []
  [dislocation_4]
    type = ElementAverageValue
    variable = dislocation_4
  []
  [slip_incr_4]
    type = ElementAverageValue
    variable = slip_incr_4
  []
  [tau_4]
    type = ElementAverageValue
    variable = tau_4
  []
  [gss_5]
    type = ElementAverageValue
    variable = gss_5
  []
  [dislocation_5]
    type = ElementAverageValue
    variable = dislocation_5
  []
  [slip_incr_5]
    type = ElementAverageValue
    variable = slip_incr_5
  []
  [tau_5]
    type = ElementAverageValue
    variable = tau_5
  []
  [gss_6]
    type = ElementAverageValue
    variable = gss_6
  []
  [dislocation_6]
    type = ElementAverageValue
    variable = dislocation_6
  []
  [slip_incr_6]
    type = ElementAverageValue
    variable = slip_incr_6
  []
  [tau_6]
    type = ElementAverageValue
    variable = tau_6
  []
  [gss_7]
    type = ElementAverageValue
    variable = gss_7
  []
  [dislocation_7]
    type = ElementAverageValue
    variable = dislocation_7
  []
  [slip_incr_7]
    type = ElementAverageValue
    variable = slip_incr_7
  []
  [tau_7]
    type = ElementAverageValue
    variable = tau_7
  []
  [gss_8]
    type = ElementAverageValue
    variable = gss_8
  []
  [dislocation_8]
    type = ElementAverageValue
    variable = dislocation_8
  []
  [slip_incr_8]
    type = ElementAverageValue
    variable = slip_incr_8
  []
  [tau_8]
    type = ElementAverageValue
    variable = tau_8
  []
  [gss_9]
    type = ElementAverageValue
    variable = gss_9
  []
  [dislocation_9]
    type = ElementAverageValue
    variable = dislocation_9
  []
  [slip_incr_9]
    type = ElementAverageValue
    variable = slip_incr_9
  []
  [tau_9]
    type = ElementAverageValue
    variable = tau_9
  []
  [gss_10]
    type = ElementAverageValue
    variable = gss_10
  []
  [dislocation_10]
    type = ElementAverageValue
    variable = dislocation_10
  []
  [slip_incr_10]
    type = ElementAverageValue
    variable = slip_incr_10
  []
  [tau_10]
    type = ElementAverageValue
    variable = tau_10
  []
  [gss_11]
    type = ElementAverageValue
    variable = gss_11
  []
  [dislocation_11]
    type = ElementAverageValue
    variable = dislocation_11
  []
  [slip_incr_11]
    type = ElementAverageValue
    variable = slip_incr_11
  []
  [tau_11]
    type = ElementAverageValue
    variable = tau_11
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
  residual_and_jacobian_together = true

  petsc_options_iname = '-pc_type'
  petsc_options_value = ' lu'
  # petsc_options_iname = '-pc_type -pc_asm_overlap -sub_pc_type -ksp_type -ksp_gmres_restart'
  # petsc_options_value = ' asm      2              lu            gmres     200'
  nl_abs_tol = 1e-10
  nl_rel_tol = 1e-8 # was 1e-10 in initial testing
  nl_max_its = 15
  end_time = 12.0 #time needed to reach 0.6% strain at the prescribed strain rate

  [TimeStepper]
    type = IterationAdaptiveDT
    optimal_iterations = 6
    linear_iteration_ratio = 10
    dt = 0.1
    growth_factor = 3.0
    cutback_factor = 0.5
    iteration_window = 1
  []
[]

[Outputs]
  exodus = true
  csv = true
  color = false
  # checkpoint = true
  perf_graph = true
[]
