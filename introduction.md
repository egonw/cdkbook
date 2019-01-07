# Introduction

Readers of this book will probably know what the
[Chemistry Development Kit](http://cdk.github.io/)
(CDK) is: *An Open-Source Java Library for Chemo- and
Bioinformatics* [1]. While the CDK project was founded in
2000, the code base originates from the groundbreaking open source
cheminformatics work Christoph Steinbeck started in 1997 with the
[JChemPaint](https://jchempaint.github.io/) [2] and CompChem projects.

This book is not about those past projects, however; it is about the CDK as it is
now. It has evolved enormously over the past 10 years, and got more and more
functionality [3,4], thanx to the many contributors
(see the Author List). Moreover, by now, the CDK has shown its
role in many cheminformatics and bioinformatics fields, and you will find that
this book cites many scientific papers that use the CDK.

The goal of this book is to introduce the reader, you, to the wide variety of
functionality available in the library. It will discuss parts of the data model,
basic cheminformatics algorithms, chemical file formats, as well as some
of the applications of the CDK.

During the discussion of the various features, we will also discuss some
of the important cheminformatics concepts, but in a minimal way only. The goal of this
book is not to provide an introduction into cheminformatics. For that,
various other books are available [5,6,7,8,9].

As such, this book does require a basic chemical education. It assumes that
you know what atoms are, how they are connected by chemical bonds, and it
assumes some basic computer knowledge. This book is about learning how to
perform cheminformatics tasks using the CDK. But to keep the required
knowledge to a minimum, the examples will be pretty verbose.

Moreover, at the end of the book you can find an appendix containing a keyword
list, where each keyword reflects some cheminformatics concept, linking to
to matching CDK class or method that provides related functionality. As such,
a secondary goal of this book is to serve as reference material for more
experienced CDK developers.

## References

1. Steinbeck C, Han Y, Kuhn S, Horlacher O, Luttmann E, Luttmann E, et al. The Chemistry Development Kit (CDK): an open-source Java library for Chemo- and Bioinformatics. Journal of Chemical Information and Modeling. 2003 Feb 11;43(2):493–500.  doi:[10.1021/CI025584Y](https://doi.org/10.1021/CI025584Y)
2. Krause S, Willighagen E, Steinbeck C. JChemPaint - Using the Collaborative Forces of the Internet to Develop a Free Editor for 2D Chemical Structures. Molecules. 2000 Jan 28;5(1):93–8.  doi:[10.3390/50100093](https://doi.org/10.3390/50100093)
3. Steinbeck C, Hoppe C, Hoppe C, Kuhn S, Floris M, Guha R, et al. Recent Developments of the Chemistry Development Kit (CDK) - An Open-Source Java Library for Chemo- and Bioinformatics. Current Pharmaceutical Design [Internet]. 2006 Jun 1;12(17):2111–20. Available from: https://cdk.github.io/cdk-paper-2/ doi:[10.2174/138161206777585274](https://doi.org/10.2174/138161206777585274)
4. Willighagen E, Mayfield JW, Alvarsson J, Berg A, Berg A, Carlsson L, et al. The Chemistry Development Kit (CDK) v2.0: atom typing, depiction, molecular formulas, and substructure searching. Journal of Cheminformatics. 2017 Jun 6;9(1).  doi:[10.1186/S13321-017-0220-4](https://doi.org/10.1186/S13321-017-0220-4)
5. Gasteiger J, Engel T, editors. Chemoinformatics: A Textbook. Wiley-VCH; 2003. 
6. Leach AR, Gillet VJ. An introduction to chemoinformatics. Springer Science+Business Media; 2007. 
7. Missing
8. Wikberg J, Eklund M, Willighagen E, Spjuth O, Lapins M, Engkvist O, et al. Introduction to Pharmaceutical Bioinformatics. 2018. 
9. Wild DJ. Introducing Cheminformatics. 2013. 

