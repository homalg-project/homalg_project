##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "GradedRingForHomalg" );

LoadPackage( "IO_ForHomalg" );

HOMALG_IO.show_banners := false;
HOMALG_IO.suppress_PID := true;

LoadPackage( "GAPDoc" );

list := [
         "../gap/GradedRing.gd",
         "../gap/GradedRing.gi",
         "../gap/GradedRingBasic.gd",
         "../gap/GradedRingBasic.gi",
          ];

size := SizeScreen( );
SizeScreen([80]);

TestManualExamples( DirectoriesPackageLibrary( "GradedRingForHomalg", "doc" )[1]![1], "GradedRingForHomalg.xml", list );

GAPDocManualLab( "GradedRingForHomalg" );

SizeScreen( size );

quit;
