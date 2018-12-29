//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html

#include "CrystalPlasticityCDDUpdateBaseInternalFcnsGNDs.h"
#include "libmesh/utility.h"
#include "SystemBase.h"
#include "MooseVariable.h"

template <>
InputParameters validParams<CrystalPlasticityCDDUpdateBaseInternalFcnsGNDs>()
{
  InputParameters params = validParams<CrystalPlasticityUpdate>();
  params.addClassDescription("Continuum Dislocation Dynamics model for crystal plasticity, relating mobile dislocations to slip through Orowan's law.");
  params.addParam<Real>("temperature", 323.0, "The coupled temperature, in K");

  params.addParam<NonlinearVariableName>("displacement_variable", "disp_x", "The name of one of the displacement variables used in the simulation");

  params.addParam<Real>("burgers_vector", 2.48e-7, "The Burger's vector for the material, in mm");
  params.addParam<Real>("initial_mobile_dislocation_density", 1.0e6, "Initial density of mobile dislocation densities, in 1/mm^2");
  params.addParam<Real>("initial_immobile_dislocation_density", 1.0e6, "Initial density of immobile dislocation densities, in 1/mm^2");
  params.addParam<Real>("gamma_o", 4.0e-2, "reference strain rate on the slip system, in mm/s");
  params.addParam<Real>("strain_rate_sensitivity_exponent", 0.012, "The strain rate sensitivity exponent for the power law relationship of resolved shear stress");
  params.addParam<Real>("Peierls_stress", 11.0, "Internal friction strength for the individual slip system, in MPa");
  params.addParam<Real>("shear_modulus", 80.0e3, "The shear modulus of the crystal, in MPa");

  params.addParam<Real>("Baily_Hirsch_barrier_coefficient", 0.4, "Leading coefficient for the Baily-Hirsch dispersed barrier hardening model");
  params.addParam<Real>("dislocation_latent_hardening_parameter", 0.2, "Latent hardening factor for slip system hardening due to dislocations on other slip systems");
  params.addParam<Real>("dislocation_self_hardening_parameter", 1.0, "Self hardening factor for slip system hardening due to dislocations on the same slip system");

  params.addParam<Real>("alpha_1", 0.02, "Mobile dislocation multiplication coefficient");
  params.addParam<Real>("alpha_2", 1.0, "Mobile-mobile dislocation annhiliation coefficient");
  params.addParam<Real>("alpha_3", 0.002, "Immobilization of mobile dislocations coefficient: mobile dislocations becoming immobile");
  params.addParam<Real>("alpha_4", 0.002, "Mobilization of immobile dislocations coefficient: immobile dislocations becoming mobile due to higher stress");
  params.addParam<Real>("alpha_5", 0.018, "Cross-slip coefficient");
  params.addParam<Real>("cross_slip_barrier_strength", 5.0, "The strength of the crystal to resist cross slip");
  params.addParam<Real>("alpha_6", 1.0, "Mobile-immobile dislocation annhiliaton coefficient");
  params.addParam<Real>("radius_capture_annhiliation", 15.0, "Multiplier of the Burger's vector to determine the radius of capture for two annhiliating dislocations on the same slip plane");
  params.addParam<Real>("mean_free_glide_path_coefficient", 1.0, "The coefficient for the calculation of the mean free glide path term from the mobile and immobile dislocation densities");

  params.addParam<Real>("cross_slip_activation_barrier_factor", 0.004, "The factor by which to multiply the shear modulus to calculate the strength barrier which a dislocation must overcome to cross slip");
  params.addParam<Real>("cross_slip_activation_volume_factor", 20.0, "The factor by which to multiply the burger's vector to determine the volume required for a dislocation to cross slip");
  params.addParam<Real>("Boltzman_constant", 1.38065e-20, "Boltzman constant, in MPa-mm^3/K");
  MooseEnum cross_slip_calculation_type ("deterministic stochastic", "stochastic");
  params.addParam<MooseEnum>("cross_slip_calculation_type", cross_slip_calculation_type, "Type of method to use when calculating cross slip.  The deterministic method will allow cross slip from all slip systems in the family onto a single recieving slip system while the deterministic method allows cross slip among random slip system pairs based on a Monte Carlo analysis");

  params.addParam<bool>("include_GND_contribution", false, "Whether or not to include Geometrically Necessary Dislocations in the crystal plasticity model");
  // params.addCoupledVar("plastic_velocity_gradient_components", "The nodal patch recovery auxvariable storing the plastic velocity gradient components. The order (x,x) (x,y) (x,z) (y,x) (y,y) (y,z) (z,x) (z,y) and (z,z) is assumed.");
  params.addParam<Real>("GND_density_coefficient", 1.0, "Coefficient used to multiply by the burgers vector when calculating the geometrically necessary dislocations from the Nye's tensor");

  return params;
}

