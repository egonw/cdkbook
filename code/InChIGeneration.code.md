# InChIGeneration.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.3')

import org.openscience.cdk.interfaces.*;
import org.openscience.cdk.*;
import org.openscience.cdk.inchi.*;
import net.sf.jniinchi.INCHI_RET;

methane = new AtomContainer();
atom1 = new Atom("C")
methane.addAtom(atom1)

factory = InChIGeneratorFactory.getInstance();
generator = factory.getInChIGenerator(methane);
if (generator.getReturnStatus() == INCHI_RET.OKAY)
  print generator.getInchi()
```
**Output:**
```plain
InChI=1S/CH4/h1H4
```
