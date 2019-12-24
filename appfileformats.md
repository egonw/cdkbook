<a name="sec:fileformats"></a>
## File Formats

This appendix lists of file formats the CDK knows about. For each format, it indicated if
the CDK has a reader (R) and/or a writer (W) for it. It also indicates which formats can
be detected from the file content. Chemical file format definitions implementations in
the CDK implement the [`IChemFormatMatcher`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/io/formats/IChemFormatMatcher.html) class for that.

This script was used to create this list:

**<a name="script:ListAllFileFormats">Script 24.1</a>** [code/ListAllFileFormats.groovy](code/ListAllFileFormats.code.md)
```groovy
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
  if (format instanceof IChemFormat &&
      format.getReaderClassName() != null) {
    output.append("R");
  }
  if (format instanceof IChemFormat &&
      format.getWriterClassName() != null) {
    output.append("W");
  }
  if (format instanceof IChemFormatMatcher) {
    output.append("M");
  }
  output.append(format.getFormatName())
}
```

<table>
<tr>
  <td><b>Read/Write</b></td>
  <td><b>Matcher</b></td>
  <td><b>File Format</b></td>
</tr>
<tr>
  <td></td>
  <td>M</td>
  <td>ABINIT</td>
</tr>
<tr>
  <td></td>
  <td>M</td>
  <td>ADF</td>
</tr>
<tr>
  <td></td>
  <td>M</td>
  <td>Aces2</td>
</tr>
<tr>
  <td></td>
  <td></td>
  <td>Alchemy</td>
</tr>
<tr>
  <td></td>
  <td></td>
  <td>Ball and Stick</td>
</tr>
<tr>
  <td></td>
  <td>M</td>
  <td>CAChe MolStruct</td>
</tr>
<tr>
  <td>RW</td>
  <td>M</td>
  <td>CDK OWL (N3)</td>
</tr>
<tr>
  <td>W</td>
  <td></td>
  <td>CDK Source Code</td>
</tr>
<tr>
  <td>W</td>
  <td></td>
  <td>CML enriched RSS</td>
</tr>
<tr>
  <td>R</td>
  <td>M</td>
  <td>CTX</td>
</tr>
<tr>
  <td></td>
  <td></td>
  <td>Cacao Cartesian</td>
</tr>
<tr>
  <td></td>
  <td></td>
  <td>Cacao Internal</td>
</tr>
<tr>
  <td></td>
  <td></td>
  <td>Chem3D Cartesian 1</td>
</tr>
<tr>
  <td></td>
  <td></td>
  <td>Chem3D Cartesian 2</td>
</tr>
<tr>
  <td></td>
  <td></td>
  <td>ChemDraw eXchange file</td>
</tr>
<tr>
  <td>RW</td>
  <td>M</td>
  <td>Chemical Markup Language</td>
</tr>
<tr>
  <td></td>
  <td></td>
  <td>Chemical Resource Kit 2D</td>
</tr>
<tr>
  <td></td>
  <td></td>
  <td>Chemical Resource Kit 3D</td>
</tr>
<tr>
  <td></td>
  <td></td>
  <td>Chemtool</td>
</tr>
<tr>
  <td>RW</td>
  <td>M</td>
  <td>CrystClust</td>
</tr>
<tr>
  <td>R</td>
  <td>M</td>
  <td>Crystallographic Interchange Format</td>
</tr>
<tr>
  <td></td>
  <td></td>
  <td>DMol3</td>
</tr>
<tr>
  <td></td>
  <td>M</td>
  <td>Dalton</td>
</tr>
<tr>
  <td></td>
  <td></td>
  <td>Dock 5 Box</td>
</tr>
<tr>
  <td></td>
  <td></td>
  <td>Fenske-Hall Z-Matrix</td>
</tr>
<tr>
  <td></td>
  <td></td>
  <td>Fingerprint</td>
</tr>
<tr>
  <td>R</td>
  <td>M</td>
  <td>GAMESS log file</td>
</tr>
<tr>
  <td></td>
  <td></td>
  <td>GROMOS96</td>
</tr>
<tr>
  <td>R</td>
  <td>M</td>
  <td>Gaussian 2003</td>
</tr>
<tr>
  <td>W</td>
  <td></td>
  <td>Gaussian Input</td>
</tr>
<tr>
  <td></td>
  <td>M</td>
  <td>Gaussian90</td>
