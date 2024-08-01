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
[]

[Physics/SolidMechanics]
  [QuasiStatic/all]
    add_variables = true
  []
  [MaterialVectorBodyForce/all]
    body_force = force_density
  []
[]

[Functions]
  [diff_func_x]
    type = ParsedFunction
    expression = 1/t
  []
  [diff_func_y]
    type = ParsedFunction
    expression = 't*t + x'
  []
[]

[BCs]
  [no_x]
    type = DirichletBC
    variable = disp_x
    boundary = left
    value = 0.0
  []
  [no_y]
    type = DirichletBC
    variable = disp_y
    boundary = bottom
    value = 0.0
  []
  [no_z]
    type = DirichletBC
    variable = disp_z
    boundary = back
    value = 0.0
  []
[]

[Materials]
  [Elasticity_tensor]
    type = ComputeElasticityTensor
    fill_method = symmetric_isotropic
    C_ijkl = '0 0.5e6'
  []
  [stress]
    type = ComputeLinearElasticStress
  []
  [force_density]
    type = GenericFunctionVectorMaterial
    block = 0
    prop_names = force_density
    prop_values = 'diff_func_x diff_func_y 0'
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
