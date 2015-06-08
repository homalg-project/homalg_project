##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "GAPDoc" );

SetGapDocLaTeXOptions( "utf8" );

#bib := ParseBibFiles( "doc/Gauss.bib" );
#WriteBibXMLextFile( "doc/GaussBib.xml", bib );

Read( "ListOfDocFiles.g" );

PrintTo( "VERSION", PackageInfo( "GaussForHomalg" )[1].Version );

MakeGAPDocDoc( "doc", "GaussForHomalg", list, "GaussForHomalg" );

GAPDocManualLab( "GaussForHomalg" );

QUIT;
