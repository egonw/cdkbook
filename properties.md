# Molecular Properties

Cheminformatics is about molecular properties and chemistry in general the field
of finding chemicals with new properties. Prof. Gasteiger in 2006 gave a
lecture at Cologne University where he expressed this view. It stuck around. We keep
databases to store those properties, and we develop methods to predict and understand
those properties. Prediction is important for one reason: there are too many
chemical structures and we cannot experimentally measure the properties for all
of them. The number of molecules is often said to be relevant to drug discovery is in
the order of $10^{60}$. The largest current databases have less than $10^{8}$
structures. That means that prediction of properties for the vast majority
of molecules will remain relevant for the foreseeable future.

This chapter will show how the CDK can be used to calculate a number of molecular
properties.

## Molecular Mass

The simplest but perhaps the most reported molecular property is the <a name="tp1">molecular mass</a>.
It is important to realize this mass is not constant, and depends on the natural
mixture of isotopes, which is not constant itself. If you have an atom container
with explicit hydrogens, you can loop over the atoms to calculate the molecular
mass as summation of the masses of the individual atoms:

**Script** [code/CalculateMolecularWeight.groovy](code/CalculateMolecularWeight.code.md)
```groovy
molWeight = 0.0
for (atom in molecule.atoms()) {
  molWeight += isotopeInfo.getNaturalMass(atom)
}
```

In this case, you can also use the [`AtomContainerManipulator`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/tools/manipulator/AtomContainerManipulator.html):

**Script** [code/CalculateMolecularWeightShort.groovy](code/CalculateMolecularWeightShort.code.md)
```groovy
molWeight = AtomContainerManipulator
  .getNaturalExactMass(molecule)
```

The element masses are calculated from the accurate isotope masses and natural
abundances defined in the Blue Obelisk Data Repository [<a href="#citeref1">1</a>].

### Implicit Hydrogens

If your atom container has <a name="tp2">implicit hydrogens</a> specified, you will have the above
code will not be sufficient. Instead, your code should look like:

**Script** [code/CalculateMolecularWeightImplicitHydrogens.groovy](code/CalculateMolecularWeightImplicitHydrogens.code.md)
```groovy
molWeight = 0.0
hWeight = isotopeInfo.getNaturalMass(Elements.HYDROGEN)
for (atom in molecule.atoms()) {
  molWeight += isotopeInfo.getNaturalMass(atom)
  if (atom.getImplicitHydrogenCount() != CDKConstants.UNSET)
    molWeight += atom.getImplicitHydrogenCount() *
                 hWeight
}
```

<a name="sec:tpsa"></a>
## Total Polar Surface Area

Another properties that frequently returns in cheminformatics is the <a name="tp3">Total Polar Surface Area</a>
(<a name="tp4">TPSA</a>). The code in the CDK uses an algorithm published by Ertl in 2000 [<a href="#citeref2">2</a>].
Here too, the descriptor API is used, so that the code is quite similar to that for the logP
calculation:

**Script** [code/TPSA.groovy](code/TPSA.code.md)
```groovy
oxazone = MoleculeFactory.makeOxazole();
benzene = MoleculeFactory.makeBenzene();
// add explicit hydrogens ...
descriptor = new TPSADescriptor()
println "TPSA of oxazone: " +
  ((DoubleResult)descriptor.calculate(oxazone).value)
  .doubleValue()
println "TPSA of benzene: " +
  ((DoubleResult)descriptor.calculate(benzene).value)
  .doubleValue()
```

which returns:

```plain
TPSA of oxazone: 21.59
TPSA of benzene: 0.0
```

<a name="sec:aromaticity"></a>
## Aromaticity

I am not fond of the <a name="tp5">aromaticity</a> concept; first of all, because there is no universal definition.
Most cheminformatics toolkits have different definitions of aromaticity, and so does the CDK.
If a compound is aromatic, and if so, which atoms and bonds are involved in an aromatic system
are not easily defined. Ultimately, it is the delocalization energies that has a large influence
on this, which are hard to reproduce with heuristic rules in chemical graph theory-based
algorithms.

The CDK now implements various models, all accessible via the [`Aromaticity`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/aromaticity/Aromaticity.html) class.
The models are parameterized: what rings are taken into account, and how many electrons do
various atoms contribute. The combination of these two aspect explains most of the differences
in aromaticity as calculated with various cheminformatics libraries. The CDK can calculate
most of them by selecting the right [`ElectronDonation`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/aromaticity/ElectronDonation.html) and [`CycleFinder`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/graph/CycleFinder.html):

**Script** [code/AromaticityDemo.groovy](code/AromaticityDemo.code.md)
```groovy
model       = ElectronDonation.daylight();
cycles      = Cycles.or(Cycles.all(), Cycles.all(6));
aromaticity = new Aromaticity(model, cycles);
aromatic = aromaticity.apply(mol);
println "benzene is " +
  (aromatic ? "" : "not ") + "aromatic."
```

which tells us that

```plain
benzene is aromatic.
```

Furthermore, if you wish to know which bonds are aromatic, the same class can be used:

**Script** [code/AromaticBonds.groovy](code/AromaticBonds.code.md)
```groovy
aromaticBonds = aromaticity.findBonds(mol)
count = aromaticBonds.size()
println "benzene has " + count + " aromatic bonds."
```

which reports the aromatic bonds:

```plain
benzene has 6 aromatic bonds.
```


## References

1. <a name="citeref1"></a>Guha R, Howard MT, Hutchison GR, Murray-Rust P, Rzepa HS, Steinbeck C, et al. The Blue Obelisk-interoperability in chemical informatics. Journal of Chemical Information and Modeling. 2006 Feb 22;46(3):991–8.  doi:[10.1021/CI050400B](https://doi.org/10.1021/CI050400B)
2. <a name="citeref2"></a>Ertl P, Rohde B, Selzer P. Fast Calculation of Molecular Polar Surface Area as a Sum of Fragment-Based Contributions and Its Application to the Prediction of Drug Transport Properties. Journal of Medicinal Chemistry. 2000 Oct 1;43(20):3714–7.  doi:[10.1021/JM000942E](https://doi.org/10.1021/JM000942E)

