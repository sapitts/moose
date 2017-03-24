//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#ifndef COMPUTEELASTICITYTENSORCONSTANTROTATIONCP_H
#define COMPUTEELASTICITYTENSORCONSTANTROTATIONCP_H

#include "ComputeElasticityTensor.h"
#include "RankTwoTensor.h"
#include "RotationTensor.h"

class ComputeElasticityTensorConstantRotationCP;

template <>
InputParameters validParams<ComputeElasticityTensorConstantRotationCP>();

/**
 * ComputeElasticityTensorConstantRotationCP defines an elasticity tensor material
 * object for crystal plasticity models which are formulated in the reference
 * configuration and therefore do not update their rotation tensor.
 * This class also defines the rotation matrix, based on the user-supplied Bunge
 * Euler angles, that is used by the crystal plasticity models to rotate the
 * crystal slip system direction and plane normals into the user-specified orientation.
 */
class ComputeElasticityTensorConstantRotationCP : public ComputeElasticityTensor
{
public:
  ComputeElasticityTensorConstantRotationCP(const InputParameters & parameters);

protected:
  /**
   * Defines the constant rotation matrix from the user specified
   * Bunge Euler Angles.
   */
  virtual void initQpStatefulProperties() override;

  /// Crystal Rotation Matrix used to rotate the slip system direction and normal
  MaterialProperty<RankTwoTensor> & _crysrot;

  /// Rotation matrix
  RotationTensor _R;

  /// Transpose of rotation matrix: used for the active crystal rotation
  RankTwoTensor _crysrot_constant;
};

#endif // COMPUTEELASTICITYTENSORCONSTANTROTATIONCP_H
