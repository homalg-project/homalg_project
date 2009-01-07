##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "Sheaves" );
LoadPackage( "ExamplesForHomalg" );

HOMALG_IO.show_banners := false;

LoadPackage( "GAPDoc" );

list := [
         "../gap/ExamplesForHomalg.gd",
         "../gap/ExamplesForHomalg.gi",
         "../examples/Schenck-3.2.g",
         "../examples/Schenck-8.3.g",
         "../examples/Schenck-8.3.3.g",
         "../examples/DE-2.2.g",
         "../examples/DE-Code.g",
         ];

TestManualExamples( "doc", "ExamplesForHomalg.xml", list );

GAPDocManualLab("ExamplesForHomalg");

quit;

