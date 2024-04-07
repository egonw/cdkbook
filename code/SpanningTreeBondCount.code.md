# SpanningTreeBondCount.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.9')

import org.openscience.cdk.interfaces.*;
import org.openscience.cdk.io.*;
import org.openscience.cdk.graph.*;
import org.openscience.cdk.io.IChemObjectReader.Mode;
import org.openscience.cdk.*;
import java.io.File;

reader = new MDLV2000Reader(
  new File("data/azulene.mol").newReader(),
  Mode.STRICT
);
azulene = reader.read(new AtomContainer());
println "Number of azulene bonds: $azulene.bondCount"
treeBuilder = new SpanningTree(azulene)
azuleneTree = treeBuilder.getSpanningTree();
println "Number of tree bonds: $azuleneTree.bondCount"
```
**Output:**
```plain
Number of azulene bonds: 11
Number of tree bonds: 9
```
