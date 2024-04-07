# Layout.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.9')

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
C: (0.9742785792574944, 2.0624999999999982)
C: (-0.32475952641916295, 2.8125)
C: (-1.6237976320958227, 2.062500000000002)
O: (-1.6237976320958263, 0.5625000000000024)
C: (-2.9228357377724787, 2.812500000000007)
```
