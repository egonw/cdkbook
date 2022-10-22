# ProteinMonomers.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.8')

import org.openscience.cdk.interfaces.*;
import org.openscience.cdk.io.*;
import org.openscience.cdk.tools.manipulator.*;
import org.openscience.cdk.*;
import java.io.*;

reader = new PDBReader(
  new FileReader("data/1CRN.pdb")
);
file = reader.read(new ChemFile());
crambin = ChemFileManipulator
  .getAllAtomContainers(file)
  .get(0)
assert crambin instanceof IBioPolymer
strand = crambin.getStrand("A")
i=0
for (name in crambin.monomerNames) {
  println "monomer " + name
  i += 1
  if (i>7) { println "..."; break }
}
```
**Output:**
```plain
monomer GLYA20
monomer ALAA24
monomer ALAA9
monomer ARGA17
monomer LEUA18
monomer PROA19
monomer CYSA16
monomer ARGA10
...
```
