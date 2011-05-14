##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "HomalgToCAS" );

HOMALG_IO.show_banners := false;

LoadPackage( "GAPDoc" );

Read( "ListOfDocFiles.g" );

size := SizeScreen( );
SizeScreen([80]);

TestManualExamples( DirectoriesPackageLibrary( "HomalgToCAS", "doc" )[1]![1], "HomalgToCAS.xml", list );

GAPDocManualLab( "HomalgToCAS" );

SizeScreen( size );

quit;
