# ChemObjectIdentifiers.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.9')

 import org.openscience.cdk.*;

butane = new AtomContainer();
butane.setID("cdkbook000000001")
print "ID: " + butane.getID()
```
**Output:**
```plain
ID: cdkbook000000001
```
