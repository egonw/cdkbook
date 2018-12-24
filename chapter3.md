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
type carbon, as defined by the element’s symbol that we pass as parameter
in the constructor:

```groovy
IAtom atom = new Atom("C");
```

Alternatively, we can also construct a new carbon atom, by passing a
carbon `IElement`, conveniently provided by the `Elements` class:

```groovy
IAtom atom = new Atom(Elements.CARBON);
```

A CDK atom has many properties, many of them inherited from the `IElement`,
`IIsotope` and `IAtomType` interfaces. Figure 3.1 shows the interface
inheritance specified by the CDK data model.

These constructors will set both the symbol as well as the atomic number
of the atom:

```plain
atomic number: 6
```

### IElement

The most common property of `IElement`s are their symbol and atomic
number. Because the `IAtom` extends the `IElement`, CDK atoms also have
these properties. Therefore, we can set these properties for atoms
manually too:

```groovy
atom.setSymbol("N")
atom.setAtomicNumber(7)
```

Of course, we can use the matching get methods to recover the properties:

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

The `IIsotope` information consists of the mass number, exact mass and
natural abundance:

```groovy
IAtom atom = new Atom("C");
atom.setMassNumber(13)
atom.setNaturalAbundance(1.07)
atom.setExactMass(13.00335484)
```

Here too, the complementary get methods are available:

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


## References

1. C. Steinbeck, Y. Han, S. Kuhn, O. Horlacher, E. Luttmann, E. Willighagen, The Chemistry Development Kit (CDK): An Open-Source Java Library for Chemo- and Bioinformatics, J. Chem. Inf. Comput. Sci. 2003, 43, 493–500.
2. A. T. Balaban, Applications of graph theory in chemistry, Journal of Chemical Information and Computer Sciences 1985, 25, 334–343.
