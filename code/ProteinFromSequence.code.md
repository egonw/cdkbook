# ProteinFromSequence.groovy
**Source code:**
```groovy
 import org.openscience.cdk.tools.*;
crambin = ProteinBuilderTool.createProtein(
  "TTCCPSIVARSNFNVCRLPGTPEA" +
  "ICATYTGCIIIPGATCPGDYAN"
);
println "Crambin has " + crambin.atomCount +
  " atoms."
```
**Output:**
```plain
Crambin has 327 atoms.
```
