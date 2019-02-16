# ListAllIsotopes.groovy
**Source code:**
```groovy
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
     if (firstIsotope) {
      output.append(
        "<tr><td>" +
        atomicNumber + "</td><td>" +
        element.symbol + "</td><td>" +
        "</td></tr>\n"
      )
     } else {
       output.append("<td><td></td><td></td><td></td></tr>\n")
     }
      output.append(
        "<tr><td>" +
        isotope.massNumber + "</td><td>" +
        isotope.naturalAbundance + "</td><td>" +
        isotope.exactMass +
        "</td></tr>\n"
      )
   firstIsotope = false
    }
  }
 }
}
```
**Output:**
```plain
```
