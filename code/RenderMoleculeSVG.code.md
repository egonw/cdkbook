# RenderMoleculeSVG.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.11')

import org.openscience.cdk.depict.*;
import org.openscience.cdk.interfaces.*;
import org.openscience.cdk.templates.*;
IAtomContainer triazole = MoleculeFactory.make123Triazole()
new DepictionGenerator()
  .withSize(600, 600)
  .withAtomColors()
  .depict(triazole)
  .writeTo("RenderMolecule.svg");
```
**Output:**
```plain
```
