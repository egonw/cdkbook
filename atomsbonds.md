#  Atoms, Bonds and Molecules

The basic objects in the CDK are the `IAtom`, `IBond` and `IAtomContainer` [1].
The name of the latter is somewhat misleading, as it contains
not just `IAtom`s but also `IBond`s. The primary use of the model is the
graph-based representation of molecules, where bonds are edges between
two atoms being the nodes [2].

Before we start, it is important to note that CDK 2.0 has an important
convention around object properties: when a property is unset, the
object’s field is set to null. This brings in sources for `NullPointerExceptions`,
but also allows us to distinguish between, for example, zero and unset
formal charge. In the former case, the formal charge value be set and have
a zero value; in the latter case, the field has a null value, indicating the
formal charge is currently unknown.

## Atoms

The CDK interface `IAtom` is the underlying data model of atoms. Creating
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
carbon `IElement`, conveniently provided by the `Elements` class:

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

The most common property of `IElement`s are their symbol and atomic
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

The `IIsotope` information consists of the *mass number*, *exact mass* and
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

Appendix B lists all isotopes defined in the CDK with a natural
abundance of more then 0.1.


### IAtomType

Atom types are an important concept in cheminformatics. They describe
some basic facts about that particular atom in some particular
configuration. These properties are used in many cheminformatics algorithms,
including adding hydrogens to hydrogen-depleted chemical graphs (see
Section 14.4.1) and force fields. Chapter 12 provides much more detail
on the atom type infrastructure in the CDK library, and, for example,
details how atom types can be perceived, and how atom type information
is set for atoms.

The `IAtomType` interface contains fields that relate to atom types. These
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

The `IAtom` class supports three types of coordinates: 2D coordinates,
used for diagrams, 3D coordinates for geometries, and crystal unit cell
or notional coordinates. These properties are set with the respective
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

The `IBond` interface of the CDK is an interaction between two or more
`IAtom`s, extending the `IElectronContainer` interface. While the most
common application in the CDK originates from graph theory [2], it is not
restricted to that. That said, many algorithms implemented in the CDK
expect a graph theory based model, where each bond connects two, and
not more, atoms.

For example, to create ethanol we write:

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
structure of benzene with bonds marked as aromatic can be constructed with:

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
electrons are involved. In a double (pi) bond, four electrons are involved,
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

The `IBond.setStereo()` method is discussed in Section 4.1.


## Molecules



## References

1. Steinbeck C, Han Y, Kuhn S, Horlacher O, Luttmann E, Luttmann E, et al. The Chemistry Development Kit (CDK): an open-source Java library for Chemo- and Bioinformatics. Journal of Chemical Information and Modeling. 2003 Feb 11;43(2):493–500. 
2. Balaban AT. Applications of graph theory in chemistry. Journal of Chemical Information and Modeling. 1985 Aug 1;25(3):334–43. 