</tr>
<tr>
  <td></td>
  <td>M</td>
  <td>Gaussian92</td>
</tr>
<tr>
  <td></td>
  <td>M</td>
  <td>Gaussian94</td>
</tr>
<tr>
  <td></td>
  <td>M</td>
  <td>Gaussian95</td>
</tr>
<tr>
  <td>R</td>
  <td>M</td>
  <td>Gaussian98</td>
</tr>
<tr>
  <td>R</td>
  <td>M</td>
  <td>Ghemical Quantum/Molecular Mechanics Model</td>
</tr>
<tr>
  <td>R</td>
  <td>M</td>
  <td>Ghemical Simplified Protein Model</td>
</tr>
<tr>
  <td>RW</td>
  <td>M</td>
  <td>HyperChem HIN</td>
</tr>
<tr>
  <td>R</td>
  <td>M</td>
  <td>IUPAC-NIST Chemical Identifier (Plain Text)</td>
</tr>
<tr>
  <td>R</td>
  <td>M</td>
  <td>IUPAC-NIST Chemical Identifier (XML)</td>
</tr>
<tr>
  <td></td>
  <td></td>
  <td>JME</td>
</tr>
<tr>
  <td></td>
  <td>M</td>
  <td>Jaguar</td>
</tr>
<tr>
  <td>R</td>
  <td>M</td>
  <td>MDL Mol/SDF V3000</td>
</tr>
<tr>
  <td>R</td>
  <td>M</td>
  <td>MDL Molfile</td>
</tr>
<tr>
  <td>RW</td>
  <td>M</td>
  <td>MDL Molfile V2000</td>
</tr>
<tr>
  <td>R</td>
  <td>M</td>
  <td>MDL RXN V2000</td>
</tr>
<tr>
  <td>R</td>
  <td>M</td>
  <td>MDL RXN V3000</td>
</tr>
<tr>
  <td>R</td>
  <td>M</td>
  <td>MDL Reaction format</td>
</tr>
<tr>
  <td>RW</td>
  <td>M</td>
  <td>MDL Structure-data file</td>
</tr>
<tr>
  <td></td>
  <td>M</td>
  <td>MOPAC 2002</td>
</tr>
<tr>
  <td></td>
  <td>M</td>
  <td>MOPAC 2007</td>
</tr>
<tr>
  <td></td>
  <td>M</td>
  <td>MOPAC 2009</td>
</tr>
<tr>
  <td></td>
  <td>M</td>
  <td>MOPAC 2012</td>
</tr>
<tr>
  <td></td>
  <td>M</td>
  <td>MOPAC 93</td>
</tr>
<tr>
  <td></td>
  <td>M</td>
  <td>MOPAC 97</td>
</tr>
<tr>
  <td></td>
  <td>M</td>
  <td>MOPAC7</td>
</tr>
<tr>
  <td></td>
  <td>M</td>
  <td>MOPAC7 Input</td>
</tr>
<tr>
  <td></td>
  <td></td>
  <td>MSI BGF</td>
</tr>
<tr>
  <td></td>
  <td></td>
  <td>MacroModel</td>
</tr>
<tr>
  <td></td>
  <td></td>
  <td>MacroModel</td>
</tr>
<tr>
  <td></td>
  <td></td>
  <td>Massively Parallel Quantum Chemistry Program</td>
</tr>
<tr>
  <td></td>
  <td>M</td>
  <td>MoSS Output Format</td>
</tr>
<tr>
  <td>RW</td>
  <td>M</td>
  <td>Mol2 (Sybyl)</td>
</tr>
<tr>
  <td></td>
  <td>M</td>
  <td>NWChem</td>
</tr>
<tr>
  <td></td>
  <td></td>
  <td>PCModel</td>
</tr>
<tr>
  <td></td>
  <td></td>
  <td>POV Ray</td>
</tr>
<tr>
  <td></td>
  <td></td>
  <td>Parallel Quantum Solutions</td>
</tr>
<tr>
  <td>R</td>
  <td>M</td>
  <td>PolyMorph Predictor (Cerius)</td>
</tr>
<tr>
  <td>RW</td>
  <td>M</td>
  <td>Protein Brookhave Database (PDB)</td>
</tr>
<tr>
  <td></td>
  <td></td>
  <td>Protein Data Bank Markup Language (PDBML)</td>
</tr>
<tr>
  <td></td>
  <td></td>
  <td>PubChem</td>
