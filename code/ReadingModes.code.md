# ReadingModes.groovy
**Source code:**
```groovy
import org.openscience.cdk.io.*;

IChemObjectReader.Mode.each {
  println it
}
```
**Output:**
```plain
RELAXED
STRICT
```
