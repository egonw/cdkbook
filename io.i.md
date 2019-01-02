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
the <topic>chemical format</topic> of a file. Appendix D
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

## References

<references/>
