<section level="#" label="inchi">InChI</section>

The IUPAC International Chemical Identifier (<topic>InChI</topic>, 
[http://www.iupac.org/inchi/](http://www.iupac.org/inchi/)) is an identifier developed
to provide a database-independent, unique identifier for small organic
molecules [<cite>Stein2003</cite>]. The CDK uses the <topic>JNI-InChI</topic> library by Adams
([http://jni-inchi.sf.net/](http://jni-inchi.sf.net/)) to provides
a Java layer on top of the open source InChI library written in C.
The InChI is design to be unique for molecules, and one InChI always identifies
the same molecule, and as such is aimed to be used to look up molecules in
databases or on the internet [<cite>Q27062596</cite>,<cite>Q28133283</cite>].

To overcome the common problem caused by <topic>tautomerism</topic> in database look up,
the InChI applies a number of rules to determine what the possible tautomers
for a particular chemical graph are. This makes it possible to find ethanal
in a database when the less-stable tautomer ethenol was searched. Both give
rise to the same InChI, as we will see later.

First, we need to see how we can generate InChIs in the CDK. It starts with
an <class>InChIGeneratorFactory</class> to create an <class>InChIGenerator</class>. This
generator is then used to run the InChI software on the given molecule. The
algorithm might fail, for various reasons, and we need to check if the
generation succeeded too:

<code>InChIGeneration</code>

which gives the InChI for methane:

<out>InChIGeneration</out>

This snippet of code has generated us a <topic>Standard InChI</topic>. To explain
what a Standard InChI is, we first need to briefly look at the layers in
InChIs.

## Layers

An InChI is like an onion. No, not in the sense that it makes you
cry, but in the sense that is has layers {See *Shrek*).
Each layer adds more detailed information to the InChI of a molecule.
The aforementioned InChI for methane has a layer reflecting the molecular
formula (*/CH4*) and a hydrogen layer showing the number of
hydrogens for each atom (*/h1H4*). Except for the molecular formula
layer, most layers start with a lower case character, as is visible in the
hydrogen layer, indicated by the (*/h*).

Another important thing to note is that hydrogens are not explicitly
defined in the connection table (see Section <xref>hydrogens</xref>).
Therefore, the InChI for methane does not have a connectivity layer,
but formic acid, *mierezuur* in Dutch, does (*/c2-1-3*):

<out>InChIMierezuur</out>

You see that the <topic>connectivity layer</topic> shows how the atoms are connected, and
this layer it does not give bond orders. The atom numbering follows the molecular
formula, where the hydrogens are not numbered. Therefore, the carbon
has atom number 1, while the oxygens are atoms 2 and 3.

Now, have a careful look at this InChI for formic acid. Take a few minutes for
this, and make sure you fully understand the connectivity and hydrogen
layers (the answer is given in code snippet <xref>script:InChIMierezuurFixed</xref>).

Other layers the InChI supports include those for, for example, stereochemistry.
The InChI software has a number of option to enable or disable certain layers.
This explains the existence of the <topic>Standard InChI</topic>. This version of
the InChI is created when a particular set of layers is used, allowing the
InChI string to be used as <topic>unique identifier</topic>: because it removes the
choice of layers, one molecule always has the same standard InChI, whereas
a molecule can have multiple InChI string depending on turning on or off certain
layers. However, it is of utmost importance to realize that a particular InChI
layer is always unique to the molecule, independent of layers being added
or removed.

A Standard InChI string is identified by the *1S* version number. If
non-standard layers are turned on, the version is simply *1*, as we will
see shortly.

### Fixed Hydrogens

If you had not cheated in the mierezuur exercise, you will have noted that one
hydrogen is delocalized: it can be attached to either of the oxygens. This
feature is picked up by the InChI algorithm to compensate for certain kinds
of <topic>tautomerism</topic>. If we want to fix the hydrogens to a particular
atom, we use the following code:

<code>InChIMierezuurFixed</code>

which results in this non-standard InChI:

<out>InChIMierezuurFixed</out>

By adding the <topic>FixedH option</topic> for the InChI algorithm, we added the
<topic>fixed hydrogen layer</topic> (*/f/h2H*). This additional layer assigns
one mobile hydrogen to the second atom, which is the first oxygen.

<!-- <code>RenderAdenine</code> -->
<figure label="adenine" caption="2D diagram of one of the tautomers of adenine.">
![](images/generated/RenderAdenine.png)
</figure>

### Stereoisomerism

Another interesting layer to look at is the <topic>stereoisomerism</topic> layer. Particular,
because databases often disagree on the exact <topic>stereochemistry</topic> of molecules, which is
weird but commonplace, unfortunately [Williams2012blog]. The standard InChIs for 
the two stereoisomers of bromo cholo fluoro methane result in two different InChIs:

<code>InChIStereoisomerism</code>

The differences are found in the stereochemistry related layers, `/t` and `/m`.
The first layer captures tetrahedral stereochemistry, while the other layer captures mirror
image. And because we started with two mirror image structures, the `/t` layer is
identical, and we the difference in the `/m` layer:

<out>InChIStereoisomerism</out>

Because of the aforementioned database comparison argument, there is an important use case in
comparing InChIs without the stereochemistry layers. To create such InChIs, you can use the
<topic>SNon option</topic>:

<code>InChINoStereoisomerism</code>

And then the InChIs for both structures are identical:

<out>InChINoStereoisomerism</out>

One important caveat: chiral information as read by the SMILES parser is not currently converted
into stereo information for the InChI generation process!



## References

<references/>

