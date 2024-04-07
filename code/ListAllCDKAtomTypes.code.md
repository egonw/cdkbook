# ListAllCDKAtomTypes.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.9')

import org.openscience.cdk.interfaces.*;
import org.openscience.cdk.config.*;
import org.openscience.cdk.silent.*;
import org.openscience.cdk.*;
import java.util.Arrays;

factory = AtomTypeFactory.getInstance(
  "org/openscience/cdk/dict/data/cdk-atom-types.owl",
  SilentChemObjectBuilder.getInstance()
);
output = new File("../atomtypelist.md")
output.text = ""

IAtomType[] types = factory.getAllAtomTypes();
Arrays.sort(types, new Comparator<IAtomType>() {
  public int compare(IAtomType type1, IAtomType type2) {
    if (type1.symbol == null) return 1
    if (type2.symbol == null) return -1
    return type1.getSymbol().compareTo(type2.getSymbol())
  }
});
for (IAtomType type : types) {
  lonepairs = type.getProperty(
    CDKConstants.LONE_PAIR_COUNT
  )
  output.append(
    "<tr>" +
    "<td>${type.atomTypeName}</td>" +
    "<td>${type.symbol}</td>" +
    "<td>${type.formalCharge}</td>" +
    "<td>${type.formalNeighbourCount}</td>" +
    (type.hybridization == null
      ? "<td></td>"
      : "<td>${type.hybridization}</td>") +
    (lonepairs == null
      ? "<td></td>"
      : "<td>${lonepairs}</td>") +
    "<td>" + type.getProperty(
      CDKConstants.PI_BOND_COUNT
    ) + "</td></tr>\n")
}
```
**Output:**
```plain
```
