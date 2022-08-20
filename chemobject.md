# From IChemObject to IChemFile

The previous chapters showed us various core data classes, including `IAtom`,
`IAtom`, and `IAtomContainer`, but also a few more complex data structures,
such as `IReaction`. But there are many more data structure interfaces used
by the CDK, and this chapter will give an overview of what is available.

All these data interfaces have one interface in common:
`IChemObject`, which we already briefly saw in Section [3.6](atomsbonds.md#sec:chemobjects).
The core `IChemObject` interface itself, extends another core, though commonly
hidden, interface: `ICDKObject`.
The roles of these two classes are to provide basic functionality needed by the
library: the `ICDKObject` interface provides the `getBuilder()` method
which returns a `IChemObjectBuilder` that is used to create new chemical objects
(see Chapter [10](builders.md#sec:builders)).
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

**<a name="script:SetOfAtomContainers">Script 9.1</a>** [code/SetOfAtomContainers.groovy](code/SetOfAtomContainers.code.md)
```groovy
set = new AtomContainerSet()
println "This set has $set.atomContainerCount containers"
anAtomContainer = new AtomContainer()
anotherAtomContainer = new AtomContainer()
set.addAtomContainer(anAtomContainer)
set.addAtomContainer(anotherAtomContainer)
println "Now it has $set.atomContainerCount containers"
```

which shows

```plain
This set has 0 containers
Now it has 2 containers
```

The set can be reused by removing all containers:

**<a name="script:EmptySetOfAtomContainers">Script 9.2</a>** [code/EmptySetOfAtomContainers.groovy](code/EmptySetOfAtomContainers.code.md)
```groovy
set.removeAllAtomContainers()
```

There are two approaches to iterate over all atom containers. The first option is
to use the matching `Iterable`:

**<a name="script:AtomContainersLoopingInSet">Script 9.3</a>** [code/AtomContainersLoopingInSet.groovy](code/AtomContainersLoopingInSet.code.md)
```groovy
println "Number of containers: " + 
  set.getAtomContainerCount()
for (atomContainer in set.atomContainers()) {
  println "container's hashcode " +
    atomContainer.hashCode()
}
```

which outputs:

```plain
Number of containers: 2
container's hashcode 1482986993
container's hashcode 1205817409
```

The other options is to use a regular for-loop:

**<a name="script:AtomContainersForLoopingInSet">Script 9.4</a>** [code/AtomContainersForLoopingInSet.groovy](code/AtomContainersForLoopingInSet.code.md)
```groovy
println "Number of containers: " +
  set.getAtomContainerCount()
for (i=0; i<set.getAtomContainerCount(); i++) {
  println "container $i has hashcode " +
    set.getAtomContainer(i).hashCode()
}
```

which requires more coding, but has the advantage that it keeps track of the index:

```plain
Number of containers: 2
container 0 has hashcode 1483243447
container 1 has hashcode 1322354584
```

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

**<a name="script:SetChemModelContent">Script 9.5</a>** [code/SetChemModelContent.groovy](code/SetChemModelContent.code.md)
```groovy
model = new ChemModel()
model.setMoleculeSet(new AtomContainerSet())
model.setRingSet(new RingSet())
model.setCrystal(new Crystal())
model.setReactionSet(new ReactionSet())
```

## IChemSequence

Sequences of `IChemModel`s are started in a `IChemSequence`. For example,
a MDL SD file contains a sequence of individual models. It otherwise looks
pretty much like another set, and has a similar API for looping over all models
with two alternative approaches. Like with the earlier sets, we can use both
a regular for-loop:

**<a name="script:ChemSequenceForLooping">Script 9.6</a>** [code/ChemSequenceForLooping.groovy](code/ChemSequenceForLooping.code.md)
```groovy
for (i = 0; i < sequence.chemModelCount; i++) {
  println "model $i has hash: " + model.getChemModel(i)
}
```

And the method that returns an `Iterable`:

**<a name="script:ChemSequenceLooping">Script 9.7</a>** [code/ChemSequenceLooping.groovy](code/ChemSequenceLooping.code.md)
```groovy
for (model in sequence.chemModels()) {
  println "model's hash: " + model.hashCode()
}
```

## IChemFile

And to rule them all, there is the `IChemFile`. This class represents the
CDK concept of a chemical file. It was design to be able to hold all the chemistry
present in an arbitraty chemical file format (see Appendix [D.1](appfileformats.md#sec:fileformats)).
This is why so many readers in the CDK support reading of `IChemFile`s.

Because many files contain complementary information, a `IChemFile` supports
storage of multiple `IChemSequence`s: each sequence contains one of the
complementary blocks of information.

Here too, we have the usual two combinations to access the sequences. The for-loop
looks like:

**<a name="script:ChemFileForLooping">Script 9.8</a>** [code/ChemFileForLooping.groovy](code/ChemFileForLooping.code.md)
```groovy
for (i = 0; i < file.chemSequenceCount; i++) {
  println "sequence $i has hash: " +
    model.getChemSequence(i)
}
```

And the approach using the `Iterable` looks like:

**<a name="script:ChemFileLooping">Script 9.9</a>** [code/ChemFileLooping.groovy](code/ChemFileLooping.code.md)
```groovy
for (sequence in file.chemSequences()) {
  println "sequence's hash: " + sequence.hashCode()
}
```

