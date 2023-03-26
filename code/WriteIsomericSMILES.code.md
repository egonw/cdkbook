# WriteIsomericSMILES.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.8')

import org.openscience.cdk.interfaces.*;
import org.openscience.cdk.*;
import org.openscience.cdk.silent.*;   
import org.openscience.cdk.smiles.*;
import org.openscience.cdk.templates.*;
import org.openscience.cdk.tools.*;
import org.openscience.cdk.tools.manipulator.*;
import org.openscience.cdk.aromaticity.*;
smiles = "F[C@@H](Cl)(Br)"
smilesParser = new SmilesParser(
  SilentChemObjectBuilder.getInstance()
)
mol = smilesParser.parseSmiles(smiles)
AtomContainerManipulator.percieveAtomTypesAndConfigureAtoms(mol);
CDKHueckelAromaticityDetector.detectAromaticity(mol);
hAdder = CDKHydrogenAdder.getInstance(mol.getBuilder())
hAdder.addImplicitHydrogens(mol)
generator = SmilesGenerator.generic()
smiles = generator.createSMILES(mol)
println "Generic SMILES: $smiles"
generator = SmilesGenerator.isomeric()
smiles = generator.createSMILES(mol)
println "Isomeric SMILES: $smiles"
```
**Output:**
```plain
Generic SMILES: FC(Cl)Br
Isomeric SMILES: F[C@@H](Cl)Br
```
