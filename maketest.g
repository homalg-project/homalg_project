##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "LocalizeRingForHomalg" );

HOMALG_IO.show_banners := false;

LoadPackage( "GAPDoc" );

list := [
         "../gap/LocalizeRing.gd",
         "../gap/LocalizeRing.gi"
          ];

TestManualExamples( "doc", "LocalizeRingForHomalg.xml", list );

GAPDocManualLab("LocalizeRingForHomalg");

quit;

