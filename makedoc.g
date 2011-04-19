##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "GAPDoc" );

## we need the Modules book loaded
LoadPackage( "Modules" );

SetGapDocLaTeXOptions( "utf8" );

bib := ParseBibFiles( "doc/homalg.bib" );
WriteBibXMLextFile( "doc/homalgBib.xml", bib );

Read( "ListOfDocFiles.g" );

PrintTo( "VERSION", PackageInfo( "homalg" )[1].Version );

MakeGAPDocDoc( "doc", "homalg", list, "homalg" );

GAPDocManualLab( "homalg" );

quit;
