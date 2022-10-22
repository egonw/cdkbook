# HydrogenRadical.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.8')

import org.openscience.cdk.interfaces.*
import org.openscience.cdk.*;

hydrogen = new Atom("H")
radicalElectron =
  new SingleElectron(hydrogen)
hydrogenRadical = new AtomContainer()
hydrogenRadical.addAtom(hydrogen)
hydrogenRadical.addSingleElectron(radicalElectron)
```
**Output:**
```plain
```
