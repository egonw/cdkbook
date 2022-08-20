# ListAllIsotopes.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.7.1')

import org.openscience.cdk.interfaces.*;
import org.openscience.cdk.config.*;
import org.openscience.cdk.silent.*;
import org.openscience.cdk.*;
import java.util.Arrays;

isofac = Isotopes.getInstance();
output = new File("../isotopelist.md")
output.text = ""

maxAtomicNumber = 150;
for (atomicNumber in 1..maxAtomicNumber) {
  element = isofac.getElement(atomicNumber)
 if (element != null) {
  isotopes = isofac.getIsotopes(element.symbol)
 firstIsotope = true
  for (isotope in isotopes) {
    if (isotope.naturalAbundance > 0.1) {
     output.append("<tr>")
     if (firstIsotope) {
      output.append(
        "<td>" +
          atomicNumber + "</td><td>" +
          element.symbol +
        "</td>"
      )
     } else {
       output.append("<td></td><td></td>")
     }
      output.append(
        "<td>" +
        isotope.massNumber + "</td><td>" +
        isotope.naturalAbundance + "</td><td>" +
        isotope.exactMass +
        "</td>"
      )
     output.append("</tr>\n");
   firstIsotope = false
    }
  }
 }
}
```
**Output:**
```plain
```