CrystalPlasticityCDDUpdateBaseInternalFcnsGNDs::CrystalPlasticityCDDUpdateBaseInternalFcnsGNDs(const InputParameters & parameters) :
    CrystalPlasticityUpdate(parameters),
    _mobile_dislocations(declareProperty<std::vector<Real> > ("mobile_dislocations")),
    _mobile_dislocations_old(getMaterialPropertyOld<std::vector<Real> > ("mobile_dislocations")),
    _immobile_dislocations(declareProperty<std::vector<Real> > ("immobile_dislocations")),
    _immobile_dislocations_old(getMaterialPropertyOld<std::vector<Real> > ("immobile_dislocations")),
    _cross_slip_dislocations(declareProperty<std::vector<Real> >("cross_slip_dislocations")),
    _geometrical_necessary_dislocations(declareProperty<Real>("density_norm_geometric_necessary_dislocations")),

    _slip_system_resistance(declareProperty<std::vector<Real> >("slip_system_resistance")),
    _slip_system_resistance_old(getMaterialPropertyOld<std::vector<Real> >("slip_system_resistance")),
    _static_resistance_contribution(declareProperty<std::vector<Real> >("static_resistance_contribution")),
    _glide_slip_increment(declareProperty<std::vector<Real> >("plastic_glide_slip_increment")),

    _temperature(getParam<Real>("temperature")),

    //Save off the the values of the state variables from the previous increment (before the values are old)
    _previous_it_mobile(declareProperty<std::vector<Real> >("previous_iteration_mobile_dislocations")),
    _previous_it_immobile(declareProperty<std::vector<Real> >("previous_iteration_immobile_dislocations")),
    _previous_it_resistance(declareProperty<std::vector<Real> >("previous_interation_slip_system_resistance")),

    // Geometrically necessary dislocation associated variables
    _slip_increment_sum(declareProperty<RankTwoTensor>("plastic_velocity_gradient")),
    _nyes_tensor(declareProperty<RankTwoTensor>("Nyes_dislocation_tensor")),
    _nyes_tensor_old(getMaterialPropertyOld<RankTwoTensor>("Nyes_dislocation_tensor")),

    // Variables required to get the shape function derivatives on each element
    _gnd_displacement_variable(_fe_problem.getStandardVariable(_tid, parameters.get<NonlinearVariableName>("displacement_variable"))),
    _gnd_grad_phi(_assembly.gradPhi(_gnd_displacement_variable)),

    // Dislocation driving force values
    _glide_velocity(declareProperty<std::vector<Real> >("dislocation_glide_velocity")),
    _burgers_vector(getParam<Real>("burgers_vector")),
    _initial_mobile_dislocation_density(getParam<Real>("initial_mobile_dislocation_density")),
    _initial_immobile_dislocation_density(getParam<Real>("initial_immobile_dislocation_density")),
    _gamma_reference(getParam<Real>("gamma_o")),
    _m_exp(getParam<Real>("strain_rate_sensitivity_exponent")),
    _shear_modulus(getParam<Real>("shear_modulus")),
    _peierls_strength(getParam<Real>("Peierls_stress")),

    // dislocation-dislocation hardening specific parameters
    _baily_hirsch_alpha(getParam<Real>("Baily_Hirsch_barrier_coefficient")),
    _dislocation_latent_hardening(getParam<Real>("dislocation_latent_hardening_parameter")),
    _dislocation_self_hardening(getParam<Real>("dislocation_self_hardening_parameter")),

    // CDD specific parameters
    _alpha_1(getParam<Real>("alpha_1")),
    _alpha_2(getParam<Real>("alpha_2")),
    _alpha_3(getParam<Real>("alpha_3")),
    _alpha_4(getParam<Real>("alpha_4")),
    _alpha_5(getParam<Real>("alpha_5")),
    _cross_slip_barrier_strength(getParam<Real>("cross_slip_barrier_strength")),
    _alpha_6(getParam<Real>("alpha_6")),
    _radius_capture(getParam<Real>("radius_capture_annhiliation")),
    _glide_path_coeff(getParam<Real>("mean_free_glide_path_coefficient")),

    // Cross slip parameters
    _cs_activation_barrier(getParam<Real>("cross_slip_activation_barrier_factor") * _shear_modulus),
    _cs_activation_volume(getParam<Real>("cross_slip_activation_volume_factor") * Utility::pow<3>(_burgers_vector)),
    _boltzmann_constant(getParam<Real>("Boltzman_constant")),
    _cross_slip_type((CrossSlipMethod)(int)getParam<MooseEnum>("cross_slip_calculation_type")),

    // Geometrically necessary dislocation parameters
    _calculate_gnd_contribution(getParam<bool>("include_GND_contribution")),
    _gnd_coefficient(getParam<Real>("GND_density_coefficient")),
    _gradient_Lp(9),

    _inital_glide_velocity(_gamma_reference / (_burgers_vector * _initial_mobile_dislocation_density))
{
  if (_number_slip_systems >= 1000)
    mooseError("CrystalPlasticityCDDUpdateBaseInternalFcnsGNDs assumes fewer than 1,000 possible slip systems");

  if (_calculate_gnd_contribution && (coupledComponents("plastic_velocity_gradient_components") != (LIBMESH_DIM * LIBMESH_DIM)))
  {
      mooseError("To calculate the geometrially necessary dislocations, all 9 of the auxvariable components of the plastic velocity gradient Rank-2 tensor must be given as inputs to the plastic_velocity_gradient parameter.");
  }

  setRandomResetFrequency(EXEC_TIMESTEP_BEGIN);
}

