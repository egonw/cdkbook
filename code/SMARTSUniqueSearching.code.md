# SMARTSUniqueSearching.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.9')

import org.openscience.cdk.interfaces.*;
import org.openscience.cdk.smiles.*;
import org.openscience.cdk.smiles.smarts.*;
import org.openscience.cdk.silent.SilentChemObjectBuilder;
 
SmilesParser sp = new SmilesParser(SilentChemObjectBuilder.getInstance());
atomContainer = sp.parseSmiles("CC(=O)OC(=O)C");
querytool = new SMARTSQueryTool(
  "O~C~O", atomContainer.getBuilder()
);
found = querytool.matches(atomContainer);
if (found) {
   mappings = querytool.getMatchingAtoms();
   for (int i = 1; i <= mappings.size(); i++) {
      atomIndices = mappings.get(i-1);
      println "match $i: $atomIndices"
   }
   mappings = querytool.getUniqueMatchingAtoms();
   for (int i = 1; i <= mappings.size(); i++) {
      atomIndices = mappings.get(i-1);
      println "unique match $i: $atomIndices"
   }
}
```
**Output:**
```plain
match 1: [2, 1, 3]
match 2: [3, 1, 2]
match 3: [3, 4, 5]
match 4: [5, 4, 3]
unique match 1: [2, 1, 3]
unique match 2: [3, 4, 5]
```
