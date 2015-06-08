##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "GAPDoc" );

SetGapDocLaTeXOptions( "utf8" );

bib := ParseBibFiles( "doc/GradedRingForHomalg.bib" );
WriteBibXMLextFile( "doc/GradedRingForHomalgBib.xml", bib );

Read( "ListOfDocFiles.g" );

PrintTo( "VERSION", PackageInfo( "GradedRingForHomalg" )[1].Version );

MakeGAPDocDoc( "doc", "GradedRingForHomalg", list, "GradedRingForHomalg" );

GAPDocManualLab("GradedRingForHomalg");

QUIT;
