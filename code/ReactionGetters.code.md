# ReactionGetters.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.11')

import org.openscience.cdk.interfaces.*;
import org.openscience.cdk.smiles.*;
import org.openscience.cdk.silent.*;
import org.openscience.cdk.tools.*;
import org.openscience.cdk.tools.manipulator.*;
import org.openscience.cdk.*;
parser = new SmilesParser(SilentChemObjectBuilder.getInstance())
hAdder = CDKHydrogenAdder.getInstance(SilentChemObjectBuilder.getInstance())
methanol = parser.parseSmiles("CO")
AtomContainerManipulator.percieveAtomTypesAndConfigureAtoms(methanol)
hAdder.addImplicitHydrogens(methanol)
AtomContainerManipulator.convertImplicitToExplicitHydrogens(methanol)
dimethoxymethane = parser.parseSmiles("COC")
AtomContainerManipulator.percieveAtomTypesAndConfigureAtoms(dimethoxymethane)
hAdder.addImplicitHydrogens(dimethoxymethane)
AtomContainerManipulator.convertImplicitToExplicitHydrogens(dimethoxymethane)
water = parser.parseSmiles("O")
AtomContainerManipulator.percieveAtomTypesAndConfigureAtoms(water)
hAdder.addImplicitHydrogens(water)
AtomContainerManipulator.convertImplicitToExplicitHydrogens(water)
reaction = new Reaction()
reaction.addReactant(methanol, (double)2.0)
reaction.addProduct(dimethoxymethane)
reaction.addProduct(water)
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
**Output:**
```plain
Reactants: 
CH4O
Products: 
C2H6O
H2O
```