</tr>
<tr>
  <td>R</td>
  <td>M</td>
  <td>PubChem Compound ASN</td>
</tr>
<tr>
  <td>R</td>
  <td>M</td>
  <td>PubChem Compound XML</td>
</tr>
<tr>
  <td></td>
  <td>M</td>
  <td>PubChem Compounds XML</td>
</tr>
<tr>
  <td>R</td>
  <td>M</td>
  <td>PubChem Substance XML</td>
</tr>
<tr>
  <td></td>
  <td>M</td>
  <td>PubChem Substances ASN</td>
</tr>
<tr>
  <td></td>
  <td>M</td>
  <td>PubChem Substances XML</td>
</tr>
<tr>
  <td></td>
  <td>M</td>
  <td>Q-Chem</td>
</tr>
<tr>
  <td></td>
  <td></td>
  <td>Raw Copy</td>
</tr>
<tr>
  <td></td>
  <td></td>
  <td>SMARTS</td>
</tr>
<tr>
  <td>RW</td>
  <td></td>
  <td>SMILES</td>
</tr>
<tr>
  <td></td>
  <td></td>
  <td>SMILES FIX</td>
</tr>
<tr>
  <td></td>
  <td></td>
  <td>Scalable Vector Graphics</td>
</tr>
<tr>
  <td>RW</td>
  <td>M</td>
  <td>ShelXL</td>
</tr>
<tr>
  <td></td>
  <td>M</td>
  <td>Spartan Quantum Mechanics Program</td>
</tr>
<tr>
  <td></td>
  <td></td>
  <td>Sybyl descriptor</td>
</tr>
<tr>
  <td>RW</td>
  <td>M</td>
  <td>Symyx Rgroup query files</td>
</tr>
<tr>
  <td></td>
  <td></td>
  <td>Tinker MM2</td>
</tr>
<tr>
  <td></td>
  <td></td>
  <td>Tinker XYZ</td>
</tr>
<tr>
  <td></td>
  <td></td>
  <td>TurboMole</td>
</tr>
<tr>
  <td></td>
  <td></td>
  <td>UniChemXYZ</td>
</tr>
<tr>
  <td>R</td>
  <td>M</td>
  <td>VASP</td>
</tr>
<tr>
  <td></td>
  <td></td>
  <td>Viewmol</td>
</tr>
<tr>
  <td></td>
  <td></td>
  <td>XED</td>
</tr>
<tr>
  <td>RW</td>
  <td></td>
  <td>XYZ</td>
</tr>
<tr>
  <td></td>
  <td></td>
  <td>Yasara</td>
</tr>
<tr>
  <td>R</td>
  <td>M</td>
  <td>ZMatrix</td>
</tr>
<tr>
  <td></td>
  <td></td>
  <td>Zindo</td>
</tr>
</table>

## The Readers and Writers

Additionally, for all formats we can list information about the readers and writers, again
by iterating over all formats:

**<a name="script:ListAllIOClassesByFormat">Script 24.2</a>** [code/ListAllIOClassesByFormat.groovy](code/ListAllIOClassesByFormat.code.md)
```groovy
for (format in formats) {
  if (format instanceof IChemFormat &&
      (format.getReaderClassName() != null ||
       format.getWriterClassName() != null)) {
    output.append(
      "## " + format.formatName + "\n"
    )
    // output some further format details
    if (format.readerClassName != null) {
      reader = format.readerClassName.substring(
        format.readerClassName.lastIndexOf(".") + 1
      )
      output.append(
        "### <topic type=\"class\">" + reader + "</topic>\n"
      )
    }
    if (format.writerClassName != null) {
      writer = format.writerClassName.substring(
        format.writerClassName.lastIndexOf(".") + 1
      )
      output.append(
        "### <topic type=\"class\">" + writer + "</topic>\n"
      )
    }
  }
}
```

## CDK OWL (N3)
**Preferred Extension**: n3
**MIME type**: text/n3
**XML Based?**: No
### <a name="tp1">`CDKOWLReader`</a>
This reader supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>false</td></tr>
<tr><td>AtomContainer</td><td>true</td></tr>
<tr><td>Crystal</td><td>true</td></tr>
</table>
### <a name="tp2">`CDKOWLWriter`</a>
This writer supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>false</td></tr>
<tr><td>AtomContainer</td><td>true</td></tr>
<tr><td>Crystal</td><td>true</td></tr>
</table>
## CDK Source Code
**Preferred Extension**: java
**XML Based?**: No
### <a name="tp3">`CDKSourceCodeWriter`</a>
This writer supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>false</td></tr>
<tr><td>AtomContainer</td><td>true</td></tr>
<tr><td>Crystal</td><td>true</td></tr>
</table>
This writer has these IO settings:
<table>
<tr><td><b>Name</b></td><td><b>Desc</b></td></tr>
<tr>
  <td>write3DCoordinates</td>
  <td>Should 3D coordinates be added? [Default: true]</td></tr>
