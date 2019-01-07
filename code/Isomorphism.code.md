# Isomorphism.groovy
**Source code:**
```groovy
 import org.openscience.cdk.templates.*;
 import org.openscience.cdk.isomorphism.*;

butane = MoleculeFactory.makeAlkane(4);
isomorphismTester = new UniversalIsomorphismTester()
println "Is isomorphic: " +
  isomorphismTester.isIsomorph(
    butane, butane
  )
```
**Output:**
```plain
Is isomorphic: true
```
