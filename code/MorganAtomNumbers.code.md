# MorganAtomNumbers.groovy
**Source code:**
```groovy
import org.openscience.cdk.*;
import org.openscience.cdk.templates.*;
import org.openscience.cdk.graph.invariant.*;
import org.openscience.cdk.tools.manipulator.*;
import org.openscience.cdk.qsar.descriptors.molecular.*;
import org.openscience.cdk.qsar.result.*;

oxazole = MoleculeFactory.makeOxazole();
long[] morganNumbers =
  MorganNumbersTools.getMorganNumbers(
    oxazole
  );
for (i in 0..(oxazole.atomCount-1)) {
  println oxazole.getAtom(i).symbol +
    " " + morganNumbers[i]
}
```
**Output:**
```plain
C 64
O 64
C 64
N 64
C 64
```
