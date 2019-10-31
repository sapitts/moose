//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "ADLevelSetBiMaterialBase.h"
#include "RankTwoTensor.h"

// Forward Declarations
template <ComputeStage>
class ADLevelSetBiMaterialRankTwo;
template <typename>
class RankTwoTensorTempl;
typedef RankTwoTensorTempl<Real> RankTwoTensor;
typedef RankTwoTensorTempl<DualReal> DualRankTwoTensor;

/**
 * Compute a RankTwoTensor material property for bi-materials problem (consisting of two different
 * materials) defined by a level set function
 *
 */
template <ComputeStage compute_stage>
class ADLevelSetBiMaterialRankTwo : public ADLevelSetBiMaterialBase<compute_stage>
{
public:
  ADLevelSetBiMaterialRankTwo(const InputParameters & parameters);

protected:
  virtual void assignQpPropertiesForLevelSetPositive() override;
  virtual void assignQpPropertiesForLevelSetNegative() override;

  /// RankTwoTensor Material properties for the two separate materials in the bi-material system
  std::vector<const ADMaterialProperty(RankTwoTensor) *> _bimaterial_material_prop;

  /// Global RankTwoTensor material property (switch bi-material diffusion coefficient based on level set values)
  ADMaterialProperty(RankTwoTensor) & _material_prop;

  usingBiMaterialBaseMembers;
};

declareADValidParams(ADLevelSetBiMaterialRankTwo);
