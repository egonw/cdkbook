# Molecular Descriptors

The previous chapter discussed prediction of molecular properties. Understanding
them is a core aspect of chemistry. Computational tools help here. Quantum
Chemistry promises to calculate many molecular properties accurately from
mere knowledge of atom locations and their electronic properties, but suffers
from a badly scaling algorithm. Instead, approaches using the chemical graph
as a core representation are less accurate, but much more faster.

Quantitative Structure-Activity Relationship (<topic>QSAR</topic>) modeling uses this latter
approach to predict molecular properties. QSAR
approaches commonly use <topic>molecular descriptors</topic> which numerically
describe molecular allowing statistical methods to correlate these descriptors
to end points, such as the logP property. A far more detailed explanation
can be found in [<cite>Q47543807</cite>].

This chapter will discuss the descriptor API present in the CDK to calculate
molecular descriptors. It should be noted that the CDK also contains atom,
atom pair, bond, and protein descriptors, using a similar API.

## Descriptors and Specifications

The CDK makes a distinction between descriptor specifications and their
implementations. The reason is simple: the CDK has implementations of
descriptor specifications. Such an implementation may depend on data
available in the CDK, such as isotopic masses which get more accurate
over time. Consequently, the calculated properties will deviate when
this data gets updated: the descriptor implementation changes even when
the algorithm stays the same.

Practically, things are even a bit more complicated, as the CDK is
different in another way. The CDK project decided it was better to have
parameterizable implementations: one descriptor instance that can calculate
the number of carbons, but also the number of nitrogens. After all,
we do not want too much code replication.

Therefore, the CDK has two core interfaces: <class>IDescriptor</class> and
<class>IImplementationSpecification</class> [<cite>Q27065423</cite>]. The first is an actual
descriptor instance,
parameterized to calculate particular output. The second links this
descriptor to a formal specification, outlined in the Blue Obelisk
Descriptor Ontology [<cite>Q27062363</cite>,<cite>Q27134746</cite>].

### IImplementationSpecification

Let's first look at the <class type="topic">IImplementationSpecification</class> interface.
This <topic>specification</topic> interface provides provenance information that allows you to keep
track how your descriptor values were calculated. Of course, you may
simply ignore that whenever you do not need that information.

This interfaces defines four fields:
* specification reference
* implementation title
* implementation identifier
* implementation vendor

This information links the CDK descriptor implementation to a formally
defined descriptor algorithm, pointed to by the specification reference.
The other three fields provide information on the CDK implementation,
allowing one to mix descriptor calculation by various tools and to keep
track of what value came from what vendor.

For example, we can inspect these field values for the TPSA descriptor
(see Section <xref>tpsa</xref>):

<code>TPSASpecs</code>

This code provides us with these details:

<out>TPSASpecs</out>

The identifier values originally referred to a String which held the
source code repository's commit number. But ever since we moved from
a Subversion source code repository to Git, we no longer had commit
numbers, but commit hashes again. But both identifiers have the
function that they identified a specific revision of the implementation
allowing people to accurately recalculate that descriptor value,
given the same input. Well, no one seems to worry about that much,
but it is with this framework possible anyway.

## IDescriptor

As the previous code example (Script <xref>TPSASpecs</xref>) shows, the
specification is for an descriptor implementation and we used
the `getSpecification()` (`.specifiction` in Groovy)
to get the specification information. This method is defined by
the <class type="topic">IDescriptor</class> interface.

The interface introduces the following additional methods:
* `getDescriptorNames()`
* `getParameterNames()`
* `getParameterType(String name)`
* `setParameters(Object[] params)`
* `getParameters()`

The CDK descriptor API differs from other tools in that it structures descriptors
around the algorithms that calculate them. Therefore, each descriptor returns one
or more descriptor values. The first methods lists the descriptor value names, and
it should be noted that those are specifically for the used <topic>parameters</topic>, as we will
see later. The default descriptor value names are listed in Appendix <xref>moldescs:mol</xref>.

The next two methods, `getParameterNames()` and `getParameterType(String name)`,
allow us to discover which parameters a particular descriptor has, if any. For example,
we can check those of the <class>AtomCountDescriptor</class>:

<code>AtomCountDescriptorParams</code>

which tells us how we can tune the descriptor calculation (see also Section <xref>noCount</xref>):

<out>AtomCountDescriptorParams</out>

