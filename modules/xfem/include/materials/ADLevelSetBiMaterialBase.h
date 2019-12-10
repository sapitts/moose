//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "ADMaterial.h"

#define usingBiMaterialBaseMembers                                                          \
  usingMaterialMembers;                                                                     \
  using ADLevelSetBiMaterialBase<compute_stage>::_base_name;                                \
  using ADLevelSetBiMaterialBase<compute_stage>::_prop_name;                                \
  using ADLevelSetBiMaterialBase<compute_stage>::_xfem;                                     \
  using ADLevelSetBiMaterialBase<compute_stage>::_level_set_var_number;                     \
  using ADLevelSetBiMaterialBase<compute_stage>::_use_positive_property

// Forward Declarations
template <ComputeStage>
class ADLevelSetBiMaterialBase;
// template <ComputeStage>
class XFEM;

/**
 * Base class for switching between materials in a bi-material system where the interface is defined
 * by a level set function.
 */
template <ComputeStage compute_stage>
class ADLevelSetBiMaterialBase : public ADMaterial<compute_stage>
{
public:
  ADLevelSetBiMaterialBase(const InputParameters & parameters);

protected:
  virtual void computeProperties();
  virtual void computeQpProperties();

  /// assign the material properties for the negative level set region.
  virtual void assignQpPropertiesForLevelSetNegative() = 0;

   /// assign the material properties for the positive level set region.
  virtual void assignQpPropertiesForLevelSetPositive() = 0;

  /// global material properties
  const std::string _base_name;

  /// Property name
  std::string _prop_name;

  /// shared pointer to XFEM
  std::shared_ptr<XFEM> _xfem;

  /// The variable number of the level set variable we are operating on
  const unsigned int _level_set_var_number;

  /// system reference
  const System & _system;

  /// the subproblem solution vector
  const NumericVector<Number> * _solution;

  /// use the positive level set region's material properties
  bool _use_positive_property;

  usingMaterialMembers;
};

declareADValidParams(ADLevelSetBiMaterialBase);
