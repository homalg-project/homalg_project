##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "RingsForHomalg" );

HOMALG_IO.show_banners := false;

LoadPackage( "GAPDoc" );

list := [
         "../gap/RingsForHomalg.gd",
         "../gap/RingsForHomalg.gi",
         ];

TestManualExamples( "doc", "RingsForHomalg.xml", list );

GAPDocManualLab("RingsForHomalg");

quit;

