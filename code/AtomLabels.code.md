# AtomLabels.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.7.1')

 import org.openscience.cdk.templates.*;
 import org.openscience.cdk.isomorphism.*;
butane = MoleculeFactory.makeAlkane(4);
butane.atoms().each { atom ->
  atom.setProperty("Label", "Molecule")
}
ccc = MoleculeFactory.makeAlkane(3);
ccc.atoms().each { atom ->
  atom.setProperty("Label", "Substructure")
}
```
**Output:**
```plain
```
