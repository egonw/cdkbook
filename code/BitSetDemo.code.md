# BitSetDemo.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.3')

import java.util.BitSet;
bitset = new BitSet(10);
println "Empty bit set: $bitset";
bitset.set(3);
bitset.set(7);
println "Two bits set: $bitset";
```
**Output:**
```plain
Empty bit set: {}
Two bits set: {3, 7}
```