<tr>
  <td>builder</td>
  <td>Which IChemObjectBuilder should be used? [Default: DefaultChemObjectBuilder]</td></tr>
<tr>
  <td>write2DCoordinates</td>
  <td>Should 2D coordinates be added? [Default: true]</td></tr>
</table>
## CML enriched RSS
**XML Based?**: Yes
### <a name="tp4">`RssWriter`</a>
This writer supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>true</td></tr>
<tr><td>AtomContainer</td><td>true</td></tr>
<tr><td>ChemSequence</td><td>true</td></tr>
<tr><td>Reaction</td><td>true</td></tr>
<tr><td>ReactionSet</td><td>true</td></tr>
<tr><td>isomorphism.matchers.RGroupQuery</td><td>true</td></tr>
<tr><td>Crystal</td><td>true</td></tr>
</table>
## CTX
**Preferred Extension**: ctx
**MIME type**: chemical/x-ctx
**XML Based?**: No
### <a name="tp5">`CTXReader`</a>
This reader supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>true</td></tr>
<tr><td>AtomContainer</td><td>false</td></tr>
</table>
## Chemical Markup Language
**Extensions**: [cml, xml]
**Preferred Extension**: cml
**MIME type**: chemical/x-cml
**XML Based?**: Yes
### <a name="tp6">`CMLReader`</a>
This reader supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>true</td></tr>
<tr><td>AtomContainer</td><td>false</td></tr>
</table>
### <a name="tp7">`CMLWriter`</a>
This writer supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>true</td></tr>
<tr><td>AtomContainer</td><td>false</td></tr>
<tr><td>ChemSequence</td><td>true</td></tr>
<tr><td>Reaction</td><td>true</td></tr>
<tr><td>ReactionSet</td><td>true</td></tr>
<tr><td>Crystal</td><td>true</td></tr>
</table>
This writer has these IO settings:
<table>
<tr><td><b>Name</b></td><td><b>Desc</b></td></tr>
<tr>
  <td>CMLIDs</td>
  <td>Should the output use CML identifiers? [Default: true]</td></tr>
<tr>
  <td>NamespacedOutput</td>
  <td>Should the output use namespaced output? [Default: true]</td></tr>
<tr>
  <td>NamespacePrefix</td>
  <td>What should the namespace prefix be? [empty is no prefix] [Default: ]</td></tr>
<tr>
  <td>Indenting</td>
  <td>Should the output be indented? [Default: true]</td></tr>
<tr>
  <td>SchemaInstance</td>
  <td>Should the output use the Schema-Instance attribute? [Default: false]</td></tr>
<tr>
  <td>XMLDeclaration</td>
  <td>Should the output contain an XML declaration? [Default: true]</td></tr>
<tr>
  <td>InstanceLocation</td>
  <td>Where is the schema found? [Default: ]</td></tr>
