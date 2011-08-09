##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "GAPDoc" );
LoadPackage( "Modules" );

SetGapDocLaTeXOptions( "utf8" );

bib := ParseBibFiles( "doc/GradedModulesForHomalg.bib" );
WriteBibXMLextFile( "doc/GradedModulesForHomalgBib.xml", bib );

Read( "ListOfDocFiles.g" );

PrintTo( "VERSION", PackageInfo( "GradedModules" )[1].Version );

MakeGAPDocDoc( "doc", "GradedModulesForHomalg", list, "GradedModulesForHomalg" );

GAPDocManualLab("GradedModules");

quit;

