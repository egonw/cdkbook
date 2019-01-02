## Atom Type Lists

The table listed in this Appendix is generated with the following
code, listing all six properties of CDK atom types, as outlined
in Section XX:

**Script** [code/ListAllCDKAtomTypes.groovy](code/ListAllCDKAtomTypes.code.md)
```groovy
factory = AtomTypeFactory.getInstance(
  "org/openscience/cdk/dict/data/cdk-atom-types.owl",
  SilentChemObjectBuilder.getInstance()
);
IAtomType[] types = factory.getAllAtomTypes();
for (IAtomType type : types) {
  lonepairs = type.getProperty(
    CDKConstants.LONE_PAIR_COUNT
  )
  output.append(
    "<tr>" +
    "<td>${type.atomTypeName}</td>" +
    "<td>${type.symbol}</td>" +
    "<td>${type.formalCharge}</td>" +
    "<td>${type.formalNeighbourCount}</td>" +
    (type.hybridization == null
      ? "<td></td>"
      : "<td>${type.hybridization}</td>") +
    (lonepairs == null
      ? "<td></td>"
      : "<td>${lonepairs}</td>") +
    "<td>" + type.getProperty(
      CDKConstants.PI_BOND_COUNT
    ) + "</td></tr>\n")
}
```

For the Sybyl atom types we can do the same, just by updating
to code to load the proper atom type list:

**Script** [code/ListAllSybylAtomTypes.groovy](code/ListAllSybylAtomTypes.code.md)
```groovy
factory = AtomTypeFactory.getInstance(
  "org/openscience/cdk/dict/data/sybyl-atom-types.owl",
  SilentChemObjectBuilder.getInstance()
);
```

## CDK Atom Types

