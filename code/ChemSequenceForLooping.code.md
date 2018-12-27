# ChemSequenceForLooping.groovy
**Source code:**
```groovy
import org.openscience.cdk.*;
sequence = new ChemSequence()
for (i = 0; i < sequence.chemModelCount; i++) {
  println "model $i has hash: " + model.getChemModel(i)
}
```
**Output:**
```plain
```
