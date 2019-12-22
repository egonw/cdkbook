# ElementsDemo.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.3')

import org.openscience.cdk.config.*;

Elements lithium = Elements.Lithium
println "atomic number: " + lithium.number()
println "symbol: " + lithium.symbol()
println "periodic group: " + lithium.group()
println "periodic period: " + lithium.period()
println "covalent radius: " + lithium.covalentRadius()
println "Vanderwaals radius: " + lithium.vdwRadius()
println "electronegativity: " + lithium.electronegativity()
```
**Output:**
```plain
atomic number: 3
symbol: Li
periodic group: 1
periodic period: 2
covalent radius: 1.34
Vanderwaals radius: 2.2
electronegativity: 0.98
```
