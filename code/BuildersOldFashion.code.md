# BuildersOldFashion.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.3')

import org.openscience.cdk.interfaces.*;
import org.openscience.cdk.*;

IAtom atom1 = new Atom("C");
IAtom atom2 = new Atom("C");
molecule = new AtomContainer();
molecule.addAtom(atom1);
molecule.addAtom(atom2);
molecule.addBond(new Bond(
  atom1, atom2, IBond.Order.SINGLE
));
```
**Output:**
```plain
```
