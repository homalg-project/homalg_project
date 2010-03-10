##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "RingsForHomalg" );
LoadPackage( "IO_ForHomalg" );

HOMALG_IO.show_banners := false;
HOMALG_IO.suppress_PID := true;

LoadPackage( "GAPDoc" );

list := [
         "../gap/RingsForHomalg.gd",
         "../gap/RingsForHomalg.gi",
         "../gap/Singular.gi",
         "../gap/SingularBasic.gi",
         "../examples/RingConstructionsExternalGAP.g",
         "../examples/RingConstructionsSingular.g",
         "../examples/RingConstructionsMAGMA.g",
         "../examples/RingConstructionsMacaulay2.g",
         "../examples/RingConstructionsSage.g",
         "../examples/RingConstructionsMaple.g",
         ];

size := SizeScreen( );
SizeScreen([80]);

TestManualExamples( DirectoriesPackageLibrary( "RingsForHomalg", "doc" )[1]![1], "RingsForHomalg.xml", list );

GAPDocManualLab( "RingsForHomalg" );

SizeScreen( size );

quit;
