# AtomContainersLoopingInSet.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.7.1')

import org.openscience.cdk.silent.*;
import org.openscience.cdk.*;
set = new AtomContainerSet()
anAtomContainer = new AtomContainer()
anotherAtomContainer = new AtomContainer()
set.addAtomContainer(anAtomContainer)
set.addAtomContainer(anotherAtomContainer)
println "Number of containers: " + 
  set.getAtomContainerCount()
for (atomContainer in set.atomContainers()) {
  println "container's hashcode " +
    atomContainer.hashCode()
}
```
**Output:**
```plain
Number of containers: 2
container's hashcode 1482986993
container's hashcode 1205817409
```
