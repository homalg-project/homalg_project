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

size := SizeScreen( );
SizeScreen([80]);

TestManualExamples( DirectoriesPackageLibrary( "HomalgToCAS", "doc" )[1]![1], "HomalgToCAS.xml", list );

GAPDocManualLab( "HomalgToCAS" );

SizeScreen( size );

quit;
