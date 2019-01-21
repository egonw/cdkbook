# Substructure Searching

<a name="sec:descriptors:fingerprints"></a>
## Fingerprints

Substructure searching is a relatively slow algorithm, and the time required
to compare two molecules scales with the number of atoms in each molecule.
To reduce the computation time, <a name="tp1">molecular fingerprints</a> were
invented. There are two key aspects to fingerprints that make them
efficient: first, they have a fixed length so that the time to compare
two molecule is independent of the size of the two structures;
secondly, the fingerprint of a substructure always matches the
fingerprint of any molecules that has that substructure.

In this section we will see two fingerprint types available in the CDK:
a substructure based fingerprint, and a path based fingerprint.
Before I will explain how these fingerprints are created, we will first
look at the `BitSet` class that is used by the CDK to
represent these fingerprints. Consider this code:

**Script** [code/BitSetDemo.groovy](code/BitSetDemo.code.md)
```groovy
bitset = new BitSet(10);
println "Empty bit set: $bitset";
bitset.set(3);
bitset.set(7);
println "Two bits set: $bitset";
```

If we analyze the output, we see that all set bits are listed, and
that all other bits are not: 

```plain
Empty bit set: {}
Two bits set: {3, 7}
```

Let us now consider a simple substructure fingerprint of length four
with the following bit definitions:

* bit 1: molecule contains a carbon
* bit 2: molecule contains a nitrogen
* bit 3: molecule contains a oxygen
* bit 4: molecule contains a chlorine

Let's call this fingerprinter Cclass>SimpleFingerprinter</class>:

**Script** [code/SimpleFingerprinter.java](code/SimpleFingerprinter.code.md)
```java
public class SimpleFingerprinter implements IFingerprinter {
  Map<String,Integer> map = new HashMap<String,Integer>() {{
    put("C", 1);
    put("N", 2);
    put("O", 3);
    put("Cl", 4);
  }};
  public BitSet getFingerprint(IAtomContainer molecule) {
    BitSet bitSet = new BitSet(getSize());
    for (IAtom atom : molecule.atoms()) {
      if (map.containsKey(atom.getSymbol()))
        bitSet.set(map.get(atom.getSymbol()));
    }
    return bitSet;
  }
  public Map<String,Integer> getRawFingerprint(
    IAtomContainer molecule
  ) {
    Map<String,Integer> fingerprint =
      new HashMap<String,Integer>();
    for (String key : map.keySet()) {
      fingerprint.put(key, 0);
    }
    for (IAtom atom : molecule.atoms()) {
      int count = map.get(atom.getSymbol());
      fingerprint.put(atom.getSymbol(), count+1);
    }
    return fingerprint;
  }
  public ICountFingerprint getCountFingerprint(
    IAtomContainer molecule
  ) throws CDKException {
    return new IntArrayCountFingerprint(
      getRawFingerprint(molecule)
    );
  }
  public IBitFingerprint getBitFingerprint(
    IAtomContainer molecule
  ) throws CDKException {
    return new BitSetFingerprint(
      getFingerprint(molecule)
    );
  }
  public int getSize() {
    return 4;
  }
  public String getVersionDescription() { return ""; }
}
```

We can then calculate the fingerprints for ethanol and benzene:

**Script** [code/SimpleFingerprintDemo.groovy](code/SimpleFingerprintDemo.code.md)
```groovy
fingerprinter = new SimpleFingerprinter();
println "ethanol: " + fingerprinter.getFingerprint(ethanol)
println "benzene: " + fingerprinter.getFingerprint(benzene)
```

and we get these bit sets:

```plain
ethanol: {1, 3}
benzene: {1}
```

Now, we can replace the presence of a particular atom, by the presence
of a substructure, such as a phenyl or a carbonyl group. We have then
defined a substructure fingerprint.

The CDK has several kinds of fingerprints, including path-based
fingerprints ([`Fingerprinter`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/fingerprint/Fingerprinter.html) and `HybridizationFingerprinter`), a MACSS fingerprint
(`MACSSFingerprinter`) [<a href="#citeref1">1</a>], and the PubChem fingerprint
(`PubChemFingerprinter`).
These fingerprints have been used for various tasks, including ligand
classification [<a href="#citeref2">2</a>], and databases like BRENDA [<a href="#citeref3">3</a>] and TIN [<a href="#citeref4">4</a>].

## MACCS Fingerprints

One substructure-based fingerprinter is the <a name="tp2">MACCSFingerprinter</a>
which partly implements the MACSS fingerprint specification [1]. The
substructures are defined as SMARTS substructure specifications,
inherited from RDKit ([http://rdkit.org/](http://rdkit.org/)). For this fingerprint it is required the implicit hydrogen
counts are first set:
	
**Script** [code/MACCSFingerprint.groovy](code/MACCSFingerprint.code.md)
```groovy
adder = CDKHydrogenAdder.getInstance(
  ethanol.getBuilder()
)
adder.addImplicitHydrogens(ethanol)
fingerprinter = new MACCSFingerprinter();
println "ethanol: " +
  fingerprinter.getBitFingerprint(ethanol).
    asBitSet()
```

The object returned by the `getBitFingerprint` method is the `IBitFingerprint`
which we can convert into a Java `BitSet` with the `asBitSet` method:
	
```plain
ethanol: {81, 108, 113, 138, 152, 154, 156, 159,...
   163}
```

## ECFP and FCFP Fingerprints

The CDK also has an implementation for the circular <a name="tp3">ECFP</a> and <a name="tp4">FCFP</a>
fingerprints [<a href="#citeref5">5</a>], developed by Alex M. Clark at Collaborative Drug Discovery, Inc
([http://collaborativedrug.com](http://collaborativedrug.com)).
The `CircularFingerprint` class implements both, each in four variants:
ECFP0, ECFP2, ECFP4, ECFP6, FCFP0, FCFP2, FCFP4, and FCFP6. The code is quite similar
as for other fingerprints, but we do have to indicate what variant we want:
	
**Script** [code/ECFPFingerprint.groovy](code/ECFPFingerprint.code.md)
```groovy
fingerprinter = new CircularFingerprinter(
  CircularFingerprinter.CLASS_ECFP6
);
println "ethanol: " +
  fingerprinter.getBitFingerprint(ethanol).
    asBitSet()
```

Again we get an `IBitFingerprint` resulting in a `BitSet` of bits:
	
```plain
ethanol: {152, 325, 625, 740, 947, 993}
```



