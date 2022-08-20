# AtomCountDescriptorParams.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.7.1')

import org.openscience.cdk.qsar.descriptors.molecular.*;

descriptor = new AtomCountDescriptor()
descriptor.parameterNames.each { name ->
  type = descriptor.getParameterType(name).class.name
  println "$name -> $type"
}
```
**Output:**
```plain
elementName -> java.lang.String
```
