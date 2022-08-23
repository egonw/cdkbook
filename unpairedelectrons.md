# Paired and unpaired electrons

The CDK data model supports more than just the chemical graph.
We have seen atoms and bonds earlier, the bonds being atoms
sharing electrons. Atoms, however, can also have electrons
in the valence shell not involved in bond: free electon (lone)
pairs, and unpaired electrons as found in radicals.

But before we look at how we add paired and unpaired electrons,
we should first look at the two principle classes involved
in representing these concepts. Like bonds,
a free electron pair and a unpaired electron are bound to
the atom. Depending on the theory used, the exact environment
which holds the electrons can be named differently. For
example, they might be referred to as orbitals, atomic or
molecular. The CDK simply refers to the holder as
<a name="tp1">IElectronContainer</a>s, and has several subinterfaces
for bonds ([`IBond`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/interfaces/IBond.html)), lone pairs ([`ILonePair`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/interfaces/ILonePair.html)),
and unpaired electrons ([`ISingleElectron`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/interfaces/ISingleElectron.html)), as
shown in Figure [7.1](#fig:ecInheritance).

<a name="fig:ecInheritance"></a>
![](images/electronContainerInheritance.png)
<br />**Figure 7.1**: The `IBond`, `ILonePair`, and `ISingleElectron` interfaces all extend the `IElectronContainer` interface.

## Lone Pairs

Oxygens are atoms with <a name="tp2">lone pairs</a>: the free electrons that do
not take part in a bond. These lone pairs can be explicitly modeled
in the CDK. For example, this is how we can represent <a name="tp3">water</a>:

**<a name="script:LonePairOxygen">Script 6.1</a>** [code/LonePairOxygen.groovy](code/LonePairOxygen.code.md)
```groovy
IAtom atom1 = new Atom("H")
IAtom atom2 = new Atom("H")
IAtom atom3 = new Atom("O")
IBond bond1 = new Bond(atom1, atom2, IBond.Order.SINGLE)
IBond bond2 = new Bond(atom2, atom3, IBond.Order.SINGLE)
IAtomContainer water = new AtomContainer()
water.addAtom(atom1)
water.addAtom(atom2)
water.addAtom(atom3)
water.addBond(bond1)
water.addBond(bond2)
water.addLonePair(new LonePair(atom3))
water.addLonePair(new LonePair(atom3))
```

And we can the count the number of lone pair on each atom with,
for example, this code:

**<a name="script:LonePairCount">Script 6.2</a>** [code/LonePairCount.groovy](code/LonePairCount.code.md)
```groovy
for (atom in water.atoms()) {
  println atom.getSymbol() + " has " +
    water.getConnectedLonePairsCount(atom) +
    " lone pairs" 
}
```

which gives us:

```plain
H has 0 lone pairs
H has 0 lone pairs
O has 2 lone pairs
```

## Unpaired electrons

An <a name="tp4">unpaired electron</a> on an atom makes that atom a
<a name="tp5">radical</a>. Radicals are common mass spectroscopy and as the
latter is an important use case of the CDK, unpaired electrons
are well-supported in the data model.

We can add an unpaired electron with the `addSingleElectron`
method of the [`IAtomContainer`](http://cdk.github.io/cdk/latest/docs/api/org/openscience/cdk/interfaces/IAtomContainer.html) class.

**<a name="script:HydrogenRadical">Script 6.3</a>** [code/HydrogenRadical.groovy](code/HydrogenRadical.code.md)
```groovy
hydrogen = new Atom("H")
radicalElectron =
  new SingleElectron(hydrogen)
hydrogenRadical = new AtomContainer()
hydrogenRadical.addAtom(hydrogen)
hydrogenRadical.addSingleElectron(radicalElectron)
```