// void
// CrystalPlasticityCDDUpdateBaseInternalFcnsGNDs::initialSetup()
// {
//   // fetch coupled gradients of the plastic velocity gradient
//   for (unsigned int i = 0; i < LIBMESH_DIM * LIBMESH_DIM; ++i)
//     _gradient_Lp[i] = &coupledGradient("plastic_velocity_gradient_components", i);
// }

void
CrystalPlasticityCDDUpdateBaseInternalFcnsGNDs::initQpStatefulProperties()
{
  _mobile_dislocations[_qp].resize(_number_slip_systems);
  _immobile_dislocations[_qp].resize(_number_slip_systems);
  _cross_slip_dislocations[_qp].resize(_number_slip_systems);

  _slip_system_resistance[_qp].resize(_number_slip_systems);
  _static_resistance_contribution[_qp].resize(_number_slip_systems);

  _glide_slip_increment[_qp].resize(_number_slip_systems);
  _glide_velocity[_qp].resize(_number_slip_systems);

  //Then loop over the slip systems and set the initial values from the params
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    _mobile_dislocations[_qp][i] = _initial_mobile_dislocation_density / _number_slip_systems;
    _immobile_dislocations[_qp][i] = _initial_immobile_dislocation_density / _number_slip_systems;
    _cross_slip_dislocations[_qp][i] = 0.0;

    _glide_slip_increment[_qp][i] = 0.0;
    _glide_velocity[_qp][i] = 0.0;
  }

  _geometrical_necessary_dislocations[_qp] = 0.0;
  _slip_increment_sum[_qp].zero();
  _nyes_tensor[_qp].zero();

  initSlipSystemResistance();

  CrystalPlasticityUpdate::initQpStatefulProperties();
}

