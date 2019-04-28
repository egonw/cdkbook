# Migration

Going from one CDK release to another brings in API changes. While the project
tries to keep the number of changes minimal, these are inevitible. This chapter
discusses some API changes, and shows code examples on how to change your
code. The following sections discuss the migration between various versions.

The set of changes include changed class names. For example, the CDK 1.2
class `MDLWriter` is now called [`MDLV2000Writer`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/io/MDLV2000Writer.html) to reflect the
V2000 version of the MDL formats.

## CDK 1.4 to 2.0

This section highlights the important API changes between the CDK 1.4 and
2.0 series. Innovations of CDK 2.0 are described in [<a href="#citeref1">1</a>].

### Removed classes

Several classes have been removed in this version, for example, because they
are superceeded by other code or were considered redundant.

#### Removal of the NoNotify interface implementation

The `NoNotificationChemObjectBuilder` and the matching implementation
classes are removed. Please use the [`SilentChemObjectBuilder`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/silent/SilentChemObjectBuilder.html) instead.
The same, of course, applies to all implementation classes. For example,
`NNMolecule` is removed.

#### Removal of IMolecule

The `IMolecule` interface and all implementing classes have been
removed. They were practically identical in functionality to the
[`IAtomContainer`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/interfaces/IAtomContainer.html) interface, except the implication that the
`IMolecule` was for fully connected structures only. This separation
was found to be complicated, and was therefore removed. Please use the
[`IAtomContainer`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/interfaces/IAtomContainer.html) interface instead.

### Renamed classes and methods

#### Rename of IteratingMDLReader to IteratingSDFReader

Strictly speaking the MDL files span a set of files and a SD file is different
from a molfile. This is reflected in the reader name change:
`IteratingMDLReader` is now called [`IteratingSDFReader`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/io/iterator/IteratingSDFReader.html).

#### CDKAtomTypeMatcher.findMatchingAtomTypes()

The method `findMatchingAtomTypes` of the [`CDKAtomTypeMatcher`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/atomtype/CDKAtomTypeMatcher.html)
gained a 's' and was previously called `findMatchingAtomType`. The new
name is more consistent, reflecting the fact that it perceives atom types
for all atoms.

### Changed behavior

