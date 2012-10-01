##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "GAPDoc" );

SetGapDocLaTeXOptions( "utf8" );

bib := ParseBibFiles( "doc/ExamplesForHomalg.bib" );
WriteBibXMLextFile( "doc/ExamplesForHomalgBib.xml", bib );

Read( "ListOfDocFiles.g" );

PrintTo( "VERSION", PackageInfo( "ExamplesForHomalg" )[1].Version );

MakeGAPDocDoc( "doc", "ExamplesForHomalg", list, "ExamplesForHomalg" );

GAPDocManualLab( "ExamplesForHomalg" );

QUIT;
