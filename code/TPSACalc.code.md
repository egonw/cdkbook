# TPSACalc.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.9')

import org.openscience.cdk.*;
import org.openscience.cdk.templates.*;
import org.openscience.cdk.tools.*;
import org.openscience.cdk.tools.manipulator.*;
import org.openscience.cdk.qsar.descriptors.molecular.*;
import org.openscience.cdk.qsar.result.*;

adder = CDKHydrogenAdder.getInstance(
  DefaultChemObjectBuilder.getInstance()
);
oxazone = MoleculeFactory.makeOxazole();
// add explicit hydrogens ...
AtomContainerManipulator.percieveAtomTypesAndConfigureAtoms(oxazone)
adder.addImplicitHydrogens(oxazone)
AtomContainerManipulator.convertImplicitToExplicitHydrogens(oxazone)
descriptor = new TPSADescriptor()
result = descriptor.calculate(oxazone)
println "Specification: " + result.specification
println "Parameters names: " + result.parameterNames
println "Parameters values: " + result.parameters
println "Exception: " + result.exception
println "Names: " + result.names
value = result.getValue()
```
**Output:**
```plain
Specification: org.openscience.cdk.qsar.DescriptorSpecification@134c38
Parameters names: [checkAromaticity]
Parameters values: [false]
Exception: null
Names: [TopoPSA]
```
