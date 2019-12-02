//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "ADComputeOxidationEigenstrain.h"
#include "RankTwoTensor.h"

registerADMooseObject("TensorMechanicsApp", ADComputeOxidationEigenstrain);

template <ComputeStage compute_stage>
InputParameters
ADComputeOxidationEigenstrain<compute_stage>::validParams()
{
  InputParameters params = ADComputeEigenstrainBase<compute_stage>::validParams();
  params.addRequiredParam<std::string>("pillings_bedworth_ratio", "The value of the PBR ratio of the oxide volume to the alloy volume");
  params.addRequiredParam<FunctionName>("oxide_thickness_growth_rate", "The rate of the oxide thickness growth as given by the prescribed function, in m/s");
  params.addParam<std::string>("omega_pbr_constant", 0.1, "The Bernstein oxide eigenstrain reduction factor prescribed to prevent unrealistically high oxide growth-induced strains");
  params.addParam<std::string>("oxide_growth_proportionality_constant", 0.5, "The Sabau-Wright constant introduced to include lateral oxide growth-induced strains, in 1/m");

  return params;
}

template <ComputeStage compute_stage>
ADComputeOxidationEigenstrain<compute_stage>::ADComputeOxidationEigenstrain(
    const InputParameters & parameters)
  : ADComputeEigenstrainBase<compute_stage>(parameters),
    _pbr(getParam<Real>("pillings_bedworth_ratio")),
    _growth_rate(&getFunction("oxide_thickness_growth_rate")),
    _omega(getParam<Real>("omega_pbr_constant")),
    _B_constant(getParam<Real>("oxide_growth_proportionality_constant"))
{
}

template <ComputeStage compute_stage>
void
ADComputeOxidationEigenstrain<compute_stage>::computeQpEigenstrain()
{
  RankTwoTensor oxide_growth_strain;
  oxide_growth_strain.zero();
  computeOxideGrowthStrain(/*oxide_growth_strain*/);

  // add the oxide growth strain to the total stress free strain
  // _eigenstrain[_qp].zero();
  // _eigenstrain[_qp] = oxide_growth_strain;
}

template <ComputeStage compute_stage>
void
ADComputeOxidationEigenstrain<compute_stage>::computeOxideGrowthStrain(/*RankTwoTensor & oxide_growth_strain*/)
{
  ADReal hoop_eigenstrain = 0.0;
  ADReal radial_eigenstrain = 0.0;

  hoop_eigenstrain = _growth_rate->value(_t, _q_point[_qp]);
  hoop_eigenstrain /= _B_constant;
  
  radial_eigenstrain = _omega * (_pbr - 1.0) - 2.0 * hoop_eigenstrain;

  _eigenstrain[_qp](0,0) = radial_eigenstrain;
  for (unsigned int i = 1; i < 3; ++i)
    _eigenstrain[_qp](i,i) = hoop_eigenstrain;
}
