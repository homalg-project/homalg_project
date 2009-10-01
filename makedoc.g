##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "GAPDoc" );

SetGapDocLaTeXOptions( "utf8" );

bib := ParseBibFiles( "doc/RingsForHomalg.bib" );
WriteBibXMLextFile( "doc/RingsForHomalgBib.xml", bib );

list := [
         "../gap/RingsForHomalg.gd",
         "../gap/RingsForHomalg.gi",
         "../gap/Singular.gi",
         "../gap/SingularBasic.gi",
         ];

MakeGAPDocDoc( "doc", "RingsForHomalg", list, "RingsForHomalg" );

GAPDocManualLab( "RingsForHomalg" );

quit;
