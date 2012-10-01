##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "GAPDoc" );

SetGapDocLaTeXOptions( "utf8" );

bib := ParseBibFiles( "doc/RingsForHomalg.bib" );
WriteBibXMLextFile( "doc/RingsForHomalgBib.xml", bib );

Read( "ListOfDocFiles.g" );

PrintTo( "VERSION", PackageInfo( "RingsForHomalg" )[1].Version );

MakeGAPDocDoc( "doc", "RingsForHomalg", list, "RingsForHomalg" );

GAPDocManualLab( "RingsForHomalg" );

QUIT;
