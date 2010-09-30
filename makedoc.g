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
         "../examples/ExtExt.g",
         "../examples/Purity.g",
         "../examples/A3_Purity.g",
         "../examples/CodegreeOfPurity.g",
         "../examples/TorExt_Grothendieck.g",
         "../examples/TorExt.g",
         "../examples/Hom(Hom(-,Z128),Z16)_On_Seq.g",
         ];

MakeGAPDocDoc( "doc", "ExamplesForHomalg", list, "ExamplesForHomalg" );

GAPDocManualLab( "ExamplesForHomalg" );

quit;
