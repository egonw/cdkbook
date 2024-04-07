# MissingHydrogens.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.9')

import org.openscience.cdk.interfaces.*;
import org.openscience.cdk.*;
import org.openscience.cdk.atomtype.*;
import org.openscience.cdk.config.*;
import org.openscience.cdk.tools.*;
import org.openscience.cdk.tools.manipulator.*;
import javax.vecmath.Point3d;

molecule = new AtomContainer();
newAtom = new Atom(Elements.CARBON);
molecule.addAtom(newAtom);
matcher = CDKAtomTypeMatcher.getInstance(
  DefaultChemObjectBuilder.getInstance()
);
type = matcher.findMatchingAtomType(molecule, newAtom);
AtomTypeManipulator.configure(newAtom, type);

adder = CDKHydrogenAdder.getInstance(
  DefaultChemObjectBuilder.getInstance()
);
adder.addImplicitHydrogens(molecule);
println "Atom count: $molecule.atomCount"
println "Implicit hydrogens: $newAtom.hydrogenCount"
```
**Output:**
```plain
Atom count: 1
Implicit hydrogens: 4
```
