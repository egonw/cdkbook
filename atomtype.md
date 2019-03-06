<a name="sec:atomtype"></a>
# Atom types

Graph theory is nice, but we are, of course, interested in chemistry. While
graph theory has its limitations, we can do a lot of interesting things with
just the vertex-edge formalism. Particularly, if we combine it with the concept
of <a name="tp1">atom types</a>.

An atom type is a concept to describe certain properties of the atom. For
example, force fields use atom types to describe geometrical and interaction
properties of the atoms in a molecule. Within such formalism, a sp<sup>3</sup> carbon
is a carbon with four neighbors organized in a tetrahedral coordination,
as depicted in Figure [11.1](#fig:methane).

<a name="fig:methane"></a>
![](images/methane.png)
<br />**Figure 12.1**: 3D structure of methane, showing a sp³ carbon surrounded byfour hydrogens. Image from Wikipedia: [File:Methane-CRC-MW-dimensions-2D.png](http://en.wikipedia.org/wiki/File:Methane-CRC-MW-dimensions-2D.png) (public domain).

<a name="sec:cdkatomtype"></a>
## The CDK atom type model

A complete description for the atom types of the following atomic properties
is needed by the various algorithms in the CDK:

* element
* formal charge
* number of bonded neighbors
* hybridization (sp<sup>3</sup>, sp<sup>2</sup>, sp, etc)
* number of lone pairs
* number of π bonds

For example, the carbon in methane, we can list these properties with
this code:

**Script** [code/CDKAtomTypeProperties.groovy](code/CDKAtomTypeProperties.code.md)
```groovy
factory = AtomTypeFactory.getInstance(
  "org/openscience/cdk/dict/data/cdk-atom-types.owl",
  SilentChemObjectBuilder.getInstance()
);
IAtomType type = factory.getAtomType("C.sp3");
println "element       : $type.symbol"
println "formal change : $type.formalCharge"
println "hybridization : $type.hybridization"
println "neighbors     : $type.formalNeighbourCount"
println "lone pairs    : " +
  type.getProperty(CDKConstants.LONE_PAIR_COUNT)
println "pi bonds      : " +
  type.getProperty(CDKConstants.PI_BOND_COUNT)
```

We will see the carbon has these properties:

```plain
element       : C
formal change : 0
hybridization : SP3
neighbors     : 4
lone pairs    : 0
pi bonds      : 0
```

For a carbon in benzene (`C.sp2`), it would list:

```plain
element       : C
formal change : 0
hybridization : SP2
neighbors     : 3
lone pairs    : 0
pi bonds      : 1
```

And for the oxygen in hydroxide (`C.minus`), it would give:

```plain
element       : O
formal change : -1
hybridization : SP3
neighbors     : 1
lone pairs    : 3
pi bonds      : 0
```

A full list of CDK atom types is given in a table in Appendix ??.

### Hybridization Types

The CDK knows about various <a name="tp2">hybridization</a> types. Hybridizations
are linear combinations of atomic orbitals and typically used to
explain the orientation of atoms attached to the central atom.
For example, Figure [11.1](#fig:methane) showed one possible
hybridization, sp<sup>3</sup>.

The list of supported hybridization types can be listed with:

**Script** [code/HybridizationTypes.groovy](code/HybridizationTypes.code.md)
```groovy
IAtomType.Hybridization.each {
  println it
}
```

listing these types:

```plain
S
SP1
SP2
SP3
PLANAR3
SP3D1
SP3D2
SP3D3
SP3D4
SP3D5
```

<a name="sec:atomtypePerception"></a>
## Atom type perception

Because so many cheminformatics algorithms depend on atom type information,
determining the atom types of the atoms in a molecule is typically a
very first step, after a molecule has been created. When the CDK is not
able to recognize (*perceive*) the atom type, then this will most
certainly mean that the output of cheminformatics algorithms in undefined.
The following two sections will describe how atom types can be perceived.
It will also be shown what happens when the atom type cannot be
recognized.

### Single atoms

Instead of perceiving atom types for all atoms in the molecule, one may also
perceive the type of a single atom. The former is more efficient when types
need to be perceived for all atoms, but when the molecule only partly changed,
it can be worthwhile to only perceive atom types for only the affected atoms:

**Script** [code/AtomTypePerception.groovy](code/AtomTypePerception.code.md)
```groovy
molecule = new AtomContainer();
atom = new Atom(Elements.CARBON);
molecule.addAtom(atom);
matcher = CDKAtomTypeMatcher.getInstance(
  DefaultChemObjectBuilder.getInstance()
);
type = matcher.findMatchingAtomType(molecule, atom);
AtomTypeManipulator.configure(atom, type);
println "Atom type: $type.atomTypeName"
```

This reports the perceived atom type for the carbon:

```plain
Atom type: C.sp3
```

### Full molecules

Because atom type perception requires the notion of ring systems, with each
atom type being perceived individually, using the above approach
ring detection must be done each time the atom type is perceived for each
atom\footnote{Theoretically, this information can be cached, but there
currently is no suitable solution for this in the CDK.}. Therefore,
perceiving atom types for all atoms in a molecule can be done more
efficiently with the following code:

**Script** [code/AtomTypePerceptionMolecule.groovy](code/AtomTypePerceptionMolecule.code.md)
```groovy
matcher = CDKAtomTypeMatcher.getInstance(
  DefaultChemObjectBuilder.getInstance()
);
types = matcher.findMatchingAtomTypes(molecule);
```

### Configuring the Atom

We saw earlier how the [`AtomTypeManipulator`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/tools/manipulator/AtomTypeManipulator.html) class was used
to configure an atom with the `configure(IAtom, IAtomType)` method.
This class also has a convenience method to
perceive and configure all atoms in a molecule with one call:

<a name="sec:noAtomType"></a>
### No atom type perceived?!

What happens when the `findMatchingAtomType` method does not
find a suitable atom type, is that it returns a generic 'X' atom type:

**Script** [code/AtomTypeX.groovy](code/AtomTypeX.code.md)
```groovy
molecule = new AtomContainer();
atom = new PseudoAtom("G");
molecule.addAtom(atom);
type = matcher.findMatchingAtomType(molecule, atom);
println "Atom type: $type.atomTypeName"
```

This code example shows that it does not recognize an atom with the element
symbol "G":

```plain
Atom type: X
```

There are several reasons why atom types cannot be perceived, including:

* the input is wrong, and
* the CDK is wrong.

The CDK library had knowledge about a lot of atoms types (see Appendix ??),
but there are still gaps. It might be that the CDK simply does not know about an
atom type that is present in your input. This can particularly be expected when
using elements other than the typical 'organic chemistry' elements like
carbon, nitrogen, and oxygen. Sulfur and phosphorus are already tricky, and metals
the library only knows about a few of them.

However, another reason why the method can return X, is that the input
passed is incorrect. In fact, this is one primary application of the CDK
atom type perception: to identify errors in the input. An example erroneous
input is the below, uncharged NH$_4$. If it is attempted to perceive an
atom type for this nitrogen, then the `findMatchingAtomType` method
will in fact return \code{X}, as intended:

**Script** [code/UnchargedNitrogenPerception.groovy](code/UnchargedNitrogenPerception.code.md)
```groovy
molecule = new AtomContainer();
atom = new Atom(Elements.NITROGEN);
molecule.addAtom(atom);
hydrogen = new Atom(Elements.HYDROGEN);
molecule.addAtom(hydrogen);
molecule.addBond(0,1,Order.SINGLE);
hydrogen = new Atom(Elements.HYDROGEN);
molecule.addAtom(hydrogen);
molecule.addBond(0,2,Order.SINGLE);
hydrogen = new Atom(Elements.HYDROGEN);
molecule.addAtom(hydrogen);
molecule.addBond(0,3,Order.SINGLE);
hydrogen = new Atom(Elements.HYDROGEN);
molecule.addAtom(hydrogen);
molecule.addBond(0,4,Order.SINGLE);
type = matcher.findMatchingAtomType(molecule, atom);
println "Atom type: $type.atomTypeName"
```

This is visible from the output it gives:

```plain
Atom type: X
```

Now, if we know the input indeed has errors like this, we can correct for
them programmatically. It is important to realize that your algorithm to do
that may make mistakes too, and it is adviced to make the detection of the
known errors in the input as explicit and detailed as possible. That may
slow down your code a bit, but will greatly reduce the chance of introducing
error.

The following code is very general and may easily make mistakes. For each
atom for which no atom type was perceived, it increases the charge of the
atom and tries to perceive the atom type again. This will certainly address
the aforementioned nitrogen problem:

**Script** [code/CorrectedNitrogenPerception.groovy](code/CorrectedNitrogenPerception.code.md)
```groovy
type = matcher.findMatchingAtomType(molecule, atom);
if (type.atomTypeName == "X") {
  // try a positive charge
  charge = atom.getFormalCharge()
  if (charge == null | charge == 0) {
    atom.setFormalCharge(+1)
    type = matcher.findMatchingAtomType(molecule, atom);
  }
}
println "Atom type: $type.atomTypeName"
```

After this programmatic correction, we now find the proper atom type for
the nitrogen:

```plain
Atom type: N.plus
```

## Sybyl atom types

The <a name="tp3">Sybyl atom type</a> list is well-known for its application in then
mol2 file format (see the [`Mol2Format`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/io/formats/Mol2Format.html) class) and used in force
fields [<a href="#citeref1">1</a>]. Sybyl atom types can be
perceived with the [`SybylAtomTypeMatcher`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/atomtype/SybylAtomTypeMatcher.html) class, which perceives CDK
atom types and then translates this in to Sybyl atom types:

**Script** [code/SybylAtomTypePerception.groovy](code/SybylAtomTypePerception.code.md)
```groovy
molecule = new AtomContainer();
atom = new Atom(Elements.CARBON);
molecule.addAtom(atom);
matcher = SybylAtomTypeMatcher.getInstance(
  DefaultChemObjectBuilder.getInstance()
);
type = matcher.findMatchingAtomType(molecule, atom);
AtomTypeManipulator.configure(atom, type);
println "Atom type: $type.atomTypeName"
```

This will give you the Sybyl atom type for carbon in methane:

```plain
Atom type: C.3
```

A full list of Sybyl atom types is given in a table in Appendix ??.

## References

1. <a name="citeref1"></a>Clark M, Cramer RD, Van Opdenbosch N. Validation of the general purpose tripos 5.2 force field. Vol. 10, Journal of Computational Chemistry. 1989. p. 982–1012.  doi:[10.1002/JCC.540100804](https://doi.org/10.1002/JCC.540100804)

