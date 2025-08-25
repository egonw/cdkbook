# RenderReaction.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.11')

import org.openscience.cdk.silent.*;
import org.openscience.cdk.depict.*;
import org.openscience.cdk.interfaces.*;
import org.openscience.cdk.smiles.SmilesParser;
import org.openscience.cdk.templates.*;
sp = new SmilesParser(
  SilentChemObjectBuilder.getInstance()
)
reaction = sp.parseReactionSmiles("CC=C.O>[H+]>CCCO")
new DepictionGenerator()
  .withSize(1200, 600)
  .withFillToFit()
  .withAtomColors()
  .depict(reaction)
  .writeTo("RenderReaction.png");
```
**Output:**
```plain
```
