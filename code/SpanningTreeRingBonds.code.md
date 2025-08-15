# SpanningTreeRingBonds.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.11')

import org.openscience.cdk.interfaces.*;
import org.openscience.cdk.graph.*;
import org.openscience.cdk.io.*;
import org.openscience.cdk.io.IChemObjectReader.Mode;
import org.openscience.cdk.*;
import java.io.File;

reader = new MDLV2000Reader(
  new File("data/azulene.mol").newReader(),
  Mode.STRICT
);
azulene = reader.read(new AtomContainer());
ethane = new AtomContainer();
ethane.addAtom(new Atom("C"));
ethane.addAtom(new Atom("C"));
ethane.addBond(0, 1, IBond.Order.SINGLE);
ethaneTree = new SpanningTree(ethane)
println "[ethane]"
println "Number of cyclic bonds: " +
  ethaneTree.bondsCyclicCount
println "Number of acyclic bonds: " +
  ethaneTree.bondsAcyclicCount
azuleneTree = new SpanningTree(azulene)
println "[azulene]"
println "Number of cyclic bonds: " +
  azuleneTree.bondsCyclicCount
println "Number of acyclic bonds: " +
  azuleneTree.bondsAcyclicCount
```
**Output:**
```plain
[ethane]
Number of cyclic bonds: 0
Number of acyclic bonds: 1
[azulene]
Number of cyclic bonds: 11
Number of acyclic bonds: 0
```
