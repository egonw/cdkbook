# ObjectListening.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.9')

import org.openscience.cdk.interfaces.*;
import org.openscience.cdk.*;

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
**Output:**
```plain
Event: org.openscience.cdk.event.ChemObjectChangeEvent[source=AtomContainer(18...
  69571492, #A:1, AtomRef{Atom(160479339, S:C, AtomType(160479339, FC:0, Isoto...
  pe(160479339, Element(160479339, S:C, AN:6))))})]
Event: org.openscience.cdk.event.ChemObjectChangeEvent[source=Atom(160479339, ...
  S:N, AtomType(160479339, FC:0, Isotope(160479339, Element(160479339, S:N, AN...
  :7))))]
```
