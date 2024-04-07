# MACCSFingerprint.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.9')

import org.openscience.cdk.interfaces.*;
import org.openscience.cdk.smiles.*;
import org.openscience.cdk.silent.*;
import org.openscience.cdk.fingerprint.*;
import org.openscience.cdk.tools.manipulator.*;

parser = new SmilesParser(SilentChemObjectBuilder.getInstance());
ethanol = parser.parseSmiles("CCO");
AtomContainerManipulator.percieveAtomTypesAndConfigureAtoms(ethanol)
fingerprinter = new MACCSFingerprinter();
println "ethanol: " +
  fingerprinter.getBitFingerprint(ethanol).
    asBitSet()
```
**Output:**
```plain
ethanol: {81, 108, 113, 138, 152, 154, 156, 159, 163}
```
