# Molecular Properties

Cheminformatics is about molecular properties and chemistry in general the field
of finding chemicals with new properties. Prof. Gasteiger in 2006 gave a
lecture at Cologne University where he expressed this view. It stuck around. We keep
databases to store those properties, and we develop methods to predict and understand
those properties. Prediction is important for one reason: there are too many
chemical structures and we cannot experimentally measure the properties for all
of them. The number of molecules is often said to be relevant to drug discovery is in
the order of $10^{60}$. The largest current databases have less than $10^{8}$
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

<section level="##" label="tpsa">Total Polar Surface Area</section>

Another properties that frequently returns in cheminformatics is the <topic>Total Polar Surface Area</topic>
(<topic>TPSA</topic>). The code in the CDK uses an algorithm published by Ertl in 2000 [<cite>Q28842810</cite>].
Here too, the descriptor API is used, so that the code is quite similar to that for the logP
calculation:

<code>TPSA</code>

which returns:

<out>TPSA</out>

## References

<references/>
