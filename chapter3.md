#  Atoms, Bonds and Molecules

The basic objects in the CDK are the IAtom, IBond and IAtomContainer [1].
The name of the latter is somewhat misleading, as it contains
not just IAtoms but also IBonds. The primary use of the model is the
graph-based representation of molecules, where bonds are edges between
two atoms being the nodes [2].

Before we start, it is important to note that CDK 1.5.10 has an important
convention around object properties: when a property is unset, the ob-
ject’s field is set to null. This brings in sources for NullPointerExceptions,
but also allows us to distinguish between, for example, zero and unset for-
mal charge. In the former case, the formal charge value be set and have
a zero value; in the latter case, the field has a null value, indicating the
formal charge is currently unknown.

## Atoms

The CDK interface IAtom is the underlying data model of atoms. Creating
a new atom is fairly easy. For example, we can create an atom of element
type carbon, as defined by the element’s symbol that we pass as parameter
in the constructor:

```groovy
IAtom atom = new Atom("C");
```

## References

1. C. Steinbeck, Y. Han, S. Kuhn, O. Horlacher, E. Luttmann, E. Willighagen, The Chemistry Development Kit (CDK): An Open-Source Java Library for Chemo- and Bioinformatics, J. Chem. Inf. Comput. Sci. 2003, 43, 493–500.
2. A. T. Balaban, Applications of graph theory in chemistry, Journal of Chemical Information and Computer Sciences 1985, 25, 334–343.
