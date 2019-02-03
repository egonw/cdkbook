# Csp2CarbonProperties.groovy
**Source code:**
```groovy
import org.openscience.cdk.interfaces.*;
import org.openscience.cdk.config.*;
import org.openscience.cdk.silent.*;
import org.openscience.cdk.*;

factory = AtomTypeFactory.getInstance(
  "org/openscience/cdk/dict/data/cdk-atom-types.owl",
  SilentChemObjectBuilder.getInstance()
);
IAtomType type = factory.getAtomType("C.sp2");
println "element       : $type.symbol"
println "formal change : $type.formalCharge"
println "hybridization : $type.hybridization"
println "neighbors     : $type.formalNeighbourCount"
println "lone pairs    : " +
  type.getProperty(CDKConstants.LONE_PAIR_COUNT)
println "pi bonds      : " +
  type.getProperty(CDKConstants.PI_BOND_COUNT)
```
**Output:**
```plain
element       : C
formal change : 0
hybridization : SP2
neighbors     : 3
lone pairs    : 0
pi bonds      : 1
```
