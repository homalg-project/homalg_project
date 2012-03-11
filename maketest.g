##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "LocalizeRingForHomalg" );

LoadPackage( "RingsForHomalg" );

LoadPackage( "Modules" );

LoadPackage( "IO_ForHomalg" );

HOMALG_IO.show_banners := false;
HOMALG_IO.suppress_PID := true;

LoadPackage( "GAPDoc" );

Read( "ListOfDocFiles.g" );

size := SizeScreen( );
SizeScreen([80]);

TestManualExamples( DirectoriesPackageLibrary( "LocalizeRingForHomalg", "doc" )[1]![1], "LocalizeRingForHomalg.xml", list );

GAPDocManualLab( "LocalizeRingForHomalg" );

SizeScreen( size );
