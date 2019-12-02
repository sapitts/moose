//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#pragma once

#include "ADComputeEigenstrainBase.h"

template <ComputeStage compute_stage>
class ADComputeOxidationEigenstrain;

declareADValidParams(ADComputeOxidationEigenstrain);

/**
 * ADComputeOxidationEigenstrain is
 */
template <ComputeStage compute_stage>
class ADComputeOxidationEigenstrain : public ADComputeEigenstrainBase<compute_stage>
{
public:
  ADComputeOxidationEigenstrain<compute_stage>(const InputParameters & parameters);

  static InputParameters validParams();

protected:
  virtual void computeQpEigenstrain();

  /*
   * Compute the lateral and radial oxide growth-induced strains, following the
   * approach of Sabau and Wright Oxid Met (2010) 73:467-492, Table 9
   */
  // void computeOxideGrowthStrain(/*RankTwoTensor & oxide_growth_strain*/);

  const Real & _pbr;

  const Function * const _growth_rate;

  const Real & _omega;
  const Real & _B_constant;

  usingComputeEigenstrainBaseMembers;
};
