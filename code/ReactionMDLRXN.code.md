# ReactionMDLRXN.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.8')

import org.openscience.cdk.silent.*;
import org.openscience.cdk.interfaces.*;
import org.openscience.cdk.io.*;

MDLRXNReader reader = new MDLRXNReader(
  new File("data/anie.201203222.rxn").newReader()
);
IReaction reaction = new Reaction();
reaction = reader.read(reaction);
reader.close();
println "Reactants: " + reaction.reactants.atomContainerCount
println "Products: " + reaction.products.atomContainerCount
```
**Output:**
```plain
Reactants: 1
Products: 1
```
