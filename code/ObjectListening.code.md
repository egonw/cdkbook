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
  eEvent[source=AtomContainer(1136419747, #A:1, ...
  Atom(1881561036, S:C, H:0, AtomType(1881561036...
  , FC:0, Isotope(1881561036, Element(1881561036...
  , S:C, AN:6)))))]
Event: org.openscience.cdk.event.ChemObjectChang...
  eEvent[source=Atom(1881561036, S:N, H:0, AtomT...
  ype(1881561036, FC:0, Isotope(1881561036, Elem...
  ent(1881561036, S:N, AN:6))))]
```
