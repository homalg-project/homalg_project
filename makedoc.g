##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "AutoDoc" );

AutoDoc(
    "ToolsForHomalg" : 
    autodoc := true,
    scaffold := false
);

PrintTo( "VERSION", PackageInfo( "ToolsForHomalg" )[1].Version );


QUIT;

