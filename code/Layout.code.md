# Layout.groovy
**Source code:**
```groovy
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
C: (-3.17403810567666, 0.5759618943233447)
C: (-1.6740381056766602, 0.5759618943233429)
C: (-0.9240381056766571, 1.8749999999999998)
O: (-1.674038105676654, 3.174038105676659)
C: (0.5759618943233435, 1.8749999999999947)
```
