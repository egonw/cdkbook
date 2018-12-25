# BondOrders.groovy
**Source code:**
```groovy
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