</table>
## CrystClust
**Preferred Extension**: crystclust
**XML Based?**: No
### <a name="tp8">`CrystClustReader`</a>
This reader supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>true</td></tr>
<tr><td>AtomContainer</td><td>false</td></tr>
</table>
### <a name="tp9">`CrystClustWriter`</a>
This writer supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>false</td></tr>
<tr><td>AtomContainer</td><td>false</td></tr>
<tr><td>ChemSequence</td><td>true</td></tr>
<tr><td>Crystal</td><td>true</td></tr>
</table>
## Crystallographic Interchange Format
**Preferred Extension**: cif
**MIME type**: chemical/x-cif
**XML Based?**: No
### <a name="tp10">`CIFReader`</a>
This reader supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>true</td></tr>
<tr><td>AtomContainer</td><td>false</td></tr>
</table>
## GAMESS log file
**Extensions**: [gam, gamin, inp, gamout]
**Preferred Extension**: gam
**MIME type**: chemical/x-gamess-output
**XML Based?**: No
### <a name="tp11">`GamessReader`</a>
This reader supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>true</td></tr>
<tr><td>AtomContainer</td><td>false</td></tr>
</table>
## Gaussian 2003
**MIME type**: chemical/x-gaussian-log
**XML Based?**: No
### <a name="tp12">`Gaussian03Reader`</a>
This reader supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>true</td></tr>
<tr><td>AtomContainer</td><td>false</td></tr>
<tr><td>ChemSequence</td><td>true</td></tr>
</table>
## Gaussian Input
**Extensions**: [gau, com]
**Preferred Extension**: gau
**MIME type**: chemical/x-gaussian-input
**XML Based?**: No
### <a name="tp13">`GaussianInputWriter`</a>
This writer supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>false</td></tr>
<tr><td>AtomContainer</td><td>true</td></tr>
<tr><td>Crystal</td><td>true</td></tr>
</table>
This writer has these IO settings:
<table>
<tr><td><b>Name</b></td><td><b>Desc</b></td></tr>
<tr>
  <td>OpenShell</td>
  <td>Should the calculation be open shell? [Default: false]</td></tr>
