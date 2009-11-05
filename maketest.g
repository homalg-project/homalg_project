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
         "../gap/homalgExternalObject.gd",
         "../gap/homalgExternalObject.gi",
         "../gap/HomalgExternalRing.gd",
         "../gap/HomalgExternalRing.gi",
         "../gap/HomalgExternalMatrix.gd",
         "../gap/HomalgExternalMatrix.gi",
         "../gap/homalgSendBlocking.gd",
         "../gap/homalgSendBlocking.gi",
         "../gap/IO.gd",
         "../gap/IO.gi",
         ];

TestManualExamples( "doc", "HomalgToCAS.xml", list );

GAPDocManualLab( "HomalgToCAS" );

quit;
