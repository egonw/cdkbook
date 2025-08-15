# SetChemModelContent.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.11')

import org.openscience.cdk.*;
model = new ChemModel()
model.setMoleculeSet(new AtomContainerSet())
model.setRingSet(new RingSet())
model.setCrystal(new Crystal())
model.setReactionSet(new ReactionSet())
```
**Output:**
```plain
```
