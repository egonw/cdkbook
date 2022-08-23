# Molecular Properties

Cheminformatics is about molecular properties and chemistry in general the field
of finding chemicals with new properties. [Prof. Gasteiger](https://scholia.toolforge.org/author/Q109081)
in 2006 gave a lecture at Cologne University where he expressed this view. It stuck around. We keep
databases to store those properties, and we develop methods to predict and understand
those properties. Prediction is important for one reason: there are too many
chemical structures and we cannot experimentally measure the properties for all
of them. The number of molecules is often said to be relevant to drug discovery is in
the order of 10<sup>60</sup>. The largest current databases have less than 10<sup>8</sup>
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

**<a name="script:CalculateMolecularWeight">Script 16.1</a>** [code/CalculateMolecularWeight.groovy](code/CalculateMolecularWeight.code.md)
```groovy
molWeight = 0.0
for (atom in molecule.atoms()) {
  molWeight += isotopeInfo.getNaturalMass(atom)
}
```

In this case, you can also use the [`AtomContainerManipulator`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/tools/manipulator/AtomContainerManipulator.html):

**<a name="script:CalculateMolecularWeightShort">Script 16.2</a>** [code/CalculateMolecularWeightShort.groovy](code/CalculateMolecularWeightShort.code.md)
```groovy
molWeight = AtomContainerManipulator
  .getNaturalExactMass(molecule)
```

The element masses are calculated from the accurate isotope masses and natural
abundances defined in the Blue Obelisk Data Repository [<a href="#citeref1">1</a>].

### Implicit Hydrogens

If your atom container has <a name="tp2">implicit hydrogens</a> specified, you will have the above
code will not be sufficient. Instead, your code should look like:

**<a name="script:CalculateMolecularWeightImplicitHydrogens">Script 16.3</a>** [code/CalculateMolecularWeightImplicitHydrogens.groovy](code/CalculateMolecularWeightImplicitHydrogens.code.md)
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


<a name="sec:properties:logp"></a>
## LogP

The <a name="tp3">partition coefficient</a> describes how a molecular structure distributes
itself over two immiscible solvents. The logarithm of the partition coefficient (<a name="tp4">LogP</a>) between
octanol and water is often used in cheminformatics to describe hydrophobicity [<a href="#citeref2">2</a>,<a href="#citeref3">3</a>].
Wikipedia gives [this equation](http://en.wikipedia.org/wiki/Partition_coefficient).
This equation assumes that the solute is neutral, which may involve changing the pH of the water.

The CDK has implemented an algorithm based on the <a name="tp5">XLogP</a> algorithm [<a href="#citeref4">4</a>,<a href="#citeref5">5</a>]. The
code is available via the descriptor API. It can be used to calculate the LogP for a single
molecule. The implementation expects explicit hydrogens, so you need to add those if not
present yet (see Section [15.4](missing.md#sec:missinghydrogens)). The calculation returns a [`DoubleResult`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/qsar/result/DoubleResult.html)
following the descriptor API:

**<a name="script:XLogP">Script 16.4</a>** [code/XLogP.groovy](code/XLogP.code.md)
```groovy
oxazone = MoleculeFactory.makeOxazole();
benzene = MoleculeFactory.makeBenzene();
// add explicit hydrogens ...
descriptor = new XLogPDescriptor()
println "LogP of oxazone: " +
  ((DoubleResult)descriptor.calculate(oxazone).value)
  .doubleValue()
println "LogP of benzene: " +
  ((DoubleResult)descriptor.calculate(benzene).value)
  .doubleValue()
```

which returns:

```plain
LogP of oxazone: -0.14800000000000002
LogP of benzene: 2.082
```

An alternative is the more recent algorithm by Plante [<a href="#citeref6">6</a>].

<a name="sec:tpsa"></a>
## Total Polar Surface Area

Another properties that frequently returns in cheminformatics is the <a name="tp6">Total Polar Surface Area</a>
(<a name="tp7">TPSA</a>). The code in the CDK uses an algorithm published by Ertl in 2000 [<a href="#citeref7">7</a>].
Here too, the descriptor API is used, so that the code is quite similar to that for the logP
calculation:

**<a name="script:TPSA">Script 16.5</a>** [code/TPSA.groovy](code/TPSA.code.md)
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


## Van der Waals Volume

Quite related to the TPSA discussed in the previous section, is the actual <a name="tp8">molecular volume</a>
itself. Zhao et al. proposed a simple, additive model to estimate the <a name="tp9">van der waals volume</a>
of molecules [<a href="#citeref8">8</a>], though their method is restricted to molecules with only these elements:
H, C, N, O, F, Cl, Br, I, P, S, As, B, Si, Se, and Te. The additive method is based on averaged
volumes of the bonds, corrected for the number of rings. The bond volumes are specific for
particular element-element combinations, which explains why their approach only works for the
aforementioned list of elements. The full method is implemented by the [`VABCVolume`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/geometry/volume/VABCVolume.html) class,
which does not use the descriptor API, so that we can simply use the following method:

**<a name="script:VABCVolumes">Script 16.6</a>** [code/VABCVolumes.groovy](code/VABCVolumes.code.md)
```groovy
methane = smilesParser.parseSmiles("C");
println "Methane volume = " +
  VABCVolume.calculate(methane);
ethane = smilesParser.parseSmiles("CC");
println "Ethane volume = " +
  VABCVolume.calculate(ethane);
```

This code gives us the volumes of methane and ethane in cubic Ångström:

```plain
Methane volume = 25.8524433266667
Ethane volume = 43.14842795253341
```


<a name="sec:aromaticity"></a>
## Aromaticity

I am not fond of the <a name="tp10">aromaticity</a> concept; first of all, because there is no universal definition.
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

**<a name="script:AromaticityDemo">Script 16.7</a>** [code/AromaticityDemo.groovy](code/AromaticityDemo.code.md)
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

**<a name="script:AromaticBonds">Script 16.8</a>** [code/AromaticBonds.groovy](code/AromaticBonds.code.md)
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

1. <a name="citeref1"></a>Guha R, Howard MT, Hutchison GR, Murray-Rust P, Rzepa HS, Steinbeck C, et al. The Blue Obelisk-interoperability in chemical informatics. JCIM. 2006 Feb 22;46(3):991–8.  doi:[10.1021/CI050400B](https://doi.org/10.1021/CI050400B) ([Scholia](https://scholia.toolforge.org/doi/10.1021/CI050400B))
2. <a name="citeref2"></a>Leo A, Hansch C, Elkins D. Partition coefficients and their uses. Chem Rev. 1971 Dec;71(6):525–616.  doi:[10.1021/CR60274A001](https://doi.org/10.1021/CR60274A001) ([Scholia](https://scholia.toolforge.org/doi/10.1021/CR60274A001))
3. <a name="citeref3"></a>Leo AJ. Calculating log Poct from structures. Chem Rev. 1993 Jun;93(4):1281–306.  doi:[10.1021/CR00020A001](https://doi.org/10.1021/CR00020A001) ([Scholia](https://scholia.toolforge.org/doi/10.1021/CR00020A001))
4. <a name="citeref4"></a>Wang R, Fu Y, Lai L. A New Atom-Additive Method for Calculating Partition Coefficients. JCICS. 1997 May;37(3):615–21.  doi:[10.1021/CI960169P](https://doi.org/10.1021/CI960169P) ([Scholia](https://scholia.toolforge.org/doi/10.1021/CI960169P))
5. <a name="citeref5"></a>Wang R, Gao Y, Lai L. JCAMD. 2000;19(1):47–66.  doi:[10.1023/A:1008763405023](https://doi.org/10.1023/A:1008763405023) ([Scholia](https://scholia.toolforge.org/doi/10.1023/A:1008763405023))
6. <a name="citeref6"></a>Plante JP, Werner S. JPlogP: an improved logP predictor trained using predicted data. J Cheminform. 2018 Dec 14;10(1):61.  doi:[10.1186/S13321-018-0316-5](https://doi.org/10.1186/S13321-018-0316-5) ([Scholia](https://scholia.toolforge.org/doi/10.1186/S13321-018-0316-5))
7. <a name="citeref7"></a>Ertl P, Rohde B, Selzer P. Fast Calculation of Molecular Polar Surface Area as a Sum of Fragment-Based Contributions and Its Application to the Prediction of Drug Transport Properties. J Med Chem. 2000 Oct;43(20):3714–7.  doi:[10.1021/JM000942E](https://doi.org/10.1021/JM000942E) ([Scholia](https://scholia.toolforge.org/doi/10.1021/JM000942E))
8. <a name="citeref8"></a>Zhao YH, Abraham MH, Zissimos AM. Fast calculation of van der Waals volume as a sum of atomic and bond contributions and its application to drug compounds. JOC. 2003 Sep 1;68(19):7368–73.  doi:[10.1021/JO034808O](https://doi.org/10.1021/JO034808O) ([Scholia](https://scholia.toolforge.org/doi/10.1021/JO034808O))

