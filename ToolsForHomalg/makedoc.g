##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "AutoDoc", "2016.02.16" );



Read( "PackageInfo.g" ); 
PrintTo( "VERSION", GAPInfo.PackageInfoCurrent.Version ); 


AutoDoc( rec(
    autodoc := true,
    scaffold := false
) );


QUIT;

