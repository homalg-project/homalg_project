##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "LocalizeRingForHomalg" );

LoadPackage( "Sheaves" );

LoadPackage( "IO_ForHomalg" );

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

size := SizeScreen( );
SizeScreen([80]);

TestManualExamples( DirectoriesPackageLibrary( "LocalizeRingForHomalg", "doc" )[1]![1], "LocalizeRingForHomalg.xml", list );

GAPDocManualLab( "LocalizeRingForHomalg" );

SizeScreen( size );

quit;
