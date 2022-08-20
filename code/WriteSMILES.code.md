# WriteSMILES.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.7.1')

import org.openscience.cdk.smiles.SmilesGenerator;
import org.openscience.cdk.interfaces.*;
import org.openscience.cdk.*;
import org.openscience.cdk.templates.*;
import org.openscience.cdk.tools.*;
import org.openscience.cdk.tools.manipulator.*;
import org.openscience.cdk.aromaticity.*;
mol = MoleculeFactory.makePhenylAmine()
AtomContainerManipulator.percieveAtomTypesAndConfigureAtoms(mol);
CDKHueckelAromaticityDetector.detectAromaticity(mol);
hAdder = CDKHydrogenAdder.getInstance(mol.getBuilder())
hAdder.addImplicitHydrogens(mol)
generator = SmilesGenerator.generic()
smiles = generator.createSMILES(mol)
println "Ph-NH2 -> $smiles"
generator = SmilesGenerator.generic().aromatic()
smiles = generator.createSMILES(mol)
println "Ph-NH2 -> $smiles"
```
**Output:**
```plain
Ph-NH2 -> C1(=CC=CC=C1)N
Ph-NH2 -> c1(ccccc1)N
```
