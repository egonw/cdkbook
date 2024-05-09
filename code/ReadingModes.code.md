# ReadingModes.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.9')

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