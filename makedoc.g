##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "GAPDoc" );

SetGapDocLaTeXOptions( "utf8" );


Read( "ListOfDocFiles.g" );

PrintTo( "VERSION", PackageInfo( "4ti2Interface" )[1].Version );

MakeGAPDocDoc( "doc", "4ti2Interface", list, "4ti2Interface" );

GAPDocManualLab( "4ti2Interface" );

QUIT;
