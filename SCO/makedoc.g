##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "GAPDoc" );

SetGapDocLaTeXOptions( "utf8" );

Read( "ListOfDocFiles.g" );

PrintTo( "VERSION", PackageInfo( "SCO" )[1].Version );

MakeGAPDocDoc( "doc", "SCO", list, "SCO" );

GAPDocManualLab( "SCO" );

QUIT;