Some classes and methods have the same API, but have slightly different
behavior as before. For example, the [`SmilesGenerator`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/smiles/SmilesGenerator.html) now requires
that all atoms have implicit hydrogen counts set. This can be done with
the [`CDKHydrogenAdder`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/tools/CDKHydrogenAdder.html) as explained in Section [14.4](missing.md#sec:missinghydrogens).

### Constructors that now require a builder

The advantage of the builders in the CDK is that code can be independent of
data class implementations (and we have three of them in CDK 1.6, at this
moment). Over the past years more and more code started using the approach,
but that does involve that more and more class constructors take a
[`IChemObjectBuilder`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/interfaces/IChemObjectBuilder.html). CDK 1.6 has two more constructors that now take
a builder.

#### DescriptorEngine
The [`DescriptorEngine`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/qsar/DescriptorEngine.html) constructor is changed to now take a
[`IChemObjectBuilder`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/interfaces/IChemObjectBuilder.html) which is needed to initialize descriptor instances.

#### SMARTSQueryTool

The second constructor that now needs a [`IChemObjectBuilder`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/interfaces/IChemObjectBuilder.html) is that of the
`SMARTSQueryTool`. Here it is passed on to the `SMARTSParser` which
needs it for its data structure for the matching.

#### ModelBuilder3D

The `getInstance()` method of the [`ModelBuilder3D`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/modeling/builder3d/ModelBuilder3D.html) class now also
requires a [`IChemObjectBuilder`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/interfaces/IChemObjectBuilder.html).

#### CDKAtomTypeMatcher

A significant change in the [`CDKAtomTypeMatcher`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/atomtype/CDKAtomTypeMatcher.html) behavior is that it now
returns a special 'X' atom type when no atom type could be perceived.
See Section [12.2](atomtype.md#sec:atomtypePerception).

### Static methods that are no longer

Some previously static methods are no longer, and now require the instantiation
of the class.

#### UniversalIsomorphismTester

The [`UniversalIsomorphismTester`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/isomorphism/UniversalIsomorphismTester.html) is an example class that now needs to be
instantiated. However, the class is easy to instantiate. For example:

**Script** [code/Isomorphism.groovy](code/Isomorphism.code.md)
```groovy
butane = MoleculeFactory.makeAlkane(4);
isomorphismTester = new UniversalIsomorphismTester()
println "Is isomorphic: " +
  isomorphismTester.isIsomorph(
    butane, butane
  )
```

### IsotopeFactory

A major API change happened around the [`IsotopeFactory`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/config/IsotopeFactory.html). Previously, this
class was used to get isotope information, which it gets from an configurable XML
file. This functionality is now available from the [`XMLIsotopeFactory`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/config/XMLIsotopeFactory.html) class.
However, to improve the speed of getting basic isotope information as well as to
reduce the size of the core modules, CDK 1.6 introduces a [`Isotopes`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/config/Isotopes.html) class,
which contains information extracted from the XML file, but is available as a pure
Java class. The APIs for getting isotope information is mostly the same, but the
instantiation is much simpler, and also no longer requires an [`IChemObjectBuilder`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/interfaces/IChemObjectBuilder.html):

**Script** [code/IsotopesDemo.groovy](code/IsotopesDemo.code.md)
```groovy
isofac = Isotopes.getInstance();
uranium = 92;
for (atomicNumber in 1..uranium) {
  element = isofac.getElement(atomicNumber)
}
```

### IFingerPrinter

The [`IFingerprinter`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/fingerprint/IFingerprinter.html) API was changed to accomodate for two types of fingerprints:
the bit fingerprint, outlined by the [`IBitFingerprint`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/fingerprint/IBitFingerprint.html) interfaces, and
the count fingerprint, defined in the [`ICountFingerprint`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/fingerprint/ICountFingerprint.html) interface. The
[`IFingerprinter`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/fingerprint/IFingerprinter.html) interface now defines `getRawFingerprint(IAtomContainer)`,
`getCountFingerprint(IAtomContainer)`, and `getBitFingerprint(IAtomContainer)`.
These methods returns various kind of fingerprints. For example,
`getRawFingerprint(IAtomContainer)` returns a `Map` with strings representing
the various parts of the fingerprint as well as the matching count, and it is this
map that is used as input to the `getCountFingerprint(IAtomContainer)` method,
which returns this information as a `ICountFingerprint` implementation. If the
count for each bit is not important, the `getBitFingerprint(IAtomContainer)` method
can be used, which returns a `IBitSetFingerprint` implementation.

Because the previous [`Fingerprinter`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/fingerprint/Fingerprinter.html) interface did not include the counting of
how often a bit was set, implementing the new `getRawFingerprint(IAtomContainer)` method
will likely take some effort, but the other two methods can in many cases just wrap
other methods in the class, as shown in this example code:

**Script** [code/FingerprinterMigration.java](code/FingerprinterMigration.code.md)
```java
  public ICountFingerprint getCountFingerprint(
    IAtomContainer molecule
  ) throws CDKException {
    return new IntArrayCountFingerprint(
      getRawFingerprint(molecule)
    );
  }
  public IBitFingerprint getBitFingerprint(
    IAtomContainer molecule
  ) throws CDKException {
    return new BitSetFingerprint(
      getFingerprint(molecule)
    );
  }
}
```

### SMILESGenerator

The <a name="tp1">SMILES</a> stack is replaced in this CDK version. This introduces a few API changes,
outlined here. The new code base is much faster and more functional that what the CDK
had before. Below are typical new [`SmilesGenerator`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/smiles/SmilesGenerator.html) API usage.

Generating unique SMILES is done slightly differently, but elegantly:

**Script** [code/UniqueSMILES.groovy](code/UniqueSMILES.code.md)
```groovy
generator = SmilesGenerator.unique()
smiles = generator.createSMILES(mol)
println "$smiles"
```

Because SMILES with lower case element symbols reflecting aromaticity has less
explicit information, it is not my suggestion to use. Still, I know that some of you
are keen on using it, for various sometimes logical reasons, so here goes. Previously,
you would use the `setUseAromaticityFlag(true)` method for this, but you can now
use instead:

**Script** [code/AromaticSMILES.groovy](code/AromaticSMILES.code.md)
```groovy
generator = SmilesGenerator.generic().aromatic()
smiles = generator.createSMILES(mol)
println "$smiles"
```

### Aromaticity calculations

Aromaticity is differently calculated now, see Section [16.5](properties.md#sec:aromaticity).

## References

1. <a name="citeref1"></a>Willighagen E, Mayfield JW, Alvarsson J, Berg A, Berg A, Carlsson L, et al. The Chemistry Development Kit (CDK) v2.0: atom typing, depiction, molecular formulas, and substructure searching. Journal of Cheminformatics. 2017 Jun 6;9(1).  doi:[10.1186/S13321-017-0220-4](https://doi.org/10.1186/S13321-017-0220-4) ([Scholia](https://tools.wmflabs.org/scholia/doi/10.1186/S13321-017-0220-4))


