# IsotopesDemo.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.3')

import org.openscience.cdk.config.*;

isofac = Isotopes.getInstance();
uranium = 92;
for (atomicNumber in 1..uranium) {
  element = isofac.getElement(atomicNumber)
}
```
**Output:**
```plain
```
