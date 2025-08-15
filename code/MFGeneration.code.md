# MFGeneration.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.11')

import org.openscience.cdk.*;
import org.openscience.cdk.interfaces.*;
import org.openscience.cdk.graph.*;
import org.openscience.cdk.io.*;
import org.openscience.cdk.io.IChemObjectReader.Mode;
import org.openscience.cdk.tools.*;
import org.openscience.cdk.tools.manipulator.*;
import java.io.File;

reader = new MDLV2000Reader(
  new File("data/azulene.mol").newReader(),
  Mode.STRICT
);
azulene = reader.read(new AtomContainer())
AtomContainerManipulator.percieveAtomTypesAndConfigureAtoms(azulene);
adder = CDKHydrogenAdder.getInstance(
  DefaultChemObjectBuilder.getInstance()
);
adder.addImplicitHydrogens(azulene);
AtomContainerManipulator.convertImplicitToExplicitHydrogens(azulene);
molForm = MolecularFormulaManipulator.getMolecularFormula(
  azulene
)
mfString = MolecularFormulaManipulator.getString(molForm)
println "Azulene: $mfString"
```
**Output:**
```plain
Azulene: C10H8
```
