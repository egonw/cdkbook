# Groovy Cheminformatics with the Chemistry Development Kit

<script type="application/ld+json">
{
  "@context":"http://schema.org/",
  "@type":"CreativeWork",
  "about":"This text book describes how to write cheminformatics software with Groovy and the Chemistry Development Kit.",
  "audience":[{
    "@type":"Audience","name":"post-docs"
  }],
  "genre":[{
    "@type":"URL","url":"http://edamontology.org/topic_2258"
  }],
  "name":"Groovy Cheminformatics with the Chemistry Development Kit",
  "author":[{
    "@type":"Person",
    "name":"Egon Willighagen",
    "identifier":"0000-0001-7542-0286"
  }],
  "keywords":"cheminformatics, chemoinformatics, java, Groovy, Chemistry Development Kit, CDK",
  "license":"CC BY-SA 4.0","url":[{"@type":"URL",
  "url":"https://egonw.github.io/cdkbook/"}],
  "version":"1.0.2"
}
</script>

Edition 2.0-6

**Egon L. Willighagen** PhD<br />
Long time CDK developer

© E.L. Willighagen 2011-2019

License: CC-BY-SA 4.0 International

## Warning

This book is being opensourced. This involves transforming the LaTeX source into Markdown,
and updating all scripts to ensure all the automation works well. I have made good
steps forward, but it will take some time for things to iron out.

## Contents

