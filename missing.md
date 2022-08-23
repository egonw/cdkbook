# Missing Information

Missing information is common place in chemical file formats and line
notations. In many cases this information is implicit to the representation,
but recovering it is not always easy, requiring assumptions which may not be
true. Examples of missing informations is the lack of bonds in XYZ files, and
the removed double bond location information for aromatic ring systems.

## Element and Isotope information

When reading files the format in one way or another has implicit information you
may need for some algorithms. Element and isotope information is a key example.
Typically, the element symbol is provided in the file, but not the mass number
or isotope implied. You would need to read the format specification what properties
are implicitly meant. The idea here is that information about elements and
isotopes is pretty standardized by other organizations such as the IUPAC.
Such default element and isotope properties are exposed in the CDK by the
classes [`Elements`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/config/Elements.html) and [`Isotopes`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/config/Isotopes.html).

### Elements

The [`Elements`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/config/Elements.html) class provides information about the element's
<a name="tp1">atomic number</a>, <a name="tp2">symbol</a>, <a name="tp3">periodic table</a> <a name="tp4">group</a>
and <a name="tp5">period</a>, <a name="tp6">covalent radius</a>
and <a name="tp7">van der Waals radius</a>
and Pauling <a name="tp8">electronegativity</a>:

**<a name="script:ElementsDemo">Script 14.1</a>** [code/ElementsDemo.groovy](code/ElementsDemo.code.md)
```groovy
Elements lithium = Elements.Lithium
println "atomic number: " + lithium.number()
println "symbol: " + lithium.symbol()
println "periodic group: " + lithium.group()
println "periodic period: " + lithium.period()
println "covalent radius: " + lithium.covalentRadius()
println "Vanderwaals radius: " + lithium.vdwRadius()
println "electronegativity: " + lithium.electronegativity()
```

For example, for lithium this gives:

```plain
atomic number: 3
symbol: Li
periodic group: 1
periodic period: 2
covalent radius: 1.34
Vanderwaals radius: 2.2
electronegativity: 0.98
```

### Isotopes

