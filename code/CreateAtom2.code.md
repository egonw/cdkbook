# CreateAtom2.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.8')

import org.openscience.cdk.interfaces.*;
import org.openscience.cdk.*;
import org.openscience.cdk.config.Elements;

IAtom atom = new Atom(Elements.CARBON);
assert atom.atomicNumber == 6;
println "atomic number: " +
  atom.atomicNumber
```
**Output:**
```plain
atomic number: 6
```
