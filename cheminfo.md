# Cheminformatics

While the purpose of this book is not to educate in <a name="tp1">cheminformatics</a> (see Chapter [1](introduction.md#sec:intro)),
this chapter provides minimal information about the representation of molecules and molecular systems.
Such a representation is needed to allow analysis and manipulation of chemical
structures in the computer. This is of paramount importance in areas like
drug design, synthesis planning, property prediction, crystal structure engineering,
structure elucidation, searching in chemical literature, exchange of chemical knowledge,
and structure elucidation.

Many different representations have been developed, each capturing different
bits of information about the molecular system under study. Unfortunately,
in many cases it is unclear which part of the information is essential for a
certain application. For example, although the <a name="tp2">boiling points</a> correlates well
with the number of carbon atoms in a homologous series of alkanes [<a href="#citeref1">1</a>]
(see Figure [2.1](#fig:bp:alkanes)), the
carbon count descriptor is not generally useful for
predicting other properties, or even the same property for a more diverse set
of molecules. From simple physico-chemical principles, it is clear why this
is the case.

<a name="fig:bp:alkanes"></a>
![](images/boilingPoints.png)
<br />**Figure 2.1**: Diagram showing the relation between the boiling point and the numberof carbon atoms in alkanes.

## References

1. <a name="citeref1"></a>Wiener H. Correlation of Heats of Isomerization, and Differences in Heats of Vaporization of Isomers, Among the Paraffin Hydrocarbons. Journal of the American Chemical Society. 1947 Jan 1;69(11):2636–8.  doi:[10.1021/JA01203A022](https://doi.org/10.1021/JA01203A022)
