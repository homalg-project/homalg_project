##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##


PrintTo( "VERSION", PackageInfo( "ToolsForHomalg" )[1].Version );

LoadPackage( "AutoDoc" );


AutoDoc(
    "ToolsForHomalg" : 
    autodoc := true,
    scaffold := false
);


QUIT;

