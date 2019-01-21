# Salts and other disconnected structures

In the Section <xref>molecules</xref> we saw how atoms and bonds are contained in
the `IAtomContainer` data model. It was mentioned that 
it is a general container, and this is exactly what we need for disconnected
structures like salts and molecular crystal structures.

Functionality to determine if the content of an IAtomContainer is
connected, you can use the `ConnectivityChecker`, as explained in
Section XXX.

## Salts

Salts are one of the most common disconnected structures found in compound
databases: a <topic>salt</topic> is a combination of two or more connected molecules
bound to each other by coulombic interactions. These may be solids.

A common kitchen example is the table salt sodium chloride. We can
represent this using the following model:

<code>Salt</code>

If you prefer a single `IAtomContainer` to only contain connected
atoms, instead of unbound atoms as in this salt example, you can
partition them into two or more new containers, as explained in
Section XX.

![](images/crystal.png) <br />
**Figure**: The `ICrystal` interface extends the `IAtomContainer` interface.

## Crystals

Of course, the representation given in the previous section
is a very basic model for sodium chloride. A <topic>crystal</topic>
structure would perhaps be a more accurate description of what you
like to represent. In this case, the <topic type="class">ICrystal</topic> subclass of
the `IAtomContainer` can be used (see Figure `):

<code>SaltCrystal</code>

If we want to add the crystal structure parameters and crystal
structure coordinates of the atoms, we add can add them too (data
taken from [this webpage](http://www.ilpi.com/inorganic/structures/nacl/)):

<code>SaltCrystalParam</code>

## References

<references/>

