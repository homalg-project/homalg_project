##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "GAPDoc" );

SetGapDocLaTeXOptions( "utf8" );

bib := ParseBibFiles( "doc/HomalgToCAS.bib" );
WriteBibXMLextFile( "doc/HomalgToCASBib.xml", bib );

list := [
         "../gap/HomalgToCAS.gd",
         "../gap/HomalgToCAS.gi",
         ];

MakeGAPDocDoc( "doc", "HomalgToCAS", list, "HomalgToCAS" );

GAPDocManualLab( "HomalgToCAS" );

quit;
