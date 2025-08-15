# AtomContainerAddAtomsAndBonds3.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.11')

import org.openscience.cdk.interfaces.*;
import org.openscience.cdk.*;

mol = new AtomContainer();
c  = mol.newAtom((int)IElement.C);
h1 = mol.newAtom((int)IElement.H);
h2 = mol.newAtom((int)IElement.H);
h3 = mol.newAtom((int)IElement.H);
h4 = mol.newAtom((int)IElement.H);
mol.newBond(c,h1,IBond.Order.SINGLE);
mol.newBond(c,h2,IBond.Order.SINGLE);
mol.newBond(c,h3,IBond.Order.SINGLE);
mol.newBond(c,h4,IBond.Order.SINGLE);
```
**Output:**
```plain
```
