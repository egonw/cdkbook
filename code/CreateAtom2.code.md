# CreateAtom2.groovy
**Source code:**
```groovy
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
