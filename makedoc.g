##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "GAPDoc" );

SetGapDocLaTeXOptions( "utf8" );

bib := ParseBibFiles( "doc/homalg.bib" );
WriteBibXMLextFile( "doc/homalgBib.xml", bib );

list := [
         "../gap/HomalgRing.gd",
         "../gap/HomalgRing.gi",
         "../gap/LIRNG.gi",
         "../gap/HomalgMatrix.gd",
         "../gap/HomalgMatrix.gi",
         "../gap/HomalgModule.gd",
         "../gap/HomalgModule.gi"
         ];

MakeGAPDocDoc( "doc", "homalg", list, "homalg" );

GAPDocManualLab("homalg");

quit;

