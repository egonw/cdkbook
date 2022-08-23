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

Given you already downloaded the [CDK jar](https://github.com/cdk/cdk/releases/tag/cdk-<version/>) file,
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

This <topic type="key">Java application</topic> can then be compiled with <topic>javac</topic> to byte code, creating a
`BasicProgram.class`:

```shell
$ javac -classpath cdk-<version/>.jar BasicProgram
```

And then run with:

```shell
$ java -classpath .:cdk-<version/>.jar BasicProgram
```

The downside of pure Java applications is the relative overhead
needed to define an application. Other programming language provide
a simpler syntax, including the BeanShell, Groovy, and Clojure
described below.

## Groovy

<topic type="key">Groovy</topic> ([http://www.groovy-lang.org/](http://www.groovy-lang.org/)) is a programming language that
advertizes itself as \emph{an agile and dynamic language for the Java
Virtual Machine}. It provides an environment to quickly
try Java code, but it provides more linguistic changes
to the Java language, and adds quite interesting sugar too.

A simple script may look like:

<code>IterateAtoms</code>

But in Groovy it can also look like:

<code>IterateAtomsGroovy</code>

## Python

Using [ScyJava](https://github.com/scijava/scyjava), the CDK can also be used in Python, for example, in a [Jupyter notebook
on Google Colab](https://colab.research.google.com/github/egonw/chempyformatics/blob/main/docs/nb/CreateAtom3.ipynb).

```python
from scyjava import config, jimport
config.add_endpoints('org.openscience.cdk:cdk-bundle:<version/>')
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
interface [<cite>Q21093640</cite>,<cite>Q21284369</cite>]. Functionality is provided using `managers`,
and CDK functionality is provided using two such managers. Bioclipse 2.6.2 was the
last release using the Eclipse UI, but [Bacting](https://github.com/egonw/bacting) allows you to run Bioclipse
scripts from the command line [<cite>Q107332190</cite>].

### Cinfony

Cinfony is a Python module that integrates to the CDK as well as other
cheminformatics toolkits [<cite>Q27499065</cite>]. Cinfony can be downloaded from [https://cinfony.github.io/](https://cinfony.github.io/].

### R

The statistical software R ([http://www.r-project.org/](http://www.r-project.org/)) also provide
access to the CDK functionality via the rcdk package [<cite>Q28838068</cite>,<cite>Q94317027</cite>]. This
package can be downloaded from CRAN from \url{http://cran.r-project.org/web/packages/rcdk/}.

## References

<references/>
