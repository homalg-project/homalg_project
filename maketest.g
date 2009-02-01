##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "Sheaves" );

HOMALG_IO.show_banners := false;

LoadPackage( "GAPDoc" );

list := [
         "../gap/Modules.gd",
         "../gap/Modules.gi",
         "../gap/Tate.gd",
         "../gap/Tate.gi"
         ];

TestManualExamples( "doc", "Sheaves.xml", list );

GAPDocManualLab("Sheaves");

quit;

