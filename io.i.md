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
the chemical format of a file. Appendix D
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


## References

<references/>
