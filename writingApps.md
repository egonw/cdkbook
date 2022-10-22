# Writing CDK Applications

This book gave a lot of small code snippets, which can easily be integrated
in larger programs. But the book has not shown so far what such a larger
program can look like. This book is not about Java programming, and therefore
did not introduce those aspects of using the CDK.
Nevertheless, this section gives a brief introduction on how to write a
Java application, a BeanShell script, and a Groovy script. Most code snippets
in this book are actually Groovy scripts, but [this repository](https://egonw.github.io/chempyformatics/)
has some Jupyter notebook examples.

## A (Very) Basic Java Application

Given you already downloaded the [CDK jar](https://github.com/cdk/cdk/releases/tag/cdk-2.8) file,
or compiled it from scratch, consider the following piece of
Java source code:

```java
import org.openscience.cdk.interfaces.IAtom;
import org.openscience.cdk.silent.Atom;

public class BasicProgram {
    public static void main(String args[]) throws Exception {
        IAtom atom = new Atom("C");
        System.out.println(atom);
    }
}
```

This <a name="tp1">`Java application`</a> can then be compiled with <a name="tp2">javac</a> to byte code, creating a
`BasicProgram.class`:

```shell
$ javac -classpath cdk-2.8.jar BasicProgram
```

And then run with:

```shell
$ java -classpath .:cdk-2.8.jar BasicProgram
```

The downside of pure Java applications is the relative overhead
needed to define an application. Other programming language provide
a simpler syntax, including the BeanShell, Groovy, and Clojure
described below.

## Groovy

<a name="tp3">`Groovy`</a> ([http://www.groovy-lang.org/](http://www.groovy-lang.org/)) is a programming language that
advertizes itself as \emph{an agile and dynamic language for the Java
Virtual Machine}. It provides an environment to quickly
try Java code, but it provides more linguistic changes
to the Java language, and adds quite interesting sugar too.

A simple script may look like:

**Script** [code/IterateAtoms.groovy](code/IterateAtoms.code.md)
```groovy
for (IAtom atom : molecule.atoms()) {
  System.out.println(atom.getSymbol());
}
```

But in Groovy it can also look like:

**Script** [code/IterateAtomsGroovy.groovy](code/IterateAtomsGroovy.code.md)
```groovy
for (atom in molecule.atoms()) {
   println atom.getSymbol()
}
```

### Closures

One of the more interesting features of Groovy is something called
<a name="tp4">`closures`</a>.
I have know this programming pattern from R and happily used for a long time,
but only recently learned them to be called closures. Closures allow you to
pass a method as a parameter, which can have many applications, and I will show one
situation here.

Consider the calculation of molecular properties which happen to be a
mere summation over atomic properties, such as the total charge, or
the molecular weight. Both these calculations require an iteration over all
atoms. If we need those properties at the same time, we can combine the
calcultion into one iteration. However, for the purpose of this section,
we will not combine the two calculations to use one iteration, but use
closures instead.

Therefore, we have two slices of code which share a large amount of
source code statements:

**Script** [code/CalculateTotalCharge.groovy](code/CalculateTotalCharge.code.md)
```groovy
totalCharge = 0.0
for (atom in molecule.atoms()) {
  totalCharge += atom.getCharge()
}
```

and

**<a name="script:CalculateMolecularWeight">Script 16.1</a>** [code/CalculateMolecularWeight.groovy](code/CalculateMolecularWeight.code.md)
```groovy
molWeight = 0.0
for (atom in molecule.atoms()) {
  molWeight += isotopeInfo.getNaturalMass(atom)
}
```

In both cases we want to apply a custom bit of code to all atoms, while
the iteration over the atoms is identical. Groovy allows
us to share the common code, by defining a \code{forAllAtoms} function
into which we inject a code block using closures:

**Script** [code/GroovyClosureForAllAtoms.groovy](code/GroovyClosureForAllAtoms.code.md)
```groovy
def forAllAtoms(molecule, block) {
  for (atom in molecule.atoms()) {
    block(atom)
  }
}
totalCharge = 0.0
forAllAtoms(molecule, { totalCharge += it.getCharge() } )
totalCharge = String.format('%.2f', totalCharge)
println "Total charge: ${totalCharge}"
molWeight = 0.0
forAllAtoms(molecule, {
  molWeight += isotopeInfo.getNaturalMass(it)
} )
molWeight = String.format('%.2f', molWeight)
println "Molecular weight: ${molWeight}"
```

which gives the output:

```plain
Total charge: -0.00
Molecular weight: 16.04
```

This language feature makes it possible to write more compact code. 

### Grabbing dependencies

The introduction of this section showed how to use the environment variable
`CLASSPATH` to define where to find dependencies. Groovy has, however,
a different way of doing this too, allowing it to `grab` its dependencies.

```groovy
@Grab(group='org.openscience.cdk', module='cdk-io', version='2.8')
@Grab(group='org.openscience.cdk', module='cdk-silent', version='2.8')
```

## Python

Using [ScyJava](https://github.com/scijava/scyjava), the CDK can also be used in Python, for example, in a [Jupyter notebook
on Google Colab](https://colab.research.google.com/github/egonw/chempyformatics/blob/main/docs/nb/CreateAtom3.ipynb).

```python
from scyjava import config, jimport
config.add_endpoints('org.openscience.cdk:cdk-bundle:2.8')
SmilesParser = jimport('org.openscience.cdk.smiles.SmilesParser')
Builder = jimport('org.openscience.cdk.silent.SilentChemObjectBuilder')

sp = SmilesParser(Builder.getInstance())
mol = sp.parseSmiles("CC(=O)OC1=CC=CC=C1C(=O)O")
print(f"Aspirin has {mol.getAtomCount()} atoms.")
```

## Other environments

There are even other languages at your disposal for using
the CDK library. This book will mostly use Groovy code snippets,
but this section points a few alternatives.
These alternatives do not always provide access to the full CDK API, but at the
same time often do offer a customized API which hides certain more technical details.

### Bioclipse

Bioclipse has a custom scripting language with a JavaScript
interface [<a href="#citeref1">1</a>,<a href="#citeref2">2</a>]. Functionality is provided using `managers`,
and CDK functionality is provided using two such managers. Bioclipse 2.6.2 was the
last release using the Eclipse UI, but [Bacting](https://github.com/egonw/bacting) allows you to run Bioclipse
scripts from the command line [<a href="#citeref3">3</a>].

### Cinfony

Cinfony is a Python module that integrates to the CDK as well as other
cheminformatics toolkits [<a href="#citeref4">4</a>]. Cinfony can be downloaded from [https://cinfony.github.io/](https://cinfony.github.io/).

### R

The statistical software R ([http://www.r-project.org/](http://www.r-project.org/)) also provide
access to the CDK functionality via the rcdk package [<a href="#citeref5">5</a>,<a href="#citeref6">6</a>]. This
package can be downloaded from CRAN from [https://cran.r-project.org/web/packages/rcdk/](https://cran.r-project.org/web/packages/rcdk/).

## References

1. <a name="citeref1"></a>Spjuth O, Helmus T, Willighagen EL, Kuhn S, Eklund M, Wagener J, et al. Bioclipse: an open source workbench for chemo- and bioinformatics. BMC Bioinf [Internet]. 2007 Feb 22;8(1):59. Available from: http://bmcbioinformatics.biomedcentral.com/track/pdf/10.1186/1471-2105-8-59 doi:[10.1186/1471-2105-8-59](https://doi.org/10.1186/1471-2105-8-59) ([Scholia](https://scholia.toolforge.org/doi/10.1186/1471-2105-8-59))
2. <a name="citeref2"></a>Spjuth O, Alvarsson J, Berg A, Eklund M, Kuhn S, Mäsak C, et al. Bioclipse 2: a scriptable integration platform for the life sciences. BMC Bioinf [Internet]. 2009;10(1):397. Available from: http://bmcbioinformatics.biomedcentral.com/track/pdf/10.1186/1471-2105-10-397 doi:[10.1186/1471-2105-10-397](https://doi.org/10.1186/1471-2105-10-397) ([Scholia](https://scholia.toolforge.org/doi/10.1186/1471-2105-10-397))
3. <a name="citeref3"></a>Willighagen E. Bacting: a next generation, command line version of Bioclipse. JOSS. 2021 Jun 23;6(62):2558.  doi:[10.21105/JOSS.02558](https://doi.org/10.21105/JOSS.02558) ([Scholia](https://scholia.toolforge.org/doi/10.21105/JOSS.02558))
4. <a name="citeref4"></a>O’Boyle N, Hutchison GR. Cinfony – combining Open Source cheminformatics toolkits behind a common interface. Chemistry Central Journal. 2008;2(1):24.  doi:[10.1186/1752-153X-2-24](https://doi.org/10.1186/1752-153X-2-24) ([Scholia](https://scholia.toolforge.org/doi/10.1186/1752-153X-2-24))
5. <a name="citeref5"></a>Guha R. Chemical Informatics Functionality in R. Journal of Statistical Software. 2007;18(5).  doi:[10.18637/JSS.V018.I05](https://doi.org/10.18637/JSS.V018.I05) ([Scholia](https://scholia.toolforge.org/doi/10.18637/JSS.V018.I05))
6. <a name="citeref6"></a>Voicu A, Duteanu N, Voicu M, Vlad D, Dumitrascu V. The rcdk and cluster R packages applied to drug candidate selection. J Cheminform. 2020 Jan 20;12.  doi:[10.1186/S13321-019-0405-0](https://doi.org/10.1186/S13321-019-0405-0) ([Scholia](https://scholia.toolforge.org/doi/10.1186/S13321-019-0405-0))

