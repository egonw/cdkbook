# MissingMFRestrictions.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.3')

import org.openscience.cdk.interfaces.*;
import org.openscience.cdk.*;
import org.openscience.cdk.formula.*;
import org.openscience.cdk.formula.rules.*;
import org.openscience.cdk.silent.*;
import org.openscience.cdk.tools.manipulator.*;
import org.openscience.cdk.config.Isotopes;

ifac = Isotopes.getInstance()
MolecularFormulaRange range =
  new MolecularFormulaRange();
range.addIsotope( ifac.getMajorIsotope("C"), 8, 20);
range.addIsotope( ifac.getMajorIsotope("H"), 0, 20);
range.addIsotope( ifac.getMajorIsotope("O"), 0, 1);
range.addIsotope( ifac.getMajorIsotope("N"), 0, 1);
MolecularFormulaGenerator tool =
  new MolecularFormulaGenerator(
    SilentChemObjectBuilder.getInstance(),
    133.0, 133.1, range
  );
IMolecularFormulaSet mfSet = tool.getAllFormulas();
for (mf in mfSet) {
  println MolecularFormulaManipulator.getString(mf) + " " +
    MolecularFormulaManipulator.getTotalExactMass(mf)
}
```
**Output:**
```plain
C11H 133.007825032
C9H11N 133.089149352
C9H9O 133.065339908
C8H7NO 133.052763844
```
