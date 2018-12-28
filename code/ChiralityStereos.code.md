# ChiralityStereos.groovy
**Source code:**
```groovy
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
