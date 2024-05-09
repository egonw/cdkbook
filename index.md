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
  "license":"CC BY-SA 4.0",
  "url": "https://egonw.github.io/cdkbook/",
  "version":"2.9-1"
}
</script>


Edition 2.9-1

**Egon L. Willighagen** PhD<br />
Long time CDK developer

© E.L. Willighagen 2011-2024

License: CC-BY-SA 4.0 International

[![DOI](https://zenodo.org/badge/163004968.svg)](https://zenodo.org/badge/latestdoi/163004968)

## Warning

This book is being opensourced [<a href="#citeref1">1</a>]. This involves transforming the LaTeX source into Markdown,
and updating all scripts to ensure all the automation works well. I have made good
steps forward, but it will take some time for things to iron out. If you find issue,
please report them [here](https://github.com/egonw/cdkbook/issues). If you like this
book, please give the [GitHub repository](https://github.com/egonw/cdkbook/) a star.

Most code snippets
in this book are actually Groovy scripts, but [this repository](https://egonw.github.io/chempyformatics/)
has some Jupyter notebook examples. If you want to know how any of those examples translates
to Python, please [file a request here](https://github.com/egonw/chempyformatics/issues).

## Contents

1. [Introduction](introduction.md) <br />
2. [Writing CDK Applications](writingApps.md) <br />
2.1. [A (Very) Basic Java Application](writingApps.md#a-(very)-basic-java-application) <br />
2.2. [Groovy](writingApps.md#groovy) <br />
2.2.1. [Closures](writingApps.md#closures) <br />
2.2.2. [Grabbing dependencies](writingApps.md#grabbing-dependencies) <br />
2.3. [Python](writingApps.md#python) <br />
2.4. [Other environments](writingApps.md#other-environments) <br />
2.4.1. [Bioclipse](writingApps.md#bioclipse) <br />
2.4.2. [Cinfony](writingApps.md#cinfony) <br />
2.4.3. [R](writingApps.md#r) <br />
3. [Cheminformatics](cheminfo.md) <br />
3.1. [Molecular Representations](cheminfo.md#molecular-representations) <br />
3.2. [Chemical Graphs](cheminfo.md#chemical-graphs) <br />
3.3. [Quantum Chemistry](cheminfo.md#quantum-chemistry) <br />
3.4. [Numerical Representations](cheminfo.md#numerical-representations) <br />
3.5. [Chemometrics](cheminfo.md#chemometrics) <br />
4. [Atoms, Bonds and Molecules](atomsbonds.md) <br />
4.1. [Atoms](atomsbonds.md#atoms) <br />
4.1.1. [IElement](atomsbonds.md#ielement) <br />
4.1.2. [IIsotope](atomsbonds.md#iisotope) <br />
4.1.3. [IAtomType](atomsbonds.md#iatomtype) <br />
4.1.4. [Coordinates](atomsbonds.md#coordinates) <br />
4.2. [Bonds](atomsbonds.md#bonds) <br />
4.2.1. [Electron counts](atomsbonds.md#electron-counts) <br />
4.2.2. [Bond stereochemistry](atomsbonds.md#bond-stereochemistry) <br />
4.3. [Molecules](atomsbonds.md#molecules) <br />
4.3.1. [Iterating over atoms and bonds](atomsbonds.md#iterating-over-atoms-and-bonds) <br />
4.3.2. [Neighboring atoms and bonds](atomsbonds.md#neighboring-atoms-and-bonds) <br />
4.4. [Molecular Formula](atomsbonds.md#molecular-formula) <br />
4.5. [Implicit and Explicit Hydrogens](atomsbonds.md#implicit-and-explicit-hydrogens) <br />
4.6. [Chemical Objects](atomsbonds.md#chemical-objects) <br />
4.7. [Rings](atomsbonds.md#rings) <br />
5. [Stereochemistry](stereo.md) <br />
5.1. [Stereochemistry in a flat world](stereo.md#stereochemistry-in-a-flat-world) <br />
5.2. [Tetrahedral chirality](stereo.md#tetrahedral-chirality) <br />
6. [Salts and other disconnected structures](salts.md) <br />
6.1. [Salts](salts.md#salts) <br />
6.2. [Crystals](salts.md#crystals) <br />
7. [Paired and unpaired electrons](unpairedelectrons.md) <br />
7.1. [Lone Pairs](unpairedelectrons.md#lone-pairs) <br />
7.2. [Unpaired electrons](unpairedelectrons.md#unpaired-electrons) <br />
8. [Protein and DNA](protein.md) <br />
8.1. [Protein From File](protein.md#protein-from-file) <br />
8.2. [Protein From Sequence](protein.md#protein-from-sequence) <br />
8.3. [Strands and Monomers](protein.md#strands-and-monomers) <br />
9. [Reactions](reaction.md) <br />
9.1. [A single reaction](reaction.md#a-single-reaction) <br />
9.2. [Reaction from File](reaction.md#reaction-from-file) <br />
9.2.1. [MDL RXN files](reaction.md#mdl-rxn-files) <br />
9.3. [CMLReact files](reaction.md#cmlreact-files) <br />
10. [From IChemObject to IChemFile](chemobject.md) <br />
10.1. [IAtomContainerSet](chemobject.md#iatomcontainerset) <br />
10.2. [IReactionSet and IRingSet](chemobject.md#ireactionset-and-iringset) <br />
10.3. [IChemModel](chemobject.md#ichemmodel) <br />
10.4. [IChemSequence](chemobject.md#ichemsequence) <br />
10.5. [IChemFile](chemobject.md#ichemfile) <br />
11. [IChemObjectBuilders](builders.md) <br />
11.1. [Implementations](builders.md#implementations) <br />
11.1.1. [The Default Builder](builders.md#the-default-builder) <br />
11.1.2. [The Debug Builder](builders.md#the-debug-builder) <br />
11.1.3. [The Silent Builder](builders.md#the-silent-builder) <br />
12. [Input/Output](io.md) <br />
12.1. [File Format Detection](io.md#file-format-detection) <br />
12.1.1. [Custom format matchers](io.md#custom-format-matchers) <br />
12.2. [Reading from Readers and InputStreams](io.md#reading-from-readers-and-inputstreams) <br />
12.2.1. [Example: Downloading Domoic Acid from PubChem](io.md#example:-downloading-domoic-acid-from-pubchem) <br />
12.3. [Input Validation](io.md#input-validation) <br />
12.3.1. [Reading modes](io.md#reading-modes) <br />
12.3.2. [Validation](io.md#validation) <br />
12.4. [Gzipped files](io.md#gzipped-files) <br />
12.5. [Iterating Readers](io.md#iterating-readers) <br />
12.5.1. [MDL SD files](io.md#mdl-sd-files) <br />
12.5.2. [PubChem Compounds XML files](io.md#pubchem-compounds-xml-files) <br />
12.6. [Customizing the Output](io.md#customizing-the-output) <br />
12.6.1. [Setting Properties](io.md#setting-properties) <br />
12.7. [Example: creating unit tests for atom type perception](io.md#example:-creating-unit-tests-for-atom-type-perception) <br />
12.8. [Line Notations](io.md#line-notations) <br />
12.8.1. [SMILES](io.md#smiles) <br />
12.9. [Recipes](io.md#recipes) <br />
12.9.1. [MDL molfile (V2000)](io.md#mdl-molfile-(v2000)) <br />
12.9.2. [SDF files with properties](io.md#sdf-files-with-properties) <br />
13. [Atom types](atomtype.md) <br />
13.1. [The CDK atom type model](atomtype.md#the-cdk-atom-type-model) <br />
13.1.1. [Hybridization Types](atomtype.md#hybridization-types) <br />
13.2. [Atom type perception](atomtype.md#atom-type-perception) <br />
13.2.1. [Single atoms](atomtype.md#single-atoms) <br />
13.2.2. [Full molecules](atomtype.md#full-molecules) <br />
13.2.3. [Configuring the Atom](atomtype.md#configuring-the-atom) <br />
13.2.4. [No atom type perceived?!](atomtype.md#no-atom-type-perceived?!) <br />
13.3. [Sybyl atom types](atomtype.md#sybyl-atom-types) <br />
14. [Graph Properties](graph.md) <br />
14.1. [Partitioning](graph.md#partitioning) <br />
14.2. [Spanning Tree](graph.md#spanning-tree) <br />
14.3. [Ring counts](graph.md#ring-counts) <br />
14.3.1. [Smallest Rings](graph.md#smallest-rings) <br />
14.3.2. [All Rings](graph.md#all-rings) <br />
14.4. [Graph matrices](graph.md#graph-matrices) <br />
14.4.1. [Adjacency matrix](graph.md#adjacency-matrix) <br />
14.4.2. [Distance matrix](graph.md#distance-matrix) <br />
14.5. [Atom Numbers](graph.md#atom-numbers) <br />
14.5.1. [Morgan Atom Numbers](graph.md#morgan-atom-numbers) <br />
14.5.2. [InChI Atom Numbers](graph.md#inchi-atom-numbers) <br />
15. [Missing Information](missing.md) <br />
15.1. [Element and Isotope information](missing.md#element-and-isotope-information) <br />
15.1.1. [Elements](missing.md#elements) <br />
15.1.2. [Isotopes](missing.md#isotopes) <br />
15.2. [Reconnecting Atoms](missing.md#reconnecting-atoms) <br />
15.3. [Missing Bond Orders](missing.md#missing-bond-orders) <br />
15.4. [Missing Hydrogens](missing.md#missing-hydrogens) <br />
15.4.1. [Implicit Hydrogens](missing.md#implicit-hydrogens) <br />
15.4.2. [Explicit Hydrogens](missing.md#explicit-hydrogens) <br />
15.5. [2D Coordinates](missing.md#2d-coordinates) <br />
15.6. [Unknown Molecular Formula](missing.md#unknown-molecular-formula) <br />
16. [Substructure Searching](substructure.md) <br />
16.1. [Fingerprints](substructure.md#fingerprints) <br />
16.1.1. [MACCS Fingerprints](substructure.md#maccs-fingerprints) <br />
16.1.2. [ECFP and FCFP Fingerprints](substructure.md#ecfp-and-fcfp-fingerprints) <br />
17. [Molecular Properties](properties.md) <br />
17.1. [Molecular Mass](properties.md#molecular-mass) <br />
17.1.1. [Implicit Hydrogens](properties.md#implicit-hydrogens) <br />
17.2. [LogP](properties.md#logp) <br />
17.3. [Total Polar Surface Area](properties.md#total-polar-surface-area) <br />
17.4. [Van der Waals Volume](properties.md#van-der-waals-volume) <br />
17.5. [Aromaticity](properties.md#aromaticity) <br />
18. [Molecular Descriptors](descriptor.md) <br />
18.1. [Descriptors and Specifications](descriptor.md#descriptors-and-specifications) <br />
18.1.1. [IImplementationSpecification](descriptor.md#iimplementationspecification) <br />
18.2. [IDescriptor](descriptor.md#idescriptor) <br />
18.3. [IMolecularDescriptor](descriptor.md#imoleculardescriptor) <br />
18.4. [IDescriptorResult](descriptor.md#idescriptorresult) <br />
18.5. [Counting Nitrogens and Oxygens](descriptor.md#counting-nitrogens-and-oxygens) <br />
19. [InChI](inchi.md) <br />
19.1. [Layers](inchi.md#layers) <br />
19.1.1. [Fixed Hydrogens](inchi.md#fixed-hydrogens) <br />
19.1.2. [Stereoisomerism](inchi.md#stereoisomerism) <br />
20. [Chemistry Toolkit Rosetta](ctr.md) <br />
20.1. [Heavy atom counts from an SD file](ctr.md#heavy-atom-counts-from-an-sd-file) <br />
20.2. [Depict a compound as an image](ctr.md#depict-a-compound-as-an-image) <br />
20.3. [Working with SD tag data](ctr.md#working-with-sd-tag-data) <br />
21. [Migration](migration.md) <br />
21.1. [CDK 2.0 to 2.3](migration.md#cdk-20-to-23) <br />
21.2. [CDK 1.4 to 2.0](migration.md#cdk-14-to-20) <br />
21.2.1. [Removed classes](migration.md#removed-classes) <br />
21.2.2. [Renamed classes and methods](migration.md#renamed-classes-and-methods) <br />
21.2.3. [Changed behavior](migration.md#changed-behavior) <br />
21.2.4. [Constructors that now require a builder](migration.md#constructors-that-now-require-a-builder) <br />
21.2.5. [Static methods that are no longer](migration.md#static-methods-that-are-no-longer) <br />
21.2.6. [IsotopeFactory](migration.md#isotopefactory) <br />
21.2.7. [IFingerPrinter](migration.md#ifingerprinter) <br />
21.2.8. [SMILESGenerator](migration.md#smilesgenerator) <br />
21.2.9. [Aromaticity calculations](migration.md#aromaticity-calculations) <br />

[Index](indexList.md) <br />

[Appendix A](appatomtypes.md) <br />
A.1 [CDK Atom Types](appatomtypes.md#cdk-atom-types) <br />
A.2 [Sybyl Atom Types](appatomtypes.md#sybyl-atom-types) <br />
[Appendix B](appisotopes.md) <br />
B.1 [Isotope List](appisotopes.md) <br />
[Appendix C](appmoldescs.md) <br />
C.1 [Molecular Descriptors](appmoldescs.md#molecular-descriptors) <br />
C.2 [Atomic Descriptors](appmoldescs.md#atomic-descriptors) <br />
C.3 [Atom-Pair Descriptors](appmoldescs.md#atom-pair-descriptors) <br />
C.4 [Bond Descriptors](appmoldescs.md#bond-descriptors) <br />
C.5 [Protein Descriptors](appmoldescs.md#protein-descriptors) <br />
[Appendix D](appfileformats.md) <br />
D.1 [Readers and Writers](appfileformats.md#the-readers-and-writers) <br />

## References

1. <a name="citeref1"></a>Willighagen E. Edition 1.4.1-0 of Groovy Cheminformatics with the Chemistry Development Kit. 2015.  doi:[10.6084/M9.FIGSHARE.2057790.V1](https://doi.org/10.6084/M9.FIGSHARE.2057790.V1) ([Scholia](https://scholia.toolforge.org/doi/10.6084/M9.FIGSHARE.2057790.V1))

