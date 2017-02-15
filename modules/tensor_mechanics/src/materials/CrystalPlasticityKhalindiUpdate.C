/****************************************************************/
/* MOOSE - Multiphysics Object Oriented Simulation Environment  */
/*                                                              */
/*          All contents are licensed under LGPL V2.1           */
/*             See LICENSE for full restrictions                */
/****************************************************************/
#include "CrystalPlasticityKhalindiUpdate.h"

template<>
InputParameters validParams<CrystalPlasticityKhalindiUpdate>()
{
  InputParameters params = validParams<CrystalPlasticityUpdate>();
  params.addClassDescription("Khalindi version of homogeneous crystal plasticity.");
  params.addParam<Real>("r", 1.0, "Latent hardening coefficient");
  params.addParam<Real>("h", 541.5, "hardening constants");
  params.addParam<Real>("t_sat", 109.8, "saturated slip system strength");
  params.addParam<Real>("gss_a", 2.5, "coefficient for hardening");
  params.addParam<Real>("ao", 0.001, "slip rate coefficient");
  params.addParam<Real>("xm", 0.1, "exponent for slip rate");
  params.addParam<Real>("gss_initial", 60.8, "Pierls strength of material");

  return params;
}

CrystalPlasticityKhalindiUpdate::CrystalPlasticityKhalindiUpdate(const InputParameters & parameters) :
    CrystalPlasticityUpdate(parameters),
    _slip_system_resistance(declareProperty<std::vector<Real> >("slip_system_resistance")),
    _slip_system_resistance_old(declarePropertyOld<std::vector<Real> >("slip_system_resistance")),
    _slip_increment(declareProperty<std::vector<Real> >("plastic_slip_increment")),

    //Save off the the values of the state variables from the previous increment (before the values are old)
    _previous_it_slip_increment(declareProperty<std::vector<Real> >("previous_iteration_slip_increment")),
    _previous_it_resistance(declareProperty<std::vector<Real> >("previous_iteration_slip_system_resistance")),
//    _slip_increment_old(declarePropertyOld<std::vector<Real> >("plastic_slip_increment")),

    // Dislocation driving force values
    _tau(declareProperty<std::vector<Real> >("applied_shear_stress")),

    // Constitutive values
    _r(getParam<Real>("r")),
    _h(getParam<Real>("h")),
    _tau_sat(getParam<Real>("t_sat")),
    _gss_a(getParam<Real>("gss_a")),
    _ao(getParam<Real>("ao")),
    _xm(getParam<Real>("xm")),
    _gss_initial(getParam<Real>("gss_initial"))
{
}

void
CrystalPlasticityKhalindiUpdate::initQpStatefulProperties()
{
  _slip_system_resistance[_qp].resize(_number_slip_systems);
  _slip_system_resistance_old[_qp].resize(_number_slip_systems);
  _previous_it_resistance[_qp].resize(_number_slip_systems);

  _slip_increment[_qp].resize(_number_slip_systems);
  _previous_it_slip_increment[_qp].resize(_number_slip_systems);

  _tau[_qp].resize(_number_slip_systems);

  //Then loop over the slip systems and set the initial values for all the Reals
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    _slip_system_resistance[_qp][i] = _gss_initial;
    _slip_system_resistance_old[_qp][i] = _gss_initial;
    _slip_increment[_qp][i] = 0.0;
    _tau[_qp][i] = 0.0;
  }

  CrystalPlasticityUpdate::initQpStatefulProperties();
}

void
CrystalPlasticityKhalindiUpdate::setInitialConstitutiveVariableValues()
{
  //Would calculate the dislocation densities here, if I had any of those in this model
  _slip_system_resistance[_qp] = _slip_system_resistance_old[_qp];
}

void
CrystalPlasticityKhalindiUpdate::calculateConstitutiveEquivalentSlipIncrement(RankTwoTensor & equivalent_slip_increment,
                                                                         bool & error_tolerance)
{
  equivalent_slip_increment.zero();

  // Save off the values from the previous increment:
  _previous_it_slip_increment[_qp] = _slip_increment[_qp];

  if (_error_tolerance)
    return;

  // Calculate the dislocation glide velocity term for each of the slip systems
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    // std::cout << "  Within the calculation of the applied shear stress for slip system: " << i << std::endl;
    // std::cout << "    the flow direction (0,0) is " << _flow_direction[_qp][i](0,0) << std::endl;
    // std::cout << "    the flow direction (0,1) is " << _flow_direction[_qp][i](0,1) << std::endl;
    // std::cout << "    the flow direction (0,2) is " << _flow_direction[_qp][i](0,2) << std::endl;
    // std::cout << "    the flow direction (1,0) is " << _flow_direction[_qp][i](1,0) << std::endl;
    // std::cout << "    the flow direction (1,1) is " << _flow_direction[_qp][i](1,1) << std::endl;
    // std::cout << "    the flow direction (1,2) is " << _flow_direction[_qp][i](1,2) << std::endl;
    // std::cout << "    the flow direction (2,0) is " << _flow_direction[_qp][i](2,0) << std::endl;
    // std::cout << "    the flow direction (2,1) is " << _flow_direction[_qp][i](2,1) << std::endl;
    // std::cout << "    the flow direction (2,2) is " << _flow_direction[_qp][i](2,2) << std::endl;
    _tau[_qp][i] = _pk2[_qp].doubleContraction(_flow_direction[_qp][i]);

    // std::cout << "  then the calculated tau on slip system " << i << " is " << _tau[_qp][i] << std::endl;
  }

  // Calculate the slip increment on each slip system
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    // if (_qp == 0)
      // std::cout << "  inside the slip increment calculation on system " << i << " and the slip resistance is " << _slip_system_resistance[_qp][i] << std::endl;
    _slip_increment[_qp][i] = _ao * std::pow(std::abs(_tau[_qp][i] / _slip_system_resistance[_qp][i]), 1.0 / _xm) * copysign(1.0, _tau[_qp][i]);

    if (std::abs(_slip_increment[_qp][i]) > _slip_incr_tol)
    {
#ifdef DEBUG
      mooseWarning("Maximum allowable slip increment exceeded ", std::abs(_slip_increment[_qp][i]));
#endif
      error_tolerance = true;
      return;
    }
  }

  // Sum up the slip increments to find the equivalent plastic strain due to slip
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    equivalent_slip_increment += _flow_direction[_qp][i] * _slip_increment[_qp][i] * _substep_dt;
    if(_qp == 0)
    {
      std::cout << "The slip increment (rate * time ) on slip system " << i << " is " << _slip_increment[_qp][i] * _substep_dt << std::endl;
    }
  }

  error_tolerance = false;
}

