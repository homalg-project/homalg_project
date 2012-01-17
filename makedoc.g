##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "GAPDoc" );

SetGapDocLaTeXOptions( "utf8" );

Read( "ListOfDocFiles.g" );

PrintTo( "VERSION", PackageInfo( "ToricVarieties" )[1].Version );

MakeGAPDocDoc( "doc", "ToricVarieties", list, "ToricVarieties" );

GAPDocManualLab( "ToricVarieties" );

quit;