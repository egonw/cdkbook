# AtomTypeUnitTest.groovy
**Source code:**
```groovy
import java.net.UnknownHostException;
import org.openscience.cdk.silent.*;
import org.openscience.cdk.io.*;
import org.openscience.cdk.io.listener.*;


cid = 3396560

if (args.length == 1) cid = args[0]

try {
reader = new PCCompoundXMLReader(
  new URL(
    "https://pubchem.ncbi.nlm.nih.gov/summary/" +
    "summary.cgi?cid=$cid&disopt=SaveXML"
  ).newInputStream()
)
mol = reader.read(new AtomContainer())
stringWriter = new StringWriter();
CDKSourceCodeWriter writer =
  new CDKSourceCodeWriter(stringWriter);
customSettings = new Properties();
customSettings.setProperty("write2DCoordinates", "false");
customSettings.setProperty("write3DCoordinates", "false");
writer.addChemObjectIOListener(
  new PropertiesListener(
    customSettings
  )
)
writer.write(mol);
writer.close();
println stringWriter.toString();
} catch (UnknownHostException exception) {
  println "FIXME: compiled without internet connection"
}
```
**Output:**
```plain
{
  IChemObjectBuilder builder = DefaultChemObject...
  Builder.getInstance();
  IAtomContainer mol = builder.newInstance(IAtom...
  Container.class);
  IAtom a1 = builder.newInstance(IAtom.class,"P");
  a1.setFormalCharge(0);
  mol.addAtom(a1);
  IAtom a2 = builder.newInstance(IAtom.class,"O");
  a2.setFormalCharge(0);
  mol.addAtom(a2);
  IAtom a3 = builder.newInstance(IAtom.class,"O");
  a3.setFormalCharge(0);
  mol.addAtom(a3);
  IAtom a4 = builder.newInstance(IAtom.class,"C");
  a4.setFormalCharge(0);
  mol.addAtom(a4);
  IAtom a5 = builder.newInstance(IAtom.class,"H");
  a5.setFormalCharge(0);
  mol.addAtom(a5);
  IAtom a6 = builder.newInstance(IAtom.class,"H");
  a6.setFormalCharge(0);
  mol.addAtom(a6);
  IAtom a7 = builder.newInstance(IAtom.class,"H");
  a7.setFormalCharge(0);
  mol.addAtom(a7);
  IAtom a8 = builder.newInstance(IAtom.class,"H");
  a8.setFormalCharge(0);
  mol.addAtom(a8);
  IAtom a9 = builder.newInstance(IAtom.class,"H");
  a9.setFormalCharge(0);
  mol.addAtom(a9);
  IBond b1 = builder.newInstance(IBond.class,a1,...
   a2, IBond.Order.SINGLE);
  mol.addBond(b1);
  IBond b2 = builder.newInstance(IBond.class,a1,...
   a3, IBond.Order.DOUBLE);
  mol.addBond(b2);
  IBond b3 = builder.newInstance(IBond.class,a1,...
   a4, IBond.Order.SINGLE);
  mol.addBond(b3);
  IBond b4 = builder.newInstance(IBond.class,a1,...
   a5, IBond.Order.SINGLE);
  mol.addBond(b4);
  IBond b5 = builder.newInstance(IBond.class,a2,...
   a9, IBond.Order.SINGLE);
  mol.addBond(b5);
  IBond b6 = builder.newInstance(IBond.class,a4,...
   a6, IBond.Order.SINGLE);
  mol.addBond(b6);
  IBond b7 = builder.newInstance(IBond.class,a4,...
   a7, IBond.Order.SINGLE);
  mol.addBond(b7);
  IBond b8 = builder.newInstance(IBond.class,a4,...
   a8, IBond.Order.SINGLE);
  mol.addBond(b8);
}

```
