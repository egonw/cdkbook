# CompactAtomParam.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.9')

import org.openscience.cdk.depict.*;
import org.openscience.cdk.interfaces.*;
import org.openscience.cdk.templates.*;
import org.openscience.cdk.renderer.generators.BasicAtomGenerator;
IAtomContainer triazole = MoleculeFactory.make123Triazole()
new DepictionGenerator()
  .withSize(600, 600)
  .withMargin(0.1)
  .withZoom(3.0)
  .withAtomColors()
  .withParam(BasicAtomGenerator.CompactAtom, true)
  .withParam(BasicAtomGenerator.CompactShape, BasicAtomGenerator.Shape.OVAL)
  .depict(triazole)
  .writeTo("RenderCompact.png");
```
**Output:**
```plain
```
