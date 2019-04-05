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
the <a name="tp1">chemical format</a> of a file. Appendix [D.1](appfileformats.md#sec:fileformats)
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
Language [<a href="#citeref1">1</a>,<a href="#citeref2">2</a>] format:

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
Format: SMILES
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

## Input Validation

The history of the CDK project has seen many bug reports about problems
which in fact turned out to be problems with in the input file. While
the general perception seems to be that because files could be written,
the content must be consistent.

However, this is a strong misconception. There are several problems
found in chemical files in the wild. A first common problem is that the
file is not conform the syntax of the specification. An example here
can be that at places where a number is expected, something else is
given; not uncommonly, this is caused by incorrect use of whitespace.

A second problem is that the file looks perfectly reasonable, but that
the software that wrote the file used conventions and extensions that
are not supported by the reading software. A common example is the use
of the D and T symbols, for deuterium and tritium in MDL molfiles,
where the specification does not allow that.

A third problem is that most chemical file formats do not disallow
incorrect chemical graphs. For example, formats often allow to
bind an atom to itself, which will cause problems when analyzing
this graph. These problems are much more rare, though.

<a name="sec:readingModes"></a>
### Reading modes

The [`IChemObjectReader`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/io/IChemObjectReader.html) has a feature that allows setting
a validating mode, which has two values:

**Script** [code/ReadingModes.groovy](code/ReadingModes.code.md)
```groovy
IChemObjectReader.Mode.each {
  println it
}
```

returning:

```plain
RELAXED
STRICT
```

The `STRICT` mode follows the exact format specification. There
`RELAXED` mode allows for a few common extensions, such as
the support for the T and D element types. For example, let's consider
this file:


  CDK

  3  2  0  0  0  0  0  0  0  0999 V2000
    2.5369   -0.1550    0.0000 O   0  0  0  0  0  0  0  0  0  0  0  0
    3.0739    0.1550    0.0000 D   1  0  0  0  0  0  0  0  0  0  0  0
    2.0000    0.1550    0.0000 T   1  0  0  0  0  0  0  0  0  0  0  0
  1  2  1  0  0  0  0
  1  3  1  0  0  0  0
M  ISO   2   2   2   3   3
M  END

If we read this file with:

**Script** [code/ReadStrict.groovy](code/ReadStrict.code.md)
```groovy
reader = new MDLV2000Reader(
  new File("data/t.mol").newReader(),
  Mode.STRICT
);
water = reader.read(new AtomContainer());
println "atom count: $water.atomCount"
```

we get this exception:

```plain
invalid symbol: D
```

However, if we read the file in `RELAXED` mode with this code:

**Script** [code/ReadRelaxed.groovy](code/ReadRelaxed.code.md)
```groovy
reader = new MDLV2000Reader(
  new File("data/t.mol").newReader(),
  Mode.RELAXED
);
water = reader.read(new AtomContainer());
println "atom count: $water.atomCount"
```

the files will be read as desired:

```plain
atom count: 3
```

### Validation

When a file is being read in `RELAXED` mode, it is possible to get
error messages. This functionality is provided by the
[`IChemObjectReaderErrorHandler`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/io/IChemObjectReaderErrorHandler.html) support in
[`IChemObjectReader`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/io/IChemObjectReader.html).
For example, we can define this custom error handler:

**Script** [code/CustomErrorHandler.groovy](code/CustomErrorHandler.code.md)
```groovy
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
}
```

and use that when reading a file:

**Script** [code/ReadErrorHandler.groovy](code/ReadErrorHandler.code.md)
```groovy
reader = new MDLV2000Reader(
  new File("data/t.mol").newReader(),
  Mode.RELAXED
);
reader.setErrorHandler(new ErrorHandler());
water = reader.read(new AtomContainer());
```

we get these warnings via the handler interface:

```plain
```

Because of an issue in version 2.0 of the CDK, the above does not show any warnings.
This has been fixed in CDK 2.3, see [commit 547b028e17656f54a080a885a166377320b3a8ad](https://github.com/cdk/cdk/commit/547b028e17656f54a080a885a166377320b3a8ad).

## Customizing the Output

An interesting feature of file IO in the CDK is that it is customizable. Before
I will give all the details, let's start with a simple example: creating a
<a name="tp2">Gaussian input file</a> for optimizing the structure of methane,
and let's start with an XYZ file, that is, with `methane.xyz`:

```
5
methane
C  0.25700 -0.36300  0.00000
H  0.25700  0.72700  0.00000
H  0.77100 -0.72700  0.89000
H  0.77100 -0.72700 -0.89000
H -0.77100 -0.72700  0.00000
```

The output will look something like:

```
%nprocl=5
# b3lyp/6-31g opt

Job started on Linux cluster on 20041010.

0 1
C 0 0.257 -0.363 0.0
H 0 0.257 0.727 0.0
H 0 0.771 -0.727 0.89
H 0 0.771 -0.727 -0.89
H 0 -0.771 -0.727 0.0

```

The writer used the default IO options in the above example. So, the next step is to see
which options the writer allows. To get a list of options for a certain IO
class in one does something along the lines:

**Script** [code/ListIOOptions.groovy](code/ListIOOptions.code.md)
```groovy
IChemObjectWriter writer = new GaussianInputWriter();
for (IOSetting setting : writer.getIOSettings()) {
  println "[" + setting.getName() + "]"
  println "Option: " + setting.getQuestion()
  println "Current value: " + setting.getSetting()
}
```

which results in the following output:

```plain
[OpenShell]
Option: Should the calculation be open shell?
Current value: false
[Comment]
Option: What comment should be put in the file?
Current value: Created with CDK (http://cdk.sf.n...
  et/)
[Memory]
Option: How much memory do you want to use?
Current value: unset
[Command]
Option: What kind of job do you want to perform?
Current value: energy calculation
[ProcessorCount]
Option: How many processors should be used by Ga...
  ussian?
Current value: 1
```

### Setting Properties

The IO settings system allows interactive setting of these options, but a
perfectly fine alternative is to use a Java Properties object.

Consider the following source code:

**Script** [code/PropertiesSettings.groovy](code/PropertiesSettings.code.md)
```groovy
// the custom settings
Properties customSettings = new Properties();
customSettings.setProperty("Basis",   "6-31g*");
customSettings.setProperty("Command",
  "geometry optimization");
customSettings.setProperty("Comment",
  "Job started on Linux cluster on 20041010.");
customSettings.setProperty("ProcessorCount", "5");
PropertiesListener listener = new PropertiesListener(
  customSettings
);
// create the writer
GaussianInputWriter writer = new GaussianInputWriter(
  new FileWriter(new File("methane.gin"))
);
writer.addChemObjectIOListener(listener);
XYZReader reader = new XYZReader(
  new FileReader(new File("data/methane.xyz"))
);
// convert the file
ChemFile content = (ChemFile)reader.read(new ChemFile());
IAtomContainer molecule = content.getChemSequence(0).
  getChemModel(0).getMoleculeSet().getAtomContainer(0);
writer.write(molecule);
writer.close();
```

The `PropertiesListener` takes a `Properties` class as parameter in
its constructor. Therefore, the properties are defined by the
`customSettings` variable in the first few lines. The
`PropertiesListener` `listener` is the instantiated with the
customizations as constructor parameter.

The output writer, specified to write to the `methane.gin` file, is
created after which the `ChemObjectIOListener` is set. Only by setting
this listener, the output will be customized with the earlier defined
properties. The rest of the code reads a molecule from an XYZ file and writes
the `content` to the created Gaussian Input file.

## Example: creating unit tests for atom type perception

We saw earlier an example for reading files directly from PubChem
(see Section XX).
This can be conveniently used to create `CDK source code`, for example,
for use in unit tests for the atom type perception code (see
Section XX). But because we do not want
2D and 3D coordinates being set in the source code, we disable those
options:

**Script** [code/AtomTypeUnitTest.groovy](code/AtomTypeUnitTest.code.md)
```groovy
cid = 3396560
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
```

This results in this source code:

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

## References

1. <a name="citeref1"></a>Murray-Rust P, Rzepa HS. Chemical Markup, XML, and the Worldwide Web. 1. Basic Principles. Journal of Chemical Information and Modeling. 1999 Jan 1;39(6):928–42.  doi:[10.1021/CI990052B](https://doi.org/10.1021/CI990052B)
2. <a name="citeref2"></a>Willighagen E. Processing CML conventions in Java. Internet Journal of Chemistry [Internet]. 2001 Jan 1;4:4. Available from: https://zenodo.org/record/1495470 doi:[10.5281/zenodo.1495470](https://doi.org/10.5281/zenodo.1495470)

