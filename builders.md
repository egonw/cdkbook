<a name="sec:builders"></a>
# IChemObjectBuilders

[`IChemObjectBuilder`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/interfaces/IChemObjectBuilder.html) are a programmatic trick that allows to CDK
to use alternative implementations. Originally, the CDK only had a
single implementation, and not even interfaces. It was recognized that
if we wanted to provide data classes that performed slightly
differently, we had to introduce interfaces. And so we did. In fact, so
we are doing: this process is still ongoing.

Existing use cases for the alternative implementations are abundant.
For example, we now have implementations that provide debug information
logging how a data model is changed over time. Another implementation
does not send around change events as do the original classes, making
it faster. Indeed, when speed matters and your code does not
rely on change event signaling, you should use this *silent*
implementation.

The advantage of using builders, is that we can easily change the
implementation we want to use. For example, while learning how a piece
of code is working, it can be beneficial to use the debug implementation,
while when in production mode, we want the fastest implementation.
Many code examples in this book use a specific implementation, but it
is recommended to builders as much as possible. This code is more verbose,
but more flexible at the same time:

**Script** [code/Builders.groovy](code/Builders.code.md)
```groovy
IChemObjectBuilder builder =
  DefaultChemObjectBuilder.getInstance();
IAtom atom1 = builder.newInstance(IAtom.class, "C");
IAtom atom2 = builder.newInstance(IAtom.class, "C");
molecule = builder.newInstance(IAtomContainer.class);
molecule.addAtom(atom1);
molecule.addAtom(atom2);
molecule.addBond(builder.newInstance(
  IBond.class, atom1, atom2, IBond.Order.SINGLE
));
```

This example shows the two key methods. The first important method is
the `getInstance()` to get an singleton instance of a particular builder.
Later in this chapter the available builders are introduced. The second
method, \code{newInstance()}, is the method to create new data structures.
In fact, there is only one such `newInstance()` method, and it uses
the Java varargs pattern [<a href="#citeref1">1</a>] to create the right object. Only requirement
is that the first parameter is the `Class` for which an instance
should be created. All further parameters are passes to the constructor
of that class. Therefore, the following example is equivalent for the
above code:

**Script** [code/BuildersOldFashion.groovy](code/BuildersOldFashion.code.md)
```groovy
IAtom atom1 = new Atom("C");
IAtom atom2 = new Atom("C");
molecule = new AtomContainer();
molecule.addAtom(atom1);
molecule.addAtom(atom2);
molecule.addBond(new Bond(
  atom1, atom2, IBond.Order.SINGLE
));
```

Shorter, but if you want to switch implementations, you have a lot more
refactoring to do.

## Implementations

As indicated earlier, there are various implementations. CDK 2.1.1
has three implementations: the default builder, a builder to create debug
output creating classes, and two builders that create data classes that do
not send around change events.

Each of these implementations resides in their own module. The default
builder is found in the \keytopic{data} module, the debug builder in the
`datadebug` module, and the non-notifying builder is found in the
`silent` module.

### The Default Builder

The [`DefaultChemObjectBuilder`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/DefaultChemObjectBuilder.html) is the original code for the CDK data
classes. It reflects to original design and needs for the CDK, and in particular
to needs of the JChemPaint editor, which strongly depended on the change event
signaling. Therefore, this feature is deeply rooted in this implementation.

Internally, these classes inform each other when contained classes are changed.
Therefore, when we register a change event listener to a molecule, we not only
get events when we change the molecule, but also when a contained atom changed:

**Script** [code/ObjectListening.groovy](code/ObjectListening.code.md)
```groovy
IChemObjectBuilder builder =
  DefaultChemObjectBuilder.getInstance();
molecule = builder.newInstance(IAtomContainer.class);
listener = new IChemObjectListener() {
  public void stateChanged(IChemObjectChangeEvent event) {
    System.out.println("Event: " + event)
  }
}
molecule.addListener(listener)
IAtom atom1 = builder.newInstance(IAtom.class, "C")
molecule.addAtom(atom1)
atom1.setSymbol("N")
```

The output shows the two events that happen based on this code. The first
event is when the atom was added, while the second event is caused by the
element symbol of the atom changing:

```plain
Event: org.openscience.cdk.event.ChemObjectChang...
  eEvent[source=AtomContainer(1613095350, #A:1, ...
  Atom(587153993, S:C, H:0, AtomType(587153993, ...
  FC:0, Isotope(587153993, Element(587153993, S:...
  C, AN:6)))))]
Event: org.openscience.cdk.event.ChemObjectChang...
  eEvent[source=Atom(587153993, S:N, H:0, AtomTy...
  pe(587153993, FC:0, Isotope(587153993, Element...
  (587153993, S:N, AN:6))))]
```

### The Debug Builder

The [`DebugChemObjectBuilder`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/debug/DebugChemObjectBuilder.html) constructs classes to provide debug
information, allowing you to track what is happening with your data model.
For example, if we use this builder instead of the default builder by
changing the first line in Script ??:

**Script** [code/DebugBuilder.groovy](code/DebugBuilder.code.md)
```groovy
IChemObjectBuilder builder =
  DebugChemObjectBuilder.getInstance();
```

... we get this debug information for the data classes:

```plain
org.openscience.cdk.debug.DebugAtom DEBUG: Getti...
  ng max bond order: null
org.openscience.cdk.debug.DebugAtom DEBUG: Getti...
  ng bond order sum: null
org.openscience.cdk.debug.DebugAtom DEBUG: Getti...
  ng formal charge: 0
org.openscience.cdk.debug.DebugAtom DEBUG: Getti...
  ng formal charge: 0
org.openscience.cdk.debug.DebugAtom DEBUG: Getti...
  ng hybridization: null
org.openscience.cdk.debug.DebugAtom DEBUG: Getti...
  ng formal neighbour count: null
org.openscience.cdk.debug.DebugAtom DEBUG: Getti...
  ng covalent radius: null
org.openscience.cdk.debug.DebugAtom DEBUG: Getti...
```

### The Silent Builder

The [`SilentChemObjectBuilder`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/silent/SilentChemObjectBuilder.html) was the second builder that did not send
around change events. It replaces the `NoNotificationChemObjectBuilder`
and has cleaner code, and is even faster [<a href="#citeref2">2</a>]. This builder too is created using
the now familiar pattern:

**Script** [code/SilentBuilder.groovy](code/SilentBuilder.code.md)
```groovy
IChemObjectBuilder builder =
  SilentChemObjectBuilder.getInstance();
```

## References

1. <a name="citeref1"></a>[https://docs.oracle.com/javase/1.5.0/docs/guide/language/varargs.html](https://docs.oracle.com/javase/1.5.0/docs/guide/language/varargs.html)
2. <a name="citeref2"></a>Willighagen E, Data, Nonotify, or Silent?, [http://chem-bla-ics.blogspot.com/2011/07/data-nonotify-or-silent.html](http://chem-bla-ics.blogspot.com/2011/07/data-nonotify-or-silent.html)

