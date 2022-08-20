# ElectronCounts.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.7.1')

import org.openscience.cdk.interfaces.*;
import org.openscience.cdk.*;

IBond.Order.each { order ->
  bond = new Bond(
    new Atom("C"), new Atom("C"),
    order
  )
  println "Bond order $order has " +
    bond.electronCount + " electrons"
}
```
**Output:**
```plain
Bond order SINGLE has 2 electrons
Bond order DOUBLE has 4 electrons
Bond order TRIPLE has 6 electrons
Bond order QUADRUPLE has 8 electrons
Bond order QUINTUPLE has 10 electrons
Bond order SEXTUPLE has 12 electrons
Bond order UNSET has 0 electrons
```
