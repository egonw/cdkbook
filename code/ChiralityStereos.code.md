# ChiralityStereos.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.7.1')

import org.openscience.cdk.interfaces.*;

ITetrahedralChirality.Stereo.each {
  println it
}
```
**Output:**
```plain
CLOCKWISE
ANTI_CLOCKWISE
```
