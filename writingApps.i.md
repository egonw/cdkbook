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

Given you already downloaded the [CDK jar](https://github.com/cdk/cdk/releases/tag/cdk-2.7.1) file,
or compiled it from scratch, consider the following piece of
Java source code:

<pre>
import org.openscience.cdk.interfaces.IAtom;
import org.openscience.cdk.silent.Atom;

public class BasicProgram {
    public static void main(String args[]) throws Exception {
        IAtom atom = new Atom("C");
        System.out.println(atom);
    }
}
</pre>

This <topic type="key">Java application</topic> can then be compiled with <topic>javac</topic> to byte code, creating a
`BasicProgram.class`:

```shell
$ javac -classpath cdk-<version/>-<minor/>.jar BasicProgram
```

And then run with:

```shell
$ java -classpath .:cdk-<version/>-<minor/>.jar BasicProgram
```

The downside of pure Java applications is the relative overhead
needed to define an application. Other programming language provide
a simpler syntax, including the BeanShell, Groovy, and Clojure
described below.
