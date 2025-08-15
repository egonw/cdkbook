# AtomContainersForLoopingInSet.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.11')

import org.openscience.cdk.silent.*;
import org.openscience.cdk.*;
set = new AtomContainerSet()
anAtomContainer = new AtomContainer()
anotherAtomContainer = new AtomContainer()
set.addAtomContainer(anAtomContainer)
set.addAtomContainer(anotherAtomContainer)
println "Number of containers: " +
  set.getAtomContainerCount()
for (i=0; i<set.getAtomContainerCount(); i++) {
  println "container $i has hashcode " +
    set.getAtomContainer(i).hashCode()
}
```
**Output:**
```plain
Number of containers: 2
container 0 has hashcode 1043170851
container 1 has hashcode 1684265526
```
