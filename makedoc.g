##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "GAPDoc" );

## we need the homalg book loaded
LoadPackage( "homalg" );

SetGapDocLaTeXOptions( "utf8" );

bib := ParseBibFiles( "doc/Modules.bib" );
WriteBibXMLextFile( "doc/ModulesBib.xml", bib );

Read( "ListOfDocFiles.g" );

PrintTo( "VERSION", PackageInfo( "Modules" )[1].Version );

MakeGAPDocDoc( "doc", "ModulesForHomalg", list, "ModulesForHomalg" );

GAPDocManualLab( "Modules" );

QUIT;
