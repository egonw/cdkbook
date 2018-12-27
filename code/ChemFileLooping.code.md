# ChemFileLooping.groovy
**Source code:**
```groovy
import org.openscience.cdk.*;
file = new ChemFile()
for (sequence in file.chemSequences()) {
  println "sequence's hash: " + sequence.hashCode()
}
```
**Output:**
```plain
```
