<section level="#" label="atomtype">Atom types</section>

Graph theory is nice, but we are, of course, interested in chemistry. While
graph theory has its limitations, we can do a lot of interesting things with
just the vertex-edge formalism. Particularly, if we combine it with the concept
of <topic>atom types</topic>.

An atom type is a concept to describe certain properties of the atom. For
example, force fields use atom types to describe geometrical and interaction
properties of the atoms in a molecule. Within such formalism, a sp<sup>3</sup> carbon
is a carbon with four neighbors organized in a tetrahedral coordination,
as depicted in Figure <xref>methane</xref>.

<figure label="methane" caption="3D structure of methane, showing a sp³ carbon surrounded by
four hydrogens. Image from Wikipedia: [File:Methane-CRC-MW-dimensions-2D.png](http://en.wikipedia.org/wiki/File:Methane-CRC-MW-dimensions-2D.png) (public domain).">
![](images/methane.png)
</figure>

<section level="##" label="cdkatomtype">The CDK atom type model</section>

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

<code>CDKAtomTypeProperties</code>

We will see the carbon has these properties:

<out>CDKAtomTypeProperties</out>

For a carbon in benzene (`C.sp2`), it would list:

<out>Csp2CarbonProperties</out>

And for the oxygen in hydroxide (`C.minus`), it would give:

<out>HydroxideOxygenProperties</out>

A full list of CDK atom types is given in a table in Appendix <xref>atomtypes</xref>.

### Hybridization Types

The CDK knows about various <topic>hybridization</topic> types. Hybridizations
are linear combinations of atomic orbitals and typically used to
explain the orientation of atoms attached to the central atom.
For example, Figure <xref>methane</xref> showed one possible
hybridization, sp<sup>3</sup>.

The list of supported hybridization types can be listed with:

<code>HybridizationTypes</code>

listing these types:

<out>HybridizationTypes</out>

<section level="##" label="atomtypePerception">Atom type perception</section>

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

<code>AtomTypePerception</code>

This reports the perceived atom type for the carbon:

<out>AtomTypePerception</out>

### Full molecules

Because atom type perception requires the notion of ring systems, with each
atom type being perceived individually, using the above approach
ring detection must be done each time the atom type is perceived for each
atom\footnote{Theoretically, this information can be cached, but there
currently is no suitable solution for this in the CDK.}. Therefore,
perceiving atom types for all atoms in a molecule can be done more
efficiently with the following code:

<code>AtomTypePerceptionMolecule</code>

### Configuring the Atom

We saw earlier how the <class>AtomTypeManipulator</class> class was used
to configure an atom with the `configure(IAtom, IAtomType)` method.
This class also has a convenience method to
perceive and configure all atoms in a molecule with one call:

<section level="###" label="noAtomType">No atom type perceived?!</section>

What happens when the `findMatchingAtomType` method does not
find a suitable atom type, is that it returns a generic 'X' atom type:

<code>AtomTypeX</code>

This code example shows that it does not recognize an atom with the element
symbol "G":

<out>AtomTypeX</out>

There are several reasons why atom types cannot be perceived, including:

* the input is wrong, and
* the CDK is wrong.

The CDK library had knowledge about a lot of atoms types (see Appendix <xref>atomtypes</xref>),
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

<code>UnchargedNitrogenPerception</code>

This is visible from the output it gives:

<out>UnchargedNitrogenPerception</out>

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

<code>CorrectedNitrogenPerception</code>

After this programmatic correction, we now find the proper atom type for
the nitrogen:

<out>CorrectedNitrogenPerception</out>

## Sybyl atom types

The <topic>Sybyl atom type</topic> list is well-known for its application in then
mol2 file format (see the <class>Mol2Format</class> class) and used in force
fields [<cite>Q61463648</cite>]. Sybyl atom types can be
perceived with the <class>SybylAtomTypeMatcher</class> class, which perceives CDK
atom types and then translates this in to Sybyl atom types:

<code>SybylAtomTypePerception</code>

This will give you the Sybyl atom type for carbon in methane:

<out>SybylAtomTypePerception</out>

A full list of Sybyl atom types is given in a table in Appendix <xref>app:atomtypes</xref>.

## References

<references/>
