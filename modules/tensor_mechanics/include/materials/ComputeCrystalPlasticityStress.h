//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#ifndef COMPUTECRYSTALPLASTICITYSTRESS_H
#define COMPUTECRYSTALPLASTICITYSTRESS_H

#include "ComputeFiniteStrainElasticStress.h"

class CrystalPlasticityUpdate;
class ComputeCrystalPlasticityStress;

template <>

InputParameters validParams<ComputeCrystalPlasticityStress>();

/**
 * ComputeCrystalPlasticityStress saves the stress, elastic strain, and
 * plastic strain due to dislocation slip calculated by the StressUpdateBase
 * child class, ComputeCrystalPlasticityUpdate. Mechanical strain is
 * considered as the sum of the elastic and inelastic strains.
 */

class ComputeCrystalPlasticityStress : public ComputeFiniteStrainElasticStress
{
public:
  ComputeCrystalPlasticityStress(const InputParameters & parameters);

protected:
  virtual void initialSetup();

  /* Calls the user-specified crystal plasticity stress update materials
   * which compute and return the stress and jacobian preconditioner
   */
  virtual void computeQpStress();

  /// Rank-4 elasticity tensors
  const MaterialProperty<RankFourTensor> & _elasticity_tensor;


  /// The user supplied cyrstal plasticity consititutive model
  CrystalPlasticityUpdate * _model;
};

#endif //COMPUTECRYSTALPLASTICITYSTRESS_H
