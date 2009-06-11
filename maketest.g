##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "HomalgToCAS" );

HOMALG_IO.show_banners := false;

LoadPackage( "GAPDoc" );

list := [
         "../gap/HomalgToCAS.gd",
         "../gap/HomalgToCAS.gi",
         ];

TestManualExamples( "doc", "HomalgToCAS.xml", list );

GAPDocManualLab("HomalgToCAS");

quit;

