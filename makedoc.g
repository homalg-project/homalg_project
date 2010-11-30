##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "GAPDoc" );

SetGapDocLaTeXOptions( "utf8" );

bib := ParseBibFiles( "doc/IO_ForHomalg.bib" );
WriteBibXMLextFile( "doc/IO_ForHomalgBib.xml", bib );

list := [
         "../gap/IO_ForHomalg.gd",
         "../gap/IO_ForHomalg.gi",
         ];

PrintTo( "VERSION", PackageInfo( "IO_ForHomalg" )[1].Version );

MakeGAPDocDoc( "doc", "IO_ForHomalg", list, "IO_ForHomalg" );

GAPDocManualLab( "IO_ForHomalg" );

quit;
