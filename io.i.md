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
the <topic>chemical format</topic> of a file. Appendix <xref>fileformats</xref>
provides a list of all chemical file formats the CDK knows about.

Programmatically, the format of a file can be detected using the
`FormatFactory`:

<code>GuessFormat</code>

For example, this script recognizes that a file has the Chemical Markup
Language [<cite>Q27783585</cite>,<cite>Q27211680</cite>] format:

<out>GuessFormat</out>

To learn if the CDK has a `IChemObjectReader` or
`IChemObjectWriter` for a format, one can use the methods `getReaderClassName()`
and `getWriterClassName()` respectively:

<code>HasReaderOrWriter</code>

It reports:

<out>HasReaderOrWriter</out>

### Custom format matchers

The SMILES format is one of the few formats which does not have a matcher.
This is because there is no generally accepted file format based on this
line notation.

However, we can define a custom matcher ourselves and use that. First,
the matcher will look something like:

<code>SMILESFormatMatcher</code>

If we then register this new matcher with the `FormatFactory`:

<code>GuessSMILES</code>

And with this, we can detect a file with SMILES strings and names:

<out>GuessSMILES</out>

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

<code>InputFromStringReader</code>

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

<section level="###" label="readingModes">Reading modes</section>

The <class type="topic">IChemObjectReader</class> has a feature that allows setting
a validating mode, which has two values:

<code>ReadingModes</code>

returning:

<out>ReadingModes</out>

The `STRICT` mode follows the exact format specification. There
`RELAXED` mode allows for a few common extensions, such as
the support for the T and D element types. For example, let's consider
this file:

<in type="verbatim">code/data/t.mol</in>

If we read this file with:

<code>ReadStrict</code>

we get this exception:

<out>ReadStrict</out>

However, if we read the file in `RELAXED` mode with this code:

<code>ReadRelaxed</code>

the files will be read as desired:

<out>ReadRelaxed</out>

### Validation

When a file is being read in `RELAXED` mode, it is possible to get
error messages. This functionality is provided by the
<class type="topic">IChemObjectReaderErrorHandler</class> support in
<class>IChemObjectReader</class>.
For example, we can define this custom error handler:

<code>CustomErrorHandler</code>

and use that when reading a file:

<code>ReadErrorHandler</code>

we get these warnings via the handler interface:

<out>ReadErrorHandler</out>

Because of an issue in version 2.0 of the CDK, the above does not show any warnings.
This has been fixed in CDK 2.3, see [commit 547b028e17656f54a080a885a166377320b3a8ad](https://github.com/cdk/cdk/commit/547b028e17656f54a080a885a166377320b3a8ad).

## Customizing the Output

An interesting feature of file IO in the CDK is that it is customizable. Before
I will give all the details, let's start with a simple example: creating a
<topic>Gaussian input file</topic> for optimizing the structure of methane,
and let's start with an XYZ file, that is, with `methane.xyz`:

```
<in>code/data/methane.xyz</in>
```

The output will look something like:

```
<in>code/methane.gin</in>
```

The writer used the default IO options in the above example. So, the next step is to see
which options the writer allows. To get a list of options for a certain IO
class in one does something along the lines:

<code>ListIOOptions</code>

which results in the following output:

<out>ListIOOptions</out>

### Setting Properties

The IO settings system allows interactive setting of these options, but a
perfectly fine alternative is to use a Java Properties object.

Consider the following source code:

<code>PropertiesSettings</code>

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

<code>AtomTypeUnitTest</code>

This results in this source code:

<out>AtomTypeUnitTest</out>

## References

<references/>