void
CrystalPlasticityCDDUpdateBaseInternalFcnsGNDs::setInitialConstitutiveVariableValues()
{
  _slip_system_resistance[_qp] = _slip_system_resistance_old[_qp];

  _mobile_dislocations[_qp] = _mobile_dislocations_old[_qp];
  _immobile_dislocations[_qp] = _immobile_dislocations_old[_qp];
}

void
CrystalPlasticityCDDUpdateBaseInternalFcnsGNDs::calculateConstitutiveEquivalentSlipIncrement(RankTwoTensor & equivalent_slip_increment,
                                                                         bool & error_tolerance)
{
  equivalent_slip_increment.zero();

  calculateGlideSlipIncrement(error_tolerance);
  if (error_tolerance)
    return;

  // Sum up the slip increments to find the equivalent plastic strain due to slip
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
    equivalent_slip_increment += _flow_direction[_qp][i] * _glide_slip_increment[_qp][i];

  // Now store off the plastic velocity gradient for use in the GND calculation
  if (_calculate_gnd_contribution)
    _slip_increment_sum[_qp] = equivalent_slip_increment;

  //Hi Stephanie! I don't know what doxygen is...

  error_tolerance = false;
}

void
CrystalPlasticityCDDUpdateBaseInternalFcnsGNDs::calculateGlideSlipIncrement(bool & error_tolerance)
{
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    if ( std::abs(_tau[_qp][i] / _peierls_strength ) >= 1.0 )
    {
      Real driving_force = std::abs(_tau[_qp][i] / _slip_system_resistance[_qp][i]);
      _glide_velocity[_qp][i] = _inital_glide_velocity * std::pow(driving_force, (1.0 / _m_exp));
      if (_tau[_qp][i] < 0.0)
        _glide_velocity[_qp][i] *= -1.0;
    }
    else  // Not enough driving force, the glide velocity should be zero
      _glide_velocity[_qp][i] = 0.0;
  }

  // Calculate the slip increment on each slip system
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    _glide_slip_increment[_qp][i] = _mobile_dislocations[_qp][i] * _burgers_vector * _glide_velocity[_qp][i] *_substep_dt;

    if (std::abs(_glide_slip_increment[_qp][i]) > _slip_incr_tol)
    {
#ifdef DEBUG
      mooseWarning("Maximum allowable glide slip increment exceeded on slip system ", i, " with a value of ", std::abs(_glide_slip_increment[_qp][i]), "At element ", _current_elem->id(), " and qp ", _qp);
      std::cout << "  the glide velocity is " << _glide_velocity[_qp][i] << std::endl;
      std::cout << "The applied tau is " << _tau[_qp][i] << std::endl;
      std::cout << "  the slip system resistance is " << _slip_system_resistance[_qp][i] << std::endl;
#endif
      error_tolerance = true;
      return;
    }
  }
}

void
CrystalPlasticityCDDUpdateBaseInternalFcnsGNDs::calculateConstitutiveSlipDerivative(std::vector<Real> & dslip_dtau, unsigned int /*slip_model_number*/)
{
  std::vector<Real> dslip_glide_dtau(_number_slip_systems, 0.0);
  calculateGlideSlipDerivative(dslip_glide_dtau);
  dslip_dtau = dslip_glide_dtau;
}

void
CrystalPlasticityCDDUpdateBaseInternalFcnsGNDs::calculateGlideSlipDerivative(std::vector<Real> & dslip_glide_dtau)
{
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    if (MooseUtils::absoluteFuzzyEqual(_tau[_qp][i], 0.0))
      dslip_glide_dtau[i] = 0.0;
    else
    {
      const Real glide_velocity_derivative = _glide_velocity[_qp][i] / (_m_exp * _tau[_qp][i]);
      dslip_glide_dtau[i] = _mobile_dislocations[_qp][i] * _burgers_vector * glide_velocity_derivative * _substep_dt;
    }
  }
}

