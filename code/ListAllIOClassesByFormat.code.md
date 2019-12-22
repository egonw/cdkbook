# ListAllIOClassesByFormat.groovy
**Source code:**
```groovy
@Grab(group='org.openscience.cdk', module='cdk-bundle', version='2.3')

import org.openscience.cdk.io.*;
import org.openscience.cdk.io.formats.*;
import org.openscience.cdk.interfaces.*;
import org.openscience.cdk.isomorphism.matchers.RGroupQuery;
import org.openscience.cdk.*;
import org.openscience.cdk.*;
import java.util.*;
import java.lang.reflect.Method;

output = new File("../ioclasseslist.i.md")
output.text = ""

classes = [ ChemFile.class, AtomContainer.class ]
optional = [ ChemSequence.class, Reaction.class, ReactionSet.class, RGroupQuery.class,
             Crystal.class]

formats = new ArrayList<IChemFormat>();
reader =
  this.getClass().getClassLoader().getResourceAsStream(
    "io-formats.set"
  )
reader.eachLine { formatName ->
  try {
    Class<? extends Object> formatClass =
      this.getClass().getClassLoader().loadClass(formatName);
    Method getinstanceMethod =
      formatClass.getMethod("getInstance", new Class[0]);
    format = getinstanceMethod.invoke(null, new Object[0]);
    formats.add(format);
  } catch (ClassNotFoundException exception) {
  } catch (Exception exception) {
  }
}
formats.sort{ it.formatName }

for (format in formats) {
  if (format instanceof IChemFormat &&
      (format.getReaderClassName() != null ||
       format.getWriterClassName() != null)) {
    output.append(
      "## " + format.formatName + "\n"
    )
    // output some further format details
   if (format.nameExtensions.length > 1)
     output.append("**Extensions**: " + format.nameExtensions + "\n")
   if (format.preferredNameExtension != null)
     output.append("**Preferred Extension**: " + format.preferredNameExtension + "\n")
   if (format.getMIMEType() != null)
     output.append("**MIME type**: " + format.getMIMEType() + "\n")
   output.append("**XML Based?**: " + (format.isXMLBased() ? "Yes" : "No") + "\n")
    if (format.readerClassName != null) {
      reader = format.readerClassName.substring(
        format.readerClassName.lastIndexOf(".") + 1
      )
      output.append(
        "### <topic type=\"class\">" + reader + "</topic>\n"
      )
     ioClass = Class.forName(format.readerClassName).newInstance()
     output.append("This reader supports these data objects:\n")
     output.append("<table>\n")
     output.append("<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>\n")
     for (clazz in classes) {
       clazzName = clazz.name.substring(clazz.name.indexOf("cdk.")+4)
       output.append(
         "<tr><td>" + clazzName + "</td><td>" +
         ioClass.accepts(clazz) +
         "</td></tr>\n"
       )
     }
     for (clazz in optional) {
       clazzName = clazz.name.substring(clazz.name.indexOf("cdk.")+4)
       if (ioClass.accepts(clazz))
       output.append(
         "<tr><td>" + clazzName + "</td><td>true</td></tr>\n"
       )
     }
     output.append("</table>\n");
     settings = ioClass.getIOSettings()
     if (settings != null && settings.length > 0) {
       output.append("This reader has these IO settings:\n")
       output.append("<table>\n")
       output.append("<tr><td><b>Name</b></td><td><b>Desc</b></td></tr>\n")
       for (setting in settings) {
         if (setting == null) {
         } else {
           output.append("<tr>\n")
           output.append("  <td>" + (setting.name != null ? setting.name : "") + "</td>\n  <td>")
           output.append((setting.question != null ? setting.question : ""))
           output.append((setting.defaultSetting != null ? " [Default: " + setting.defaultSetting + "]" : ""))
           output.append("</td></tr>\n")
         }
       }
       output.append("</table>\n")
     }
    }
    if (format.writerClassName != null) {
      writer = format.writerClassName.substring(
        format.writerClassName.lastIndexOf(".") + 1
      )
      output.append(
        "### <topic type=\"class\">" + writer + "</topic>\n"
      )
     ioClass = Class.forName(format.writerClassName).newInstance()
     output.append("This writer supports these data objects:\n")
     output.append("<table>\n")
     output.append("<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>\n")
     for (clazz in classes) {
       clazzName = clazz.name.substring(clazz.name.indexOf("cdk.")+4)
       output.append(
         "<tr><td>" + clazzName + "</td><td>" +
         ioClass.accepts(clazz) +
         "</td></tr>\n"
       )
     }
     for (clazz in optional) {
       clazzName = clazz.name.substring(clazz.name.indexOf("cdk.")+4)
       if (ioClass.accepts(clazz))
       output.append(
         "<tr><td>" + clazzName + "</td><td>true</td></tr>\n"
       )
     }
     output.append("</table>\n");
     settings = ioClass.getIOSettings()
     if (settings != null && settings.length > 0) {
       output.append("This writer has these IO settings:\n")
       output.append("<table>\n")
       output.append("<tr><td><b>Name</b></td><td><b>Desc</b></td></tr>\n")
       for (setting in settings) {
         if (setting == null) {
         } else {
           output.append("<tr>\n")
           output.append("  <td>" + (setting.name != null ? setting.name : "") + "</td>\n  <td>")
           output.append((setting.question != null ? setting.question : ""))
           output.append((setting.defaultSetting != null ? " [Default: " + setting.defaultSetting + "]" : ""))
           output.append("</td></tr>\n")
         }
       }
       output.append("</table>\n")
     }
    }
  }
}
```
**Output:**
```plain
```
