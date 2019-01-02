# Input/Output

The CDK has functionality for extracting information from files in many
different file formats. Unfortunately, hardly ever the full format
specification is supported, but generally the chemical graph and 2D or 3D
coordinates are extracted, not uncommonly complemented with formal or partial
charge.

## File Format Detection

Typically, a human is fairly aware about the format of a file, if he looks
at a file. Very often, the file extension (which is hidden on many Microsoft
Windows versions by default) gives a clear clue. Files with the .mol and .sdf
extension are very likely to have one of the MDL formats. If the file 
extension is ambiguous, a trained cheminformatician can often help you out
quickly, applying tacit knowledge about those formats.

Computer programs, however, cannot rely on file formats, and have to
formalize rules for inspecting the file content to determine what file format
it is. The CDK has such functionality available for recognizing chemical
file formats. But, to ensure no false detections are made, it
requires a fairly accurate method for detecting
the <a name="tp1">chemical format</a> of a file. Appendix D
provides a list of all chemical file formats the CDK knows about.

Programmatically, the format of a file can be detected using the
`FormatFactory`:

**Script** [code/GuessFormat.groovy](code/GuessFormat.code.md)
```groovy
Reader stringReader = new StringReader(
  "<molecule xmlns='http://www.xml-cml.org/schema'/>"
);
FormatFactory factory = new FormatFactory();
IChemFormat format = factory.guessFormat(stringReader);
System.out.println("Format: " + format.getFormatName());
```

For example, this script recognizes that a file has the Chemical Markup
Language [1,2] format:

```plain
Format: Chemical Markup Language
```

To learn if the CDK has a `IChemObjectReader` or
`IChemObjectWriter` for a format, one can use the methods `getReaderClassName()`
and `getWriterClassName()` respectively:

**Script** [code/HasReaderOrWriter.groovy](code/HasReaderOrWriter.code.md)
```groovy
Reader stringReader = new StringReader(
  "<molecule xmlns='http://www.xml-cml.org/schema'/>"
);
IChemFormat format = factory.guessFormat(stringReader);
String readerClass = format.getReaderClassName();
String writerClass = format.getWriterClassName();
System.out.println("Reader: " + readerClass);
System.out.println("Writer: " + writerClass);
```

It reports:

```plain
Reader: org.openscience.cdk.io.CMLReader
Writer: org.openscience.cdk.io.CMLWriter
```

### Custom format matchers

The SMILES format is one of the few formats which does not have a matcher.
This is because there is no generally accepted file format based on this
line notation.

However, we can define a custom matcher ourselves and use that. First,
the matcher will look something like:

**Script** [code/SMILESFormatMatcher.java](code/SMILESFormatMatcher.code.md)
```java
public class SMILESFormatMatcher
  extends SMILESFormat
  implements IChemFormatMatcher {
  private static IResourceFormat instance = null;
  private SmilesParser parser = null;
  public SMILESFormatMatcher() {
    parser = new SmilesParser(
      SilentChemObjectBuilder.getInstance()
    );
  }
  public static IResourceFormat getInstance() {
    if (instance == null)
      instance = new SMILESFormatMatcher();
    return instance;
  }
  public boolean matches(int lineNumber, String line) {
    if (lineNumber == 1) {
      String[] parts = line.split(" ");
      if (parts.length == 2) {
        String smiles = parts[0];
        String name = parts[1]; // not used here
        try {
          parser.parseSmiles(smiles);
          return true;
        } catch (InvalidSmilesException exception) {}
      }
    }
    return false;
  }
  public final MatchResult matches(final List<String> lines) {
    if (lines.get(0) != null && matches(1, lines.get(0))) {
      return new MatchResult(
        true,
        (IChemFormat)SMILESFormat.getInstance(),
        new Integer(1)
      );
    }
    return new MatchResult(false, null, Integer.MAX_VALUE);
  }
}
```

If we then register this new matcher with the `FormatFactory`:

**Script** [code/GuessSMILES.groovy](code/GuessSMILES.code.md)
```groovy
Reader stringReader = new StringReader(
  "O=CN formamide\n" +
  "OCC ethanol\n"
);
FormatFactory factory = new FormatFactory();
factory.registerFormat(SMILESFormatMatcher.getInstance());
IChemFormat format = factory.guessFormat(stringReader);
System.out.println("Format: " + format.getFormatName());
```

And with this, we can detect a file with SMILES strings and names:

```plain
```

Keep in mind that the more specific your custom matcher is, the lower
the change of other formats accidentally recognized by your custom matcher.

REINSERT TABLE

## Reading from Readers and InputStreams

Many input readers in the CDK allow reading from a Java `Reader` class,
but all are required to also read from an `InputStream`. The difference
between these two Java classes is that the Reader is based on a character
stream, while an InputStream is based on an byte stream. For some readers this
difference is crucial: processing an XML based format, such as CML and XML
formats used by PubChem should be read from an InputStream, not a Reader.

For other formats, it does not matter. This allows, for example, to read
a file easily from a string with a `StringReader`
(mind the newlines indicated by `\n`):

**Script** [code/InputFromStringReader.groovy](code/InputFromStringReader.code.md)
```groovy
String bf3 = "4\n" +
"Bortrifluorid\n" +
"B    0.0000    0.0000    0.0000\n" +
"F    1.0000    0.0000    0.0000\n" +
"F   -0.5000   -0.8660    0.0000\n" +
"F   -0.5000    0.8660    0.0000\n";
reader = new XYZReader(
  new StringReader(bf3)
)
chemfile = reader.read(new ChemFile())
mol = ChemFileManipulator.getAllAtomContainers(chemfile)
  .get(0)
println "Atom count: $mol.atomCount"
```

But besides reading XML files correctly, the support for InputStream also allows
reading files directly from the internet and from gzipped files (see
Section XX.

## References

1. Murray-Rust P, Rzepa HS. Chemical Markup, XML, and the Worldwide Web. 1. Basic Principles. Journal of Chemical Information and Modeling. 1999 Jan 1;39(6):928–42. 
2. Willighagen E. Processing CML conventions in Java. Internet Journal of Chemistry [Internet]. 2001 Jan 1;4:4. Available from: https://zenodo.org/record/1495470

