# PropertiesSettings.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.7.1')

import java.io.*;
import java.util.*;
import org.openscience.cdk.*;
import org.openscience.cdk.interfaces.*;
import org.openscience.cdk.io.*;
import org.openscience.cdk.io.listener.*;
import org.openscience.cdk.io.program.*;
import org.openscience.cdk.io.setting.*;

// the custom settings
Properties customSettings = new Properties();
customSettings.setProperty("Basis",   "6-31g*");
customSettings.setProperty("Command",
  "geometry optimization");
customSettings.setProperty("Comment",
  "Job started on Linux cluster on 20041010.");
customSettings.setProperty("ProcessorCount", "5");
PropertiesListener listener = new PropertiesListener(
  customSettings
);
// create the writer
GaussianInputWriter writer = new GaussianInputWriter(
  new FileWriter(new File("methane.gin"))
);
writer.addChemObjectIOListener(listener);
XYZReader reader = new XYZReader(
  new FileReader(new File("data/methane.xyz"))
);
// convert the file
ChemFile content = (ChemFile)reader.read(new ChemFile());
IAtomContainer molecule = content.getChemSequence(0).
  getChemModel(0).getMoleculeSet().getAtomContainer(0);
writer.write(molecule);
writer.close();
```
**Output:**
```plain
```
