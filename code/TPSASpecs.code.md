# TPSASpecs.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.8')

import org.openscience.cdk.qsar.descriptors.molecular.*;

descriptor = new TPSADescriptor()
specs = descriptor.specification
println "Title: " + specs.implementationTitle
println "Reference: " + specs.specificationReference
println "Vendor: " + specs.implementationVendor
println "Identifier: " + specs.implementationIdentifier
```
**Output:**
```plain
Title: org.openscience.cdk.qsar.descriptors.molecular.TPSADescriptor
Reference: http://www.blueobelisk.org/ontologies/chemoinformatics-algorithms/#...
  tpsa
Vendor: The Chemistry Development Kit
Identifier: 2.8
```
