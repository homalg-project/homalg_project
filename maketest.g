##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "Sheaves" );

HOMALG_IO.show_banners := false;

LoadPackage( "GAPDoc" );

list := [
         "../gap/Sheaves.gd",
         "../gap/Sheaves.gi",
         "../gap/Modules.gd",
         "../gap/Modules.gi",
         "../gap/Tate.gd",
         "../gap/Tate.gi"
         ];

TestManualExamples( "doc", "SheavesForHomalg.xml", list );

GAPDocManualLab("Sheaves");

quit;

