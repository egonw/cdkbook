<a name="sec:intro"></a>
# Introduction

Readers of this book will probably know what the
[Chemistry Development Kit](http://cdk.github.io/)
(CDK) is: *An Open-Source Java Library for Chemo- and
Bioinformatics* [<a href="#citeref1">1</a>]. While the CDK project was founded in
2000, the code base originates from the groundbreaking open source
cheminformatics work [Christoph Steinbeck](https://en.wikipedia.org/wiki/Christoph_Steinbeck) started in 1997 with the
[JChemPaint](https://jchempaint.github.io/) [<a href="#citeref2">2</a>] and CompChem projects.

This book is not about those past projects, however; it is about the CDK as it is
now. It has evolved enormously over the past 10 years, and got more and more
functionality [<a href="#citeref3">3</a>,<a href="#citeref4">4</a>], thanx to the many contributors
(see the [Author List](https://github.com/cdk/cdk/blob/main/AUTHORS.txt)). Moreover, by now, the CDK has shown its
role in many cheminformatics and bioinformatics fields, and you will find that
this book cites many scientific papers that use the CDK.

The goal of this book is to introduce the reader, you, to the wide variety of
functionality available in the library. It will discuss parts of the data model,
basic cheminformatics algorithms, chemical file formats, as well as some
of the applications of the CDK.

During the discussion of the various features, we will also discuss some
of the important cheminformatics concepts, but in a minimal way only. The goal of this
book is not to provide an introduction into cheminformatics. For that,
various other books are available [<a href="#citeref5">5</a>,<a href="#citeref6">6</a>,<a href="#citeref7">7</a>,<a href="#citeref8">8</a>,<a href="#citeref9">9</a>].

As such, this book does require a basic chemical education. It assumes that
you know what atoms are, how they are connected by chemical bonds, and it
assumes some basic computer knowledge. This book is about learning how to
perform cheminformatics tasks using the CDK. But to keep the required
knowledge to a minimum, the examples will be pretty verbose.

## References

1. <a name="citeref1"></a>Steinbeck C, Han Y, Kuhn S, Horlacher O, Luttmann E, Willighagen E. The Chemistry Development Kit (CDK): an open-source Java library for Chemo- and Bioinformatics. JCICS. 2003 Feb 11;43(2):493–500.  doi:[10.1021/CI025584Y](https://doi.org/10.1021/CI025584Y) ([Scholia](https://scholia.toolforge.org/doi/10.1021/CI025584Y))
2. <a name="citeref2"></a>Krause S, Willighagen E, Steinbeck C. JChemPaint - Using the Collaborative Forces of the Internet to Develop a Free Editor for 2D Chemical Structures. Molecules. 2000 Jan 28;5(1):93–8.  doi:[10.3390/50100093](https://doi.org/10.3390/50100093) ([Scholia](https://scholia.toolforge.org/doi/10.3390/50100093))
3. <a name="citeref3"></a>Steinbeck C, Hoppe C, Kuhn S, Floris M, Guha R, Willighagen E. Recent Developments of the Chemistry Development Kit (CDK) - An Open-Source Java Library for Chemo- and Bioinformatics. Curr Pharm Des [Internet]. 2006 Jun 1;12(17):2111–20. Available from: https://cdk.github.io/cdk-paper-2/ doi:[10.2174/138161206777585274](https://doi.org/10.2174/138161206777585274) ([Scholia](https://scholia.toolforge.org/doi/10.2174/138161206777585274))
4. <a name="citeref4"></a>Willighagen E, Mayfield JW, Alvarsson J, Berg A, Carlsson L, Jeliazkova N, et al. The Chemistry Development Kit (CDK) v2.0: atom typing, depiction, molecular formulas, and substructure searching. J Cheminform. 2017 Jun 6;9(1).  doi:[10.1186/S13321-017-0220-4](https://doi.org/10.1186/S13321-017-0220-4) ([Scholia](https://scholia.toolforge.org/doi/10.1186/S13321-017-0220-4))
5. <a name="citeref5"></a>Gasteiger J, Engel T, editors. Chemoinformatics: A Textbook. Weinheim, Deutschland: Wiley-VCH; 2003. 
6. <a name="citeref6"></a>Leach AR, Gillet VJ. An introduction to chemoinformatics. Berlin, Deutschland: Springer Science+Business Media; 2007. 
7. <a name="citeref7"></a>Faulon J-L, Bender A, editors. Handbook of Chemoinformatics Algorithms. 2010. 
8. <a name="citeref8"></a>Wikberg J, Eklund M, Willighagen E, Spjuth O, Lapins M, Engkvist O, et al. Introduction to Pharmaceutical Bioinformatics. 2018. 
9. <a name="citeref9"></a>Wild DJ. Introducing Cheminformatics [Internet]. 2013. Available from: http://www.lulu.com/shop/david-wild/introducing-cheminformatics/ebook/product-20988418.html

