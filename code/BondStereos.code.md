# BondStereos.groovy
**Source code:**
```groovy
import org.openscience.cdk.interfaces.*;

IBond.Stereo.each {
  println it
}
```
**Output:**
```plain
NONE
UP
UP_INVERTED
DOWN
DOWN_INVERTED
UP_OR_DOWN
UP_OR_DOWN_INVERTED
E_OR_Z
E
Z
E_Z_BY_COORDINATES
```