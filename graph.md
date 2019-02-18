# Graph Properties

Graph theory is the most common representation in cheminformatics, and with
quantum mechanics, rule the informatics side of chemistry. The molecular graph
follow <a name="tp1">graph</a> theory and defines atoms as molecules and bonds as edge between to
atoms. This is by far the only option, and the IBond allows for more complex
representations, but we will focus on the molecular graph in this chapter.

<a name="sec:partitioning"></a>
## Partitioning

If one is going to calculate graph properties, the first thing one often has to
do, is to split ensure that one is looking at a fully connected graph. Since
this is often in combination with ensuring fully connected graphs, the
[`ConnectivityChecker`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/graph/ConnectivityChecker.html) is a welcome tool. It allows
<a name="tp2">partitioning</a> of the
atoms and bonds in an [`IAtomContainer`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/interfaces/IAtomContainer.html) into molecules, organized into
[`IAtomContainerSet`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/interfaces/IAtomContainerSet.html):

