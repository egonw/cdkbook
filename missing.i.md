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
classes <class>Elements</class> and <class>Isotopes</class>.

### Elements

The <class type="topic">Elements</class> class provides information about the element's
<topic>atomic number</topic>, <topic>symbol</topic>, <topic>periodic table</topic> <topic>group</topic>
and <topic>period</topic>, <topic>covalent radius</topic>
and <topic>van der Waals radius</topic>
and Pauling <topic>electronegativity</topic>:

<code>ElementsDemo</code>

For example, for lithium this gives:

<out>ElementsDemo</out>

### Isotopes

Similarly, there is the <class type="topic">Isotopes</class> class to help you look up isotope
information. For example, you can get all isotopes for an element or just
the major isotope (a full list of isotopes is available from
Appendix B:

<code>HydrogenIsotopes</code>

For hydrogen this gives:

<out>HydrogenIsotopes</out>

This class is also used by the `getMajorIsotopeMass` method in the
<class type="topic">MolecularFormulaManipulator</class> class to calculate the
<topic>monoisotopic mass</topic> of a molecule:

<code>MonoisotopicMass</code>

The output for ethanol looks like:

<code>MonoisotopicMass</code>

<section level="##">Reconnecting Atoms</section>

XYZ files do not have bond information, and may look like:

<in type="verbatim">code/data/methane.xyz</in>

Fortunately, we can reasonably assume bonds to have a certain length, and
reasonably understand how many connections and atom can have at most. Then,
using the 3D coordinate information available from the XYZ file, an algorithm
can deduce how the atoms must be bonded. The <class type="topic">RebondTool</class> does exactly
that. And, it does it efficiently too, using a binary search tree, which allows
it to scale to protein-sized molecules.

Now, the algorithm does need to know what reasonable bond lengths are, and for
this we can use the Jmol list of <topic>covalent radii</topic>, and
we configure the atoms accordingly:

<code>CovalentRadii</code>

which configures and prints the atoms' radii:

<out>CovalentRadii</out>

Then the <class>RebondTool</class> can be used to rebind the atoms:

<code>RebondToolDemo</code>

The number of bonds it found are reported
in the last line:

<out>RebondToolDemo</out>

## Missing Bond Orders

There are several reasons why <topic>bond orders</topic> are missing from an input structure.
For example, you may be reading a XYZ file and just performed a rebonding as
outlined in the previous section. Or, you may be reading SMILES strings with
aromatic organic subset atoms, such as *c1ccccc1*. Or, you may be reading
a MDL molfile that uses the query bond order 4 to indicate an *aromatic*
bond.

The latter two situations are, in fact, very common in cheminformatics. Before
CDK 1.4.11 we had the <class>DeduceBondSystemTool</class> to find the location of double
bonds in such delocalized electron bond systems, but in that 1.4.11 release a
new tool was released, the <class>FixBondOrdersTool</class> class, that does a better job,
and faster too. Both classes only look for double bond positions in rings, but
that covers many common use cases.

The method requires atom types to be perceived already, which is already done
when reading SMILES, for example for pyrrole:

<code>FixPyrroleBondOrders</code>

This results in the image given in Figure <xref>pyrrole</xref>.

<figure label="pyrrole" caption="2D diagram of pyrrole.">
![](code/generated/FixPyrroleBondOrders.png)
</figure>

<section level="##" label="missinghydrogens">Missing Hydrogens</section>

The <class>CDKHydrogenAdder</class> class can be used to add
<topic>missing hydrogens</topic>. The algorithm itself adds implicit
hydrogens (see Section <xref>hydrogens</xref>), but we will see how these can be
converted into explicit hydrogens. 
The hydrogen adding algorithm expects, however, that CDK atom
types are already perceived (see Section <xref>atomtypePerception</xref>).

<section level="###" label="implicithydrogens">Implicit Hydrogens</section>

Hydrogens that are not vertices in the molecular graph are called
<topic>implicit hydrogens</topic>. They are merely a property of the atom to which
they are connected. If these values are not given, which is common in
for example SMILES, they can be (re)calculated with:

<code>MissingHydrogens</code>

which reports:

<out>MissingHydrogens</out>

<section level="###" label="explicithydrogens">Explicit Hydrogens</section>

These implicit hydrogens can be converted into <topic>explicit hydrogens</topic>
using the following code:

<code>ExplicitHydrogens</code>

which reports for the running methane example:

<out>ExplicitHydrogens</out>

<section level="##" label="layout">2D Coordinates</section>

Another bit of information missing from the input is often <topic>2D coordinates</topic>.
To generate 2D <topic>coordinates</topic>, the <class>StructureDiagramGenerator</class> can be
used:

<code>Layout</code>

which will generate the coordinate starting with an initial direction:

<out>Layout</out>

<section label="unknownmf" level="##">Unknown Molecular Formula</section>

Mass spectrometry (MS) is a technology where the experiment yields monoisotopic
masses for molecules. In order to analyze these further, it is common to convert
them to <topic>molecular formula</topic>. The <class>MassToFormulaTool</class> has functionality
to determine these missing formulae. Miguel Rojas-Chertó developed this code
for use in <topic>metabolomics</topic> [<cite>Q27134827</cite>]. Basic usage looks like:

<code>MissingMF</code>

This will create a long list of possible molecular formula. It is important to realize
that it looks only at what molecular formula are possible with respect to the
corresponding mass. This means that it will include chemically unlikely molecular
formulae:

<out>MissingMF</out>

This is overcome by setting restrictions. For example, we can put restrictions on the
number of elements we allow in the matched formulae:

<code>MissingMFRestrictions</code>

Now the list looks more chemical:

<out>MissingMFRestrictions</out>

Of course, this is a long way from actual chemical structures. An Open Source structure
generator has been a long standing holy grail, and the CDK-based MAYGEN addresses
this gap [<cite>Q109827109</cite>], though the also open source Surge is a good bit
faster [<cite>Q113585012</cite>].

## References

<references/>