void
CrystalPlasticityCDDUpdateBaseInternalFcnsGNDs::updateConstitutiveSlipSystemResistanceAndVariables(bool & error_tolerance)
{
  // Set the previous value of the slip system resistance here for comparison in the convergence check
  _previous_it_resistance[_qp] = _slip_system_resistance[_qp];
  _previous_it_mobile[_qp] = _mobile_dislocations[_qp];
  _previous_it_immobile[_qp] = _immobile_dislocations[_qp];

  // At the early stages when all of the glide velocities are zero,
  // save a bit of time at the early stages of the simulation.
  bool no_glide_velocity = true;

  unsigned int i = 0;
  do
  {
    if (!(MooseUtils::absoluteFuzzyEqual(_glide_velocity[_qp][i], 0.0)))
      no_glide_velocity = false;

    ++i;
  } while (no_glide_velocity && (i < _number_slip_systems));

  if (no_glide_velocity)
  {
    error_tolerance = false;
    return;
  }

  calculateDislocationDensities(error_tolerance);
  if (error_tolerance)
    return;

  calculateSlipSystemResistance(error_tolerance);
}

bool
CrystalPlasticityCDDUpdateBaseInternalFcnsGNDs::areConstitutiveStateVariablesConverged()
{
  Real mobile_diff, immobile_diff = 0.0;

  // Will have to run through twice:  once for each type of state variable because I've hardcoded them
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    // Calculate the change in the state variables over the two iterations
    mobile_diff = std::abs(_previous_it_mobile[_qp][i] - _mobile_dislocations[_qp][i]);
    immobile_diff = std::abs(_previous_it_immobile[_qp][i] - _immobile_dislocations[_qp][i]);

    // Set the iteration flag to rerun if the old value is pretty much zero and if the difference from iterations is above tolerance
    if ((std::abs(_mobile_dislocations_old[_qp][i])) < _zero_tol)
    {
      if (mobile_diff > _zero_tol)
        return true;
    }
    else
    {
      if (mobile_diff > _rel_state_var_tol * std::abs(_mobile_dislocations_old[_qp][i]))
        return true;
    }

    if (std::abs(_immobile_dislocations_old[_qp][i]) < _zero_tol)
    {
      if (immobile_diff > _zero_tol)
        return true;
    }
    else
    {
      if (immobile_diff > _rel_state_var_tol * std::abs(_immobile_dislocations_old[_qp][i]))
        return true;
    }
  }

  // Check slip system convergence; could be it's own method
  Real resistance_diff = 0.0;
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    resistance_diff = std::abs(_previous_it_resistance[_qp][i] - _slip_system_resistance[_qp][i]);
    if (resistance_diff > _resistance_tol)
      return true;
  }
  return false;
}