The last two methods allow is to change the current parameter values
(`setParameters(Object[] params)`), and what those active values are
(`getParameters()`). These values are in the same order as the parameter
names. For example, we can see if the <class>AromaticAtomsCountDescriptor</class> calculates
aromaticity itself by default:

<code>AromaticAtomCountDescriptorParams</code>

Note that I used the Groovy syntax to create an array here, because the Java syntax overlaps
with the Groovy syntax for specifying closures [<cite>so:groovyBoolean</cite>]. This code shows
us:

<out>AromaticAtomCountDescriptorParams</out>

## IMolecularDescriptor

With this information about the descriptor now clear, it is time to look at a descriptor
value calculation. A molecular descriptor in the CDK is symbolized by the
<class type="topic">IMolecularDescriptor</class> interface, which extends the <class>IDescriptor</class> interface,
as shown in Figure <xref>descriptorInheritance</xref>.

<figure label="descriptorInheritance" caption="The IDescriptor interface has a few derived interfaces, but only IMolecularDescriptor is shown here.">
![](images/descriptor.png) <br />
</figure>

The relevant method now is the `calculate(IAtomContainer)` method, which returns
a <class>DescriptorValue</class>. This class is returned rather than a double, because descriptors
can calculate multiple types. The most common two types are a single `Double` and
a `Double[]`, followed by the integer variants. However, a descriptor could also
return a cardinal value, and a boolean. But before we go into the details of the
actually calculated descriptor values, let's look at TPSA calculation in a bit more detail
then we did in Script <xref>TPSA</xref>:

<code>TPSACalc</code>

The output shows us that quite some metadata is preserved:

<out>TPSACalc</out>

The descriptor specification is kept for reference, as well as the parameters, and the
descriptor value names. This is all the information you need to report in a publication
so that other people can recalculate the exact values you calculated.

Additionally, if the calculation failed (because the input structure
had error, had missing information, like no 3D coordinates), then an <topic>exception</topic> is stored
and returned too:

<code>DescriptorCalcException</code>

The <topic>moment of inertia</topic> descriptor requires 3D coordinates, which are not provided
in the above script. Therefore, we get an exception:

<out>DescriptorCalcException</out>

## IDescriptorResult

With all this context described, it is time to look at the actual calculated values. It was
already noted that a molecular descriptor implementation in the CDK returns one or more values,
each of which can be of a varying type. Indeed, if we look at Appendix <xref>moldescs:mol</xref>
we see that some descriptors return one numerical value, while others return many values.
It should also be noted, that depending on parameter values set, the actual number of
calculated numbers can vary!

<code>DescriptorResultLength</code>

Which shows us that the molecular inertia descriptor calculates more than one value:

<out>DescriptorResultLength</out>

The <class type="topic">IDescriptorResult</class> interface is currently implemented by various classes,
outlined in Figure <xref>descriptorResults</xref>. Each of the classes has a slightly different
API to get the actual values. The <class type="topic">IntegerResult</class>, <class type="topic">DoubleResult</class>,
and <class type="topic">BooleanResult</class> classes have the methods `intValue()`,
`doubleValue()`, and `booleanValue()` respectively.

<figure label="descriptorResults" caption="The IDescriptorResults interface has several implementation, each wrapping calculated descriptor values.">
![](images/descriptorResults.png) <br />
</figure>

The two array variants, <class type="topic">IntegerArrayResult</class> and <class type="topic">DoubleArrayResult</class>,
work slightly different, and both provide a `get(int)` method to iterate over all
values. For example, for the molecular inertia descriptor values for methane it would
look like:

<code>DoubleArrayGetValue</code>

This returns us all inertia values, and note that the index starts at zero:

<out>DoubleArrayGetValue</out>

<section level="##" label="noCount">Counting Nitrogens and Oxygens</section>

Now that we know how the general API works, we can calculate custom descriptors, say the
`nitrogenCount` and `oxygenCount`. We reuse the <class>AtomCountDescriptor</class> for that, and
set the parameter:

<code>SpecificAtomCountDescriptor</code>

And this returns us the nitrogen and oxygen counts:

<out>SpecificAtomCountDescriptor</out>

It should be noted too, that the descriptor labels, given in brackets in the output,
have been updated according to the change in descriptor parameters. This is not necessarily
the case for all descriptors, but many take this approach.

## References

<references/>

