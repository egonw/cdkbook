# Overlap.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.9')

 import org.openscience.cdk.templates.*;
 import org.openscience.cdk.isomorphism.*;
butane = MoleculeFactory.makeAlkane(4)
ccc = MoleculeFactory.makeAlkane(3)
isomorphismTester = new UniversalIsomorphismTester()
hits = isomorphismTester.getOverlaps(
  butane, ccc
)
println "Number of hits: " + hits.size()
hits.each { substructure ->
  println "Substructure in AtomContainer:"
  println "  #atoms: " + substructure.atomCount
}
```
**Output:**
```plain
Number of hits: 1
Substructure in AtomContainer:
  #atoms: 3
```
