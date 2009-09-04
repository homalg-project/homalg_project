##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "GAPDoc" );

SetGapDocLaTeXOptions( "utf8" );

bib := ParseBibFiles( "doc/Sheaves.bib" );
WriteBibXMLextFile( "doc/SheavesBib.xml", bib );

list := [
         "../gap/RingMaps.gd",
         "../gap/RingMaps.gi",
         "../gap/Modules.gd",
         "../gap/Modules.gi",
         "../gap/Tate.gd",
         "../gap/Tate.gi",
         "../gap/Relative.gd",
         "../gap/Relative.gi",
         "../gap/LinearSystems.gd",
         "../gap/LinearSystems.gi",
         "../gap/Sheaves.gd",
         "../gap/Sheaves.gi",
         "../gap/Schemes.gd",
         "../gap/Schemes.gi",
         "../gap/MorphismsOfSchemes.gd",
         "../gap/MorphismsOfSchemes.gi",
         "../gap/Curves.gd",
         "../gap/Curves.gi",
         "../gap/Tools.gd",
         "../gap/Tools.gi",
         "../examples/DE-2.2.g",
         "../examples/DE-Code.g",
         ];

MakeGAPDocDoc( "doc", "SheavesForHomalg", list, "SheavesForHomalg" );

GAPDocManualLab("Sheaves");

quit;

