# Reactions

Reactions are fundamental events in chemistry, biochemistry, and thus in life. As such, a cheminformatics
toolkit cannot do without a <topic>reaction</topic> framework. This chapter will outline the reaction data model present
in the CDK. It will first outline the core data interfaces, and how they can be used.

## A single reaction

A single reaction consists of reacting chemical and the products of the reaction. Optionally, a reaction
can be catalyzed. This idea is captured in the <class>IReaction</class> interface, which directly extends the
<class>IChemObject</class> interface. Let's consider the following reaction:

2 H<sub>3</sub>COH H<sub>3</sub>O<sup>+</sup> H<sub>3</sub>COCH<sub>3</sub> + H<sub>2</sub>O

This reaction between two methanol molecules is catalyzed by acid and results in methoxymethane and
water. To encode this into a CDK data model, we need to set the reaction coefficient, the reactants,
products, and catalyst. The latter is called an agent in the data model. We know how to create molecules
and that will not be repeated here. Given these atom containers, we create this reaction with:

<code>MethanolReaction</code>

This example shows we can set the reaction direction too. We can list the balance directions that
are available by the <class>Direction</class> enum:

<code>ReactionDirections</code>

which returns us these current options:

<out>ReactionDirections</out>

There are matching get methods to access all <topic>reactants</topic> and <topic>products</topic>:

<code>ReactionGetters</code>

This scripts takes advantage of the <class>MolecularFormulaManipulator</class> class (see Section <xref>molecularFormula</xref>)
and outputs the molecular formula of the reactants and products:

<out>ReactionGetters</out>

## Reaction from File

There are a few file formats that can store reaction. This short paragraph will give some quick pointers
which these are, and how files in that format can be read into a data model. The full IO details are
presented in Chapter <xref>io</xref>.

### MDL RXN files

The first, and likely more common format, is the <topic>MDL RXN</topic> file format. This format basically consists of
a special concatenation of MDL molfiles. The <class>MDLRXNReader</class> will read the content from such files into
a <class>IReaction</class> class:

<code>ReactionMDLRXN</code>

From there on, we can easily extract the reaction details:

<out>ReactionMDLRXN</out>

## CMLReact files

There is also a CML extension for reactions [<cite>Q27162658</cite>]. But because CML files can contain a lot
of information, we read an <class>IChemFile</class> from this file, and extract the <class>IReaction</class> from that:

<code>ReactionCMLReact</code>

But once down to the <class>IReaction</class>, we are back in business:

<out>ReactionCMLReact</out>

## References

<references/>

