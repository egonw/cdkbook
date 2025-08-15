# ProteinFromSequence.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.11')

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
