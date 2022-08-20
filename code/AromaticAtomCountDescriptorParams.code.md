# AromaticAtomCountDescriptorParams.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.7.1')

import org.openscience.cdk.qsar.descriptors.molecular.*;

descriptor = new AromaticAtomsCountDescriptor()
println "Descriptor names:"
descriptor.parameterNames.each { name ->
  type = descriptor.getParameterType(name).class.name
  println "$name -> $type"
}
println ""
println "Values:"
descriptor.parameters.each { param ->
  type = param.class.name
  println "$type -> $param"
}
println ""
println "Updating the value..."
Object[] newValues = [ Boolean.TRUE ]
descriptor.setParameters(newValues)
println ""
println "New values:"
descriptor.parameters.each { param ->
  type = param.class.name
  println "$type -> $param"
}
```
**Output:**
```plain
Descriptor names:
checkAromaticity -> java.lang.Boolean

Values:
java.lang.Boolean -> false

Updating the value...

New values:
java.lang.Boolean -> true
```
