# Layout.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.8')

import org.openscience.cdk.*;
import org.openscience.cdk.layout.*;
import org.openscience.cdk.smiles.*;
import javax.vecmath.*;

smilesParser = new SmilesParser(
  DefaultChemObjectBuilder.getInstance()
);
butanol = smilesParser.parseSmiles("CCC(O)C")
sdg = new StructureDiagramGenerator();
sdg.setMolecule(butanol);
sdg.generateCoordinates(new Vector2d(0, 1));
butanol = sdg.getMolecule();
for (atom in butanol.atoms()) {
  println atom.getSymbol() + ": " +
    atom.getPoint2d()
}
```
**Output:**
```plain
C: (-1.7763568394002505E-15, -1.3322676295501878...
  E-15)
C: (0.0, 1.4999999999999991)
C: (-1.299038105676657, 2.2500000000000018)
O: (-2.5980762113533165, 1.5000000000000049)
C: (-1.299038105676652, 3.750000000000002)
```
