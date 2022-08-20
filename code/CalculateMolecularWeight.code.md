# CalculateMolecularWeight.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.7.1')

import org.openscience.cdk.interfaces.*;
import org.openscience.cdk.silent.SilentChemObjectBuilder;
import org.openscience.cdk.config.Isotopes;

IChemObjectBuilder builder = SilentChemObjectBuilder.getInstance();
IAtomContainer molecule = builder.newInstance(IAtomContainer.class);
molecule.addAtom(builder.newInstance(IAtom.class, "C"));
molecule.addAtom(builder.newInstance(IAtom.class, "H"));
molecule.addAtom(builder.newInstance(IAtom.class, "H"));
molecule.addAtom(builder.newInstance(IAtom.class, "H"));
molecule.addAtom(builder.newInstance(IAtom.class, "H"));
Isotopes isotopeInfo = Isotopes.getInstance();
molWeight = 0.0
for (atom in molecule.atoms()) {
  molWeight += isotopeInfo.getNaturalMass(atom)
}
println molWeight
assert(molWeight - 16 < 0.3)
```
**Output:**
```plain
16.04249891209116
```
