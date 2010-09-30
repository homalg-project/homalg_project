##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "ExamplesForHomalg" );

LoadPackage( "IO_ForHomalg" );

HOMALG_IO.show_banners := false;
HOMALG_IO.use_common_stream := true;

LoadPackage( "GAPDoc" );

list := [
         "../gap/ExamplesForHomalg.gd",
         "../gap/ExamplesForHomalg.gi",
         "../examples/ExtExt.g",
         "../examples/Purity.g",
         "../examples/A3_Purity.g",
         "../examples/CodegreeOfPurity.g",
         "../examples/TorExt_Grothendieck.g",
         "../examples/TorExt.g",
         "../examples/Hom(Hom(-,Z128),Z16)_On_Seq.g",
         ];

size := SizeScreen( );
SizeScreen([80]);

TestManualExamples( DirectoriesPackageLibrary( "ExamplesForHomalg", "doc" )[1]![1], "ExamplesForHomalg.xml", list );

GAPDocManualLab( "ExamplesForHomalg" );

SizeScreen( size );

quit;
