# AtomTypePerceptionMolecule.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.11')

import org.openscience.cdk.interfaces.*;
import org.openscience.cdk.*;
import org.openscience.cdk.atomtype.*;
import org.openscience.cdk.config.*;
import org.openscience.cdk.tools.manipulator.*;
import javax.vecmath.Point3d;

molecule = new AtomContainer();
atom = new Atom(Elements.CARBON);
molecule.addAtom(atom);
matcher = CDKAtomTypeMatcher.getInstance(
  DefaultChemObjectBuilder.getInstance()
);
types = matcher.findMatchingAtomTypes(molecule);
```
**Output:**
```plain
```
