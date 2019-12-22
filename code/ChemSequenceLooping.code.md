# ChemSequenceLooping.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.3')

import org.openscience.cdk.*;
sequence = new ChemSequence()
for (model in sequence.chemModels()) {
  println "model's hash: " + model.hashCode()
}
```
**Output:**
```plain
```
