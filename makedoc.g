##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "GAPDoc" );

SetGapDocLaTeXOptions( "utf8" );

bib := ParseBibFiles( "doc/4ti2Interface.bib" );
WriteBibXMLextFile( "doc/4ti2InterfaceBib.xml", bib );

Read( "ListOfDocFiles.g" );

PrintTo( "VERSION", PackageInfo( "4ti2Interface" )[1].Version );

MakeGAPDocDoc( "doc", "4ti2Interface", list, "4ti2Interface" );

GAPDocManualLab( "4ti2Interface" );

QUIT;