<tr>
  <td>Comment</td>
  <td>What comment should be put in the file? [Default: Created with CDK (http://cdk.sf.net/)]</td></tr>
<tr>
  <td>Memory</td>
  <td>How much memory do you want to use? [Default: unset]</td></tr>
<tr>
  <td>Command</td>
  <td>What kind of job do you want to perform? [Default: energy calculation]</td></tr>
<tr>
  <td>ProcessorCount</td>
  <td>How many processors should be used by Gaussian? [Default: 1]</td></tr>
</table>
## Gaussian98
**MIME type**: chemical/x-gaussian-log
**XML Based?**: No
### <a name="tp14">`Gaussian98Reader`</a>
This reader supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>true</td></tr>
<tr><td>AtomContainer</td><td>false</td></tr>
</table>
This reader has these IO settings:
<table>
<tr><td><b>Name</b></td><td><b>Desc</b></td></tr>
<tr>
  <td>ReadOptimizedStructureOnly</td>
  <td>Should I only read the optimized structure from a geometry optimization? [Default: false]</td></tr>
</table>
## Ghemical Quantum/Molecular Mechanics Model
**Preferred Extension**: gpr
**MIME type**: application/x-ghemical
**XML Based?**: No
### <a name="tp15">`GhemicalMMReader`</a>
This reader supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>true</td></tr>
<tr><td>AtomContainer</td><td>false</td></tr>
</table>
## Ghemical Simplified Protein Model
**XML Based?**: No
### <a name="tp16">`GhemicalMMReader`</a>
This reader supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>true</td></tr>
<tr><td>AtomContainer</td><td>false</td></tr>
</table>
## HyperChem HIN
**Preferred Extension**: hin
**MIME type**: chemical/x-hin
**XML Based?**: No
### <a name="tp17">`HINReader`</a>
This reader supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>true</td></tr>
<tr><td>AtomContainer</td><td>false</td></tr>
</table>
### <a name="tp18">`HINWriter`</a>
This writer supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>false</td></tr>
<tr><td>AtomContainer</td><td>true</td></tr>
</table>
## IUPAC-NIST Chemical Identifier (Plain Text)
**MIME type**: chemical/x-inchi
**XML Based?**: No
### <a name="tp19">`INChIPlainTextReader`</a>
This reader supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>true</td></tr>
<tr><td>AtomContainer</td><td>false</td></tr>
</table>
## IUPAC-NIST Chemical Identifier (XML)
**Preferred Extension**: inchi
**MIME type**: chemical/x-inchi-xml
**XML Based?**: Yes
### <a name="tp20">`INChIReader`</a>
This reader supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>true</td></tr>
<tr><td>AtomContainer</td><td>false</td></tr>
</table>
## MDL Mol/SDF V3000
**MIME type**: chemical/x-mdl-molfile
**XML Based?**: No
### <a name="tp21">`MDLV3000Reader`</a>
This reader supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>false</td></tr>
<tr><td>AtomContainer</td><td>true</td></tr>
<tr><td>Crystal</td><td>true</td></tr>
</table>
## MDL Molfile
**Preferred Extension**: mol
**MIME type**: chemical/x-mdl-molfile
**XML Based?**: No
### <a name="tp22">`MDLReader`</a>
This reader supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>true</td></tr>
<tr><td>AtomContainer</td><td>true</td></tr>
<tr><td>Crystal</td><td>true</td></tr>
</table>
This reader has these IO settings:
<table>
<tr><td><b>Name</b></td><td><b>Desc</b></td></tr>
<tr>
  <td>ForceReadAs3DCoordinates</td>
  <td>Should coordinates always be read as 3D? [Default: false]</td></tr>
</table>
## MDL Molfile V2000
**Preferred Extension**: mol
**MIME type**: chemical/x-mdl-molfile
**XML Based?**: No
### <a name="tp23">`MDLV2000Reader`</a>
This reader supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>true</td></tr>
<tr><td>AtomContainer</td><td>true</td></tr>
<tr><td>Crystal</td><td>true</td></tr>
</table>
This reader has these IO settings:
<table>
<tr><td><b>Name</b></td><td><b>Desc</b></td></tr>
<tr>
  <td>ForceReadAs3DCoordinates</td>
  <td>Should coordinates always be read as 3D? [Default: false]</td></tr>
<tr>
  <td>AddStereoElements</td>
  <td>Detect and create IStereoElements for the input. [Default: true]</td></tr>
<tr>
  <td>InterpretHydrogenIsotopes</td>
  <td>Should D and T be interpreted as hydrogen isotopes? [Default: true]</td></tr>
</table>
### <a name="tp24">[`MDLV2000Writer`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/io/MDLV2000Writer.html)</a>
This writer supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>true</td></tr>
<tr><td>AtomContainer</td><td>true</td></tr>
<tr><td>Crystal</td><td>true</td></tr>
</table>
This writer has these IO settings:
<table>
<tr><td><b>Name</b></td><td><b>Desc</b></td></tr>
<tr>
  <td>ProgramName</td>
  <td>Program name to write at the top of the molfile header, should be exactly 8 characters long [Default: CDK]</td></tr>
<tr>
  <td>ForceWriteAs2DCoordinates</td>
  <td>Should coordinates always be written as 2D? [Default: false]</td></tr>
<tr>
  <td>WriteAromaticBondTypes</td>
  <td>Should aromatic bonds be written as bond type 4? [Default: false]</td></tr>
<tr>
  <td>WriteMajorIsotopes</td>
  <td>Write atomic mass of any non-null atomic mass including major isotopes (e.g. [12]C) [Default: true]</td></tr>
<tr>
  <td>WriteDefaultProperties</td>
  <td>Write trailing zero's on atom/bond property blocks even if they're not used. [Default: true]</td></tr>
<tr>
  <td>WriteQueryFormatValencies</td>
  <td>Should valencies be written in the MDL Query format? (deprecated) [Default: false]</td></tr>
</table>
## MDL RXN V2000
**Preferred Extension**: rxn
**MIME type**: chemical/x-mdl-rxnfile
**XML Based?**: No
### <a name="tp25">`MDLRXNV2000Reader`</a>
This reader supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>true</td></tr>
<tr><td>AtomContainer</td><td>false</td></tr>
<tr><td>Reaction</td><td>true</td></tr>
</table>
## MDL RXN V3000
**Preferred Extension**: rxn
**MIME type**: chemical/x-mdl-rxnfile
**XML Based?**: No
### <a name="tp26">`MDLRXNV3000Reader`</a>
This reader supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>false</td></tr>
<tr><td>AtomContainer</td><td>false</td></tr>
<tr><td>Reaction</td><td>true</td></tr>
</table>
## MDL Reaction format
**Preferred Extension**: rxn
**MIME type**: chemical/x-mdl-rxnfile
**XML Based?**: No
### <a name="tp27">[`MDLRXNReader`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/io/MDLRXNReader.html)</a>
This reader supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>true</td></tr>
<tr><td>AtomContainer</td><td>false</td></tr>
<tr><td>Reaction</td><td>true</td></tr>
<tr><td>ReactionSet</td><td>true</td></tr>
</table>
## MDL Structure-data file
**Extensions**: [sdf, sd]
**Preferred Extension**: sdf
**MIME type**: chemical/x-mdl-sdfile
**XML Based?**: No
### <a name="tp28">`MDLV2000Reader`</a>
This reader supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>true</td></tr>
<tr><td>AtomContainer</td><td>true</td></tr>
<tr><td>Crystal</td><td>true</td></tr>
</table>
This reader has these IO settings:
<table>
<tr><td><b>Name</b></td><td><b>Desc</b></td></tr>
<tr>
  <td>ForceReadAs3DCoordinates</td>
  <td>Should coordinates always be read as 3D? [Default: false]</td></tr>
<tr>
  <td>AddStereoElements</td>
  <td>Detect and create IStereoElements for the input. [Default: true]</td></tr>
<tr>
  <td>InterpretHydrogenIsotopes</td>
  <td>Should D and T be interpreted as hydrogen isotopes? [Default: true]</td></tr>
</table>
### <a name="tp29">`SDFWriter`</a>
This writer supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>true</td></tr>
<tr><td>AtomContainer</td><td>true</td></tr>
<tr><td>Crystal</td><td>true</td></tr>
</table>
This writer has these IO settings:
<table>
<tr><td><b>Name</b></td><td><b>Desc</b></td></tr>
<tr>
  <td>WriteAromaticBondTypes</td>
  <td>Should aromatic bonds be written as bond type 4? [Default: false]</td></tr>
<tr>
  <td>WriteMajorIsotopes</td>
  <td>Write atomic mass of any non-null atomic mass including major isotopes (e.g. [12]C) [Default: true]</td></tr>
<tr>
  <td>writeProperties</td>
  <td>Should molecule properties be written as non-structural data [Default: true]</td></tr>
<tr>
  <td>WriteQueryFormatValencies</td>
  <td>Should valencies be written in the MDL Query format? (deprecated) [Default: false]</td></tr>
<tr>
  <td>ProgramName</td>
  <td>Program name to write at the top of the molfile header, should be exactly 8 characters long [Default: CDK]</td></tr>
<tr>
  <td>ForceWriteAs2DCoordinates</td>
  <td>Should coordinates always be written as 2D? [Default: false]</td></tr>
<tr>
  <td>WriteDefaultProperties</td>
  <td>Write trailing zero's on atom/bond property blocks even if they're not used. [Default: true]</td></tr>
<tr>
  <td>writeV3000</td>
  <td>Write all records as V3000 [Default: false]</td></tr>
</table>
## Mol2 (Sybyl)
**Preferred Extension**: mol2
**MIME type**: chemical/x-mol2
**XML Based?**: No
### <a name="tp30">`Mol2Reader`</a>
This reader supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>true</td></tr>
<tr><td>AtomContainer</td><td>true</td></tr>
<tr><td>Crystal</td><td>true</td></tr>
</table>
### <a name="tp31">`Mol2Writer`</a>
This writer supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>false</td></tr>
<tr><td>AtomContainer</td><td>true</td></tr>
<tr><td>Crystal</td><td>true</td></tr>
</table>
## PolyMorph Predictor (Cerius)
**Preferred Extension**: pmp
**XML Based?**: No
### <a name="tp32">`PMPReader`</a>
This reader supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>true</td></tr>
<tr><td>AtomContainer</td><td>false</td></tr>
</table>
## Protein Brookhave Database (PDB)
**Extensions**: [pdb, ent]
**Preferred Extension**: pdb
**MIME type**: chemical/x-pdb
**XML Based?**: No
### <a name="tp33">[`PDBReader`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/io/PDBReader.html)</a>
This reader supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>true</td></tr>
<tr><td>AtomContainer</td><td>false</td></tr>
</table>
This reader has these IO settings:
<table>
<tr><td><b>Name</b></td><td><b>Desc</b></td></tr>
<tr>
  <td>UseRebondTool</td>
  <td>Should the PDBReader deduce bonding patterns? [Default: false]</td></tr>
<tr>
  <td>ReadConnectSection</td>
  <td>Should the CONECT be read? [Default: true]</td></tr>
<tr>
  <td>UseHetDictionary</td>
  <td>Should the PDBReader use the HETATM dictionary for atom types? [Default: false]</td></tr>
</table>
### <a name="tp34">`PDBWriter`</a>
This writer supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>true</td></tr>
<tr><td>AtomContainer</td><td>true</td></tr>
<tr><td>Crystal</td><td>true</td></tr>
</table>
This writer has these IO settings:
<table>
<tr><td><b>Name</b></td><td><b>Desc</b></td></tr>
<tr>
  <td>WriteCONECT</td>
  <td>Should the bonds be written as CONECT records? [Default: true]</td></tr>
<tr>
  <td>UseElementSymbolAsAtomName</td>
  <td>Should the element symbol be written as the atom name [Default: false]</td></tr>
<tr>
  <td>WriteTER</td>
  <td>Should a TER record be put at the end of the atoms? [Default: false]</td></tr>
<tr>
  <td>WriteEND</td>
  <td>Should an END record be put at the end of the file? [Default: true]</td></tr>
<tr>
  <td>WriteAsHET</td>
  <td>Should the output file use HETATM [Default: false]</td></tr>
</table>
## PubChem Compound ASN
**Preferred Extension**: asn
**XML Based?**: No
### <a name="tp35">`PCCompoundASNReader`</a>
This reader supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>true</td></tr>
<tr><td>AtomContainer</td><td>false</td></tr>
</table>
## PubChem Compound XML
**Preferred Extension**: xml
**XML Based?**: Yes
### <a name="tp36">`PCCompoundXMLReader`</a>
This reader supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>false</td></tr>
<tr><td>AtomContainer</td><td>true</td></tr>
<tr><td>Crystal</td><td>true</td></tr>
</table>
## PubChem Substance XML
**Preferred Extension**: xml
**XML Based?**: Yes
### <a name="tp37">`PCSubstanceXMLReader`</a>
This reader supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>false</td></tr>
<tr><td>AtomContainer</td><td>true</td></tr>
<tr><td>Crystal</td><td>true</td></tr>
</table>
## SMILES
**Preferred Extension**: smi
**MIME type**: chemical/x-daylight-smiles
**XML Based?**: No
### <a name="tp38">`SMILESReader`</a>
This reader supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>true</td></tr>
<tr><td>AtomContainer</td><td>false</td></tr>
</table>
### <a name="tp39">`SMILESWriter`</a>
This writer supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>false</td></tr>
<tr><td>AtomContainer</td><td>true</td></tr>
<tr><td>Crystal</td><td>true</td></tr>
</table>
This writer has these IO settings:
<table>
<tr><td><b>Name</b></td><td><b>Desc</b></td></tr>
<tr>
  <td>UseAromaticity</td>
  <td>Should aromaticity information be stored in the SMILES? [Default: false]</td></tr>
</table>
## ShelXL
**Extensions**: [ins, res]
**Preferred Extension**: ins
**MIME type**: chemical/x-shelx
**XML Based?**: No
### <a name="tp40">`ShelXReader`</a>
This reader supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>true</td></tr>
<tr><td>AtomContainer</td><td>false</td></tr>
<tr><td>Crystal</td><td>true</td></tr>
</table>
### <a name="tp41">`ShelXWriter`</a>
This writer supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>false</td></tr>
<tr><td>AtomContainer</td><td>false</td></tr>
<tr><td>Crystal</td><td>true</td></tr>
</table>
## Symyx Rgroup query files
**Extensions**: [mol, rgp]
**Preferred Extension**: mol
**XML Based?**: No
### <a name="tp42">`RGroupQueryReader`</a>
This reader supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>false</td></tr>
<tr><td>AtomContainer</td><td>false</td></tr>
<tr><td>isomorphism.matchers.RGroupQuery</td><td>true</td></tr>
</table>
### <a name="tp43">`RGroupQueryWriter`</a>
This writer supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>false</td></tr>
<tr><td>AtomContainer</td><td>false</td></tr>
<tr><td>isomorphism.matchers.RGroupQuery</td><td>true</td></tr>
</table>
## VASP
**XML Based?**: No
### <a name="tp44">`VASPReader`</a>
This reader supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>true</td></tr>
<tr><td>AtomContainer</td><td>false</td></tr>
</table>
## XYZ
**Preferred Extension**: xyz
**MIME type**: chemical/x-xyz
**XML Based?**: No
### <a name="tp45">`XYZReader`</a>
This reader supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>true</td></tr>
<tr><td>AtomContainer</td><td>false</td></tr>
</table>
### <a name="tp46">`XYZWriter`</a>
This writer supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>false</td></tr>
<tr><td>AtomContainer</td><td>true</td></tr>
<tr><td>Crystal</td><td>true</td></tr>
</table>
## ZMatrix
**XML Based?**: No
### <a name="tp47">`ZMatrixReader`</a>
This reader supports these data objects:
<table>
<tr><td><b>Class</b></td><td><b>Accepted</b></td></tr>
<tr><td>ChemFile</td><td>true</td></tr>
<tr><td>AtomContainer</td><td>false</td></tr>
</table>
