# ObjectListening.groovy
**Source code:**
```groovy
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
  eEvent[source=AtomContainer(1613095350, #A:1, ...
  Atom(587153993, S:C, H:0, AtomType(587153993, ...
  FC:0, Isotope(587153993, Element(587153993, S:...
  C, AN:6)))))]
Event: org.openscience.cdk.event.ChemObjectChang...
  eEvent[source=Atom(587153993, S:N, H:0, AtomTy...
  pe(587153993, FC:0, Isotope(587153993, Element...
  (587153993, S:N, AN:6))))]
```
