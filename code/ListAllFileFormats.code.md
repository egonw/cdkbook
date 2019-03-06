# ListAllFileFormats.groovy
**Source code:**
```groovy
import org.openscience.cdk.io.*;
import org.openscience.cdk.io.formats.*;
import org.openscience.cdk.*;
import java.util.*;
import java.lang.reflect.Method;

output = new File("../fileformatlist.md")
output.text = ""
formats = new ArrayList<IChemFormat>();
reader =
  this.getClass().getClassLoader().getResourceAsStream(
    "io-formats.set"
  )
reader.eachLine { formatName ->
  try {
    Class<? extends Object> formatClass =
      this.getClass().getClassLoader().
        loadClass(formatName);
    Method getinstanceMethod =
      formatClass.getMethod(
        "getInstance", new Class[0]
      );
    format = getinstanceMethod.invoke(
      null, new Object[0]
    );
    formats.add(format);
  } catch (ClassNotFoundException exception) {
  } catch (Exception exception) {
  }
}
formats.sort{ it.formatName }
for (format in formats) {
 output.append("<tr>\n  <td>")
  if (format instanceof IChemFormat &&
      format.getReaderClassName() != null) {
    output.append("R");
  }
  if (format instanceof IChemFormat &&
      format.getWriterClassName() != null) {
    output.append("W");
  }
 output.append("</td>\n  <td>")
  if (format instanceof IChemFormatMatcher) {
    output.append("M");
  }
 output.append("</td>\n  <td>")
  output.append(format.getFormatName())
  output.append("</td>\n</tr>\n")
}
```
**Output:**
```plain
```
