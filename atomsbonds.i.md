#  Atoms, Bonds and Molecules

The basic objects in the CDK are the <topic type="class">IAtom</topic>, <class>IBond</class> and
<class>IAtomContainer</class> [<cite>Q27061829</cite>].
The name of the latter is somewhat misleading, as it contains
not just <class>IAtom</class>s but also <class>IBond</class>s. The primary use of the model is the
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

The CDK interface <topic type="class">IAtom</topic> is the underlying data model of atoms. Creating
a new atom is fairly easy. For example, we can create an atom of element
type carbon, as defined by the element’s atomic number that we pass as parameter
in the constructor:

<code>CreateAtom3</code>

An atom can also be constructed by passing in the symbol but this is marginally
less efficient:

<code>CreateAtom1</code>

Alternatively, we can also construct a new carbon atom, by passing a
carbon <class>IElement</class>, conveniently provided by the <class>Elements</class> class:

<code>CreateAtom2</code>

A CDK atom has many properties, many of them inherited from the `IElement`,
`IIsotope` and `IAtomType` interfaces. Figure 3.1 shows the interface
inheritance specified by the CDK data model.

These constructors will set the atomic number of the atom:

<out>CreateAtom2</out>

### IElement

The most common property of <topic type="class">IElement</topic>s are their symbol and atomic
number. Because the `IAtom` extends the `IElement`, CDK atoms also have
these properties. Therefore, we can set these properties for atoms
manually too:

<code>ElementProperties</code>

Of course, we can use the matching get methods to recover the properties:

<code>ElementGetProperties</code>

which outputs:

<out>ElementGetProperties</out>

### IIsotope

The <topic type="class">IIsotope</topic> information consists of the *mass number*, *exact mass* and
*natural abundance*:

<code>IsotopeProperties</code>

Here too, the complementary get methods are available:

<code>IsotopeGetProperties</code>

giving:

<out>IsotopeGetProperties</out>

Appendix <xref>isotopes</xref> lists all isotopes defined in the CDK with a natural
abundance of more then 0.1.


### IAtomType

Atom types are an important concept in cheminformatics. They describe
some basic facts about that particular atom in some particular
configuration. These properties are used in many cheminformatics algorithms,
including adding hydrogens to hydrogen-depleted chemical graphs (see
Section <xref>implicithydrogens</xref>) and force fields. Chapter <xref>atomtype</xref> provides much more detail
on the atom type infrastructure in the CDK library, and, for example,
details how atom types can be perceived, and how atom type information
is set for atoms.

The <topic type="class">IAtomType</topic> interface contains fields that relate to atom types. These
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

The <topic type="class">IBond</topic> interface of the CDK is an interaction between two or more
`IAtom`s, extending the <topic type="class">IElectronContainer</topic> interface. While the most
common application in the CDK originates from graph theory [<cite>Q37988904</cite>], it is not
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

The `IBond.setStereo()` method is discussed in Section <xref>stereo:bond</xref>.

<section level="##" label="molecules">Molecules</section>

We already saw in the previous pieces of code how the CDK can be used to create
molecules, and while the above is, strictly speaking, enough to find all atoms in the
<topic>molecule</topic> starting with only one of the atoms in the molecule, it often is more
convenient to store all atoms and bonds in a container.

The CDK has one container: the <class>IAtomContainer</class>.
It is a general container to holds atoms an bonds, and can contain both
unconnected as well asfully connected structures. The latter
has the added implication that it holds a single molecule, of which all
atoms are connected to each other via one or more covalent bonds.

Adding atoms and bonds is done by the methods `addAtom(IAtom)` and
`addBond(IBond)`:

<code>AtomContainerAddAtomsAndBonds</code>

The `addBond()` method has an alternative which takes three parameters:
the first atom, the second atom, and the bond order. Note that atom indices
follows programmers habits and starts at `0`, as you can observe in the
previous example too. This shortens the previous version a bit:

<code>AtomContainerAddAtomsAndBonds2</code>

### Iterating over atoms and bonds

The <class>IAtomContainer</class> comes with convenience methods to iterate over atoms
and bonds. Both methods use the <class>Iterable</class> interfaces, and for atoms we
do:

<code>CountHydrogens</code>

which returns

<out>CountHydrogens</out>

And for bonds the equivalent:

<code>CountDoubleBonds</code>

giving

<out>CountDoubleBonds</out>

### Neighboring atoms and bonds

It is quite common that you like to see what atoms are connected
to one particular atom. For example, you may wish to count how many
bonds surround a particular atom. Or, you may want to list all atoms
that are bound to this atom. The <class>IAtomContainer</class> class
provides methods for these use cases. But it should be stressed that
these methods do only take into account explicit hydrogens (see the
next section).

Let's consider ethanol again, given in Script XX,
and count the number of neighbors for each atom:

<code>NeighborCount</code>

which lists for the three heavy atoms:

<out>NeighborCount</out>

Similarly, we can also list all <topic>connected atoms</topic>:

<code>ConnectedAtoms</code>

which outputs:

<out>ConnectedAtoms</out>

We can do the same thing for <topic>connected bonds</topic>:

<code>ConnectedBonds</code>

which outputs:

<out>ConnectedBonds</out>

<section lavel="##" label="molecularFormula">Molecular Formula</section>

Getting the <topic>molecular formula</topic> of a molecule and returning that as a String
is both done with the <class>MolecularFormulaManipulator</class> class:

<code>MFGeneration</code>

giving:

<out>MFGeneration</out>

## References

<references/>
