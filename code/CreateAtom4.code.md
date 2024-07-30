# CreateAtom4.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.9')

import org.openscience.cdk.Atom;
import org.openscience.cdk.interfaces.IElement;

atom = new Atom(IElement.C);
assert atom.atomicNumber == 6;
assert atom.symbol == "C";
```
**Output:**
```plain
```
