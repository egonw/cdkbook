# IsotopesDemo.groovy
**Source code:**
```groovy
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
