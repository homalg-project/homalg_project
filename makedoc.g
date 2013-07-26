##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "GAPDoc" );

SetGapDocLaTeXOptions( "utf8" );

bib := ParseBibFiles( "doc/PolymakeInterface.bib" );
WriteBibXMLextFile( "doc/PolymakeInterfaceBib.xml", bib );

Read( "ListOfDocFiles.g" );

PrintTo( "VERSION", PackageInfo( "PolymakeInterface" )[1].Version );

MakeGAPDocDoc( "doc", "PolymakeInterface", list, "PolymakeInterface" );

GAPDocManualLab("PolymakeInterface");

QUIT;
