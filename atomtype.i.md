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

<figure label="methane" caption="3D structure of methane, showing a sp$^3$ carbon surrounded by
four hydrogens. Image from Wikipedia: \url{http://en.wikipedia.org/wiki/File:Methane-CRC-MW-dimensions-2D.png} (public domain).">
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

