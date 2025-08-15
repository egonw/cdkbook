# ChemFileLooping.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.11')

import org.openscience.cdk.*;
file = new ChemFile()
for (sequence in file.chemSequences()) {
  println "sequence's hash: " + sequence.hashCode()
}
```
**Output:**
```plain
```
