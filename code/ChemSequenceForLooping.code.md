# ChemSequenceForLooping.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.9')

import org.openscience.cdk.*;
sequence = new ChemSequence()
for (i = 0; i < sequence.chemModelCount; i++) {
  println "model $i has hash: " + model.getChemModel(i)
}
```
**Output:**
```plain
```
