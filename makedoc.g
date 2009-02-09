##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "GAPDoc" );

SetGapDocLaTeXOptions( "utf8" );

bib := ParseBibFiles( "doc/LocalizeRingForHomalg.bib" );
WriteBibXMLextFile( "doc/LocalizeRingForHomalgBib.xml", bib );

list := [
         "../gap/LocalizeRing.gd",
         "../gap/LocalizeRing.gi"
         ];

MakeGAPDocDoc( "doc", "LocalizeRingForHomalg", list, "LocalizeRingForHomalg" );

GAPDocManualLab("LocalizeRingForHomalg");

quit;