void
CrystalPlasticityCDDUpdateBaseInternalFcnsGNDs::calculateDislocationDensities(bool & error_tolerance)
{
  std::vector<Real> increment_mobile(_number_slip_systems, 0.0);
  std::vector<Real> increment_immobile(_number_slip_systems, 0.0);

  if (_calculate_cross_slip)
    calculateDislocationCrossSlip();

  if (_calculate_gnd_contribution)
    calculateGeometricallyNecessaryDislocations();

  Real glide_path_inv = calculateMeanFreeGlidePath();

  //Calculate terms of the CDD dislocation evolution for each slip system
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    const Real term1 = _alpha_1 * _mobile_dislocations[_qp][i] * glide_path_inv;

    const Real term2_mobile_sq = _mobile_dislocations[_qp][i] * _mobile_dislocations[_qp][i];
    const Real term2 = 2.0 * _alpha_2 * _radius_capture * _burgers_vector * term2_mobile_sq;
    const Real term3 = _alpha_3 * _mobile_dislocations[_qp][i] * glide_path_inv;

    const Real term4_force = std::sqrt(std::abs(_tau[_qp][i] / _slip_system_resistance[_qp][i]));
    const Real term4 = _alpha_4 * term4_force * _immobile_dislocations[_qp][i] * glide_path_inv;

    Real term5 = _cross_slip_dislocations[_qp][i] * _alpha_5 * glide_path_inv;

    const Real term6 = _alpha_6 * _radius_capture * _burgers_vector * _mobile_dislocations[_qp][i] * _immobile_dislocations[_qp][i];

    //put the increment here, then run the tolerance check and update in a separate loop
    increment_mobile[i] = (term1 - term2 - term3 + term4 + term5 - term6) * std::abs(_glide_velocity[_qp][i]) * _substep_dt;
    increment_immobile[i] = (term3 - term4 - term6) * std::abs(_glide_velocity[_qp][i]) * _substep_dt;

    //Update here the cross slip dislocations so that can print out the correct value
    _cross_slip_dislocations[_qp][i] *= _alpha_5 * glide_path_inv * std::abs(_glide_velocity[_qp][i]) * _substep_dt;
  }

  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    if (_mobile_dislocations_old[_qp][i] < _zero_tol && increment_mobile[i] < 0.0)
      _mobile_dislocations[_qp][i] = _mobile_dislocations_old[_qp][i];
    else
      _mobile_dislocations[_qp][i] = increment_mobile[i] + _mobile_dislocations_old[_qp][i];

    if (_immobile_dislocations_old[_qp][i] < _zero_tol && increment_immobile[i] < 0.0)
      _immobile_dislocations[_qp][i] = _immobile_dislocations_old[_qp][i];
    else
      _immobile_dislocations[_qp][i] = increment_immobile[i] + _immobile_dislocations_old[_qp][i];

    // check that total is equal or positive; very small values okay
    if (_mobile_dislocations[_qp][i] < 0.0 || _immobile_dislocations[_qp][i] < 0.0)
    {
      error_tolerance = true;
      return;
    }
  }
  error_tolerance = false;
}

Real
CrystalPlasticityCDDUpdateBaseInternalFcnsGNDs::calculateMeanFreeGlidePath()
{
  Real glide_path_inv = 0.0;
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
    glide_path_inv += _mobile_dislocations[_qp][i] + _immobile_dislocations[_qp][i];

  glide_path_inv = std::sqrt(glide_path_inv + _geometrical_necessary_dislocations[_qp])
                    * _glide_path_coeff;

  return glide_path_inv;
}

