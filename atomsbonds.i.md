#  Atoms, Bonds and Molecules

The basic objects in the CDK are the <topic type="class">IAtom</topic>, `IBond` and `IAtomContainer` [<cite>Q27061829</cite>].
The name of the latter is somewhat misleading, as it contains
not just `IAtom`s but also `IBond`s. The primary use of the model is the
graph-based representation of molecules, where bonds are edges between
two atoms being the nodes [<cite>Q37988904</cite>].

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

<code>CreateAtom3</code>

An atom can also be constructed by passing in the symbol but this is marginally
less efficient:

<code>CreateAtom1</code>

Alternatively, we can also construct a new carbon atom, by passing a
carbon `IElement`, conveniently provided by the `Elements` class:

<code>CreateAtom2</code>

A CDK atom has many properties, many of them inherited from the `IElement`,
`IIsotope` and `IAtomType` interfaces. Figure 3.1 shows the interface
inheritance specified by the CDK data model.

These constructors will set the atomic number of the atom:

<out>CreateAtom2</out>

### IElement

The most common property of `IElement`s are their symbol and atomic
number. Because the `IAtom` extends the `IElement`, CDK atoms also have
these properties. Therefore, we can set these properties for atoms
manually too:

<code>ElementProperties</code>

Of course, we can use the matching get methods to recover the properties:

<code>ElementGetProperties</code>

which outputs:

<out>ElementGetProperties</out>

### IIsotope

The `IIsotope` information consists of the *mass number*, *exact mass* and
*natural abundance*:

<code>IsotopeProperties</code>

Here too, the complementary get methods are available:

<code>IsotopeGetProperties</code>

giving:

<out>IsotopeGetProperties</out>

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

<code>AtomTypeProperties</code>

### Coordinates

The `IAtom` class supports three types of coordinates: <topic>2D coordinates</topic>,
used for diagrams, <topic>3D coordinates</topic> for geometries, and crystal <topic>unit cell</topic>
or <topic>notional coordinates</topic>. These properties are set with the respective
methods:

<code>AtomCoordinates</code>

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

For example, to create <topic>ethanol</topic> we write:

<code>Ethanol</code>

The CDK has a few bond orders, which we can list with this groovy code:

<code>BondOrders</code>

which outputs:

<out>BondOrders</out>

As you might notice, there is no `AROMATIC` bond defined. This is
deliberate and the CDK allows to define single-double bond order patterns at
the same time as aromaticity information. For example, a kekule
structure of <topic>benzene</topic> with bonds marked as aromatic can be constructed with:

<code>AromaticBond</code>

### Electron counts

Bond orders, as we have seen earlier, are commonly used in the CDK to
indicate the electronic properties of a bond. At the same time, each bond
consists of a number of atoms. For example, in a single (sigma) bond, two
<topic>electrons</topic> are involved. In a double (pi) bond, four electrons are involved,
and in a triple bond, six electrons are involved. We can report on the
electron counts for the various orders with this code:

<code>ElectronCounts</code>

showing us the default implementation:

<out>ElectronCounts</out>
 
### Bond stereochemistry

The `IBond.setStereo()` method is discussed in Section 4.1.


## Molecules



## References

<references/>
