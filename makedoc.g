##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "GAPDoc" );

SetGapDocLaTeXOptions( "utf8" );

bib := ParseBibFiles( "doc/GradedModulesForHomalg.bib" );
WriteBibXMLextFile( "doc/GradedModulesForHomalgBib.xml", bib );

list := [
         "../gap/RingMaps.gd",
         "../gap/RingMaps.gi",
         "../gap/GradedModule.gd",
         "../gap/GradedModule.gi",
         "../gap/GradedSubmodule.gd",
         "../gap/GradedSubmodule.gi",
         "../gap/Tate.gd",
         "../gap/Tate.gi",
         "../gap/Relative.gd",
         "../gap/Relative.gi",
         "../examples/DE-2.2.g",
         "../examples/DE-Code.g",
         "../examples/Schenck-3.2.g",
         "../examples/Schenck-8.3.g",
         "../examples/Schenck-8.3.3.g",
         "../examples/Saturate.g",
         "../examples/Eliminate.g",
         ];

PrintTo( "VERSION", PackageInfo( "GradedModules" )[1].Version );

MakeGAPDocDoc( "doc", "GradedModulesForHomalg", list, "GradedModulesForHomalg" );

GAPDocManualLab("GradedModules");

quit;

