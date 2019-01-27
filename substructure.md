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

Let's call this fingerprinter `SimpleFingerprinter`:

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
fingerprints ([`Fingerprinter`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/fingerprint/Fingerprinter.html) and [`HybridizationFingerprinter`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/fingerprint/HybridizationFingerprinter.html)), a MACSS fingerprint
(`MACSSFingerprinter`) [<a href="#citeref1">1</a>], and the PubChem fingerprint
(`PubChemFingerprinter`).
These fingerprints have been used for various tasks, including ligand
classification [<a href="#citeref2">2</a>], and databases like BRENDA [<a href="#citeref3">3</a>] and TIN [<a href="#citeref4">4</a>].

### MACCS Fingerprints

One substructure-based fingerprinter is the `MACCSFingerprinter`
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

### ECFP and FCFP Fingerprints

The CDK also has an implementation for the circular <a name="tp2">ECFP</a> and <a name="tp3">FCFP</a>
fingerprints [<a href="#citeref5">5</a>]. These are developed by Alex M. Clark at
[Collaborative Drug Discovery, Inc](http://collaborativedrug.com) in the
[`CircularFingerprinter`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/fingerprint/CircularFingerprinter.html) [<a href="#citeref6">6</a>].
It implements both in four variants:
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

## References

1. <a name="citeref1"></a>Durant JL, Leland BA, Henry DR, Nourse JG. Reoptimization of MDL keys for use in drug discovery. Journal of Chemical Information and Modeling. 2002 Nov 1;42(6):1273–80.  doi:[10.1021/CI010132R](https://doi.org/10.1021/CI010132R)
2. <a name="citeref2"></a>Chao, Wang L, Xie X-Q. Ligand Classifier of Adaptively Boosting Ensemble Decision Stumps (LiCABEDS) and its application on modeling ligand functionality for 5HT-subtype GPCR families. Journal of Chemical Information and Modeling. 2011 Mar 7;51(3):521–31.  doi:[10.1021/CI100399J](https://doi.org/10.1021/CI100399J)
3. <a name="citeref3"></a>Schomburg I, Chang A, Ebeling C, Ebeling C, Gremse M, Heldt C, et al. BRENDA, the enzyme database: updates and major new developments. Nucleic Acids Research. 2004 Jan 1;32(Database issue):D431-3.  doi:[10.1093/NAR/GKH081](https://doi.org/10.1093/NAR/GKH081)
4. <a name="citeref4"></a>Dorschner KV, Toomey D, Brennan MP, Heinemann T, Duffy FJ, Nolan KB, et al. TIN-a combinatorial compound collection of synthetically feasible multicomponent synthesis products. Journal of Chemical Information and Modeling. 2011 Apr 15;51(5):986–95.  doi:[10.1021/CI100443X](https://doi.org/10.1021/CI100443X)
5. <a name="citeref5"></a>D R, M H. Extended-connectivity fingerprints. Journal of Chemical Information and Modeling. 2010 May 24;50(5):742–54.  doi:[10.1021/CI100050T](https://doi.org/10.1021/CI100050T)
6. <a name="citeref6"></a>Clark AM, Sarker M, Ekins S. New target prediction and visualization tools incorporating open source molecular fingerprints for TB Mobile 2.0. Journal of Cheminformatics. 2014 Jan 1;6(1):38.  doi:[10.1186/S13321-014-0038-2](https://doi.org/10.1186/S13321-014-0038-2)

