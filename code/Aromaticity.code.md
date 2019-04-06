# Aromaticity.groovy
**Source code:**
```groovy
import org.openscience.cdk.interfaces.*;
import org.openscience.cdk.tools.*;
import org.openscience.cdk.templates.*;
import org.openscience.cdk.aromaticity.*;
import org.openscience.cdk.graph.*;
mol = MoleculeFactory.makeBenzene()
model       = ElectronDonation.daylight();
cycles      = Cycles.or(Cycles.all(), Cycles.all(6));
aromaticity = new Aromaticity(
  (ElectronDonation)model,
  (CycleFinder)cycles
);
aromaticity.apply(mol);
notAromatic = aromaticity.findBonds().isEmpty()
println "benzene is " +
  (notAromatic ? "not " : "") + "aromatic."
```
**Output:**
```plain
```
