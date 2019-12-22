# InputMDLMolfiles.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.3')

import org.openscience.cdk.interfaces.*;
import org.openscience.cdk.interfaces.IBond.Order;
import org.openscience.cdk.io.*;
import org.openscience.cdk.exception.*;
import org.openscience.cdk.*;
import org.openscience.cdk.aromaticity.Kekulization;
import org.openscience.cdk.io.IChemObjectReader.Mode;
import org.openscience.cdk.smiles.DeduceBondSystemTool;
import org.openscience.cdk.tools.CDKHydrogenAdder;
import org.openscience.cdk.tools.manipulator.*;
import java.io.File;

reader = new MDLV2000Reader(
  new File("data/azulene4.mol").newReader(),
  Mode.RELAXED
);
azulene = reader.read(new AtomContainer());
// perceive atom types
AtomContainerManipulator
  .percieveAtomTypesAndConfigureAtoms(
  azulene
)
// add missing hydrogens
adder = CDKHydrogenAdder.getInstance(
  azulene.getBuilder()
);
adder.addImplicitHydrogens(azulene);
// if bond order 4 was present,
// deduce bond orders
Kekulization.kekulize(azulene);
println "Atom count: " + azulene.atomCount
doubleBondCount = 0
singleBondCount = 0
for (bond in azulene.bonds()) {
  if (bond.order == Order.DOUBLE)
    doubleBondCount++
  if (bond.order == Order.SINGLE) 
    singleBondCount++
}
println "Single bonds: " + singleBondCount
println "Double bonds: " + doubleBondCount
```
**Output:**
```plain
Atom count: 10
Single bonds: 6
Double bonds: 5
```