void
CrystalPlasticityCDDUpdateBaseInternalFcnsGNDs::calculateDislocationCrossSlip()
{
  if (_cross_slip_type == stochastic)
  {
    // Work within the cross slip families for the cross slip calculation
    for (unsigned int i = 0; i < _number_cross_slip_directions; ++i)
    {
      std::vector<Real> family_xslip_probability(_number_cross_slip_planes);
      Real family_xslip_probability_sum = 0.0;
      std::vector<std::vector<unsigned int> > family_xslip_interactions(_number_cross_slip_planes, std::vector<unsigned int>(_number_cross_slip_planes, 1000));

      // Determine the probability of cross slip for each slip plane in the family
      for (unsigned int j = 0; j < _number_cross_slip_planes; ++j)
      {
        unsigned int index = _cross_slip_familes[i][j];
        Real xslip_force = (_cs_activation_barrier - std::abs(_tau[_qp][index])) * _cs_activation_volume;
        Real xslip_probabilty = std::exp(-xslip_force / (_boltzmann_constant * _temperature));

        family_xslip_probability[j] = xslip_probabilty;
        family_xslip_probability_sum += xslip_probabilty;
      }

      // Now normalize the components of each probabilty by dividing by the probabilty sum
      for (unsigned int j = 0; j < _number_cross_slip_planes; ++j)
        family_xslip_probability[j] /= family_xslip_probability_sum;

      // And build the CDF function for this family
      for (unsigned int j = 1; j < _number_cross_slip_planes; ++j)
        family_xslip_probability[j] += family_xslip_probability[j-1];

      if (MooseUtils::relativeFuzzyGreaterThan(family_xslip_probability[_number_cross_slip_planes - 1], 1.0))
        mooseError("The cumulative distribution function for the stochastic cross slip analysis was incorrectly calculated");

      // Monte Carlo Analysis using Moose's RandomInterface, assumes all systems can cross slip
      for (unsigned int giving_system = 0; giving_system < _number_cross_slip_planes; ++giving_system)
      {
        Real xslip_dice = getRandomReal();

        // Now check the value of the random xslip dice against the bin values to determine into which
        // slip system the dislocations will cross slip
        for (unsigned int j = 0; j < _number_cross_slip_planes; ++j)
        {
          if (xslip_dice < family_xslip_probability[j])
          {
            unsigned int recieving_system = j;

            if (giving_system != recieving_system)  // Not self: cross slip occurs
            {
              // Find the actual index that corresponds to the giving system
              unsigned int index = _cross_slip_familes[i][giving_system];
              family_xslip_interactions[giving_system][giving_system] = index;
              family_xslip_interactions[recieving_system][giving_system] = index;
            }
          break;
          }
        }
      }
      // Now need to calculate the sum of the cross slip dislocations
      // (probabilty * mobile dislocations) acting on each slip system in the cross slip family
      for (unsigned int a = 0; a < _number_cross_slip_planes; ++a)
      {
        Real single_system_sum = 0.0;
        for (unsigned int b = 0; b < _number_cross_slip_planes; ++b)
        {
          if (family_xslip_interactions[a][b] != 1000) // 1000 is the intital placeholder
          {
            unsigned int index = family_xslip_interactions[a][b];

            if (a != b) // recieving dislocations
              single_system_sum += _mobile_dislocations[_qp][index];
            else // a == b, giving dislocations
              single_system_sum -= _mobile_dislocations[_qp][index];
          }
        }
        // Now that have completed the summing, store in the appropriate position in the material property
        unsigned int self_index = _cross_slip_familes[i][a];
        _cross_slip_dislocations[_qp][self_index] = single_system_sum;
      }
    }
  }
  else if (_cross_slip_type == deterministic)
  {
    // Reset the values of the cross slip dislocations because use +=/-= below
    std::fill(_cross_slip_dislocations[_qp].begin(), _cross_slip_dislocations[_qp].end(), 0.0);

    // Work within the cross slip families for the cross slip calculation
    for (unsigned int i = 0; i < _number_cross_slip_directions; ++i)
    {
      // Calculate the probability of cross slip for each system in the family
      for (unsigned int  j= 0; j < _number_cross_slip_planes; ++j)
      {
        unsigned int index_j = _cross_slip_familes[i][j];
        Real xslip_force = (_cs_activation_barrier - std::abs(_tau[_qp][index_j])) * _cs_activation_volume;
        Real xslip_probabilty_j = std::exp(-xslip_force / (_boltzmann_constant * _temperature));

        // Calculate the amount of cross slip dislocations with this probability
        Real family_xslip_dislocation_sum = 0.0;
        for (unsigned int k = 0; k < _number_cross_slip_planes; ++k)
        {
          unsigned int index_k = _cross_slip_familes[i][k];
          if (index_k != index_j)
          {
            const Real xslip_dislocations = xslip_probabilty_j * _mobile_dislocations[_qp][index_k];
            _cross_slip_dislocations[_qp][index_k] -= xslip_dislocations;
            family_xslip_dislocation_sum += xslip_dislocations;
          }
        }
        _cross_slip_dislocations[_qp][index_j] += family_xslip_dislocation_sum;
      }
    }
  }
}

