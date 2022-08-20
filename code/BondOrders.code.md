# BondOrders.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.7.1')

import org.openscience.cdk.interfaces.*;

IBond.Order.each {
  println it
}
```
**Output:**
```plain
SINGLE
DOUBLE
TRIPLE
QUADRUPLE
QUINTUPLE
SEXTUPLE
UNSET
```
