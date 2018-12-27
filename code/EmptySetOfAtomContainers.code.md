# EmptySetOfAtomContainers.groovy
**Source code:**
```groovy
import org.openscience.cdk.silent.*;
import org.openscience.cdk.*;
set = new AtomContainerSet()
anAtomContainer = new AtomContainer()
anotherAtomContainer = new AtomContainer()
set.addAtomContainer(anAtomContainer)
set.addAtomContainer(anotherAtomContainer)
set.removeAllAtomContainers()
```
**Output:**
```plain
```
