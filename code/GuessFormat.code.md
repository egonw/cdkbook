# GuessFormat.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.9')

import java.io.*;
import org.openscience.cdk.io.*;
import org.openscience.cdk.io.formats.*;

Reader stringReader = new StringReader(
  "<molecule xmlns='http://www.xml-cml.org/schema'/>"
);
FormatFactory factory = new FormatFactory();
IChemFormat format = factory.guessFormat(stringReader);
System.out.println("Format: " + format.getFormatName());
```
**Output:**
```plain
Format: Chemical Markup Language
```
