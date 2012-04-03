##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "homalg" );
LoadPackage( "Modules" );
LoadPackage( "GAPDoc" );

Read( "ListOfDocFiles.g" );

size := SizeScreen( );
SizeScreen([80]);

TestManualExamples( DirectoriesPackageLibrary( "homalg", "doc" )[1]![1], "homalg.xml", list );

GAPDocManualLab( "homalg" );

SizeScreen( size );

quit;
