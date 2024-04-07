# AromaticityDemo.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.9')

import org.openscience.cdk.interfaces.*;
import org.openscience.cdk.smiles.*;
import org.openscience.cdk.templates.*;
import org.openscience.cdk.aromaticity.*;
import org.openscience.cdk.graph.*;
import org.openscience.cdk.silent.*;

sp = new SmilesParser(
  SilentChemObjectBuilder.getInstance()
)
mol = sp.parseSmiles("c1ccccc1")
model       = ElectronDonation.daylight();
cycles      = Cycles.or(Cycles.all(), Cycles.all(6));
aromaticity = new Aromaticity(model, cycles);
aromatic = aromaticity.apply(mol);
println "benzene is " +
  (aromatic ? "" : "not ") + "aromatic."
```
**Output:**
```plain
benzene is aromatic.
```
