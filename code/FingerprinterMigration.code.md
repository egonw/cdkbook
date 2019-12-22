# FingerprinterMigration.java
**Source code:**
```java
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='%CDKVERSION%')
import java.util.BitSet;
import java.util.Map;
import java.util.HashMap;
import org.openscience.cdk.interfaces.IAtomContainer;
import org.openscience.cdk.interfaces.IAtom;
import org.openscience.cdk.exception.CDKException;
import org.openscience.cdk.fingerprint.IFingerprinter;
import org.openscience.cdk.fingerprint.ICountFingerprint;
import org.openscience.cdk.fingerprint.IBitFingerprint;
import org.openscience.cdk.fingerprint.IntArrayCountFingerprint;
import org.openscience.cdk.fingerprint.BitSetFingerprint;


public class FingerprinterMigration implements IFingerprinter {

  Map<String,Integer> map = new HashMap<String,Integer>() {{
    put("C", 1);
    put("N", 2);
    put("O", 3);
  }};

  public BitSet getFingerprint(IAtomContainer molecule) {
    BitSet bitSet = new BitSet(getSize());
    for (IAtom atom : molecule.atoms()) {
      if (map.containsKey(atom.getSymbol()))
        bitSet.set(map.get(atom.getSymbol()));
   }
    return bitSet;
  }

  public Map<String,Integer> getRawFingerprint(
    IAtomContainer molecule
  ) {
    Map<String,Integer> fingerprint =
      new HashMap<String,Integer>();
    for (String key : map.keySet()) {
      fingerprint.put(key, 0);
    }
    for (IAtom atom : molecule.atoms()) {
      int count = map.get(atom.getSymbol());
      fingerprint.put(atom.getSymbol(), count+1);
    }
    return fingerprint;
  }

  public ICountFingerprint getCountFingerprint(
    IAtomContainer molecule
  ) throws CDKException {
    return new IntArrayCountFingerprint(
      getRawFingerprint(molecule)
    );
  }
  public IBitFingerprint getBitFingerprint(
    IAtomContainer molecule
  ) throws CDKException {
    return new BitSetFingerprint(
      getFingerprint(molecule)
    );
  }

  public int getSize() {
    return 3;
  }

 public static void main(String[] args) {}

 public String getVersionDescription() { return ""; }
}
```
**Output:**
```plain
```
