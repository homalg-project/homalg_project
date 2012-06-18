##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "GAPDoc" );

SetGapDocLaTeXOptions( "utf8" );

bib := ParseBibFiles( "doc/ToolsForHomalg.bib" );
WriteBibXMLextFile( "doc/ToolsForHomalgBib.xml", bib );

Read( "ListOfDocFiles.g" );

PrintTo( "VERSION", PackageInfo( "ToolsForHomalg" )[1].Version );

MakeGAPDocDoc( "doc", "ToolsForHomalg", list, "ToolsForHomalg" );

GAPDocManualLab( "ToolsForHomalg" );

quit;
