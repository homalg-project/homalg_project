##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "GAPDoc" );

SetGapDocLaTeXOptions( "utf8" );

bib := ParseBibFiles( "doc/LocalizeRingForHomalg.bib" );
WriteBibXMLextFile( "doc/LocalizeRingForHomalgBib.xml", bib );

Read( "ListOfDocFiles.g" );

PrintTo( "VERSION", PackageInfo( "LocalizeRingForHomalg" )[1].Version );

MakeGAPDocDoc( "doc", "LocalizeRingForHomalg", list, "LocalizeRingForHomalg" );

GAPDocManualLab("LocalizeRingForHomalg");
