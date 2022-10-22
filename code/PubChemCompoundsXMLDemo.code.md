# PubChemCompoundsXMLDemo.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.8')

import org.openscience.cdk.interfaces.*;
import org.openscience.cdk.io.*;
import org.openscience.cdk.io.iterator.*;
import org.openscience.cdk.*;
import org.openscience.cdk.tools.manipulator.*;

iterator = new IteratingPCCompoundXMLReader(
  new File("data/aceticAcids38.xml").newReader(),
  DefaultChemObjectBuilder.getInstance()
)
while (iterator.hasNext()) {
  IAtomContainer mol = iterator.next()
  formula = MolecularFormulaManipulator
    .getMolecularFormula(mol)
  println MolecularFormulaManipulator.getString(formula)
}
```
**Output:**
```plain
C2H4O2
[C2H3O2]-
[C2H3HgO2]+
```
