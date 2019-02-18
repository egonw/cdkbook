# Graph Properties

Graph theory is the most common representation in cheminformatics, and with
quantum mechanics, rule the informatics side of chemistry. The molecular graph
follow <topic>graph</topic> theory and defines atoms as molecules and bonds as edge between to
atoms. This is by far the only option, and the IBond allows for more complex
representations, but we will focus on the molecular graph in this chapter.

<section label="partitioning" level="##">Partitioning</section>

If one is going to calculate graph properties, the first thing one often has to
do, is to split ensure that one is looking at a fully connected graph. Since
this is often in combination with ensuring fully connected graphs, the
<class type="topic">ConnectivityChecker</class> is a welcome tool. It allows
<topic>partitioning</topic> of the
atoms and bonds in an <class>IAtomContainer</class> into molecules, organized into
<class>IAtomContainerSet</class>:

<code>ConnectivityCheckerDemo</code>

Which gives:

<out>ConnectivityCheckerDemo</out>

<section level="##" label="spanningtree">Spanning Tree</section>

The <topic>spanning tree</topic> of a graph, is subgraph with no cycles; that spans
all atoms into a, still, fully connected graph:

<code>SpanningTreeBondCount</code>

which returns:

<out>SpanningTreeBondCount</out>

As a side effect, it also determines which bonds are <topic>ring bonds</topic>, and which are
not:

<code>SpanningTreeRingBonds</code>

giving

<out>SpanningTreeRingBonds</out>

<section label="ringsearch" level="##">Ring counts</section>

<b>Warning: this section needs updating as there are better approaches in CDK 2.x.</b>

Without providing a full review of all ring detection algorithms, this section discusses three
algorithms for <topic>ring detection</topic>. The first two are alternative
implementations of the <topic>Smallest Set of Smallest Rings</topic> (<topic>SSSR</topic>) concept. While argued to have limited
usefulness if not harmful [<cite>OpenEyeSSSR</cite>], the CDK implements two algorithms: the
<topic>Figueras algorithm</topic> [<cite>Figueras1996</cite>], and an improved algorithm addressing limitations of
the first [<cite>Berger2004</cite>].
The key limitation is that the resulting set is not unique. Depending on the initial conditions,
alternative sets may result for the same structure, particularly for structures with bridgehead
atoms. However, on the bright side, it does give some indication on the number of rings in a structure.

The third algorithm discussed is one to find all rings, even if they are merely combinations of
smaller rings. For example, naphthalene contains has three rings.

### Smallest Rings

The smallest set of smallest rings refers to a set of unique <topic>rings</topic> that, together, capture all
ring atoms. Ring atoms may participate in multiple rings in this set, but each ring will have
at least one ring atom not in other rings. But for each compound, the set itself may not be unique.
For example, adamantane has multiple SSSRs. The trick of the SSSR algorithm is to find a smallest
set of rings that cover all ring atoms.

The CDK implements two algorithms, both are found in the `cdk.ringsearch` package. The
first is the algorithm developed by Figureas [<cite>Figueras1996</cite>] for which the
<class>FiguerasSSSRFinder</class> class can be used:

<code>FiguerasSSSR</code>

Which tells us the number of smallest rings for azulene:

<out>FiguerasSSSR</out>

However, because of this algorithm's limitations in finding a correct SSSR set for some corner
case structure, the following alternative method by Berger \textit{et al.} [<cite>Berger2004</cite>] is
recommended:

<code>SSSR</code>

Which calculates the same number of rings for this compound:

<out>SSSR</out>

### All Rings

If you are interesting in all possible rings, you can use the <class>AllRingsFinder</class> class, which
implements an algorithm by Hanser \textit{et al.} [<cite>Hanser1996</cite>]:

<code>FindAllRings</code>

Which returns all three rings present in azulene:

<code>FindAllRings</code>

One should keep in mind that when more smallest rings are fused together, the number of
all rings grows quickly. The <class>AllRingsFinder</class> class has three options to keep the
calculation manageable for larger structures.

The first option is to search only for rings up to a certain size. For example, only rings
of at most 5 atoms:

<code>FindUptoFiveRings</code>

