# From IChemObject to IChemFile

The previous chapters showed us various core data classes, including `IAtom`,
`IAtom`, and `IAtomContainer`, but also a few more complex data structures,
such as `IReaction`. But there are many more data structure interfaces used
by the CDK, and this chapter will give an overview of what is available.

All these data interfaces have one interface in common:
`IChemObject`, which we already briefly saw in Section <xref>chemobjects</xref>.
The core `IChemObject` interface itself, extends another core, though commonly
hidden, interface: `ICDKObject`.
The roles of these two classes are to provide basic functionality needed by the
library: the `ICDKObject` interface provides the `getBuilder()` method
which returns a `IChemObjectBuilder` that is used to create new chemical objects
(see Chapter <xref>builders</xref>).
This method is split out from `IChemObject` because some classes are required
to return a builder, but not provide the full set of fields that `IChemObject`
does.

## IAtomContainerSet

The `IAtomContainerSet` is a data structures to store
a (unsorted) list of `IAtomContainer` instances.
The semantic purpose of this set is undefined. For example, it can contain a set
of different molecules for which you want to calculate a property, or it can be a
set of conformation for a single molecule.

Adding entries typically works with add methods:

<code>SetOfAtomContainers</code>

which shows

<out>SetOfAtomContainers</out>

The set can be reused by removing all containers:

<code>EmptySetOfAtomContainers</code>

There are two approaches to iterate over all atom containers. The first option is
to use the matching `Iterable`:

<code>AtomContainersLoopingInSet</code>

which outputs:

<out>AtomContainersLoopingInSet</out>

The other options is to use a regular for-loop:

<code>AtomContainersForLoopingInSet</code>

which requires more coding, but has the advantage that it keeps track of the index:

<out>AtomContainersForLoopingInSet</out>

## IReactionSet and IRingSet

Similarly, `IReactionSet` and `IRingSet` serve the same role for
reactions and ring structures. These sets do not have a particular semantic
meaning either. For reaction various more semantically meaningful reaction
collections are available, such as `IReactionScheme`, suggesting that
`IReactionSet` is more generally suitable for unconnected reaction, but
that is not disallowed.

## IChemModel

However, as soon as these set structures get embedded in an `IChemModel`,
the semantics are starting to get shape. Because the `IChemModel` has
semantic meaning: it is a unit of knowledge; a single model about something.
A single model is like an entry in a knowledge base, and used as such by 
many file readers.

Each model can contain any chemistry. From an API perspective, it can contain
mixtures of content, but silently assumed is that the fields are mutually
exclusive: if the model contains an crystal, it will not also contain a set
of reactions.

<code>SetChemModelContent</code>

## IChemSequence

Sequences of `IChemModel`s are started in a `IChemSequence`. For example,
a MDL SD file contains a sequence of individual models. It otherwise looks
pretty much like another set, and has a similar API for looping over all models
with two alternative approaches. Like with the earlier sets, we can use both
a regular for-loop:

<code>ChemSequenceForLooping</code>

And the method that returns an `Iterable`:

<code>ChemSequenceLooping</code>

## IChemFile

And to rule them all, there is the `IChemFile`. This class represents the
CDK concept of a chemical file. It was design to be able to hold all the chemistry
present in an arbitraty chemical file format (see Appendix <xref>fileformats</xref>).
This is why so many readers in the CDK support reading of `IChemFile`s.

Because many files contain complementary information, a `IChemFile` supports
storage of multiple `IChemSequence`s: each sequence contains one of the
complementary blocks of information.

Here too, we have the usual two combinations to access the sequences. The for-loop
looks like:

<code>ChemFileForLooping</code>

And the approach using the `Iterable` looks like:

<code>ChemFileLooping</code>

