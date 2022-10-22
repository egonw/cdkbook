# ChemObjectProperties.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.8')

 import org.openscience.cdk.*;

butane = new AtomContainer();
butane.setProperty(
  "InChI", "InChI=1/C4H10/c1-3-4-2/h3-4H2,1-2H3"
)
print "InChI: " + butane.getProperty("InChI")
```
**Output:**
```plain
InChI: InChI=1/C4H10/c1-3-4-2/h3-4H2,1-2H3
```
