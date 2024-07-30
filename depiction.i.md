<section label="ch:depiction" level="#">Depiction</section>

The CDK originates from the merger of Jmol and <topic>JChemPaint</topic> [<cite>Q27093381</cite>]. As such, CDK has long
contained code to depict molecules. However, after the 1.0 series, a rewrite of the code base
was initiated, causing the CDK 1.2 series to not be available with <topic>rendering</topic> functionality.
During the development of the 1.4 series, the rendering code became gradually available as
a set of patches, and, separately, as a JChemPaint applet. The new rendering code has
entered the CDK.

However, if you need rendering of reaction schemes or the editing functionality found
in JChemPaint, you still need the <topic>CDK-JChemPaint</topic> patch.

## Molecules

Rendering molecules to an image is done in a few steps. First, an <class>Image</class> needs
to be defined, for example, of 200 by 200 pixels. The next step is to define what is to be
generated, and how. The most basic rendering requires a few generators: one for the overall
scene, one for atoms, and one for bonds. Therefore, we add a <class>BasicSceneGenerator</class>,
a <class>BasicAtomGenerator</class>, and a <class>BasicBondGenerator</class>.
We will see later that we can add further generators to add further visualization.
Now that we defined what we want to have depicted, we construct a renderer. Because we
are rendering a molecule here, we simply use the <class>AtomContainerRenderer</class>.

<figure label="fig:triazole" caption="2D diagram of triazole">
![](images/generated/RenderMolecule.png) <br />
</figure>

We also need to define, however, what rendering platform we want to use. The Java
community has a few options, with the AWT/Swing platform to be the reference implementation
provided by Oracle, and the SWT toolkit as a popular second. In fact, the redesign
was needed to be able to support both widget toolkits. For rendering images,
we can use the AWT toolkit. Therefore, we use a <class>AWTFontManager</class> to help the
renderer draw texts. We get our <class>Graphics2D</class> object to which will be drawn from the
earlier created image, and we set some basic properties.
Then we are ready to draw the molecule to the graphics object with the `paint()`
method, and here again we need a AWT-specific class: the <class>AWTDrawVisitor</class>.

What then remains is to save the image to a <topic>PNG</topic> image file with the
<class>ImageIO</class> helper class.

The full code example then looks like:

<code>RenderMolecule</code>

This results in the image of triazole given in Figure <xref>fig:triazole</xref>.

## Background color

Starting from the common pattern to set up a renderer used in the earlier sections,
you can also customize the <topic>background color</topic>. This too uses a parameter, but the
color is also passed to the `Graphics2D` object:

<code>BackgroundColor</code>

The result of this code is depicted in Figure <xref>fig:backgroundColor</xref>.

<figure label="fig:backgroundColor" caption="Triazole depicted with a custom, grey background.">
![](images/generated/BackgroundColor.png) <br />
</figure>

## References

<references/>
