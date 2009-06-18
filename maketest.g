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

TestManualExamples( "doc", "SCO.xml", list );

GAPDocManualLab( "SCO" );

quit;
