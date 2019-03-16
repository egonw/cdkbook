# AtomContainersLoopingInSet.groovy
**Source code:**
```groovy
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
container's hashcode 1912962767
container's hashcode 452805835
```
