##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "Sheaves" );
LoadPackage( "LocalizeRingForHomalg" );
LoadPackage( "IO_ForHomalg" );
LoadPackage( "GAPDoc" );

HOMALG_IO.show_banners := false;
HOMALG_IO.suppress_PID := true;

LoadPackage( "GAPDoc" );

list := [
         "../gap/LocalizeRing.gd",
         "../gap/LocalizeRing.gi",
         "../gap/LocalizeRingBasic.gd",
         "../gap/LocalizeRingBasic.gi",
         "../gap/LocalizeRingMora.gd",
         "../gap/LocalizeRingMora.gi",
         "../examples/Hom\(Hom\(-\,Z128\)\,Z16\)_On_Seq.g",
         "../examples/QuickstartZ.g",
         "../examples/ResidueClass.g",
         "../examples/EasyPoly.g",
         "../examples/Intersection.g",
          ];

TestManualExamples( "doc", "LocalizeRingForHomalg.xml", list );

GAPDocManualLab("LocalizeRingForHomalg");

quit;

