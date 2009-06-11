##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "IO_ForHomalg" );

HOMALG_IO.show_banners := false;

LoadPackage( "GAPDoc" );

list := [
         "../gap/IO_ForHomalg.gd",
         "../gap/IO_ForHomalg.gi",
         ];

TestManualExamples( "doc", "IO_ForHomalg.xml", list );

GAPDocManualLab("IO_ForHomalg");

quit;

