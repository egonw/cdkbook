# ReactionDirections.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.3')

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
```
