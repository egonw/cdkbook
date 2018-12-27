# Chemistry Toolkit Rosetta

The [Chemistry Toolkit Rosetta](http://ctr.wikia.com/) (CTR) wiki was set up some time ago by Andrew Dalke to
demonstrate how certain basic cheminformatics tasks are done in the various cheminformatics toolkits around.
This chapter shows how CTR tasks can be solved with the CDK in Groovy. Each section discusses one CTR task,
and show one possible solution.

The data used in this chapter originates from the wiki, and is redistributed with this book under the
CC-BY-SA license, as it is in the wiki.

## Heavy atom counts from an SD file

This tasks starts with an SD file (see Section XX) and counts for each structure in the file
the number of heavy atoms (non-hydrogen atoms). Because we simply handle the structures one by one,
the solution uses the `IteratingSDFReader` reader. The input file (`benzodiazepine.sdf.gz`) is a
gzipped file, which we handle by using a `GZIPInputStream` as outlined in Section XX.
Because we want to make sure the input file does not have any unexpected content, we use the `STRICT`
mode, detailed in Section XX. The input file turns out to do not have non-standard
features, so that we do not have to worry about D and T element symbols.

The solution lists all heavy atom counts:

**Script** [code/CTR1.groovy](code/CTR1.code.md)
```groovy
iterator = new IteratingSDFReader(
  new GZIPInputStream(
    new File("ctr/benzodiazepine.sdf.gz")
      .newInputStream()
  ),
  SilentChemObjectBuilder.getInstance()
)
iterator.setReaderMode(
  IChemObjectReader.Mode.STRICT
)
while (iterator.hasNext()) {
  mol = iterator.next()
  heavyAtomCount = 0
  for (atom in mol.atoms()) {
    if (1 == atom.atomicNumber ||
        "H" == atom.symbol) {
      // do not count hydrogens
    } else {
      heavyAtomCount++
    }
  }
  println heavyAtomCount
}
```

![](images/generated/CTR2.png) <br />
**Figure 20.1**: 2D diagram of caffeine.

## Depict a compound as an image

The CTR asks in this task an approach to take a SMILES string, generate 2D coordinates, and depict the result
in a PNG image. Chapter XX describes the last step, and for the first and second step
we use the `SmilesParser` and `StructureDiagramGenerator` classes, respectively.
The solution does not render the structure's title.

The solution can then look like, resulting roughly in Figure 20.1 for the SMILES of
caffeine in this example:

**Script** [code/CTR2.groovy](code/CTR2.code.md)
```groovy
smiles = "CN1C=NC2=C1C(=O)N(C(=O)N2C)C"
int WIDTH = 200
int HEIGHT = 250
Rectangle drawArea = new Rectangle(WIDTH, HEIGHT);
Image image = new BufferedImage(
  WIDTH, HEIGHT, BufferedImage.TYPE_INT_RGB
);
smilesParser = new SmilesParser(
  SilentChemObjectBuilder.getInstance()
)
molecule = smilesParser.parseSmiles(smiles)
StructureDiagramGenerator sdg =
  new StructureDiagramGenerator();
sdg.setMolecule(molecule);
sdg.generateCoordinates();
molecule = sdg.getMolecule();
List<IGenerator> generators =
  new ArrayList<IGenerator>();
generators.add(new BasicSceneGenerator());
generators.add(new BasicBondGenerator());
generators.add(new BasicAtomGenerator());
AtomContainerRenderer renderer =
  new AtomContainerRenderer(
    generators, new AWTFontManager()
  );
renderer.setup(molecule, drawArea);
model = renderer.getRenderer2DModel();
model.set(ZoomFactor.class, (double)0.9);
Graphics2D g2 = (Graphics2D)image.getGraphics();
g2.setColor(Color.WHITE);
g2.fillRect(0, 0, WIDTH, HEIGHT);
renderer.paint(molecule, new AWTDrawVisitor(g2));
ImageIO.write(
  (RenderedImage)image, "PNG",
  new File("CTR2.png")
);
```
