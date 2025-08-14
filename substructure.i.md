# Substructure Searching

The <class type="topic">UniversalIsomorphismTester</class> class in the CDK can be used
for <topic>substructure searching</topic>. It allows you to determine if some
structure is a substructure and what the
matching substructures are. As such, this can also be used to determine
if two structures are identical.

In this chapter we will see how the class returns all possible
substructure matches, and we'll notice that redundancy occurs due
to symmetrically equivalent matches, and how these redundant
matches can be removed.

<section level="##" label="sec:exactsearch">Exact Search</section>

The <class>UniversalIsomorphismTester</class> class implements an algorithm
that was originally developed for <topic>isomorphism</topic> checking.
However, it can be used for substructure search too.
This section will first show how the class is used to
check if two classes are identical:

<code>Isomorphism</code>

This algorithm works by looking the how bonds are connected to each
other. This is important to realize, because it explains a typical
corner case for this algorithm: it cannot distinguish cyclopropane
from isobutane (see Figure <xref>cyclopropane:isobutane</xref>) when
they are hydrogen depleted:

<code>UITLimitation</code>

Fortunately, the CDK implementation has a workaround for this so that they are
still considered different, based on the fact that they have
different atom counts:

<out>UITLimitation</out>

However, for substructure searching we're less lucky, as we will see shortly.

%%% <code>RenderCyclopropane</code>
%%% <code>RenderIsobutane</code>


<figure label="cyclopropane:isobutane" caption="Cyclopropane (left) and isobutane (right).">
![](images/generated/RenderCyclopropane.png) <!-- <code>RenderAdenineWithNumbers</code> -->
![](images/generated/RenderIsobutane.png) <!-- <code>RenderOxazoleWithNumbers</code> -->
</figure>

<section level="##">Substructures</section>

Starting from the above code to match two structures, the step to substructure searching
is made via the `isSubgraph()` method:

<code>IsSubgraph</code>

It gives this output:

<out>IsSubgraph</out>

Now, you may wonder why propane is a subgraph of butane, because it is
indeed not. But while the variable names suggest that that is what we have been testing,
we have been testing something else: this code works because of the fact that the <class>MoleculeFactory</class>
returns hydrogen depleted graphs (see Section <xref>sec:hydrogens</xref>).
Therefore, butane is a chain of four carbons, and propane is a chain
of three carbons. Then, the latter is a chemical subgraph of the
former.

If we now return to our previous cyclopropane-isobutane example, we can run a subgraph
analysis on them too:

<code>UITSubgraphLimitation</code>

Here we do see the intrinsic limitation of the algorithm reflected. While it is
possible to see that isobutane has more atoms then cyclobutane and therefore cannot
be a substructure, that conclusion cannot be derived for cyclobutane as substructure
as isobutane, visualizing that algorithmic limitation:

<out>UITSubgraphLimitation</out>

<section level="##">Matching Substructures</section>

Substructure searching is finding in a target molecule the atoms that
match the given searched substructure. With the <class>UniversalIsomorphismTester</class>
we can do:

<code>Overlap</code>

However, this only returns us one match, selected as being the largest:

<out>Overlap</out>

There is an alternative:

<code>Substructure</code>

The `getSubgraphAtomsMaps()` methods returns a `List<List<RMap>>`
object, where each `List<RMap>` represents on substructure match.
When we look at the outer list, we see that the subgraph of three carbon atoms
is found 4 times in butane, each with 3 atoms:

<out>Substructure</out>

This is caused by the symmetrical nature of the substructure. It can map
twice onto the same three atoms in butane: once in the forward direction,
and once in the backward direction.

<section level="##" label="sec:smarts">SMARTS matching</section>

A common method to find substructures in cheminformatics is the
SMiles ARbitrary Target Specification (<topic>SMARTS</topic>). The CDK has a
<class>SMARTSParser</class> class to parse SMARTS strings and a convenience tool to perform
SMARTS substructure searches. This is a typical use case:

<code>SMARTSSearching</code>

This shows us that the SMARTS-encoded carboxylic acid substructure is found twice
and which atoms in the input structure form that match:

<out>SMARTSSearching</out>

### Unique matches

Symmetry can cause identical hits to match multiple times, in different ways. This
is, for example, the case when we loosen the above substructure search to a carbon
connected to two oxygens, whatever the bond order is:

<code>SMARTSUniqueSearching</code>

This shows the different between the `getMatchingAtoms` and `getUniqueMatchingAtoms`
method:

<out>SMARTSUniqueSearching</out>

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
