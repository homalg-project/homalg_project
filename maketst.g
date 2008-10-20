##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "homalg" );
LoadPackage( "GAPDoc" );

list := [
         "../gap/HomalgRing.gd",
         "../gap/HomalgRing.gi",
         "../gap/LIRNG.gi",
         "../gap/HomalgMatrix.gd",
         "../gap/HomalgMatrix.gi",
         "../gap/HomalgModule.gd",
         "../gap/HomalgModule.gi"
         ];

TestManualExamples( "doc", "homalg.xml", list );

GAPDocManualLab("homalg");

quit;

