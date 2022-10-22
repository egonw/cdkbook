# DoubleArrayGetValue.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.8')

import org.openscience.cdk.*;
import org.openscience.cdk.io.*;
import org.openscience.cdk.templates.*;
import org.openscience.cdk.tools.*;
import org.openscience.cdk.tools.manipulator.*;
import org.openscience.cdk.qsar.descriptors.molecular.*;
import org.openscience.cdk.qsar.result.*;

reader = new XYZReader(
  new FileReader(new File("data/methane.xyz"))
);

// convert the file
ChemFile content = (ChemFile)reader.read(new ChemFile());
containers = ChemFileManipulator.getAllAtomContainers(content)
methane = containers.get(0)

descriptor = new MomentOfInertiaDescriptor()
value = descriptor.calculate(methane).value
for (i in 0..(value.length()-1)) {
  println i + " " + value.get(i)
}
```
**Output:**
```plain
0 3.1955750763324886
1 3.1945914391012566
2 3.1941764686200322
3 1.0003079070516474
4 1.0004378617544136
5 1.0001299147011136
6 1.1190669469245764
```
