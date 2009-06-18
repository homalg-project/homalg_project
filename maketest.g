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

TestManualExamples( "doc", "Gauss.xml", list );

GAPDocManualLab( "Gauss" );

quit;
