# Protein and DNA

While the most prominent functionality of the CDK lies around small organic molecules,
there is support for protein structures too. Of course, <a name="tp1">protein</a> are just large
organic molecules, and the [`IAtomContainer`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/interfaces/IAtomContainer.html) can simply be used. The same holds
for <a name="tp2">DNA</a> strands. However, there is more extensive support for protein and
DNA in the CDK, and this chapter will outline some of that.
The core interface is the [`IBioPolymer`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/interfaces/IBioPolymer.html) interface, which is derived from an
IAtomContainer. Figure [7.1](#fig:proteinClass) shows its hierarchy.

<a name="fig:proteinClass"></a>
![](images/biopolymer.png)
<br />**Figure 7.1**: The IBioPolymer interface extends the IPolymer interface, which extends the IAtomContainer interface.

## Protein From File

One straightforward way to create protein and DNA structures is to read them from
PDB files [<a href="#citeref1">1</a>]. Chapter [11](io.md#sec:io) explains how files are read in general. For <a name="tp3">PDB files</a>,
the [`PDBReader`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/io/PDBReader.html) should be used. A code example showing how to use this reader
is given by Script [11.13](io.md#script:PDBCoordinateExtraction).

Of course, we can also read PDB files from a local disc. The results are read into
a [`IChemFile`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/interfaces/IChemFile.html). from which the first IAtomContainer is the IBioPolymer. For example,
we can read <a name="tp4">crambin</a> [<a href="#citeref2">2</a>]:

**<a name="script:ProteinFromFile">Script 7.1</a>** [code/ProteinFromFile.groovy](code/ProteinFromFile.code.md)
```groovy
reader = new PDBReader(
  new FileReader("data/1CRN.pdb")
);
file = reader.read(new ChemFile());
crambin = ChemFileManipulator
  .getAllAtomContainers(file)
  .get(0)
println "Crambin has " + crambin.atomCount +
  " atoms."
```

Which returns:

```plain
Crambin has 327 atoms.
```

## Protein From Sequence

It is also possible to create an protein data structure starting from a <a name="tp5">sequence</a>
with the `ProteinBuilder` class:

**<a name="script:ProteinFromSequence">Script 7.2</a>** [code/ProteinFromSequence.groovy](code/ProteinFromSequence.code.md)
```groovy
crambin = ProteinBuilderTool.createProtein(
  "TTCCPSIVARSNFNVCRLPGTPEA" +
  "ICATYTGCIIIPGATCPGDYAN"
);
println "Crambin has " + crambin.atomCount +
  " atoms."
```

Because a IBioPolymer extends the IAtomContainer interface, we can simply query for
the number of atoms, as done here. The scripts returns us:

```plain
Crambin has 327 atoms.
```

## Strands and Monomers

The [`IBioPolymer`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/interfaces/IBioPolymer.html) interface is modeled after PDB files, those being their primary
use case. Therefore, the data structure can hold atoms part of proteins, hetero atoms,
solvents, etc. The atoms in the protein structure itself, are also part of a monomer,
but also of strands, which consist of a sequence of polymers. So, a BioPolymer is not a single polymeric molecule.

There are access methods for the strand information we can use to iterate over the sequence of a biopolymer:

**<a name="script:ProteinStrands">Script 7.3</a>** [code/ProteinStrands.groovy](code/ProteinStrands.code.md)
```groovy
println "Crambin has " +
  crambin.strandCount + " strand(s)"
for (name in crambin.strandNames) {
  print "  strand " + name
  strand = crambin.getStrand(name)
  println " has " + strand.atomCount +
    " atoms"
}
```

This returns a list of strands and the number of atoms per strand.

```plain
Crambin has 1 strand(s)
  strand A has 327 atoms
```

Each strand consists of a sequence monomers, over which we can iterate:

**<a name="script:ProteinMonomers">Script 7.4</a>** [code/ProteinMonomers.groovy](code/ProteinMonomers.code.md)
```groovy
strand = crambin.getStrand("A")
for (name in crambin.monomerNames) {
  println "monomer " + name
}
```

The full script has some hidden code to only list the first few monomers:

```plain
monomer GLYA20
monomer ALAA24
monomer ALAA9
monomer ARGA17
monomer LEUA18
monomer PROA19
monomer CYSA16
monomer ARGA10
...
```

The [`IStrand`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/interfaces/IStrand.html) and [`IMonomer`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/interfaces/IMonomer.html) interfaces provide functionality to access
specific properties, but also extend the `IAtomContainer` interface, as depicted
in Figure [7.2](#fig:strandmonomerClass). Both provide access to a name for the entity as
well as a type:

**<a name="script:BioNameType">Script 7.5</a>** [code/BioNameType.groovy](code/BioNameType.code.md)
```groovy
strand = crambin.getStrand("A")
println "Strand name: " + strand.strandName
println "       type: " + strand.strandType
monomer = strand.getMonomer("ALAA9")
println "Monomer name: " + monomer.monomerName
println "        type: " + monomer.monomerType
```

Using these methods, we get some additional information about the strands and monomers:

```plain
Strand name: A
       type: null
Monomer name: ALAA9
        type: ALA
```

<a name="fig:strandmonomerClass"></a>
![](images/strandmonomer.png)
<br />**Figure 7.2**: The IStrand and IMonomer interfaces extend the IAtomContainer interface.

## References

1. <a name="citeref1"></a>Henrick K, Feng Z, Bluhm WF, Dimitropoulos D, Doreleijers JF, Dutta S, et al. Remediation of the protein data bank archive. Nucleic Acids Research. 2008 Jan 1;36(Database issue):D426-33.  doi:[10.1093/NAR/GKM937](https://doi.org/10.1093/NAR/GKM937) ([Scholia](https://tools.wmflabs.org/scholia/doi/10.1093/NAR/GKM937))
2. <a name="citeref2"></a>MM T, WA H. Highly ordered crystals of the plant seed protein crambin. Journal of Molecular Biology. 1979 Jan 1;127(2):219–23.  doi:[10.1016/0022-2836(79)90242-0](https://doi.org/10.1016/0022-2836(79)90242-0) ([Scholia](https://tools.wmflabs.org/scholia/doi/10.1016/0022-2836(79)90242-0))


