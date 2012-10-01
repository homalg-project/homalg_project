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

Read( "ListOfDocFiles.g" );

PrintTo( "VERSION", PackageInfo( "HomalgToCAS" )[1].Version );

MakeGAPDocDoc( "doc", "HomalgToCAS", list, "HomalgToCAS" );

GAPDocManualLab( "HomalgToCAS" );

QUIT;
