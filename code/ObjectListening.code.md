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
Event: org.openscience.cdk.event.ChemObjectChangeEvent[source=AtomContainer(73...
  4370487, #A:1, AtomRef{Atom(1091523506, S:C, AtomType(1091523506, FC:0, Isot...
  ope(1091523506, Element(1091523506, S:C, AN:6))))})]
Event: org.openscience.cdk.event.ChemObjectChangeEvent[source=Atom(1091523506,...
   S:N, AtomType(1091523506, FC:0, Isotope(1091523506, Element(1091523506, S:N...
  , AN:7))))]
```