void
CrystalPlasticityCDDUpdateBaseInternalFcnsGNDs::calculateGeometricallyNecessaryDislocations()
{
  RankTwoTensor increment_nyes_tensor;
  increment_nyes_tensor.zero();

  // for (unsigned int i = 0; i < LIBMESH_DIM; ++i)
  // {
  //   for (unsigned int j = 0; j < LIBMESH_DIM; ++j)
  //   {
  //     if (i == 0)
  //     {
  //       increment_nyes_tensor(0,j) = (*_gradient_Lp[2 * LIBMESH_DIM + j])[_qp](1)
  //                                    - (*_gradient_Lp[LIBMESH_DIM + j])[_qp](2);
  //     }
  //     else if (i == 1)
  //     {
  //       increment_nyes_tensor(1,j) = (*_gradient_Lp[j])[_qp](2)
  //                                    - (*_gradient_Lp[2 * LIBMESH_DIM + j])[_qp](0);
  //     }
  //     else if (i == 2)
  //     {
  //       increment_nyes_tensor(2,j) = (*_gradient_Lp[LIBMESH_DIM + j])[_qp](0)
  //                                    - (*_gradient_Lp[j])[_qp](1);
  //     }
  //   }
  // }

  _nyes_tensor[_qp] = increment_nyes_tensor + _nyes_tensor_old[_qp];

  // Caculate the density norm of the geometrically density dislocations
  Real norm_nyes = _nyes_tensor[_qp].doubleContraction(_nyes_tensor[_qp]);
  _geometrical_necessary_dislocations[_qp] = _gnd_coefficient * std::sqrt(norm_nyes) / _burgers_vector;
}


void
CrystalPlasticityCDDUpdateBaseInternalFcnsGNDs::calculateSlipSystemResistance(bool & error_tolerance)
{
  std::vector<Real> forest_strength(_number_slip_systems, 0.0);
  calculateDislocationForestHardening(forest_strength);

  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    // const Real sq_resistance = Utility::pow<2>(forest_strength[i])
    //                          + Utility::pow<2>(_static_resistance_contribution[_qp][i]);
    // _slip_system_resistance[_qp][i] = std::sqrt(sq_resistance);

  _slip_system_resistance[_qp][i] = forest_strength[i] + _static_resistance_contribution[_qp][i];
  }

  //Now perform the check to see if the slip system should be updated
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    if (_slip_system_resistance_old[_qp][i] < _zero_tol && _slip_system_resistance[_qp][i] < 0.0)
      _slip_system_resistance[_qp][i] = _slip_system_resistance_old[_qp][i];

    if (_slip_system_resistance[_qp][i] < 0.0)
    {
      error_tolerance = true;
      return;
    }
  }
  error_tolerance = false;
}

void
CrystalPlasticityCDDUpdateBaseInternalFcnsGNDs::initSlipSystemResistance()
{
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
    _static_resistance_contribution[_qp][i] = _peierls_strength;

  std::vector<Real> forest_strength(_number_slip_systems);
  calculateDislocationForestHardening(forest_strength);

  // Loop over all the slip systems and add these strength contributions
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    // const Real sq_resistance = Utility::pow<2>(forest_strength[i])
    //                          + Utility::pow<2>(_static_resistance_contribution[_qp][i]);
    // _slip_system_resistance[_qp][i] = std::sqrt(sq_resistance);

  _slip_system_resistance[_qp][i] = forest_strength[i] + _static_resistance_contribution[_qp][i];
  }
}

void
CrystalPlasticityCDDUpdateBaseInternalFcnsGNDs::calculateDislocationForestHardening(
                                          std::vector<Real> & forest_strength)
{
  const Real barrier_coeffient = _baily_hirsch_alpha * _burgers_vector * _shear_modulus;

  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    Real sum = 0.0;
    for (unsigned int j = 0; j < _number_slip_systems; ++j)
    {
      if (i != j)
        sum += _dislocation_latent_hardening * (_mobile_dislocations[_qp][j] + _immobile_dislocations[_qp][j]);
      else
        sum += _dislocation_self_hardening * (_mobile_dislocations[_qp][j] + _immobile_dislocations[_qp][j]);
    }
    forest_strength[i] = barrier_coeffient * std::sqrt(sum);
  }
}