For which there is only one in azulene:

<out>FindUptoFiveRings</out>

A second option is more like a trick to reduce the search space, but first isolating
the ring systems. There are `findAllRingsInIsolatedRingSystem` alternatives for the
above two approaches.

The third option to limit the execution time is to set a time out. This ensures that
a computation will return after a certain time rather than continuing indefinately:

<code>FindAllRingsInLimitedTime</code>

## Graph matrices

Chemical graphs have been very successfully used as representations of molecular
structures, but are not always to most suitable representation. For example,
for computation of graph properties often a matrix representation is used
as intermediate step. The CDK has predefined helper classes to calculate two
kind of <topic>graph matrices</topic>: the adjacency matrix and the distance matrix. Both
are found in the `cdk.graph.matrix` package.

### Adjacency matrix

The <class>adjacency matrix</class> describes which atoms are connected via a covalent
bond. All matrix elements that link to bonded atoms are 1, and those matrix
elements for disconnected atoms are 0. In mathematical terms, the adjacency matrix `A` is defined as:

<b>Copy back in the equation. MathML?</b>

The algorithm to calculate this matrix is implemented in the
<class>AdjacencyMatrix</class> class. The matrix is calculated with
the static `getMatrix(IAtomContainer)` method:

<code>AdjacencyMatrixCalc</code>

This code outputs the matrix, resulting for ethanoic acid, with the
atoms in the order C, C, O, and O, in:

<out>AdjacencyMatrixCalc</out>

### Distance matrix

The distance matrix describes the number of bonds on has to traverse
to get from one atom to another. Therefore, it has zeros on the diagonal
and non-zero values at all other locations. Matrix elements for
neighboring atoms are 1 and others are larger. The CDK uses
<topic>Floyd's algorithm</topic> to calculate this matrix [<cite>Floyd1962</cite>],
which is exposed via the <class>TopologicalMatrix</class> class:

<code>DistanceMatrix</code>

For the ethanoic acid used earlier, the resulting matrix looks like:

<out>DistanceMatrix</out>

## Atom Numbers

Another important aspect of the chemical graph, is that the graph uniquely
places atoms in the molecule. That is, the graphs allows us to uniquely
identify, and therefore, number atoms in the molecule. This is an important
aspect of cheminformatics, and the concept behind <topic>canonicalization</topic>, such
as used to create <topic>canonical SMILES</topic>. The InChI library (see Chapter <xref>ch:inchi</xref>)
implements such an algorithm, and we can use it to assign unique integers to all
atoms in a chemical graph.

### Morgan Atom Numbers

Morgan published an algorithm in 1965 to assign numbers <!-- <topic>Morgan atom numbers</topic> -->
to vertices in the chemical graph [<cite>Morgan1965</cite>].
The algorithm does not take into account the element symbols
associated with those vertices, and it only based on the connectivity.
Therefore, we see the same number of symmetry related atoms, even if they have
different symbols. If we run:

<code>MorganAtomNumbers</code>

we see this output:

<out>MorganAtomNumbers</out>

<section level="###" label="inchiatomnumbers">InChI Atom Numbers</section>

<figure caption="InChI atom numbers of oxazole (left) and benzene (right).">
![](images/generated/RenderAdenineWithNumbers.png)
![](images/generated/InChIAtomNumbersBenzene.png)
</figure>

The <topic>InChI</topic> library does not have a direct method to calculate atom numbers
from Java, but the CDK can extract these from the auxiliary layer. These numbers
are those listed in the bond layer, but to use these in the CDK molecule class,
we need to mapping of the <topic>InChI atom numbers</topic> This method
is made available via the <class>InChINumbersTools</class> class:

<code>InChIAtomNumbers</code>

which outputs:

<out>InChIAtomNumbers</out>

It is important to note that because these numbers are used in the connectivity layer,
symmetry is broken in assignment of these numbers, allowing all atoms in, for example,
benzene to still be uniquely identified:

<code>InChIAtomNumbersBenzene</code>

which outputs:

<code>InChIAtomNumbersBenzene</code>

The InChI atom numbers are shown in Figure <xref>fig:inchiAtomNumbers</xref>.

## References

<references/>

