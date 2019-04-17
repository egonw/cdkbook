#  Atoms, Bonds and Molecules

The basic objects in the CDK are the <a name="tp1">[`IAtom`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/interfaces/IAtom.html)</a>, [`IBond`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/interfaces/IBond.html) and
[`IAtomContainer`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/interfaces/IAtomContainer.html) [<a href="#citeref1">1</a>].
The name of the latter is somewhat misleading, as it contains
not just [`IAtom`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/interfaces/IAtom.html)s but also [`IBond`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/interfaces/IBond.html)s. The primary use of the model is the
graph-based representation of molecules, where bonds are edges between
two atoms being the nodes [<a href="#citeref2">2</a>].

Before we start, it is important to note that CDK 2.0 has an important
convention around object properties: when a property is unset, the
object’s field is set to null. This brings in sources for `NullPointerExceptions`,
but also allows us to distinguish between, for example, zero and unset
formal charge. In the former case, the formal charge value be set and have
a zero value; in the latter case, the field has a null value, indicating the
formal charge is currently unknown.

## Atoms

The CDK interface <a name="tp2">[`IAtom`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/interfaces/IAtom.html)</a> is the underlying data model of atoms. Creating
a new atom is fairly easy. For example, we can create an atom of element
type carbon, as defined by the element’s atomic number that we pass as parameter
in the constructor:

**Script** [code/CreateAtom3.groovy](code/CreateAtom3.code.md)
```groovy
atom = new Atom(6);
```

An atom can also be constructed by passing in the symbol but this is marginally
less efficient:

**Script** [code/CreateAtom1.groovy](code/CreateAtom1.code.md)
```groovy
IAtom atom = new Atom("C");
```

Alternatively, we can also construct a new carbon atom, by passing a
carbon [`IElement`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/interfaces/IElement.html), conveniently provided by the [`Elements`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/config/Elements.html) class:

**Script** [code/CreateAtom2.groovy](code/CreateAtom2.code.md)
```groovy
IAtom atom = new Atom(Elements.CARBON);
```

A CDK atom has many properties, many of them inherited from the `IElement`,
`IIsotope` and `IAtomType` interfaces. Figure 3.1 shows the interface
inheritance specified by the CDK data model.

These constructors will set the atomic number of the atom:

```plain
atomic number: 6
```

### IElement

The most common property of <a name="tp3">[`IElement`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/interfaces/IElement.html)</a>s are their symbol and atomic
number. Because the `IAtom` extends the `IElement`, CDK atoms also have
these properties. Therefore, we can set these properties for atoms
manually too:

**Script** [code/ElementProperties.groovy](code/ElementProperties.code.md)
```groovy
atom.setSymbol("N")
atom.setAtomicNumber(7)
```

Of course, we can use the matching get methods to recover the properties:

**Script** [code/ElementGetProperties.groovy](code/ElementGetProperties.code.md)
```groovy
IAtom atom = new Atom(Elements.CARBON);
println "Symbol: " + atom.getSymbol()
println "Atomic number: " + atom.getAtomicNumber()
```

which outputs:

```plain
Symbol: C
Atomic number: 6
```

### IIsotope

The <a name="tp4">`IIsotope`</a> information consists of the *mass number*, *exact mass* and
*natural abundance*:

**Script** [code/IsotopeProperties.groovy](code/IsotopeProperties.code.md)
```groovy
IAtom atom = new Atom("C");
atom.setMassNumber(13)
atom.setNaturalAbundance(1.07)
atom.setExactMass(13.00335484)
```

Here too, the complementary get methods are available:

**Script** [code/IsotopeGetProperties.groovy](code/IsotopeGetProperties.code.md)
```groovy
println "Mass number: " + atom.getMassNumber()
println "Natural abundance: " + atom.getNaturalAbundance()
println "Exact mass: " + atom.getExactMass()
```

giving:

```plain
Mass number: 13
Natural abundance: 1.07
Exact mass: 13.00335484
```

