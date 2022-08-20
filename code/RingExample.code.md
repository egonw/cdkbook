# RingExample.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.7.1')

import org.openscience.cdk.interfaces.IRing;
import org.openscience.cdk.*;

IRing ring = new Ring(5, "C")
println "Ring size: " + ring.getRingSize()
println "Ring atoms: " + ring.getAtomCount()
println "Ring bonds: " + ring.getBondCount()
```
**Output:**
```plain
Ring size: 5
Ring atoms: 5
Ring bonds: 5
```
