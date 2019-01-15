# ReactionDirections.groovy
**Source code:**
```groovy
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
