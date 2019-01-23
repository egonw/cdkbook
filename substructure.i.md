# Substructure Searching

<section level="##" label="descriptors:fingerprints">Fingerprints</section>

Substructure searching is a relatively slow algorithm, and the time required
to compare two molecules scales with the number of atoms in each molecule.
To reduce the computation time, <topic>molecular fingerprints</topic> were
invented. There are two key aspects to fingerprints that make them
efficient: first, they have a fixed length so that the time to compare
two molecule is independent of the size of the two structures;
secondly, the fingerprint of a substructure always matches the
fingerprint of any molecules that has that substructure.

In this section we will see two fingerprint types available in the CDK:
a substructure based fingerprint, and a path based fingerprint.
Before I will explain how these fingerprints are created, we will first
look at the <class>BitSet</class> class that is used by the CDK to
represent these fingerprints. Consider this code:

<code>BitSetDemo</code>

If we analyze the output, we see that all set bits are listed, and
that all other bits are not: 

<out>BitSetDemo</out>

Let us now consider a simple substructure fingerprint of length four
with the following bit definitions:

* bit 1: molecule contains a carbon
* bit 2: molecule contains a nitrogen
* bit 3: molecule contains a oxygen
* bit 4: molecule contains a chlorine

Let's call this fingerprinter `SimpleFingerprinter`:

<code>SimpleFingerprinter</code>

We can then calculate the fingerprints for ethanol and benzene:

<code>SimpleFingerprintDemo</code>

and we get these bit sets:

<out>SimpleFingerprintDemo</out>

Now, we can replace the presence of a particular atom, by the presence
of a substructure, such as a phenyl or a carbonyl group. We have then
defined a substructure fingerprint.

The CDK has several kinds of fingerprints, including path-based
fingerprints (<class>Fingerprinter</class> and <class>HybridizationFingerprinter</class>), a MACSS fingerprint
(<class>MACSSFingerprinter</class>) [<cite>Q34160151</cite>], and the PubChem fingerprint
(<class>PubChemFingerprinter</class>).
These fingerprints have been used for various tasks, including ligand
classification [<cite>Q42704791</cite>], and databases like BRENDA [<cite>Q24599948</cite>] and TIN [<cite>Q33874102</cite>].

### MACCS Fingerprints

One substructure-based fingerprinter is the <class type="topic">MACCSFingerprinter</class>
which partly implements the MACSS fingerprint specification [<cite>Q34160151</cite>]. The
substructures are defined as SMARTS substructure specifications,
inherited from RDKit ([http://rdkit.org/](http://rdkit.org/)). For this fingerprint it is required the implicit hydrogen
counts are first set:
	
<code>MACCSFingerprint</code>

The object returned by the `getBitFingerprint` method is the `IBitFingerprint`
which we can convert into a Java `BitSet` with the `asBitSet` method:
	
<out>MACCSFingerprint</out>

### ECFP and FCFP Fingerprints

The CDK also has an implementation for the circular <topic>ECFP</topic> and <topic>FCFP</topic>
fingerprints [<cite>Q29616639</cite>]. These are developed by Alex M. Clark at
[Collaborative Drug Discovery, Inc](http://collaborativedrug.com) in the
<class>CircularFingerprinter</class> [<cite>Q27902272</cite>].
It implements both in four variants:
ECFP0, ECFP2, ECFP4, ECFP6, FCFP0, FCFP2, FCFP4, and FCFP6. The code is quite similar
as for other fingerprints, but we do have to indicate what variant we want:
	
<code>ECFPFingerprint</code>

Again we get an `IBitFingerprint` resulting in a `BitSet` of bits:
	
<out>ECFPFingerprint</out>

## References

<references/>
