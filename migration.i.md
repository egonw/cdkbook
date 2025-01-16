# Migration

Going from one CDK release to another brings in API changes. While the project
tries to keep the number of changes minimal, these are inevitible. This chapter
discusses some API changes, and shows code examples on how to change your
code. The following sections discuss the migration between various versions.

The set of changes include changed class names. For example, the CDK 1.2
class <class>MDLWriter</class> is now called <class>MDLV2000Writer</class> to reflect the
V2000 version of the MDL formats.

## CDK 2.6 to 2.7

### InChI functionality

CDK 2.7 includes a InChI library no longer using the Java Native Interace (JNI, see [<cite>Q21092920</cite>]) but the Java Native Access (JNA). With this, the Java
packages and classes changed. If you used the `net.sf.jniinchi` package before, you now need to use the `io.github.dan2097.jnainchi` package.
An example update of this code is found in [this Bacting patch](https://github.com/egonw/bacting/commit/664d6941a6ddce4a9d99d5a5cec2fb181ca8b9c4).

## CDK 2.0 to 2.3

#### Deprecated AllRingsFinder.setTimeout()

The time out in <class>AllRingsFinder</class> has been replaced by a treshold that reflects
the percentage of PubChem for which the algorithm finishes. Use the new
`AllRingsFinger(Treshold)` constructor, instead.

## CDK 1.4 to 2.0

This section highlights the important API changes between the CDK 1.4 and
2.0 series. Innovations of CDK 2.0 are described in [<cite>Q30149558</cite>].

### Removed classes

Several classes have been removed in this version, for example, because they
are superceeded by other code or were considered redundant.

#### Removal of the NoNotify interface implementation

The <class>NoNotificationChemObjectBuilder</class> and the matching implementation
classes are removed. Please use the <class>SilentChemObjectBuilder</class> instead.
The same, of course, applies to all implementation classes. For example,
<class>NNMolecule</class> is removed.

#### Removal of IMolecule and IMoleculeSet

The <class>IMolecule</class> interface and all implementing classes have been
removed. They were practically identical in functionality to the
<class>IAtomContainer</class> interface, except the implication that the
<class>IMolecule</class> was for fully connected structures only. This separation
was found to be complicated, and was therefore removed. Please use the
<class>IAtomContainer</class> interface instead.

Generally, <class>IMolecule</class>, <class>IMoleculeSet</class>, <class>Molecule</class>,
and <class>MoleculeSet</class> can be replaced with the 'atomcontainer' equivalents.
Additionally, for <class>IMoleculeSet</class> you may also have to replace
use of methods like `getMoleculeCount()` with their matching `getAtomContainerCount()`.

### Renamed classes and methods

#### Rename of IteratingMDLReader to IteratingSDFReader

Strictly speaking the MDL files span a set of files and a SD file is different
from a molfile. This is reflected in the reader name change:
<class>IteratingMDLReader</class> is now called <class>IteratingSDFReader</class>.

#### CDKAtomTypeMatcher.findMatchingAtomTypes()

The method `findMatchingAtomTypes` of the <class>CDKAtomTypeMatcher</class>
gained a 's' and was previously called `findMatchingAtomType`. The new
name is more consistent, reflecting the fact that it perceives atom types
for all atoms.

### Changed behavior

Some classes and methods have the same API, but have slightly different
behavior as before. For example, the <class>SmilesGenerator</class> now requires
that all atoms have implicit hydrogen counts set. This can be done with
the <class>CDKHydrogenAdder</class> as explained in Section <xref>missinghydrogens</xref>.

### Constructors that now require a builder

The advantage of the builders in the CDK is that code can be independent of
data class implementations (and we have three of them in CDK 1.6, at this
moment). Over the past years more and more code started using the approach,
but that does involve that more and more class constructors take a
<class>IChemObjectBuilder</class>. CDK 1.6 has two more constructors that now take
a builder.

#### DescriptorEngine
The <class>DescriptorEngine</class> constructor is changed to now take a
<class>IChemObjectBuilder</class> which is needed to initialize descriptor instances.

#### SMARTSQueryTool

The second constructor that now needs a <class>IChemObjectBuilder</class> is that of the
<class>SMARTSQueryTool</class>. Here it is passed on to the <class>SMARTSParser</class> which
needs it for its data structure for the matching.

#### ModelBuilder3D

The `getInstance()` method of the <class>ModelBuilder3D</class> class now also
requires a <class>IChemObjectBuilder</class>.

#### CDKAtomTypeMatcher

A significant change in the <class>CDKAtomTypeMatcher</class> behavior is that it now
returns a special 'X' atom type when no atom type could be perceived.
See Section <xref>atomtypePerception</xref>.

### Static methods that are no longer

Some previously static methods are no longer, and now require the instantiation
of the class.

#### UniversalIsomorphismTester

The <class>UniversalIsomorphismTester</class> is an example class that now needs to be
instantiated. However, the class is easy to instantiate. For example:

<code>Isomorphism</code>

### IsotopeFactory

A major API change happened around the <class>IsotopeFactory</class>. Previously, this
class was used to get isotope information, which it gets from an configurable XML
file. This functionality is now available from the <class>XMLIsotopeFactory</class> class.
However, to improve the speed of getting basic isotope information as well as to
reduce the size of the core modules, CDK 1.6 introduces a <class>Isotopes</class> class,
which contains information extracted from the XML file, but is available as a pure
Java class. The APIs for getting isotope information is mostly the same, but the
instantiation is much simpler, and also no longer requires an <class>IChemObjectBuilder</class>:

<code>IsotopesDemo</code>

### IFingerPrinter

The <class>IFingerprinter</class> API was changed to accomodate for two types of fingerprints:
the bit fingerprint, outlined by the <class>IBitFingerprint</class> interfaces, and
the count fingerprint, defined in the <class>ICountFingerprint</class> interface. The
<class>IFingerprinter</class> interface now defines `getRawFingerprint(IAtomContainer)`,
`getCountFingerprint(IAtomContainer)`, and `getBitFingerprint(IAtomContainer)`.
These methods returns various kind of fingerprints. For example,
`getRawFingerprint(IAtomContainer)` returns a `Map` with strings representing
the various parts of the fingerprint as well as the matching count, and it is this
map that is used as input to the `getCountFingerprint(IAtomContainer)` method,
which returns this information as a `ICountFingerprint` implementation. If the
count for each bit is not important, the `getBitFingerprint(IAtomContainer)` method
can be used, which returns a `IBitSetFingerprint` implementation.

Because the previous <class>Fingerprinter</class> interface did not include the counting of
how often a bit was set, implementing the new `getRawFingerprint(IAtomContainer)` method
will likely take some effort, but the other two methods can in many cases just wrap
other methods in the class, as shown in this example code:

<code>FingerprinterMigration</code>

### SMILESGenerator

The <topic>SMILES</topic> stack is replaced in this CDK version. This introduces a few API changes,
outlined here. The new code base is much faster and more functional that what the CDK
had before. Below are typical new <class>SmilesGenerator</class> API usage.

Generating unique SMILES is done slightly differently, but elegantly:

<code>UniqueSMILES</code>

Because SMILES with lower case element symbols reflecting aromaticity has less
explicit information, it is not my suggestion to use. Still, I know that some of you
are keen on using it, for various sometimes logical reasons, so here goes. Previously,
you would use the `setUseAromaticityFlag(true)` method for this, but you can now
use instead:

<code>AromaticSMILES</code>

### Aromaticity calculations

Aromaticity is differently calculated now, see Section <xref>aromaticity</xref>.

## References

<references/>

