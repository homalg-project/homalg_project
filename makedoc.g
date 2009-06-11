##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "GAPDoc" );

SetGapDocLaTeXOptions( "utf8" );

bib := ParseBibFiles( "doc/ExamplesForHomalg.bib" );
WriteBibXMLextFile( "doc/ExamplesForHomalgBib.xml", bib );

list := [
         "../gap/ExamplesForHomalg.gd",
         "../gap/ExamplesForHomalg.gi",
         "../examples/Schenck-3.2.g",
         "../examples/Schenck-8.3.g",
         "../examples/Schenck-8.3.3.g",
         "../examples/ExtExt.g",
         "../examples/Purity.g",
         "../examples/A3_Purity.g",
         "../examples/CodegreeOfPurity.g",
         "../examples/torext.g",
         "../examples/TorExt.g",
         ];

MakeGAPDocDoc( "doc", "ExamplesForHomalg", list, "ExamplesForHomalg" );

GAPDocManualLab("ExamplesForHomalg");

quit;

