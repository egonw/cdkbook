# Reactions

Reactions are fundamental events in chemistry, biochemistry, and thus in life. As such, a cheminformatics
toolkit cannot do without a <a name="tp1">reaction</a> framework. This chapter will outline the reaction data model present
in the CDK. It will first outline the core data interfaces, and how they can be used.

## A single reaction

A single reaction consists of reacting chemical and the products of the reaction. Optionally, a reaction
can be catalyzed. This idea is captured in the [`IReaction`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/interfaces/IReaction.html) interface, which directly extends the
[`IChemObject`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/interfaces/IChemObject.html) interface. Let's consider the following reaction:

2 H<sub>3</sub>COH H<sub>3</sub>O<sup>+</sup> H<sub>3</sub>COCH<sub>3</sub> + H<sub>2</sub>O

This reaction between two methanol molecules is catalyzed by acid and results in methoxymethane and
water. To encode this into a CDK data model, we need to set the reaction coefficient, the reactants,
products, and catalyst. The latter is called an agent in the data model. We know how to create molecules
and that will not be repeated here. Given these atom containers, we create this reaction with:

**<a name="script:MethanolReaction">Script 8.1</a>** [code/MethanolReaction.groovy](code/MethanolReaction.code.md)
```groovy
reaction = new Reaction()
reaction.addReactant(methanol, (double)2.0)
reaction.setDirection(IReaction.Direction.FORWARD)
reaction.addAgent(acid)
reaction.addProduct(dimethoxymethane)
reaction.addProduct(water)
```

This example shows we can set the reaction direction too. We can list the balance directions that
are available by the `Direction` enum:

**<a name="script:ReactionDirections">Script 8.2</a>** [code/ReactionDirections.groovy](code/ReactionDirections.code.md)
```groovy
IReaction.Direction.each {
  println it
}
```

which returns us these current options:

```plain
FORWARD
BACKWARD
BIDIRECTIONAL
NO_GO
RETRO_SYNTHETIC
RESONANCE
```

There are matching get methods to access all <a name="tp2">reactants</a> and <a name="tp3">products</a>:

**<a name="script:ReactionGetters">Script 8.3</a>** [code/ReactionGetters.groovy](code/ReactionGetters.code.md)
```groovy
println "Reactants: "
for (reactant in reaction.reactants.atomContainers()) {
  formula = MolecularFormulaManipulator
    .getMolecularFormula(reactant)
  println MolecularFormulaManipulator
    .getString(formula)    
}
println "Products: "
for (product in reaction.products.atomContainers()) {
  formula = MolecularFormulaManipulator
    .getMolecularFormula(product)
  println MolecularFormulaManipulator
    .getString(formula)
}
```

This scripts takes advantage of the [`MolecularFormulaManipulator`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/tools/manipulator/MolecularFormulaManipulator.html) class (see Section [4.4](atomsbonds.md#sec:molecularFormula))
and outputs the molecular formula of the reactants and products:

```plain
Reactants: 
CH4O
Products: 
C2H6O
H2O
```

## Reaction from File

There are a few file formats that can store reaction. This short paragraph will give some quick pointers
which these are, and how files in that format can be read into a data model. The full IO details are
presented in Chapter [12](io.md#sec:io).

### MDL RXN files

The first, and likely more common format, is the <a name="tp4">MDL RXN</a> file format. This format basically consists of
a special concatenation of MDL molfiles. The [`MDLRXNReader`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/io/MDLRXNReader.html) will read the content from such files into
a [`IReaction`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/interfaces/IReaction.html) class:

**<a name="script:ReactionMDLRXN">Script 8.4</a>** [code/ReactionMDLRXN.groovy](code/ReactionMDLRXN.code.md)
```groovy
MDLRXNReader reader = new MDLRXNReader(
  new File("data/anie.201203222.rxn").newReader()
);
IReaction reaction = new Reaction();
reaction = reader.read(reaction);
reader.close();
println "Reactants: " + reaction.reactants.atomContainerCount
println "Products: " + reaction.products.atomContainerCount
```

From there on, we can easily extract the reaction details:

```plain
Reactants: 1
Products: 1
```

## CMLReact files

There is also a CML extension for reactions [<a href="#citeref1">1</a>]. But because CML files can contain a lot
of information, we read an [`IChemFile`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/interfaces/IChemFile.html) from this file, and extract the [`IReaction`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/interfaces/IReaction.html) from that:

**<a name="script:ReactionCMLReact">Script 8.5</a>** [code/ReactionCMLReact.groovy](code/ReactionCMLReact.code.md)
```groovy
CMLReader reader = new CMLReader(
  new File("data/anie.201203222.cml").newInputStream()
);
IChemFile file = new ChemFile();
reaction = reader.read(file);
reader.close();
sequence = file.getChemSequence(0)
model = sequence.getChemModel(0)
reactions = model.getReactionSet()
reaction = reactions.getReaction(0)
println "Reactants: " + reaction.reactants.atomContainerCount
println "Products: " + reaction.products.atomContainerCount
```

But once down to the [`IReaction`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/interfaces/IReaction.html), we are back in business:

```plain
Reactants: 1
Products: 1
```

## References

1. <a name="citeref1"></a>Holliday GL, Murray-Rust P, Rzepa HS. Chemical Markup, XML, and the World Wide Web. 6. CMLReact, an XML Vocabulary for Chemical Reactions. JCIM. 2006 Jan;46(1):145–57.  doi:[10.1021/CI0502698](https://doi.org/10.1021/CI0502698) ([Scholia](https://scholia.toolforge.org/doi/10.1021/CI0502698))


