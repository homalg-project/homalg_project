##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "SCO" );
LoadPackage( "GAPDoc" );

list := [
         "../gap/OrbifoldTriangulation.gi",
         "../gap/SimplicialSet.gi",
         "../gap/Matrices.gi",
         "../gap/SCO.gi"
         ];

size := SizeScreen( );
SizeScreen([80]);

TestManualExamples( DirectoriesPackageLibrary( "SCO", "doc" )[1]![1], "SCO.xml", list );

GAPDocManualLab( "SCO" );

SizeScreen( size );

quit;
