##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "GaussForHomalg" );
LoadPackage( "GAPDoc" );

list := [
         "../gap/GaussForHomalg.gi",
         "../gap/GaussTools.gi",
         "../gap/GaussBasic.gi",
         "../gap/GaussFQI.gi"
         ];

TestManualExamples( "doc", "GaussForHomalg.xml", list );

GAPDocManualLab( "GaussForHomalg" );

quit;