1. [Introduction](introduction.md) <br />
2. [Cheminformatics](cheminfo.md) <br />
2.1. [Molecular Representations](cheminfo.md#molecular-representations) <br />
3. [Atoms, Bonds and Molecules](atomsbonds.md) <br />
3.1. [Atoms](atomsbonds.md#atoms) <br />
3.1.1. [IElement](atomsbonds.md#ielement) <br />
3.1.2. [IIsotope](atomsbonds.md#iisotope) <br />
3.1.3. [IAtomType](atomsbonds.md#iatomtype) <br />
3.1.4. [Coordinates](atomsbonds.md#coordinates) <br />
3.2. [Bonds](atomsbonds.md#bonds) <br />
3.2.1. [Electron counts](atomsbonds.md#electron-counts) <br />
3.2.2. [Bond stereochemistry](atomsbonds.md#bond-stereochemistry) <br />
3.3. [Molecules](atomsbonds.md#molecules) <br />
3.3.1. [Iterating over atoms and bonds](atomsbonds.md#iterating-over-atoms-and-bonds) <br />
3.3.2. [Neighboring atoms and bonds](atomsbonds.md#neighboring-atoms-and-bonds) <br />
4. [Stereochemistry](stereo.md) <br />
4.1. [Stereochemistry in a flat world](stereo.md#stereochemistry-in-a-flat-world) <br />
4.2. [Tetrahedral chirality](stereo.md#tetrahedral-chirality) <br />
5. [Salts and other disconnected structures](salts.md) <br />
5.1. [Salts](salts.md#salts) <br />
5.2. [Crystals](salts.md#crystals) <br />
6. [Paired and unpaired electrons](unpairedelectrons.md) <br />
6.1. [Lone Pairs](unpairedelectrons.md#lone-pairs) <br />
6.2. [Unpaired electrons](unpairedelectrons.md#unpaired-electrons) <br />
7. [From IChemObject to IChemFile](chemobject.md) <br />
7.1. [IAtomContainerSet](chemobject.md#iatomcontainerset) <br />
7.2. [IReactionSet and IRingSet](chemobject.md#ireactionset-and-iringset) <br />
7.3. [IChemModel](chemobject.md#ichemmodel) <br />
7.4. [IChemSequence](chemobject.md#ichemsequence) <br />
7.5. [IChemFile](chemobject.md#ichemfile) <br />
8. [IChemObjectBuilders](builders.md) <br />
8.1. [Implementations](builders.md#implementations) <br />
8.1.1. [The Default Builder](builders.md#the-default-builder) <br />
8.1.2. [The Debug Builder](builders.md#the-debug-builder) <br />
8.1.3. [The Silent Builder](builders.md#the-silent-builder) <br />
9. [Input/Output](io.md) <br />
9.1. [File Format Detection](io.md#file-format-detection) <br />
9.1.1. [Custom format matchers](io.md#custom-format-matchers) <br />
9.2. [Reading from Readers and InputStreams](io.md#reading-from-readers-and-inputstreams) <br />
9.3. [Customizing the Output](io.md#customizing-the-output) <br />
9.3.1. [Setting Properties](io.md#setting-properties) <br />
9.4. [Example: creating unit tests for atom type perception](io.md#example:-creating-unit-tests-for-atom-type-perception) <br />
10. [Atom types](atomtype.md) <br />
10.1. [The CDK atom type model](atomtype.md#the-cdk-atom-type-model) <br />
10.1.1. [Hybridization Types](atomtype.md#hybridization-types) <br />
10.2. [Atom type perception](atomtype.md#atom-type-perception) <br />
10.2.1. [Single atoms](atomtype.md#single-atoms) <br />
10.2.2. [Full molecules](atomtype.md#full-molecules) <br />
10.2.3. [Configuring the Atom](atomtype.md#configuring-the-atom) <br />
10.2.3. [No atom type perceived?!](atomtype.md#no-atom-type-perceived?!) <br />
10.3. [Sybyl atom types](atomtype.md#sybyl-atom-types) <br />
11. [Missing Information](missing.md) <br />
11.1. [Element and Isotope information](missing.md#element-and-isotope-information) <br />
11.1.1. [Elements](missing.md#elements) <br />
11.1.2. [Isotopes](missing.md#isotopes) <br />
11.2. [Reconnecting Atoms](missing.md#reconnecting-atoms) <br />
11.3. [Missing Bond Orders](missing.md#missing-bond-orders) <br />
11.4. [Missing Hydrogens](missing.md#missing-hydrogens) <br />
11.4.0. [Implicit Hydrogens](missing.md#implicit-hydrogens) <br />
11.4.0. [Explicit Hydrogens](missing.md#explicit-hydrogens) <br />
11.5. [2D Coordinates](missing.md#2d-coordinates) <br />
11.6. [Unknown Molecular Formula](missing.md#unknown-molecular-formula) <br />
12. [Substructure Searching](substructure.md) <br />
12.1. [Fingerprints](substructure.md#fingerprints) <br />
12.1.1. [MACCS Fingerprints](substructure.md#maccs-fingerprints) <br />
12.1.2. [ECFP and FCFP Fingerprints](substructure.md#ecfp-and-fcfp-fingerprints) <br />
13. [InChI](inchi.md) <br />
13.1. [Layers](inchi.md#layers) <br />
14. [Chemistry Toolkit Rosetta](ctr.md) <br />
14.1. [Heavy atom counts from an SD file](ctr.md#heavy-atom-counts-from-an-sd-file) <br />
14.2. [Depict a compound as an image](ctr.md#depict-a-compound-as-an-image) <br />
15. [Migration](migration.md) <br />
15.1. [CDK 1.4 to 2.0](migration.md#cdk-14-to-20) <br />
15.1.1. [Removed classes](migration.md#removed-classes) <br />
15.1.2. [Renamed classes and methods](migration.md#renamed-classes-and-methods) <br />
15.1.3. [Changed behavior](migration.md#changed-behavior) <br />
15.1.4. [Constructors that now require a builder](migration.md#constructors-that-now-require-a-builder) <br />
15.1.5. [Static methods that are no longer](migration.md#static-methods-that-are-no-longer) <br />
15.1.6. [IsotopeFactory](migration.md#isotopefactory) <br />
15.1.7. [IFingerPrinter](migration.md#ifingerprinter) <br />
15.1.8. [SMILESGenerator](migration.md#smilesgenerator) <br />
[Index](indexList.md) <br />
[Appendix A](appatomtypes.md) <br />
A.1 [CDK Atom Types](appatomtypes.md#cdk-atom-types) <br />
A.2 [Sybyl Atom Types](appatomtypes.md#sybyl-atom-types) <br />
