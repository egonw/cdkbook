# SDFWithProperties.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.11')

import org.openscience.cdk.interfaces.*;
import org.openscience.cdk.io.*;
import org.openscience.cdk.io.iterator.*;
import org.openscience.cdk.*;
import org.openscience.cdk.silent.*;
import org.openscience.cdk.tools.manipulator.*;

iterator = new IteratingSDFReader(
  new File("data/CHEMBL3183843.sdf").newReader(),
  DefaultChemObjectBuilder.getInstance()
)
while (iterator.hasNext()) {
  mol = iterator.next()
  println mol.getProperty("chembl_id")
}
```
**Output:**
```plain
CHEMBL3183843
```
