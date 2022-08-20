# CreateAtom3.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.7.1')

import org.openscience.cdk.*;

atom = new Atom(6);
assert atom.atomicNumber == 6;
assert atom.symbol == "C";
```
**Output:**
```plain
```
