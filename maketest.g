##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "Sheaves" );

LoadPackage( "IO_ForHomalg" );

HOMALG_IO.show_banners := false;

LoadPackage( "GAPDoc" );

list := [
         "../gap/RingMaps.gd",
         "../gap/RingMaps.gi",
         "../gap/Modules.gd",
         "../gap/Modules.gi",
         "../gap/Tate.gd",
         "../gap/Tate.gi",
         "../gap/Relative.gd",
         "../gap/Relative.gi",
         "../gap/Sheaves.gd",
         "../gap/Sheaves.gi",
         "../gap/Tools.gd",
         "../gap/Tools.gi",
         "../examples/DE-2.2.g",
         "../examples/DE-Code.g",
         ];

TestManualExamples( "doc", "SheavesForHomalg.xml", list );

GAPDocManualLab("Sheaves");

quit;

