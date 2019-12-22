# ObjectListening.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.3')

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
  eEvent[source=AtomContainer(1789282489, #A:1, ...
  AtomRef{Atom(600199331, S:C, AtomType(60019933...
  1, FC:0, Isotope(600199331, Element(600199331,...
   S:C, AN:6))))})]
Event: org.openscience.cdk.event.ChemObjectChang...
  eEvent[source=Atom(600199331, S:N, AtomType(60...
  0199331, FC:0, Isotope(600199331, Element(6001...
  99331, S:N, AN:7))))]
```
