# Molecular Properties

Cheminformatics is about molecular properties and chemistry in general the field
of finding chemicals with new properties. [Prof. Gasteiger](https://tools.wmflabs.org/scholia/author/Q109081)
in 2006 gave a lecture at Cologne University where he expressed this view. It stuck around. We keep
databases to store those properties, and we develop methods to predict and understand
those properties. Prediction is important for one reason: there are too many
chemical structures and we cannot experimentally measure the properties for all
of them. The number of molecules is often said to be relevant to drug discovery is in
the order of 10<sup>60</sup>. The largest current databases have less than 10<sup>8</sup>
structures. That means that prediction of properties for the vast majority
of molecules will remain relevant for the foreseeable future.

This chapter will show how the CDK can be used to calculate a number of molecular
properties.

## Molecular Mass

The simplest but perhaps the most reported molecular property is the <topic>molecular mass</topic>.
It is important to realize this mass is not constant, and depends on the natural
mixture of isotopes, which is not constant itself. If you have an atom container
with explicit hydrogens, you can loop over the atoms to calculate the molecular
mass as summation of the masses of the individual atoms:

<code>CalculateMolecularWeight</code>

In this case, you can also use the <class>AtomContainerManipulator</class>:

<code>CalculateMolecularWeightShort</code>

The element masses are calculated from the accurate isotope masses and natural
abundances defined in the Blue Obelisk Data Repository [<cite>Q27062363</cite>].

### Implicit Hydrogens

If your atom container has <topic>implicit hydrogens</topic> specified, you will have the above
code will not be sufficient. Instead, your code should look like:

<code>CalculateMolecularWeightImplicitHydrogens</code>


<section level="##" label="properties:logp">LogP</section>

The <topic>partition coefficient</topic> describes how a molecular structure distributes
itself over two immiscible solvents. The logarithm of the partition coefficient (<topic>LogP</topic>) between
octanol and water is often used in cheminformatics to describe hydrophobicity [<cite>Q55954394</cite>,<cite>Q63367539</cite>].
Wikipedia gives [this equation](http://en.wikipedia.org/wiki/Partition_coefficient).
This equation assumes that the solute is neutral, which may involve changing the pH of the water.

The CDK has implemented an algorithm based on the <topic>XLogP</topic> algorithm [<cite>Q28842968</cite>,<cite>Q63367548</cite>]. The
code is available via the descriptor API. It can be used to calculate the LogP for a single
molecule. The implementation expects explicit hydrogens, so you need to add those if not
present yet (see Section <xref>missinghydrogens</xref>). The calculation returns a <class>DoubleResult</class>
following the descriptor API:

<code>XLogP</code>

which returns:

<out>XLogP</out>

An alternative is the more recent algorithm by Plante [<cite>Q59771351</cite>].

<section level="##" label="tpsa">Total Polar Surface Area</section>

Another properties that frequently returns in cheminformatics is the <topic>Total Polar Surface Area</topic>
(<topic>TPSA</topic>). The code in the CDK uses an algorithm published by Ertl in 2000 [<cite>Q28842810</cite>].
Here too, the descriptor API is used, so that the code is quite similar to that for the logP
calculation:

<code>TPSA</code>

which returns:

<out>TPSA</out>


## Van der Waals Volume

Quite related to the TPSA discussed in the previous section, is the actual <topic>molecular volume</topic>
itself. Zhao et al. proposed a simple, additive model to estimate the <topic>van der waals volume</topic>
of molecules [<cite>Q47632144</cite>], though their method is restricted to molecules with only these elements:
H, C, N, O, F, Cl, Br, I, P, S, As, B, Si, Se, and Te. The additive method is based on averaged
volumes of the bonds, corrected for the number of rings. The bond volumes are specific for
particular element-element combinations, which explains why their approach only works for the
aforementioned list of elements. The full method is implemented by the <class>VABCVolume</class> class,
which does not use the descriptor API, so that we can simply use the following method:

<code>VABCVolumes</code>

This code gives us the volumes of methane and ethane in cubic Ångström:

<out>VABCVolumes</out>


<section level="##" label="aromaticity">Aromaticity</section>

I am not fond of the <topic>aromaticity</topic> concept; first of all, because there is no universal definition.
Most cheminformatics toolkits have different definitions of aromaticity, and so does the CDK.
If a compound is aromatic, and if so, which atoms and bonds are involved in an aromatic system
are not easily defined. Ultimately, it is the delocalization energies that has a large influence
on this, which are hard to reproduce with heuristic rules in chemical graph theory-based
algorithms.

The CDK now implements various models, all accessible via the <class>Aromaticity</class> class.
The models are parameterized: what rings are taken into account, and how many electrons do
various atoms contribute. The combination of these two aspect explains most of the differences
in aromaticity as calculated with various cheminformatics libraries. The CDK can calculate
most of them by selecting the right <class>ElectronDonation</class> and <class>CycleFinder</class>:

<code>AromaticityDemo</code>

which tells us that

<out>AromaticityDemo</out>

Furthermore, if you wish to know which bonds are aromatic, the same class can be used:

<code>AromaticBonds</code>

which reports the aromatic bonds:

<out>AromaticBonds</out>


## References

<references/>
