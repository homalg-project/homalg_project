##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "GAPDoc" );

SetGapDocLaTeXOptions( "utf8" );

bib := ParseBibFiles( "doc/GradedRingForHomalg.bib" );
WriteBibXMLextFile( "doc/GradedRingForHomalgBib.xml", bib );

list := [
         "../gap/GradedRing.gd",
         "../gap/GradedRing.gi",
         "../gap/GradedRingBasic.gd",
         "../gap/GradedRingBasic.gi",
         ];

MakeGAPDocDoc( "doc", "GradedRingForHomalg", list, "GradedRingForHomalg" );

GAPDocManualLab("GradedRingForHomalg");

quit;
