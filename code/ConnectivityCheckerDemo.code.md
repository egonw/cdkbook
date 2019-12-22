# ConnectivityCheckerDemo.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.3')

import org.openscience.cdk.interfaces.*;
import org.openscience.cdk.*;
import org.openscience.cdk.graph.*;

atomCon = new AtomContainer();
atom1 = new Atom("C");
atom2 = new Atom("C");
atomCon.addAtom(atom1);
atomCon.addAtom(atom2);
moleculeSet = ConnectivityChecker.partitionIntoMolecules(
  atomCon
);
println "Number of isolated graphs: " +
  moleculeSet.atomContainerCount
```
**Output:**
```plain
Number of isolated graphs: 2
```
