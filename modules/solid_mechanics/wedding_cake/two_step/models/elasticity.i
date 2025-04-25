[Solvers]
  [newton]
    type = Newton
  []
[]

[Models]
  [elasticity]
    type = LinearIsotropicElasticity
    coefficients = '137.95e9 0.346'
    coefficient_types = 'YOUNGS_MODULUS POISSONS_RATIO'
    strain = 'state/Ee'
    stress = 'state/S'
  []
  [eigenstrain]
    type = ThermalEigenstrain
    reference_temperature = 294.26
    CTE = 1.836e-5 ### from BISON manual
  []
  [elastic_strain]
    type = SR2LinearCombination
    to_var = 'state/Ee'
    from_var = 'forces/E forces/Eg'
    coefficients = '1 -1'
  []
  [surface]
    type = ComposedModel
    models = 'elastic_strain elasticity'
  []
  [return_map]
    type = ImplicitUpdate
    implicit_model = 'surface'
    solver = 'newton'
  []
  [model]
    type = ComposedModel
    models = 'eigenstrain elastic_strain elasticity'
    additional_outputs = 'forces/Eg state/Ee'
  []
[]

## Young's modulus from BISON:
## 198.*(1.0 - 3.93625*10**(-4)*temp - 8.37648*10**(-8)*temp*temp + 9.26214*10**(-11)*temp**3)
## and Poisson's ration from BISON, too:
## 0.29015*(1 +3.55518*10**(-4)*temp - 2.20321*10**(-7)*temp*temp + 1.18177*10**(-10)*temp**3)

##both at 750C