Similarly, there is the [`Isotopes`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/config/Isotopes.html) class to help you look up isotope
information. For example, you can get all isotopes for an element or just
the major isotope (a full list of isotopes is available from
Appendix B:

**<a name="script:HydrogenIsotopes">Script 14.2</a>** [code/HydrogenIsotopes.groovy](code/HydrogenIsotopes.code.md)
```groovy
isofac = Isotopes.getInstance();
isotopes = isofac.getIsotopes("H");
majorIsotope = isofac.getMajorIsotope("H")
for (isotope in isotopes) {
  print "${isotope.massNumber}${isotope.symbol}: " +
    "${isotope.exactMass} ${isotope.naturalAbundance}%"
  if (majorIsotope.massNumber == isotope.massNumber)
    print " (major isotope)"
  println ""
}
```

For hydrogen this gives:

```plain
1H: 1.007825032 99.9885% (major isotope)
2H: 2.014101778 0.0115%
3H: 3.016049278 0.0%
4H: 4.02781 0.0%
5H: 5.03531 0.0%
6H: 6.04494 0.0%
7H: 7.05275 0.0%
```

This class is also used by the `getMajorIsotopeMass` method in the
[`MolecularFormulaManipulator`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/tools/manipulator/MolecularFormulaManipulator.html) class to calculate the
<a name="tp9">monoisotopic mass</a> of a molecule:

**<a name="script:MonoisotopicMass">Script 14.3</a>** [code/MonoisotopicMass.groovy](code/MonoisotopicMass.code.md)
```groovy
molFormula = MolecularFormulaManipulator
  .getMolecularFormula(
    "C2H6O",
    SilentChemObjectBuilder.getInstance()
  )
println "Monoisotopic mass: " +
  MolecularFormulaManipulator.getMajorIsotopeMass(
    molFormula
  )
```

The output for ethanol looks like:

**<a name="script:MonoisotopicMass">Script 14.3</a>** [code/MonoisotopicMass.groovy](code/MonoisotopicMass.code.md)
```groovy
molFormula = MolecularFormulaManipulator
  .getMolecularFormula(
    "C2H6O",
    SilentChemObjectBuilder.getInstance()
  )
println "Monoisotopic mass: " +
  MolecularFormulaManipulator.getMajorIsotopeMass(
    molFormula
  )
```

<a name="sec:"></a>
## Reconnecting Atoms

XYZ files do not have bond information, and may look like:

```plain
5
methane
C  0.25700 -0.36300  0.00000
H  0.25700  0.72700  0.00000
H  0.77100 -0.72700  0.89000
H  0.77100 -0.72700 -0.89000
H -0.77100 -0.72700  0.00000
```

Fortunately, we can reasonably assume bonds to have a certain length, and
reasonably understand how many connections and atom can have at most. Then,
using the 3D coordinate information available from the XYZ file, an algorithm
can deduce how the atoms must be bonded. The [`RebondTool`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/graph/rebond/RebondTool.html) does exactly
that. And, it does it efficiently too, using a binary search tree, which allows
it to scale to protein-sized molecules.

Now, the algorithm does need to know what reasonable bond lengths are, and for
this we can use the Jmol list of <a name="tp10">covalent radii</a>, and
we configure the atoms accordingly:

**<a name="script:CovalentRadii">Script 14.4</a>** [code/CovalentRadii.groovy](code/CovalentRadii.code.md)
```groovy
methane = new AtomContainer();
methane.addAtom(new Atom("C", new Point3d(0.0, 0.0, 0.0)));
methane.addAtom(new Atom("H", new Point3d(0.6, 0.6, 0.6)));
methane.addAtom(new Atom("H", new Point3d(-0.6,-0.6,0.6)));
methane.addAtom(new Atom("H", new Point3d(0.6,-0.6,-0.6)));
methane.addAtom(new Atom("H", new Point3d(-0.6,0.6,-0.6)));
factory = AtomTypeFactory.getInstance(
  "org/openscience/cdk/config/data/jmol_atomtypes.txt", 
  methane.getBuilder()
);
for (IAtom atom : methane.atoms()) {
  factory.configure(atom);
  println "$atom.symbol -> $atom.covalentRadius"
}
```

which configures and prints the atoms' radii:

```plain
C -> 0.77
H -> 0.32
H -> 0.32
H -> 0.32
H -> 0.32
```

Then the [`RebondTool`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/graph/rebond/RebondTool.html) can be used to rebind the atoms:

**<a name="script:RebondToolDemo">Script 14.5</a>** [code/RebondToolDemo.groovy](code/RebondToolDemo.code.md)
```groovy
RebondTool rebonder = new RebondTool(2.0, 0.5, 0.5);
rebonder.rebond(methane);
println "Bond count: $methane.bondCount"
```

The number of bonds it found are reported
in the last line:

```plain
Bond count: 4
```

## Missing Bond Orders

There are several reasons why <a name="tp11">bond orders</a> are missing from an input structure.
For example, you may be reading a XYZ file and just performed a rebonding as
outlined in the previous section. Or, you may be reading SMILES strings with
aromatic organic subset atoms, such as *c1ccccc1*. Or, you may be reading
a MDL molfile that uses the query bond order 4 to indicate an *aromatic*
bond.

The latter two situations are, in fact, very common in cheminformatics. Before
CDK 1.4.11 we had the `DeduceBondSystemTool` to find the location of double
bonds in such delocalized electron bond systems, but in that 1.4.11 release a
new tool was released, the `FixBondOrdersTool` class, that does a better job,
and faster too. Both classes only look for double bond positions in rings, but
that covers many common use cases.

The method requires atom types to be perceived already, which is already done
when reading SMILES, for example for pyrrole:

**<a name="script:FixPyrroleBondOrders">Script 14.6</a>** [code/FixPyrroleBondOrders.groovy](code/FixPyrroleBondOrders.code.md)
```groovy
pyrrole = smilesParser.parseSmiles(
  "c2ccc3n([H])c1ccccc1c3(c2)"
)
fbot = new FixBondOrdersTool()
pyrrole = fbot.kekuliseAromaticRings(pyrrole)
```

This results in the image given in Figure [15.1](#fig:pyrrole).

<a name="fig:pyrrole"></a>
![](code/generated/FixPyrroleBondOrders.png)
<br />**Figure 15.1**: 2D diagram of pyrrole.

<a name="sec:missinghydrogens"></a>
## Missing Hydrogens

The [`CDKHydrogenAdder`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/tools/CDKHydrogenAdder.html) class can be used to add
<a name="tp12">missing hydrogens</a>. The algorithm itself adds implicit
hydrogens (see Section [4.5](atomsbonds.md#sec:hydrogens)), but we will see how these can be
converted into explicit hydrogens. 
The hydrogen adding algorithm expects, however, that CDK atom
types are already perceived (see Section [13.2](atomtype.md#sec:atomtypePerception)).

<a name="sec:implicithydrogens"></a>
### Implicit Hydrogens

Hydrogens that are not vertices in the molecular graph are called
<a name="tp13">implicit hydrogens</a>. They are merely a property of the atom to which
they are connected. If these values are not given, which is common in
for example SMILES, they can be (re)calculated with:

**<a name="script:MissingHydrogens">Script 14.7</a>** [code/MissingHydrogens.groovy](code/MissingHydrogens.code.md)
```groovy
adder = CDKHydrogenAdder.getInstance(
  DefaultChemObjectBuilder.getInstance()
);
adder.addImplicitHydrogens(molecule);
println "Atom count: $molecule.atomCount"
println "Implicit hydrogens: $newAtom.hydrogenCount"
```

which reports:

```plain
Atom count: 1
Implicit hydrogens: 4
```

<a name="sec:explicithydrogens"></a>
### Explicit Hydrogens

These implicit hydrogens can be converted into <a name="tp14">explicit hydrogens</a>
using the following code:

**<a name="script:ExplicitHydrogens">Script 14.8</a>** [code/ExplicitHydrogens.groovy](code/ExplicitHydrogens.code.md)
```groovy
adder.addImplicitHydrogens(molecule);
println "Atom count: $molecule.atomCount"
println " .. adding explicit hydrogens .."
AtomContainerManipulator.convertImplicitToExplicitHydrogens(
  molecule
);
println "Atom count: $molecule.atomCount"
```

which reports for the running methane example:

```plain
Atom count: 1
 .. adding explicit hydrogens ..
Atom count: 5
```

<a name="sec:layout"></a>
## 2D Coordinates

Another bit of information missing from the input is often <a name="tp15">2D coordinates</a>.
To generate 2D <a name="tp16">coordinates</a>, the [`StructureDiagramGenerator`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/layout/StructureDiagramGenerator.html) can be
used:

**<a name="script:Layout">Script 14.9</a>** [code/Layout.groovy](code/Layout.code.md)
```groovy
butanol = smilesParser.parseSmiles("CCC(O)C")
sdg = new StructureDiagramGenerator();
sdg.setMolecule(butanol);
sdg.generateCoordinates(new Vector2d(0, 1));
butanol = sdg.getMolecule();
for (atom in butanol.atoms()) {
  println atom.getSymbol() + ": " +
    atom.getPoint2d()
}
```

which will generate the coordinate starting with an initial direction:

```plain
C: (-1.7763568394002505E-15, -1.3322676295501878...
  E-15)
C: (0.0, 1.4999999999999991)
C: (-1.299038105676657, 2.2500000000000018)
O: (-2.5980762113533165, 1.5000000000000049)
C: (-1.299038105676652, 3.750000000000002)
```

<a name="sec:unknownmf"></a>
## Unknown Molecular Formula

Mass spectrometry (MS) is a technology where the experiment yields monoisotopic
masses for molecules. In order to analyze these further, it is common to convert
them to <a name="tp17">molecular formula</a>. The `MassToFormulaTool` has functionality
to determine these missing formulae. Miguel Rojas-Chertó developed this code
for use in <a name="tp18">metabolomics</a> [<a href="#citeref1">1</a>]. Basic usage looks like:

**<a name="script:MissingMF">Script 14.10</a>** [code/MissingMF.groovy](code/MissingMF.code.md)
```groovy
tool = new MassToFormulaTool(
  SilentChemObjectBuilder.getInstance()
)
mfSet = tool.generate(133.0968);
for (mf in mfSet) {
  println MolecularFormulaManipulator.getString(mf)
}
```

This will create a long list of possible molecular formula. It is important to realize
that it looks only at what molecular formula are possible with respect to the
corresponding mass. This means that it will include chemically unlikely molecular
formulae:

```plain
C3H11N5O
C5H13N2O2
C2H15NO5
CH9N8
H13N4O4
C10H13
C9H11N
CH15N3O4
C6H13O3
C2H11N7
C4H11N3O2
C4H13N4O
C2H9N6O
C6H15NO2
CH13N2O5
H7N9
C8H9N2
H15N5O3
C5H11NO3
C3H13N6
C3H9N4O2
C5H15N3O
C2H13O6
CH7N7O
H11N3O5
C9H9O
C7H7N3
C4H9N2O3
C4H15N5
C2H7N5O2
CH11NO6
H5N8O
C8H7NO
C6H5N4
C5H9O4
C3H7N3O3
CH5N6O2
```

This is overcome by setting restrictions. For example, we can put restrictions on the
number of elements we allow in the matched formulae:

**<a name="script:MissingMFRestrictions">Script 14.11</a>** [code/MissingMFRestrictions.groovy](code/MissingMFRestrictions.code.md)
```groovy
MolecularFormulaRange range =
  new MolecularFormulaRange();
range.addIsotope( ifac.getMajorIsotope("C"), 8, 20);
range.addIsotope( ifac.getMajorIsotope("H"), 0, 20);
range.addIsotope( ifac.getMajorIsotope("O"), 0, 1);
range.addIsotope( ifac.getMajorIsotope("N"), 0, 1);
MolecularFormulaGenerator tool =
  new MolecularFormulaGenerator(
    SilentChemObjectBuilder.getInstance(),
    133.0, 133.1, range
  );
IMolecularFormulaSet mfSet = tool.getAllFormulas();
```

Now the list looks more chemical:

```plain
C11H 133.007825032
C9H11N 133.089149352
C9H9O 133.065339908
C8H7NO 133.052763844
```

Of course, this is a long way from actual chemical structures. An Open Source structure
generator has been a long standing holy grail, and recently the CDK-based Open Molecular
Generator addressed this gap [<a href="#citeref2">2</a>].

## References

1. <a name="citeref1"></a>Rojas-Cherto M, Kasper PT, Willighagen E, Vreeken RJ, Hankemeier T, Reijmers TH. Elemental composition determination based on MSn. Bioinformatics. 2011 Jul 14;27(17):2376–83.  doi:[10.1093/BIOINFORMATICS/BTR409](https://doi.org/10.1093/BIOINFORMATICS/BTR409) ([Scholia](https://scholia.toolforge.org/doi/10.1093/BIOINFORMATICS/BTR409))
2. <a name="citeref2"></a>Peironcely JE, Rojas-Chertó M, Fichera D, Reijmers T, Reijmers T, Coulier L, et al. OMG: Open Molecule Generator. J Cheminform. 2012 Sep 17;4(1):21.  doi:[10.1186/1758-2946-4-21](https://doi.org/10.1186/1758-2946-4-21) ([Scholia](https://scholia.toolforge.org/doi/10.1186/1758-2946-4-21))


