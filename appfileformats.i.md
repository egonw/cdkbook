<section label="fileformats" level="##">File Formats</section>

This appendix lists of file formats the CDK knows about. For each format, it indicated if
the CDK has a reader (R) and/or a writer (W) for it. It also indicates which formats can
be detected from the file content. Chemical file format definitions implementations in
the CDK implement the <class>IChemFormatMatcher</class> class for that.

This script was used to create this list:

<code>ListAllFileFormats</code>

<table>
<tr>
  <td><b>Read/Write</b></td>
  <td><b>Matcher</b></td>
  <td><b>File Format</b></td>
</tr>
<in>fileformatlist.md</in>
</table>

## The Readers and Writers

Additionally, for all formats we can list information about the readers and writers, again
by iterating over all formats:

<code>ListAllIOClassesByFormat</code>

<input>ioclasseslist.md</input>
