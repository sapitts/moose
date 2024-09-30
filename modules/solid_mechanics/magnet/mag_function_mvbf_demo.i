#
# MaterialVectorBodyForce Test
#
# This test is designed to apply gravity using the MaterialVectorBodyForce kernel/action.
#
# The mesh is composed of one block with a single element.
# The bottom is fixed in all three directions.  Poisson's ratio
# is zero, which makes it trivial to check displacements.
#

[GlobalParams]
  displacements = 'disp_x disp_y disp_z'
[]

[Mesh]
  type = GeneratedMesh
  dim = 3
  nx = 8
  ny = 16
  nz = 8
  ymax = 2
  elem_type = HEX27
[]

[Physics/SolidMechanics]
  [QuasiStatic/all]
    add_variables = true
    use_automatic_differentiation = false
    incremental = true
    generate_output = 'stress_xx stress_yy stress_zz vonmises_stress'
  []
  [MaterialVectorBodyForce/all]
    body_force = force_density
  []
[]

[Functions]
  [magnetic_field_density_r]
    type = ParsedFunction
    expression = '1.0e6 * t / (2.0 * 3.14 * ((x-0.5)^2 + (z-0.5)^2)^0.5)'
  []
[]

[BCs]
  [no_x]
    type = DirichletBC
    variable = disp_x
    boundary = bottom
    value = 0.0
  []
  [no_y]
    type =DirichletBC
    variable = disp_y
    boundary = bottom
    value = 0.0
  []
  [no_z]
    type = DirichletBC
    variable = disp_z
    boundary = bottom
    value = 0.0
  []
[]

[Materials]
  [Elasticity_tensor]
    type = ComputeIsotropicElasticityTensor
  youngs_modulus = 1.57e11  #Material properties from https://iopscience.iop.org/article/10.1088/1361-6668/ab7778, Table 1
  poissons_ratio = 0.3
  []
  [stress]
    type = ComputeFiniteStrainElasticStress
  []
  [force_density]
    type = GenericFunctionVectorMaterial
    block = 0
    prop_names = force_density
    prop_values = 'magnetic_field_density_r 0 magnetic_field_density_r'
  []
[]

[Executioner]
  type = Transient
  num_steps = 10
  dt = 0.1

  solve_type = 'PJFNK'

  petsc_options_iname = '-pc_type -pc_hypre_type'
  petsc_options_value = 'hypre boomeramg'
[]


[Outputs]
  [out]
    type = Exodus
    elemental_as_nodal = true
  []
[]
