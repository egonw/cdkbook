# SilentBuilder.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.8')

import org.openscience.cdk.interfaces.*;
import org.openscience.cdk.silent.*;
import org.openscience.cdk.tools.*;

IChemObjectBuilder builder =
  SilentChemObjectBuilder.getInstance();
```
**Output:**
```plain
```