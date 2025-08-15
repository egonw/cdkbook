# Substructure.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.11')

 import org.openscience.cdk.templates.*;
 import org.openscience.cdk.isomorphism.*;

butane = MoleculeFactory.makeAlkane(4);
ccc = MoleculeFactory.makeAlkane(3);
isomorphismTester = new UniversalIsomorphismTester()
hits = isomorphismTester.getSubgraphAtomsMaps(
     butane, ccc
  )
println "Number of hits: " + hits.size()
 assert hits.size() == 4
hits.each { substructure ->
  println "Atoms in substructure: " +
    substructure.size()
}
```
**Output:**
```plain
Number of hits: 4
Atoms in substructure: 3
Atoms in substructure: 3
Atoms in substructure: 3
Atoms in substructure: 3
```
