# PubChemDownload.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.3')

import java.net.UnknownHostException;
import org.openscience.cdk.*
import org.openscience.cdk.io.*
import org.openscience.cdk.silent.*


cid = 5282253
try {
reader = new PCCompoundXMLReader(
  new URL(
    "https://pubchem.ncbi.nlm.nih.gov/summary/" +
    "summary.cgi?cid=$cid&disopt=SaveXML"
  ).newInputStream()
)
mol = reader.read(new AtomContainer())
println "CID: " + mol.getProperty("PubChem CID")
println "Atom count: $mol.atomCount"
} catch (UnknownHostException exception) {
  println "FIXME: compiled without internet connection"
}
```
**Output:**
```plain
CID: 5282253
Atom count: 43
```
