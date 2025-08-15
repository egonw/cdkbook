# ReactionDirections.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.11')

import org.openscience.cdk.interfaces.*;

IReaction.Direction.each {
  println it
}
```
**Output:**
```plain
FORWARD
BACKWARD
BIDIRECTIONAL
NO_GO
RETRO_SYNTHETIC
RESONANCE
UNDIRECTED
```
