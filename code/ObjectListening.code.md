# ObjectListening.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.7.1')

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
Event: org.openscience.cdk.event.ChemObjectChang...
  eEvent[source=AtomContainer(166788150, #A:1, A...
  tomRef{Atom(104803851, S:C, AtomType(104803851...
  , FC:0, Isotope(104803851, Element(104803851, ...
  S:C, AN:6))))})]
Event: org.openscience.cdk.event.ChemObjectChang...
  eEvent[source=Atom(104803851, S:N, AtomType(10...
  4803851, FC:0, Isotope(104803851, Element(1048...
  03851, S:N, AN:7))))]
```
