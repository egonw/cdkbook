# ReadErrorHandler.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.11')

import org.openscience.cdk.interfaces.*;
import org.openscience.cdk.io.*;
import org.openscience.cdk.*;
import org.openscience.cdk.io.IChemObjectReader.Mode;
import org.openscience.cdk.io.listener.*;
import org.openscience.cdk.io.setting.*;
import java.io.File;

class ErrorHandler
implements IChemObjectReaderErrorHandler {
  public void handleError(String message) {
    println message;
  };
  public void handleError(String message,
    Exception exception)
  {
    println message + "\n  -> " +
            exception.getMessage();
  };
  public void handleError(String message,
    int row, int colStart, int colEnd)
  {
    print "location: " + row + ", " + 
          colStart + "-" + colEnd + ": ";
    println message;
  };
  public void handleError(String message,
    int row, int colStart, int colEnd,
    Exception exception)
  {
    print "location: " + row + ", " +
          colStart + "-" + colEnd + ": "
    println message + "\n  -> " +
            exception.getMessage()
  };
  public void handleFatalError(String message)
  {
    println "FATAL: " + message;
  };
  public void handleFatalError(String message,
    Exception exception) {
    println "FATAL: " + message + "\n  -> " +
            exception.getMessage();
  };
  public void handleFatalError(String message,
    int row, int colStart, int colEnd) {
    print "FATAL at location: " + row + ", " +
          colStart + "-" + colEnd + ": ";
    println message;
  };
  public void handleFatalError(String message,
    int row, int colStart, int colEnd,
    Exception exception) {
    print "FATAL at location: " + row + ", " +
          colStart + "-" + colEnd + ": "
    println message + "\n  -> " +
            exception.getMessage()
  };
}
reader = new MDLV2000Reader(
  new File("data/t.mol").newReader(),
  Mode.RELAXED
);
Properties customSettings = new Properties();
customSettings.setProperty(
  "InterpretHydrogenIsotopes", "false"
);
PropertiesListener listener = new PropertiesListener(
  customSettings
);
reader.addChemObjectIOListener(listener);
reader.setErrorHandler(new ErrorHandler());
water = reader.read(new AtomContainer());
```
**Output:**
```plain
location: 6, 31-33: invalid symbol: D
location: 7, 31-33: invalid symbol: T
```
