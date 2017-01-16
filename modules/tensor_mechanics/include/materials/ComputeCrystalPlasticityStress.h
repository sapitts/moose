/****************************************************************/
/* MOOSE - Multiphysics Object Oriented Simulation Environment  */
/*                                                              */
/*          All contents are licensed under LGPL V2.1           */
/*             See LICENSE for full restrictions                */
/****************************************************************/
#ifndef COMPUTECRYSTALPLASTICITYSTRESS_H
#define COMPUTECRYSTALPLASTICITYSTRESS_H

#include "ComputeFiniteStrainElasticStress.h"

// forward decl
class CrystalPlasticityUpdate;

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
   * which compute and return the stress and strains.
   */
  virtual void computeQpStress();

  /// Calls all of the user-specified radial recompute materials and iterates
  /// over the change in the effective radial return stress.
  // virtual void updateQpStress(RankTwoTensor & strain_increment,
  //                            RankTwoTensor & stress_new);

  // ///@{Input parameters associated with the recompute iteration to return the stress state to the yield surface
  // const unsigned int _max_its;
  // const Real _relative_tolerance;
  // const Real _absolute_tolerance;
  // const bool _output_iteration_info;
  // ///@}

  ///@{ Rank-4 and Rank-2 elasticity and elastic strain tensors
  const MaterialProperty<RankFourTensor> & _elasticity_tensor;
//  MaterialProperty<RankTwoTensor> & _elastic_strain_old;
//  const MaterialProperty<RankTwoTensor> & _strain_increment;
  ///@}

  /* The user supplied cyrstal plasticity consititutive model for use in
   * this simulation.
   */
  CrystalPlasticityUpdate * _model;
};

#endif //COMPUTECRYSTALPLASTICITYSTRESS_H
