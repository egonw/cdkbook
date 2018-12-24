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

Appendix B lists all isotopes defined in the CDK with a natural abun-
dance of more then 0.1.


## References

1. C. Steinbeck, Y. Han, S. Kuhn, O. Horlacher, E. Luttmann, E. Willighagen, The Chemistry Development Kit (CDK): An Open-Source Java Library for Chemo- and Bioinformatics, J. Chem. Inf. Comput. Sci. 2003, 43, 493–500.
2. A. T. Balaban, Applications of graph theory in chemistry, Journal of Chemical Information and Computer Sciences 1985, 25, 334–343.
