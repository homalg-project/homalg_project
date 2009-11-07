##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "Gauss" );
LoadPackage( "GAPDoc" );

list := [
         "../gap/Sparse.gi",
         "../gap/SparseMatrix.gi"
         ];

size := SizeScreen( );
SizeScreen([80]);

TestManualExamples( DirectoriesPackageLibrary( "Gauss", "doc" )[1]![1], "Gauss.xml", list );

GAPDocManualLab( "Gauss" );

SizeScreen( size );

quit;
