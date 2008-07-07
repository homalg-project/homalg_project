##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "GAPDoc" );

MakeGAPDocDoc( "doc", "Gauss", [ "../gap/Sparse.gi", "../gap/SparseMatrix.gi" ], "Gauss" );

GAPDocManualLab( "Gauss" );

quit;
