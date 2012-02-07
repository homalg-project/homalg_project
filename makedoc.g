##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "GAPDoc" );

SetGapDocLaTeXOptions( "utf8" );

Read( "ListOfDocFiles.g" );

PrintTo( "VERSION", PackageInfo( "Convex" )[1].Version );

MakeGAPDocDoc( "doc", "Convex", list, "Convex" );

GAPDocManualLab( "Convex" );

quit;