# ChemFileForLooping.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.8')

import org.openscience.cdk.*;
file = new ChemFile()
for (i = 0; i < file.chemSequenceCount; i++) {
  println "sequence $i has hash: " +
    model.getChemSequence(i)
}
```
**Output:**
```plain
```
