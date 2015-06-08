##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "GAPDoc" );

SetGapDocLaTeXOptions( "utf8" );

bib := ParseBibFiles( "doc/MatricesForHomalg.bib" );
WriteBibXMLextFile( "doc/MatricesForHomalgBib.xml", bib );

Read( "ListOfDocFiles.g" );

PrintTo( "VERSION", PackageInfo( "MatricesForHomalg" )[1].Version );

MakeGAPDocDoc( "doc", "MatricesForHomalg", list, "MatricesForHomalg" );

GAPDocManualLab( "MatricesForHomalg" );

QUIT;
