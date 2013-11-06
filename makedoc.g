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


QUIT;

