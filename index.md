# Groovy Cheminformatics with the Chemistry Development Kit

Edition 2.0-5

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
8. [Input/Output](io.md) <br />
8.1. [File Format Detection](io.md#file-format-detection) <br />
8.1.1. [Custom format matchers](io.md#custom-format-matchers) <br />
8.2. [Reading from Readers and InputStreams](io.md#reading-from-readers-and-inputstreams) <br />
8.3. [Customizing the Output](io.md#customizing-the-output) <br />
8.3.1. [Setting Properties](io.md#setting-properties) <br />
8.4. [Example: creating unit tests for atom type perception](io.md#example:-creating-unit-tests-for-atom-type-perception) <br />
9. [Chemistry Toolkit Rosetta](ctr.md) <br />
9.1. [Heavy atom counts from an SD file](ctr.md#heavy-atom-counts-from-an-sd-file) <br />
9.2. [Depict a compound as an image](ctr.md#depict-a-compound-as-an-image) <br />
10. [Migration](migration.md) <br />
10.1. [CDK 1.4 to 2.0](migration.md#cdk-14-to-20) <br />
10.1.1. [Removed classes](migration.md#removed-classes) <br />
10.1.2. [Renamed classes and methods](migration.md#renamed-classes-and-methods) <br />
10.1.3. [Changed behavior](migration.md#changed-behavior) <br />
10.1.4. [Constructors that now require a builder](migration.md#constructors-that-now-require-a-builder) <br />
10.1.5. [Static methods that are no longer](migration.md#static-methods-that-are-no-longer) <br />
10.1.6. [IsotopeFactory](migration.md#isotopefactory) <br />
10.1.7. [IFingerPrinter](migration.md#ifingerprinter) <br />
10.1.8. [SMILESGenerator](migration.md#smilesgenerator) <br />
[Index](indexList.md) <br />
[Appendix A](appatomtypes.md) <br />
A.1 [CDK Atom Types](appatomtypes.md#cdk-atom-types) <br />
A.2 [Sybyl Atom Types](appatomtypes.md#sybyl-atom-types) <br />