Appendix [B](appisotopes.md#sec:isotopes) lists all isotopes defined in the CDK with a natural
abundance of more then 0.1.


### IAtomType

Atom types are an important concept in cheminformatics. They describe
some basic facts about that particular atom in some particular
configuration. These properties are used in many cheminformatics algorithms,
including adding hydrogens to hydrogen-depleted chemical graphs (see
Section [14.4.1](missing.md#sec:implicithydrogens)) and force fields. Chapter [12](atomtype.md#sec:atomtype) provides much more detail
on the atom type infrastructure in the CDK library, and, for example,
details how atom types can be perceived, and how atom type information
is set for atoms.

The <a name="tp5">`IAtomType`</a> interface contains fields that relate to atom types. These
properties include formal charge, neighbor count, maximum bond order
and atom type name:

**Script** [code/AtomTypeProperties.groovy](code/AtomTypeProperties.code.md)
```groovy
atom.setAtomTypeName("C.3")
atom.setFormalCharge(-1)
atom.setMaxBondOrder(IBond.Order.SINGLE)
atom.setFormalNeighbourCount(4)
```

### Coordinates

The `IAtom` class supports three types of coordinates: <a name="tp6">2D coordinates</a>,
used for diagrams, <a name="tp7">3D coordinates</a> for geometries, and crystal <a name="tp8">unit cell</a>
or <a name="tp9">notional coordinates</a>. These properties are set with the respective
methods:

**Script** [code/AtomCoordinates.groovy](code/AtomCoordinates.code.md)
```groovy
atom.setPoint2d(
  new Point2d(1.0, 2.3)
)
atom.setPoint3d(
  new Point3d(-2.0, -3.5, 4.7)
)
atom.setFractionalPoint3d(
  new Point3d(0.1, 0.5, 0.25)
)
```

The latter coordinates define the locations of the atoms with respect to
(or inside) the crystal structure’s unit cell. Section 5.2 explains the full
crystal structure functionality.

## Bonds

The <a name="tp10">[`IBond`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/interfaces/IBond.html)</a> interface of the CDK is an interaction between two or more
`IAtom`s, extending the <a name="tp11">`IElectronContainer`</a> interface. While the most
common application in the CDK originates from graph theory [2], it is not
restricted to that. That said, many algorithms implemented in the CDK
expect a graph theory based model, where each bond connects two, and
not more, atoms.

For example, to create <a name="tp12">ethanol</a> we write:

**Script** [code/Ethanol.groovy](code/Ethanol.code.md)
```groovy
IAtom atom1 = new Atom("C")
IAtom atom2 = new Atom("C")
IAtom atom3 = new Atom("O")
IBond bond1 = new Bond(atom1, atom2, IBond.Order.SINGLE);
IBond bond2 = new Bond(atom2, atom3, IBond.Order.SINGLE);
```

The CDK has a few bond orders, which we can list with this groovy code:

**Script** [code/BondOrders.groovy](code/BondOrders.code.md)
```groovy
IBond.Order.each {
  println it
}
```

which outputs:

```plain
SINGLE
DOUBLE
TRIPLE
QUADRUPLE
QUINTUPLE
SEXTUPLE
UNSET
```

As you might notice, there is no `AROMATIC` bond defined. This is
deliberate and the CDK allows to define single-double bond order patterns at
the same time as aromaticity information. For example, a kekule
structure of <a name="tp13">benzene</a> with bonds marked as aromatic can be constructed with:

**Script** [code/AromaticBond.groovy](code/AromaticBond.code.md)
```groovy
IAtom atom1 = new Atom("C")
IAtom atom2 = new Atom("C")
IAtom atom3 = new Atom("C")
IAtom atom4 = new Atom("C")
IAtom atom5 = new Atom("C")
IAtom atom6 = new Atom("C")
IBond bond1 = new Bond(atom1, atom2, IBond.Order.SINGLE)
IBond bond2 = new Bond(atom2, atom3, IBond.Order.DOUBLE)
IBond bond3 = new Bond(atom3, atom4, IBond.Order.SINGLE)
IBond bond4 = new Bond(atom4, atom5, IBond.Order.DOUBLE)
IBond bond5 = new Bond(atom5, atom6, IBond.Order.SINGLE)
IBond bond6 = new Bond(atom6, atom1, IBond.Order.DOUBLE)
bond1.setFlag(CDKConstants.ISAROMATIC, true);
bond2.setFlag(CDKConstants.ISAROMATIC, true);
bond3.setFlag(CDKConstants.ISAROMATIC, true);
bond4.setFlag(CDKConstants.ISAROMATIC, true);
bond5.setFlag(CDKConstants.ISAROMATIC, true);
bond6.setFlag(CDKConstants.ISAROMATIC, true);
```

### Electron counts

Bond orders, as we have seen earlier, are commonly used in the CDK to
indicate the electronic properties of a bond. At the same time, each bond
consists of a number of atoms. For example, in a single (sigma) bond, two
<a name="tp14">electrons</a> are involved. In a double (pi) bond, four electrons are involved,
and in a triple bond, six electrons are involved. We can report on the
electron counts for the various orders with this code:

**Script** [code/ElectronCounts.groovy](code/ElectronCounts.code.md)
```groovy
IBond.Order.each { order ->
  bond = new Bond(
    new Atom("C"), new Atom("C"),
    order
  )
  println "Bond order $order has " +
    bond.electronCount + " electrons"
}
```

showing us the default implementation:

```plain
Bond order SINGLE has 2 electrons
Bond order DOUBLE has 4 electrons
Bond order TRIPLE has 6 electrons
Bond order QUADRUPLE has 8 electrons
Bond order QUINTUPLE has 10 electrons
Bond order SEXTUPLE has 12 electrons
Bond order UNSET has 0 electrons
```
 
### Bond stereochemistry

The `IBond.setStereo()` method is discussed in Section [4.1](stereo.md#sec:stereo:bond).

<a name="sec:molecules"></a>
## Molecules

We already saw in the previous pieces of code how the CDK can be used to create
molecules, and while the above is, strictly speaking, enough to find all atoms in the
<a name="tp15">molecule</a> starting with only one of the atoms in the molecule, it often is more
convenient to store all atoms and bonds in a container.

The CDK has one container: the [`IAtomContainer`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/interfaces/IAtomContainer.html).
It is a general container to holds atoms an bonds, and can contain both
unconnected as well asfully connected structures. The latter
has the added implication that it holds a single molecule, of which all
atoms are connected to each other via one or more covalent bonds.

Adding atoms and bonds is done by the methods `addAtom(IAtom)` and
`addBond(IBond)`:

**Script** [code/AtomContainerAddAtomsAndBonds.groovy](code/AtomContainerAddAtomsAndBonds.code.md)
```groovy
mol = new AtomContainer();
mol.addAtom(new Atom("C"));
mol.addAtom(new Atom("H"));
mol.addAtom(new Atom("H"));
mol.addAtom(new Atom("H"));
mol.addAtom(new Atom("H"));
mol.addBond(new Bond(mol.getAtom(0), mol.getAtom(1)));
mol.addBond(new Bond(mol.getAtom(0), mol.getAtom(2)));
mol.addBond(new Bond(mol.getAtom(0), mol.getAtom(3)));
mol.addBond(new Bond(mol.getAtom(0), mol.getAtom(4)));
```

The `addBond()` method has an alternative which takes three parameters:
the first atom, the second atom, and the bond order. Note that atom indices
follows programmers habits and starts at `0`, as you can observe in the
previous example too. This shortens the previous version a bit:

**Script** [code/AtomContainerAddAtomsAndBonds2.groovy](code/AtomContainerAddAtomsAndBonds2.code.md)
```groovy
mol = new AtomContainer();
mol.addAtom(new Atom("C"));
mol.addAtom(new Atom("H"));
mol.addAtom(new Atom("H"));
mol.addAtom(new Atom("H"));
mol.addAtom(new Atom("H"));
mol.addBond(0,1,IBond.Order.SINGLE);
mol.addBond(0,2,IBond.Order.SINGLE);
mol.addBond(0,3,IBond.Order.SINGLE);
mol.addBond(0,4,IBond.Order.SINGLE);
```

### Iterating over atoms and bonds

The [`IAtomContainer`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/interfaces/IAtomContainer.html) comes with convenience methods to iterate over atoms
and bonds. Both methods use the `Iterable` interfaces, and for atoms we
do:

**Script** [code/CountHydrogens.groovy](code/CountHydrogens.code.md)
```groovy
int hydrogenCount = 0
for (IAtom atom : mol.atoms()) {
    if ("H".equals(atom.getSymbol())) hydrogenCount++
}
println "Number of hydrogens: $hydrogenCount"
```

which returns

```plain
Number of hydrogens: 4
```

And for bonds the equivalent:

**Script** [code/CountDoubleBonds.groovy](code/CountDoubleBonds.code.md)
```groovy
int doubleBondCount = 0
for (IBond bond : mol.bonds()) {
  if (IBond.Order.DOUBLE == bond.getOrder())
    doubleBondCount++
}
println "Number of double bonds: $doubleBondCount"
```

giving

```plain
Number of double bonds: 1
```

### Neighboring atoms and bonds

It is quite common that you like to see what atoms are connected
to one particular atom. For example, you may wish to count how many
bonds surround a particular atom. Or, you may want to list all atoms
that are bound to this atom. The [`IAtomContainer`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/interfaces/IAtomContainer.html) class
provides methods for these use cases. But it should be stressed that
these methods do only take into account explicit hydrogens (see the
next section).

Let's consider ethanol again, given in Script XX,
and count the number of neighbors for each atom:

**Script** [code/NeighborCount.groovy](code/NeighborCount.code.md)
```groovy
for (atom in ethanol.atoms()) {
  println atom.getSymbol() +
    " " + ethanol.getConnectedAtomsCount(atom)
}
```

which lists for the three heavy atoms:

```plain
C 1
C 2
O 1
```

Similarly, we can also list all <a name="tp16">connected atoms</a>:

**Script** [code/ConnectedAtoms.groovy](code/ConnectedAtoms.code.md)
```groovy
for (atom in ethanol.atoms()) {
  print atom.getSymbol() +
    " is connected to "
  for (neighbor in ethanol.getConnectedAtomsList(atom)) {
    print neighbor.getSymbol() + " "
  }
  println ""
}
```

which outputs:

```plain
C is connected to C 
C is connected to C O 
O is connected to C 
```

We can do the same thing for <a name="tp17">connected bonds</a>:

**Script** [code/ConnectedBonds.groovy](code/ConnectedBonds.code.md)
```groovy
for (atom in ethanol.atoms()) {
  print atom.getSymbol() +
    " has bond(s)"
  for (bond in ethanol.getConnectedBondsList(atom)) {
    print " " + bond.getOrder()
  }
  println ""
}
```

which outputs:

```plain
C has bond(s) SINGLE
C has bond(s) SINGLE SINGLE
O has bond(s) SINGLE
```

<a name="sec:molecularFormula"></a>
## Molecular Formula

Getting the <a name="tp18">molecular formula</a> of a molecule and returning that as a String
is both done with the [`MolecularFormulaManipulator`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/tools/manipulator/MolecularFormulaManipulator.html) class:

**Script** [code/MFGeneration.groovy](code/MFGeneration.code.md)
```groovy
molForm = MolecularFormulaManipulator.getMolecularFormula(
  azulene
)
mfString = MolecularFormulaManipulator.getString(molForm)
println "Azulene: $mfString"
```

giving:

```plain
Azulene: C10H8
```

## References

1. <a name="citeref1"></a>Steinbeck C, Han Y, Kuhn S, Horlacher O, Luttmann E, Luttmann E, et al. The Chemistry Development Kit (CDK): an open-source Java library for Chemo- and Bioinformatics. Journal of Chemical Information and Modeling. 2003 Feb 11;43(2):493–500.  doi:[10.1021/CI025584Y](https://doi.org/10.1021/CI025584Y)
2. <a name="citeref2"></a>Balaban AT. Applications of graph theory in chemistry. Journal of Chemical Information and Modeling. 1985 Aug 1;25(3):334–43.  doi:[10.1021/CI00047A033](https://doi.org/10.1021/CI00047A033)

