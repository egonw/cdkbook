<section level="#" label="builders">IChemObjectBuilders</section>

<class>IChemObjectBuilder</class> are a programmatic trick that allows to CDK
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

<code>Builders</code>

This example shows the two key methods. The first important method is
the `getInstance()` to get an singleton instance of a particular builder.
Later in this chapter the available builders are introduced. The second
method, `newInstance()`, is the method to create new data structures.
In fact, there is only one such `newInstance()` method, and it uses
the Java varargs pattern [<cite>varargs</cite>] to create the right object. Only requirement
is that the first parameter is the <class>Class</class> for which an instance
should be created. All further parameters are passes to the constructor
of that class. Therefore, the following example is equivalent for the
above code:

<code>BuildersOldFashion</code>

Shorter, but if you want to switch implementations, you have a lot more
refactoring to do.

## Implementations

As indicated earlier, there are various implementations. CDK <version/>
has three implementations: the default builder, a builder to create debug
output creating classes, and two builders that create data classes that do
not send around change events.

Each of these implementations resides in their own module. The default
builder is found in the \keytopic{data} module, the debug builder in the
`datadebug` module, and the non-notifying builder is found in the
`silent` module.

### The Default Builder

The <class>DefaultChemObjectBuilder</class> is the original code for the CDK data
classes. It reflects to original design and needs for the CDK, and in particular
to needs of the JChemPaint editor, which strongly depended on the change event
signaling. Therefore, this feature is deeply rooted in this implementation.

Internally, these classes inform each other when contained classes are changed.
Therefore, when we register a change event listener to a molecule, we not only
get events when we change the molecule, but also when a contained atom changed:

<code>ObjectListening</code>

The output shows the two events that happen based on this code. The first
event is when the atom was added, while the second event is caused by the
element symbol of the atom changing:

<out>ObjectListening</out>

### The Debug Builder

The <class>DebugChemObjectBuilder</class> constructs classes to provide debug
information, allowing you to track what is happening with your data model.
For example, if we use this builder instead of the default builder by
changing the first line in Script <xref>script:Builders</xref>:

<code>DebugBuilder</code>

... we get this debug information for the data classes:

<out>DebugBuilder.datadebug</out>

### The Silent Builder

The <class>SilentChemObjectBuilder</class> was the second builder that did not send
around change events. It replaces the `NoNotificationChemObjectBuilder`
and has cleaner code, and is even faster [<cite>silentbuilder</cite>]. This builder too is created using
the now familiar pattern:

<code>SilentBuilder</code>

## References

<references/>
