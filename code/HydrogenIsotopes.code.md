# HydrogenIsotopes.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.11')

import org.openscience.cdk.config.*;

isofac = Isotopes.getInstance();
isotopes = isofac.getIsotopes("H");
majorIsotope = isofac.getMajorIsotope("H")
for (isotope in isotopes) {
  print "${isotope.massNumber}${isotope.symbol}: " +
    "${isotope.exactMass} ${isotope.naturalAbundance}%"
  if (majorIsotope.massNumber == isotope.massNumber)
    print " (major isotope)"
  println ""
}
```
**Output:**
```plain
1H: 1.007825032 99.9885% (major isotope)
2H: 2.014101778 0.0115%
3H: 3.016049278 0.0%
4H: 4.02781 0.0%
5H: 5.03531 0.0%
6H: 6.04494 0.0%
7H: 7.05275 0.0%
```
