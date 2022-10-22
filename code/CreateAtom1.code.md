# CreateAtom1.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.8')

import org.openscience.cdk.interfaces.*;
import org.openscience.cdk.*;

IAtom atom = new Atom("C");
assert atom.getAtomicNumber() == 6;
```
**Output:**
```plain
```
