# ReadRelaxed.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.3')

import org.openscience.cdk.interfaces.*;
import org.openscience.cdk.io.*;
import org.openscience.cdk.exception.*;
import org.openscience.cdk.*;
import org.openscience.cdk.io.IChemObjectReader.Mode;
import org.openscience.cdk.io.listener.*;
import org.openscience.cdk.io.setting.*;
import java.io.File;

reader = new MDLV2000Reader(
  new File("data/t.mol").newReader(),
  Mode.RELAXED
);
Properties customSettings = new Properties();
customSettings.setProperty(
  "InterpretHydrogenIsotopes", "false"
);
PropertiesListener listener = new PropertiesListener(
  customSettings
);
reader.addChemObjectIOListener(listener);
try {
water = reader.read(new AtomContainer());
println "atom count: $water.atomCount"
} catch (CDKException exception) {
 println exception.getMessage()
}
```
**Output:**
```plain
atom count: 3
```