<table>
<tr><td>Ag.neutral</td><td>Ag</td><td>0</td><td>0</td><td></td><td></td><td>0</td></tr>
<tr><td>Ag.1</td><td>Ag</td><td>0</td><td>1</td><td></td><td></td><td>0</td></tr>
<tr><td>Ag.plus</td><td>Ag</td><td>1</td><td>0</td><td></td><td></td><td>0</td></tr>
<tr><td>Al.3plus</td><td>Al</td><td>3</td><td>0</td><td>S</td><td>0</td><td>0</td></tr>
<tr><td>Al</td><td>Al</td><td>0</td><td>3</td><td>SP3</td><td>0</td><td>0</td></tr>
<tr><td>Al.3minus</td><td>Al</td><td>-3</td><td>6</td><td></td><td></td><td>0</td></tr>
<tr><td>Ar</td><td>Ar</td><td>0</td><td>0</td><td>SP3</td><td>4</td><td>0</td></tr>
<tr><td>As</td><td>As</td><td>0</td><td>3</td><td>SP3</td><td>1</td><td>0</td></tr>
<tr><td>As.3plus</td><td>As</td><td>3</td><td>0</td><td></td><td></td><td>0</td></tr>
<tr><td>As.plus</td><td>As</td><td>1</td><td>4</td><td>SP3</td><td>0</td><td>0</td></tr>
<tr><td>As.5</td><td>As</td><td>0</td><td>4</td><td>SP3</td><td>0</td><td>1</td></tr>
<tr><td>As.2</td><td>As</td><td>0</td><td>2</td><td>SP2</td><td>1</td><td>1</td></tr>
<tr><td>As.minus</td><td>As</td><td>-1</td><td>6</td><td></td><td></td><td>0</td></tr>
<tr><td>Au.1</td><td>Au</td><td>0</td><td>1</td><td></td><td>0</td><td>0</td></tr>
<tr><td>B</td><td>B</td><td>0</td><td>3</td><td>SP3</td><td>0</td><td>0</td></tr>
<tr><td>B.3plus</td><td>B</td><td>3</td><td>4</td><td>SP3</td><td>0</td><td>0</td></tr>
<tr><td>B.minus</td><td>B</td><td>-1</td><td>4</td><td>SP3</td><td>0</td><td>0</td></tr>
<tr><td>Ba.2plus</td><td>Ba</td><td>2</td><td>0</td><td></td><td>0</td><td>0</td></tr>
<tr><td>Be.2minus</td><td>Be</td><td>-2</td><td>4</td><td>SP3</td><td>0</td><td>0</td></tr>
<tr><td>Be.neutral</td><td>Be</td><td>0</td><td>0</td><td></td><td></td><td>0</td></tr>
<tr><td>Br.3</td><td>Br</td><td>0</td><td>3</td><td>SP3</td><td>1</td><td>2</td></tr>
<tr><td>Br.minus</td><td>Br</td><td>-1</td><td>0</td><td>SP3</td><td>4</td><td>0</td></tr>
<tr><td>Br</td><td>Br</td><td>0</td><td>1</td><td>SP3</td><td>3</td><td>0</td></tr>
<tr><td>Br.radical</td><td>Br</td><td>0</td><td>0</td><td>SP3</td><td>3</td><td>0</td></tr>
<tr><td>Br.plus.sp3</td><td>Br</td><td>1</td><td>2</td><td>SP3</td><td>2</td><td>0</td></tr>
<tr><td>Br.plus.radical</td><td>Br</td><td>1</td><td>1</td><td>SP3</td><td>2</td><td>0</td></tr>
<tr><td>Br.plus.sp2</td><td>Br</td><td>1</td><td>1</td><td>SP2</td><td>2</td><td>1</td></tr>
<tr><td>C.radical.planar</td><td>C</td><td>0</td><td>3</td><td>PLANAR3</td><td>0</td><td>0</td></tr>
<tr><td>C.radical.sp1</td><td>C</td><td>0</td><td>1</td><td>SP1</td><td>0</td><td>2</td></tr>
<tr><td>C.radical.sp2</td><td>C</td><td>0</td><td>2</td><td>SP2</td><td>0</td><td>1</td></tr>
<tr><td>C.minus.planar</td><td>C</td><td>-1</td><td>3</td><td>PLANAR3</td><td>1</td><td>0</td></tr>
<tr><td>C.sp2</td><td>C</td><td>0</td><td>3</td><td>SP2</td><td>0</td><td>1</td></tr>
<tr><td>C.sp3</td><td>C</td><td>0</td><td>4</td><td>SP3</td><td>0</td><td>0</td></tr>
<tr><td>C.plus.sp1</td><td>C</td><td>1</td><td>1</td><td>SP1</td><td>0</td><td>2</td></tr>
<tr><td>C.plus.sp2</td><td>C</td><td>1</td><td>2</td><td>SP2</td><td>0</td><td>1</td></tr>
<tr><td>C.allene</td><td>C</td><td>0</td><td>2</td><td>SP1</td><td>0</td><td>2</td></tr>
<tr><td>C.minus.sp1</td><td>C</td><td>-1</td><td>1</td><td>SP1</td><td>1</td><td>2</td></tr>
<tr><td>C.minus.sp3</td><td>C</td><td>-1</td><td>3</td><td>SP3</td><td>1</td><td>0</td></tr>
<tr><td>C.minus.sp2</td><td>C</td><td>-1</td><td>2</td><td>SP2</td><td>1</td><td>1</td></tr>
<tr><td>C.plus.planar</td><td>C</td><td>1</td><td>3</td><td>PLANAR3</td><td>0</td><td>0</td></tr>
<tr><td>C.sp</td><td>C</td><td>0</td><td>2</td><td>SP1</td><td>0</td><td>2</td></tr>
<tr><td>Ca.2</td><td>Ca</td><td>0</td><td>2</td><td></td><td></td><td>0</td></tr>
<tr><td>Ca.1</td><td>Ca</td><td>0</td><td>1</td><td></td><td></td><td>1</td></tr>
<tr><td>Ca.2plus</td><td>Ca</td><td>2</td><td>0</td><td>S</td><td>0</td><td>0</td></tr>
<tr><td>Cd.2</td><td>Cd</td><td>0</td><td>2</td><td>SP1</td><td></td><td>0</td></tr>
<tr><td>Cd.2plus</td><td>Cd</td><td>2</td><td>0</td><td></td><td></td><td>0</td></tr>
<tr><td>Cd.metallic</td><td>Cd</td><td>0</td><td>0</td><td></td><td></td><td>0</td></tr>
<tr><td>Cl.chlorate</td><td>Cl</td><td>0</td><td>3</td><td>SP2</td><td>0</td><td>2</td></tr>
<tr><td>Cl.2</td><td>Cl</td><td>0</td><td>2</td><td>SP3</td><td>2</td><td>1</td></tr>
<tr><td>Cl.perchlorate</td><td>Cl</td><td>0</td><td>4</td><td>SP3</td><td>0</td><td>3</td></tr>
<tr><td>Cl.plus.sp3</td><td>Cl</td><td>1</td><td>2</td><td>SP3</td><td>2</td><td>0</td></tr>
<tr><td>Cl.plus.sp2</td><td>Cl</td><td>1</td><td>1</td><td>SP2</td><td>2</td><td>1</td></tr>
<tr><td>Cl</td><td>Cl</td><td>0</td><td>1</td><td>SP3</td><td>3</td><td>0</td></tr>
<tr><td>Cl.minus</td><td>Cl</td><td>-1</td><td>0</td><td>SP3</td><td>4</td><td>0</td></tr>
<tr><td>Cl.plus.radical</td><td>Cl</td><td>1</td><td>1</td><td>SP3</td><td>2</td><td>0</td></tr>
<tr><td>Cl.radical</td><td>Cl</td><td>0</td><td>0</td><td>SP3</td><td>3</td><td>0</td></tr>
<tr><td>Cl.perchlorate.charged</td><td>Cl</td><td>3</td><td>4</td><td>SP3</td><td>0</td><td>0</td></tr>
<tr><td>Co.metallic</td><td>Co</td><td>0</td><td>0</td><td></td><td></td><td>0</td></tr>
<tr><td>Co.3plus</td><td>Co</td><td>3</td><td>0</td><td></td><td></td><td>0</td></tr>
<tr><td>Co.plus.1</td><td>Co</td><td>1</td><td>1</td><td></td><td></td><td>0</td></tr>
<tr><td>Co.1</td><td>Co</td><td>0</td><td>1</td><td></td><td></td><td>0</td></tr>
<tr><td>Co.2</td><td>Co</td><td>0</td><td>2</td><td></td><td></td><td>0</td></tr>
<tr><td>Co.4</td><td>Co</td><td>0</td><td>4</td><td></td><td></td><td>0</td></tr>
<tr><td>Co.6</td><td>Co</td><td>0</td><td>6</td><td></td><td></td><td>0</td></tr>
<tr><td>Co.plus.2</td><td>Co</td><td>1</td><td>2</td><td></td><td></td><td>0</td></tr>
<tr><td>Co.plus.5</td><td>Co</td><td>1</td><td>5</td><td></td><td></td><td>0</td></tr>
<tr><td>Co.plus.4</td><td>Co</td><td>1</td><td>4</td><td></td><td></td><td>0</td></tr>
<tr><td>Co.plus.6</td><td>Co</td><td>1</td><td>6</td><td></td><td></td><td>0</td></tr>
<tr><td>Co.plus</td><td>Co</td><td>1</td><td>0</td><td></td><td></td><td>0</td></tr>
<tr><td>Co.2plus</td><td>Co</td><td>2</td><td>0</td><td></td><td></td><td>0</td></tr>
<tr><td>Cr</td><td>Cr</td><td>0</td><td>6</td><td></td><td>0</td><td>0</td></tr>
<tr><td>Cr.6plus</td><td>Cr</td><td>6</td><td>0</td><td></td><td>0</td><td>0</td></tr>
<tr><td>Cr.4</td><td>Cr</td><td>0</td><td>4</td><td>SP3</td><td>0</td><td>2</td></tr>
<tr><td>Cr.neutral</td><td>Cr</td><td>0</td><td>0</td><td></td><td>0</td><td>0</td></tr>
<tr><td>Cr.3plus</td><td>Cr</td><td>3</td><td>0</td><td></td><td>0</td><td>0</td></tr>
<tr><td>Cu.2plus</td><td>Cu</td><td>2</td><td>0</td><td></td><td></td><td>0</td></tr>
<tr><td>Cu.metallic</td><td>Cu</td><td>0</td><td>0</td><td></td><td></td><td>0</td></tr>
<tr><td>Cu.plus</td><td>Cu</td><td>1</td><td>0</td><td></td><td></td><td>0</td></tr>
<tr><td>Cu.1</td><td>Cu</td><td>0</td><td>1</td><td></td><td></td><td>0</td></tr>
<tr><td>F</td><td>F</td><td>0</td><td>1</td><td>SP3</td><td>3</td><td>0</td></tr>
<tr><td>F.plus.radical</td><td>F</td><td>1</td><td>1</td><td>SP3</td><td>2</td><td>0</td></tr>
<tr><td>F.radical</td><td>F</td><td>0</td><td>0</td><td>SP3</td><td>3</td><td>0</td></tr>
<tr><td>F.minus</td><td>F</td><td>-1</td><td>0</td><td>SP3</td><td>4</td><td>0</td></tr>
<tr><td>F.plus.sp3</td><td>F</td><td>1</td><td>2</td><td>SP3</td><td>2</td><td>0</td></tr>
<tr><td>F.plus.sp2</td><td>F</td><td>1</td><td>1</td><td>SP2</td><td>2</td><td>1</td></tr>
<tr><td>Fe.2minus</td><td>Fe</td><td>-2</td><td>6</td><td></td><td></td><td>0</td></tr>
<tr><td>Fe.4minus</td><td>Fe</td><td>-4</td><td>6</td><td></td><td></td><td>0</td></tr>
<tr><td>Fe.metallic</td><td>Fe</td><td>0</td><td>0</td><td></td><td></td><td>0</td></tr>
<tr><td>Fe.2</td><td>Fe</td><td>0</td><td>2</td><td></td><td></td><td>0</td></tr>
<tr><td>Fe.4</td><td>Fe</td><td>0</td><td>4</td><td></td><td></td><td>0</td></tr>
<tr><td>Fe.3</td><td>Fe</td><td>0</td><td>3</td><td></td><td></td><td>0</td></tr>
<tr><td>Fe.6</td><td>Fe</td><td>0</td><td>6</td><td></td><td></td><td>0</td></tr>
<tr><td>Fe.5</td><td>Fe</td><td>0</td><td>5</td><td></td><td></td><td>0</td></tr>
<tr><td>Fe.2plus</td><td>Fe</td><td>2</td><td>0</td><td></td><td></td><td>0</td></tr>
<tr><td>Fe.3minus</td><td>Fe</td><td>-3</td><td>6</td><td></td><td></td><td>0</td></tr>
<tr><td>Fe.plus</td><td>Fe</td><td>1</td><td>2</td><td></td><td></td><td>0</td></tr>
<tr><td>Fe.3plus</td><td>Fe</td><td>3</td><td>0</td><td></td><td></td><td>0</td></tr>
<tr><td>Ga.3plus</td><td>Ga</td><td>3</td><td>0</td><td></td><td>0</td><td>0</td></tr>
<tr><td>Ga</td><td>Ga</td><td>0</td><td>3</td><td></td><td>0</td><td>0</td></tr>
<tr><td>Gd.3plus</td><td>Gd</td><td>3</td><td>0</td><td></td><td>0</td><td>0</td></tr>
<tr><td>Ge</td><td>Ge</td><td>0</td><td>4</td><td>SP3</td><td>0</td><td>0</td></tr>
<tr><td>Ge.3</td><td>Ge</td><td>0</td><td>3</td><td>SP2</td><td>0</td><td>1</td></tr>
<tr><td>H.plus</td><td>H</td><td>1</td><td>0</td><td>S</td><td>0</td><td>0</td></tr>
<tr><td>H.minus</td><td>H</td><td>-1</td><td>0</td><td>S</td><td>0</td><td>0</td></tr>
<tr><td>H</td><td>H</td><td>0</td><td>1</td><td>S</td><td>0</td><td>0</td></tr>
<tr><td>X</td><td>H</td><td>0</td><td>0</td><td></td><td></td><td>0</td></tr>
<tr><td>H.radical</td><td>H</td><td>0</td><td>0</td><td>S</td><td>0</td><td>0</td></tr>
<tr><td>He</td><td>He</td><td>0</td><td>0</td><td>S</td><td>1</td><td>0</td></tr>
<tr><td>Hg.minus</td><td>Hg</td><td>-1</td><td>2</td><td></td><td></td><td>0</td></tr>
<tr><td>Hg.plus</td><td>Hg</td><td>1</td><td>1</td><td></td><td></td><td>0</td></tr>
<tr><td>Hg.2plus</td><td>Hg</td><td>2</td><td>0</td><td></td><td></td><td>0</td></tr>
<tr><td>Hg.1</td><td>Hg</td><td>0</td><td>1</td><td></td><td></td><td>1</td></tr>
<tr><td>Hg.2</td><td>Hg</td><td>0</td><td>2</td><td></td><td></td><td>0</td></tr>
<tr><td>Hg.metallic</td><td>Hg</td><td>0</td><td>0</td><td></td><td></td><td>0</td></tr>
<tr><td>I.radical</td><td>I</td><td>0</td><td>0</td><td>SP3</td><td>3</td><td>0</td></tr>
<tr><td>I</td><td>I</td><td>0</td><td>1</td><td>SP3</td><td>3</td><td>0</td></tr>
<tr><td>I.minus</td><td>I</td><td>-1</td><td>0</td><td>SP3</td><td>4</td><td>0</td></tr>
<tr><td>I.minus.5</td><td>I</td><td>-1</td><td>2</td><td>SP3D1</td><td>3</td><td>0</td></tr>
<tr><td>I.plus.radical</td><td>I</td><td>1</td><td>1</td><td>SP3</td><td>2</td><td>0</td></tr>
<tr><td>I.3</td><td>I</td><td>0</td><td>2</td><td>SP2</td><td>1</td><td>1</td></tr>
<tr><td>I.5</td><td>I</td><td>0</td><td>3</td><td>SP2</td><td>0</td><td>2</td></tr>
<tr><td>I.plus.sp2</td><td>I</td><td>1</td><td>1</td><td>SP2</td><td>2</td><td>1</td></tr>
<tr><td>I.plus.sp3</td><td>I</td><td>1</td><td>2</td><td>SP3</td><td>2</td><td>0</td></tr>
<tr><td>I.sp3d2.3</td><td>I</td><td>0</td><td>3</td><td>SP3D2</td><td>2</td><td>0</td></tr>
<tr><td>In</td><td>In</td><td>0</td><td>0</td><td></td><td>0</td><td>0</td></tr>
<tr><td>In.3plus</td><td>In</td><td>3</td><td>0</td><td></td><td>0</td><td>0</td></tr>
<tr><td>In.3</td><td>In</td><td>0</td><td>3</td><td></td><td>0</td><td>0</td></tr>
<tr><td>In.1</td><td>In</td><td>0</td><td>1</td><td></td><td>0</td><td>2</td></tr>
<tr><td>K.neutral</td><td>K</td><td>0</td><td>1</td><td></td><td></td><td>0</td></tr>
<tr><td>K.metallic</td><td>K</td><td>0</td><td>0</td><td></td><td></td><td>0</td></tr>
<tr><td>K.plus</td><td>K</td><td>1</td><td>0</td><td>S</td><td>0</td><td>0</td></tr>
<tr><td>Kr</td><td>Kr</td><td>0</td><td>0</td><td></td><td></td><td>0</td></tr>
<tr><td>Li.neutral</td><td>Li</td><td>0</td><td>0</td><td></td><td></td><td>0</td></tr>
<tr><td>Li.plus</td><td>Li</td><td>1</td><td>0</td><td></td><td>0</td><td>0</td></tr>
<tr><td>Li</td><td>Li</td><td>0</td><td>1</td><td>S</td><td>0</td><td>0</td></tr>
<tr><td>Mg.neutral.1</td><td>Mg</td><td>0</td><td>1</td><td></td><td></td><td>1</td></tr>
<tr><td>Mg.neutral.2</td><td>Mg</td><td>0</td><td>2</td><td></td><td></td><td>0</td></tr>
<tr><td>Mg.2plus</td><td>Mg</td><td>2</td><td>0</td><td>S</td><td>0</td><td>0</td></tr>
<tr><td>Mg.neutral</td><td>Mg</td><td>0</td><td>4</td><td></td><td></td><td>0</td></tr>
<tr><td>Mn.metallic</td><td>Mn</td><td>0</td><td>0</td><td></td><td></td><td>0</td></tr>
<tr><td>Mn.3plus</td><td>Mn</td><td>3</td><td>0</td><td></td><td></td><td>0</td></tr>
<tr><td>Mn.2plus</td><td>Mn</td><td>2</td><td>0</td><td></td><td></td><td>0</td></tr>
<tr><td>Mn.2</td><td>Mn</td><td>0</td><td>2</td><td></td><td></td><td>0</td></tr>
<tr><td>Mo.metallic</td><td>Mo</td><td>0</td><td>0</td><td></td><td></td><td>0</td></tr>
<tr><td>Mo.4</td><td>Mo</td><td>0</td><td>4</td><td></td><td></td><td>2</td></tr>
<tr><td>N.plus.sp3.radical</td><td>N</td><td>1</td><td>3</td><td>SP3</td><td>0</td><td>0</td></tr>
<tr><td>N.oxide</td><td>N</td><td>0</td><td>4</td><td>SP2</td><td>0</td><td>1</td></tr>
<tr><td>N.nitro</td><td>N</td><td>0</td><td>3</td><td>PLANAR3</td><td>0</td><td>2</td></tr>
<tr><td>N.plus.sp2</td><td>N</td><td>1</td><td>3</td><td>SP2</td><td>0</td><td>1</td></tr>
<tr><td>N.plus.sp1</td><td>N</td><td>1</td><td>2</td><td>SP1</td><td>0</td><td>2</td></tr>
<tr><td>N.plus.sp2.radical</td><td>N</td><td>1</td><td>2</td><td>SP2</td><td>0</td><td>1</td></tr>
<tr><td>N.sp3.radical</td><td>N</td><td>0</td><td>2</td><td>SP3</td><td>1</td><td>0</td></tr>
<tr><td>N.minus.planar3</td><td>N</td><td>-1</td><td>2</td><td>PLANAR3</td><td>2</td><td>0</td></tr>
<tr><td>N.plus</td><td>N</td><td>1</td><td>4</td><td>SP3</td><td>0</td><td>0</td></tr>
<tr><td>N.minus.sp3</td><td>N</td><td>-1</td><td>2</td><td>SP3</td><td>2</td><td>0</td></tr>
<tr><td>N.minus.sp2</td><td>N</td><td>-1</td><td>1</td><td>SP2</td><td>2</td><td>1</td></tr>
<tr><td>N.sp2.radical</td><td>N</td><td>0</td><td>1</td><td>SP2</td><td>1</td><td>1</td></tr>
<tr><td>N.planar3</td><td>N</td><td>0</td><td>3</td><td>PLANAR3</td><td>1</td><td>0</td></tr>
<tr><td>N.amide</td><td>N</td><td>0</td><td>3</td><td>SP2</td><td>1</td><td>0</td></tr>
<tr><td>N.sp2.3</td><td>N</td><td>0</td><td>3</td><td>SP2</td><td>0</td><td>2</td></tr>
<tr><td>N.sp2</td><td>N</td><td>0</td><td>2</td><td>SP2</td><td>1</td><td>1</td></tr>
<tr><td>N.sp1.2</td><td>N</td><td>0</td><td>2</td><td>SP1</td><td>0</td><td>3</td></tr>
<tr><td>N.sp1</td><td>N</td><td>0</td><td>1</td><td>SP1</td><td>1</td><td>2</td></tr>
<tr><td>N.sp3</td><td>N</td><td>0</td><td>3</td><td>SP3</td><td>1</td><td>0</td></tr>
<tr><td>N.thioamide</td><td>N</td><td>0</td><td>3</td><td>SP2</td><td>1</td><td>0</td></tr>
<tr><td>Na.neutral</td><td>Na</td><td>0</td><td>0</td><td></td><td>0</td><td>0</td></tr>
<tr><td>Na.plus</td><td>Na</td><td>1</td><td>0</td><td>S</td><td>0</td><td>0</td></tr>
<tr><td>Na</td><td>Na</td><td>0</td><td>1</td><td>S</td><td>0</td><td>0</td></tr>
<tr><td>Ne</td><td>Ne</td><td>0</td><td>0</td><td></td><td></td><td>0</td></tr>
<tr><td>Ni.2plus</td><td>Ni</td><td>2</td><td>0</td><td></td><td></td><td>0</td></tr>
<tr><td>Ni.metallic</td><td>Ni</td><td>0</td><td>0</td><td></td><td></td><td>0</td></tr>
<tr><td>Ni.plus</td><td>Ni</td><td>1</td><td>1</td><td></td><td></td><td>0</td></tr>
<tr><td>Ni</td><td>Ni</td><td>0</td><td>2</td><td></td><td></td><td>0</td></tr>
<tr><td>O.plus</td><td>O</td><td>1</td><td>3</td><td>SP3</td><td>1</td><td>0</td></tr>
<tr><td>O.sp2.co2</td><td>O</td><td>0</td><td>1</td><td>SP2</td><td>2</td><td>1</td></tr>
<tr><td>O.minus.co2</td><td>O</td><td>-1</td><td>1</td><td>SP3</td><td>3</td><td>0</td></tr>
<tr><td>O.plus.radical</td><td>O</td><td>1</td><td>2</td><td>SP3</td><td>1</td><td>0</td></tr>
<tr><td>O.sp3</td><td>O</td><td>0</td><td>2</td><td>SP3</td><td>2</td><td>0</td></tr>
<tr><td>O.sp2</td><td>O</td><td>0</td><td>1</td><td>SP2</td><td>2</td><td>1</td></tr>
<tr><td>O.plus.sp2</td><td>O</td><td>1</td><td>2</td><td>SP2</td><td>1</td><td>1</td></tr>
<tr><td>O.plus.sp1</td><td>O</td><td>1</td><td>1</td><td>SP1</td><td>1</td><td>2</td></tr>
<tr><td>O.minus2</td><td>O</td><td>-2</td><td>0</td><td>SP3</td><td>4</td><td>0</td></tr>
<tr><td>O.planar3</td><td>O</td><td>0</td><td>2</td><td>PLANAR3</td><td>2</td><td>0</td></tr>
<tr><td>O.minus</td><td>O</td><td>-1</td><td>1</td><td>SP3</td><td>3</td><td>0</td></tr>
<tr><td>O.sp3.radical</td><td>O</td><td>0</td><td>1</td><td>SP3</td><td>2</td><td>0</td></tr>
<tr><td>O.plus.sp2.radical</td><td>O</td><td>1</td><td>1</td><td>SP2</td><td>1</td><td>1</td></tr>
<tr><td>P.ide</td><td>P</td><td>0</td><td>1</td><td>SP1</td><td>1</td><td>2</td></tr>
<tr><td>P.ate.charged</td><td>P</td><td>1</td><td>4</td><td>SP3</td><td>0</td><td>0</td></tr>
<tr><td>P.irane</td><td>P</td><td>0</td><td>2</td><td>PLANAR3</td><td>1</td><td>1</td></tr>
<tr><td>P.se.3</td><td>P</td><td>0</td><td>0</td><td>SP3</td><td>0</td><td>0</td></tr>
<tr><td>P.ine</td><td>P</td><td>0</td><td>3</td><td>SP3</td><td>1</td><td>0</td></tr>
<tr><td>P.ane</td><td>P</td><td>0</td><td>5</td><td>SP3D1</td><td>0</td><td>0</td></tr>
<tr><td>P.ate</td><td>P</td><td>0</td><td>4</td><td>SP3</td><td>0</td><td>1</td></tr>
<tr><td>P.anium</td><td>P</td><td>1</td><td>3</td><td>SP2</td><td>0</td><td>1</td></tr>
<tr><td>P.sp1.plus</td><td>P</td><td>1</td><td>2</td><td></td><td>0</td><td>2</td></tr>
<tr><td>Pb.2plus</td><td>Pb</td><td>2</td><td>0</td><td></td><td></td><td>0</td></tr>
<tr><td>Pb.neutral</td><td>Pb</td><td>0</td><td>0</td><td></td><td></td><td>0</td></tr>
<tr><td>Pb.1</td><td>Pb</td><td>0</td><td>1</td><td>SP1</td><td></td><td>1</td></tr>
<tr><td>Po</td><td>Po</td><td>0</td><td>2</td><td></td><td></td><td>0</td></tr>
<tr><td>Pt.2plus</td><td>Pt</td><td>2</td><td>0</td><td></td><td></td><td>0</td></tr>
<tr><td>Pt.6</td><td>Pt</td><td>0</td><td>6</td><td></td><td></td><td>0</td></tr>
<tr><td>Pt.4</td><td>Pt</td><td>0</td><td>4</td><td></td><td></td><td>0</td></tr>
<tr><td>Pt.2</td><td>Pt</td><td>0</td><td>2</td><td></td><td></td><td>0</td></tr>
<tr><td>Pt.2plus.4</td><td>Pt</td><td>2</td><td>4</td><td></td><td></td><td>0</td></tr>
<tr><td>Pu</td><td>Pu</td><td>0</td><td>0</td><td></td><td></td><td>0</td></tr>
<tr><td>Ra.neutral</td><td>Ra</td><td>0</td><td>0</td><td></td><td></td><td>0</td></tr>
<tr><td>Rb.neutral</td><td>Rb</td><td>0</td><td>1</td><td></td><td>0</td><td>0</td></tr>
<tr><td>Rb.plus</td><td>Rb</td><td>1</td><td>0</td><td></td><td>0</td><td>0</td></tr>
<tr><td>Rn</td><td>Rn</td><td>0</td><td>0</td><td></td><td></td><td>0</td></tr>
<tr><td>Ru.2minus.6</td><td>Ru</td><td>-2</td><td>6</td><td></td><td>0</td><td>0</td></tr>
<tr><td>Ru.6</td><td>Ru</td><td>0</td><td>6</td><td>SP3D2</td><td>0</td><td>0</td></tr>
<tr><td>Ru.3minus.6</td><td>Ru</td><td>-3</td><td>6</td><td></td><td>0</td><td>0</td></tr>
<tr><td>S.plus</td><td>S</td><td>1</td><td>2</td><td>SP2</td><td>1</td><td>1</td></tr>
<tr><td>S.minus</td><td>S</td><td>-1</td><td>1</td><td>SP3</td><td>3</td><td>0</td></tr>
<tr><td>S.inyl.charged</td><td>S</td><td>1</td><td>3</td><td>SP2</td><td>0</td><td>0</td></tr>
<tr><td>S.inyl.2</td><td>S</td><td>0</td><td>2</td><td>SP2</td><td>0</td><td>2</td></tr>
<tr><td>S.planar3</td><td>S</td><td>0</td><td>2</td><td>PLANAR3</td><td>2</td><td>0</td></tr>
<tr><td>S.trioxide</td><td>S</td><td>0</td><td>6</td><td>SP2</td><td>0</td><td>6</td></tr>
<tr><td>S.octahedral</td><td>S</td><td>0</td><td>6</td><td>SP3D2</td><td>0</td><td>0</td></tr>
<tr><td>S.thionyl</td><td>S</td><td>0</td><td>4</td><td>SP3</td><td>0</td><td>2</td></tr>
<tr><td>S.anyl</td><td>S</td><td>0</td><td>4</td><td>SP3D2</td><td>1</td><td>0</td></tr>
<tr><td>S.sp3d1</td><td>S</td><td>0</td><td>5</td><td>SP3D1</td><td>0</td><td>1</td></tr>
<tr><td>S.2</td><td>S</td><td>0</td><td>1</td><td>SP2</td><td>2</td><td>1</td></tr>
<tr><td>S.3</td><td>S</td><td>0</td><td>2</td><td>SP3</td><td>2</td><td>0</td></tr>
<tr><td>S.2minus</td><td>S</td><td>-2</td><td>0</td><td></td><td>4</td><td>0</td></tr>
<tr><td>S.onyl</td><td>S</td><td>0</td><td>4</td><td>SP3</td><td>0</td><td>2</td></tr>
<tr><td>S.oxide</td><td>S</td><td>0</td><td>2</td><td>PLANAR3</td><td>3</td><td>2</td></tr>
<tr><td>S.sp3.4</td><td>S</td><td>0</td><td>4</td><td>SP3</td><td>0</td><td>2</td></tr>
<tr><td>S.inyl</td><td>S</td><td>0</td><td>3</td><td>SP2</td><td>0</td><td>1</td></tr>
<tr><td>S.onyl.charged</td><td>S</td><td>2</td><td>4</td><td>SP3</td><td>0</td><td>2</td></tr>
<tr><td>Sb.4</td><td>Sb</td><td>0</td><td>4</td><td></td><td>0</td><td>1</td></tr>
<tr><td>Sb.3</td><td>Sb</td><td>0</td><td>3</td><td>SP3</td><td>1</td><td>0</td></tr>
<tr><td>Sc.3minus</td><td>Sc</td><td>-3</td><td>6</td><td></td><td>0</td><td>0</td></tr>
<tr><td>Se.2minus</td><td>Se</td><td>-2</td><td>0</td><td></td><td>4</td><td>0</td></tr>
<tr><td>Se.sp3.4</td><td>Se</td><td>0</td><td>4</td><td>SP3</td><td>0</td><td>2</td></tr>
<tr><td>Se.sp2.2</td><td>Se</td><td>0</td><td>2</td><td>SP2</td><td>1</td><td>2</td></tr>
<tr><td>Se.sp3.3</td><td>Se</td><td>0</td><td>3</td><td>SP3</td><td>1</td><td>1</td></tr>
<tr><td>Se.sp3d1.4</td><td>Se</td><td>0</td><td>4</td><td>SP3D1</td><td>1</td><td>0</td></tr>
<tr><td>Se.4plus</td><td>Se</td><td>4</td><td>0</td><td></td><td>0</td><td>0</td></tr>
<tr><td>Se.plus.3</td><td>Se</td><td>1</td><td>3</td><td>SP3</td><td>1</td><td>0</td></tr>
<tr><td>Se.3</td><td>Se</td><td>0</td><td>2</td><td>SP3</td><td>2</td><td>0</td></tr>
<tr><td>Se.2</td><td>Se</td><td>0</td><td>0</td><td></td><td>0</td><td>0</td></tr>
<tr><td>Se.1</td><td>Se</td><td>0</td><td>1</td><td>SP2</td><td>2</td><td>1</td></tr>
<tr><td>Se.5</td><td>Se</td><td>0</td><td>5</td><td>SP3D1</td><td>0</td><td>1</td></tr>
<tr><td>Si.2minus.6</td><td>Si</td><td>-2</td><td>6</td><td>SP3D2</td><td>0</td><td>0</td></tr>
<tr><td>Si.sp3</td><td>Si</td><td>0</td><td>4</td><td>SP3</td><td>0</td><td>0</td></tr>
<tr><td>Si.3</td><td>Si</td><td>0</td><td>3</td><td>SP3</td><td>0</td><td>1</td></tr>
<tr><td>Si.2</td><td>Si</td><td>0</td><td>2</td><td>SP1</td><td>0</td><td>2</td></tr>
<tr><td>Sn.sp3</td><td>Sn</td><td>0</td><td>4</td><td>SP3</td><td>0</td><td>0</td></tr>
<tr><td>Sr.2plus</td><td>Sr</td><td>2</td><td>0</td><td></td><td>0</td><td>0</td></tr>
<tr><td>Te.3</td><td>Te</td><td>0</td><td>2</td><td>SP3</td><td>2</td><td>0</td></tr>
<tr><td>Te.4plus</td><td>Te</td><td>4</td><td>0</td><td></td><td>1</td><td>0</td></tr>
<tr><td>Th</td><td>Th</td><td>0</td><td>0</td><td></td><td></td><td>0</td></tr>
<tr><td>Ti.2</td><td>Ti</td><td>0</td><td>2</td><td></td><td>0</td><td>2</td></tr>
<tr><td>Ti.sp3</td><td>Ti</td><td>0</td><td>4</td><td>SP3</td><td>0</td><td>0</td></tr>
<tr><td>Ti.3minus</td><td>Ti</td><td>-3</td><td>6</td><td></td><td>0</td><td>0</td></tr>
<tr><td>Tl.1</td><td>Tl</td><td>0</td><td>1</td><td>SP1</td><td>1</td><td>0</td></tr>
<tr><td>Tl</td><td>Tl</td><td>0</td><td>0</td><td></td><td>0</td><td>0</td></tr>
<tr><td>Tl.plus</td><td>Tl</td><td>1</td><td>0</td><td></td><td>0</td><td>0</td></tr>
<tr><td>V.3minus</td><td>V</td><td>-3</td><td>6</td><td></td><td>0</td><td>0</td></tr>
<tr><td>V.3minus.4</td><td>V</td><td>-3</td><td>4</td><td></td><td>0</td><td>1</td></tr>
<tr><td>W.metallic</td><td>W</td><td>0</td><td>0</td><td></td><td></td><td>0</td></tr>
<tr><td>Xe</td><td>Xe</td><td>0</td><td>0</td><td></td><td></td><td>0</td></tr>
<tr><td>Xe.3</td><td>Xe</td><td>0</td><td>4</td><td>SP3D2</td><td></td><td>0</td></tr>
<tr><td>Zn.metallic</td><td>Zn</td><td>0</td><td>0</td><td></td><td></td><td>0</td></tr>
<tr><td>Zn.2plus</td><td>Zn</td><td>2</td><td>2</td><td>S</td><td>0</td><td>0</td></tr>
<tr><td>Zn.1</td><td>Zn</td><td>0</td><td>1</td><td></td><td></td><td>1</td></tr>
<tr><td>Zn</td><td>Zn</td><td>0</td><td>2</td><td></td><td></td><td>0</td></tr>
</table>

## Sybyl Atom Types


