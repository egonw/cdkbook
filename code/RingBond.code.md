# RingBond.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.9')

import org.openscience.cdk.interfaces.*;
import org.openscience.cdk.templates.*;
import org.openscience.cdk.*;

benzene = MoleculeFactory.makeBenzene();
benzene.bonds().each { bond ->
  bond.setFlag(CDKConstants.ISINRING, true)
  println "Is ring bond: " +
    bond.getFlag(CDKConstants.ISINRING)
}
```
**Output:**
```plain
Is ring bond: true
Is ring bond: true
Is ring bond: true
Is ring bond: true
Is ring bond: true
Is ring bond: true
```
