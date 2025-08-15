# MissingMF.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.11')

import org.openscience.cdk.interfaces.*;
import org.openscience.cdk.*;
import org.openscience.cdk.formula.*;
import org.openscience.cdk.silent.*;
import org.openscience.cdk.tools.manipulator.*;

tool = new MassToFormulaTool(
  SilentChemObjectBuilder.getInstance()
)
mfSet = tool.generate(133.0968);
for (mf in mfSet) {
  println MolecularFormulaManipulator.getString(mf)
}
```
**Output:**
```plain
C3H11N5O
C5H13N2O2
C2H15NO5
CH9N8
H13N4O4
C10H13
C9H11N
CH15N3O4
C6H13O3
C2H11N7
C4H11N3O2
C4H13N4O
C2H9N6O
C6H15NO2
CH13N2O5
H7N9
C8H9N2
H15N5O3
C5H11NO3
C3H13N6
C3H9N4O2
C5H15N3O
C2H13O6
CH7N7O
H11N3O5
C9H9O
C7H7N3
C4H9N2O3
C4H15N5
C2H7N5O2
CH11NO6
H5N8O
C8H7NO
C6H5N4
C5H9O4
C3H7N3O3
CH5N6O2
```
