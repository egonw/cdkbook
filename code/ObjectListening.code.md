# ObjectListening.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.8')

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
  eEvent[source=AtomContainer(559087077, #A:1, A...
  tomRef{Atom(1566104673, S:C, AtomType(15661046...
  73, FC:0, Isotope(1566104673, Element(15661046...
  73, S:C, AN:6))))})]
Event: org.openscience.cdk.event.ChemObjectChang...
  eEvent[source=Atom(1566104673, S:N, AtomType(1...
  566104673, FC:0, Isotope(1566104673, Element(1...
  566104673, S:N, AN:7))))]
```