void
CrystalPlasticityKhalindiUpdate::calculateConstitutiveSlipDerivative(std::vector<Real> & dslip_dtau)
{
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    if (MooseUtils::absoluteFuzzyEqual(_tau[_qp][i], 0.0))
      dslip_dtau[i] = 0.0;
    else
      dslip_dtau[i] = _ao / _xm * std::pow(std::abs(_tau[_qp][i] / _slip_system_resistance[_qp][i]), 1.0 / _xm - 1.0) / _slip_system_resistance[_qp][i];

    // std::cout << "  the derivative of the slip increment on slip system " << i << " is " << dslip_dtau[i] << std::endl;
  }
}

void
CrystalPlasticityKhalindiUpdate::updateConstitutiveSlipSystemResistanceAndVariables(bool & error_tolerance)
{
  // Set the previous value of the slip system resistance here for comparison in the convergence check
  _previous_it_resistance[_qp] = _slip_system_resistance[_qp];
  calculateSlipSystemResistance(error_tolerance);
}

bool
CrystalPlasticityKhalindiUpdate::areConstitutiveStateVariablesConverged()
{
  // Check slip system convergence; could be it's own method in the dislocation based model
  Real resistance_diff = 0.0;
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    resistance_diff = std::abs(_previous_it_resistance[_qp][i] - _slip_system_resistance[_qp][i]);
    if (resistance_diff > _resistance_tol)
    {
      std::cout << " The value of the slip resistance on slip system " << i << " is greater than the tolerance and is " << resistance_diff << std::endl;
      return true;
    }
  }

  // If make it here, everything converged nicely
//  std::cout << "Everything converged nicely - good job! " << std::endl;
  return false;
}


void
CrystalPlasticityKhalindiUpdate::calculateSlipSystemResistance(bool & error_tolerance)
{
  std::vector<Real> hb(_number_slip_systems);
  std::vector<Real> slip_system_resistance_increment(_number_slip_systems);
  Real qab;

  // if (_qp == 0)
    // std::cout << "Inside the slip resistance method " << std::endl;

  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    hb[i] = _h * std::pow(std::abs(1.0 - _slip_system_resistance[_qp][i] / _tau_sat), _gss_a) * copysign(1.0,1.0 - _slip_system_resistance[_qp][i] / _tau_sat);
      // if (_qp == 0)
        // std::cout << "  and inside the loop to sum the latent hardening, on slip system " << i << " the used resistance is " << _slip_system_resistance[_qp][i] << std::endl;
  }

  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    for (unsigned int j = 0; j < _number_slip_systems; ++j)
    {
      unsigned int iplane, jplane;
      iplane = i / 3;
      jplane = j / 3;

      if (iplane == jplane) // Kalidindi
        qab = 1.0;
      else
        qab = _r;

      // if (_qp == 0)
        // std::cout << "  and on slip system " << i <<" the used slip increment is " << _slip_increment[_qp][j] << std::endl;

      slip_system_resistance_increment[i] += std::abs(_slip_increment[_qp][j]) * qab * hb[j]; //* _scale_factor[i];
    }
    // if (_qp == 0)
      // std::cout << "The calculated value of the slip resistance increment on slip system " << i << " is " << slip_system_resistance_increment(i) << std::endl;
  }


  std::cout << "Now evaluating the update-ability of the resistance" << std::endl;
  //Now perform the check to see if the slip system should be updated
  for (unsigned int i = 0; i < _number_slip_systems; ++i)
  {
    slip_system_resistance_increment[i] *= _substep_dt;
    if (_slip_system_resistance_old[_qp][i] < _zero_tol && slip_system_resistance_increment[i] < 0.0)
    {
      _slip_system_resistance[_qp][i] = _slip_system_resistance_old[_qp][i];
      std::cout << "  in slip system " << i << " and the value of the old value / increment is too small to update" << std::endl;
    }
    else
    {
      if (_qp == 0)
      {
        std::cout << "  Inside the updateStateVariable method on slip system " << i << " and the resistance value increment is " << slip_system_resistance_increment[i] << std::endl;
        std::cout << "    and the old resistance value is " << _slip_system_resistance_old[_qp][i] << std::endl;
      }
      _slip_system_resistance[_qp][i] = _slip_system_resistance_old[_qp][i] + slip_system_resistance_increment[i];
      if (_qp == 0)
        std::cout << "  and the value of the resistance is updated to " << _slip_system_resistance[_qp][i] << std::endl;
    }

    if (_slip_system_resistance[_qp][i] < 0.0)
      error_tolerance = true;
  }
}
