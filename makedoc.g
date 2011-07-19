##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "GAPDoc" );

SetGapDocLaTeXOptions( "utf8" );

#bib := ParseBibFiles( "doc/Gauss.bib" );
#WriteBibXMLextFile( "doc/GaussBib.xml", bib );

list := [
         "../gap/Sparse.gi",
         "../gap/SparseMatrix.gi"
         ];

PrintTo( "VERSION", PackageInfo( "Gauss" )[1].Version );

MakeGAPDocDoc( "doc", "Gauss", list, "Gauss" );

GAPDocManualLab( "Gauss" );

quit;
