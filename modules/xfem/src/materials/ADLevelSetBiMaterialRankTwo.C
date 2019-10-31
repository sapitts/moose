//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "ADLevelSetBiMaterialRankTwo.h"

registerADMooseObject("XFEMApp", ADLevelSetBiMaterialRankTwo);

defineADValidParams(
    ADLevelSetBiMaterialRankTwo,
    ADLevelSetBiMaterialBase,
  params.addClassDescription(
      "Compute an AD RankTwoTensor material property for bi-materials problem (consisting of two "
      "different materials) defined by a level set function."););


template <ComputeStage compute_stage>
ADLevelSetBiMaterialRankTwo<compute_stage>::ADLevelSetBiMaterialRankTwo(
    const InputParameters & parameters)
  : ADLevelSetBiMaterialBase<compute_stage>(parameters),
    _bimaterial_material_prop(2),
    _material_prop(declareADProperty<RankTwoTensor>(_base_name + _prop_name))
{
  _bimaterial_material_prop[0] = &getADMaterialProperty<RankTwoTensor>(
      getParam<std::string>("levelset_positive_base") + "_" + _prop_name);
  _bimaterial_material_prop[1] = &getADMaterialProperty<RankTwoTensor>(
      getParam<std::string>("levelset_negative_base") + "_" + _prop_name);
}

template <ComputeStage compute_stage>
void
ADLevelSetBiMaterialRankTwo<compute_stage>::assignQpPropertiesForLevelSetPositive()
{
  _material_prop[_qp] = (*_bimaterial_material_prop[0])[_qp];
}

template <ComputeStage compute_stage>
void
ADLevelSetBiMaterialRankTwo<compute_stage>::assignQpPropertiesForLevelSetNegative()
{
  _material_prop[_qp] = (*_bimaterial_material_prop[1])[_qp];
}
