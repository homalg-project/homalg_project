##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "GAPDoc" );

LoadPackage( "homalg" );

SetGapDocLaTeXOptions( "utf8" );

bib := ParseBibFiles( "doc/HomalgToCAS.bib" );
WriteBibXMLextFile( "doc/HomalgToCASBib.xml", bib );

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

MakeGAPDocDoc( "doc", "HomalgToCAS", list, "HomalgToCAS" );

GAPDocManualLab( "HomalgToCAS" );

quit;
