##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "GAPDoc" );

SetGapDocLaTeXOptions( "utf8" );

bib := ParseBibFiles( "doc/MatricesForHomalg.bib" );
WriteBibXMLextFile( "doc/MatricesForHomalgBib.xml", bib );

list := [
         "../gap/MatricesForHomalg.gi",
         "../gap/HomalgRing.gd",
         "../gap/HomalgRing.gi",
         "../gap/HomalgRingMap.gd",
         "../gap/HomalgRingMap.gi",
         "../gap/LIRNG.gi",
         "../gap/HomalgMatrix.gd",
         "../gap/HomalgMatrix.gi",
         "../gap/HomalgRingRelations.gd",
         "../gap/HomalgRingRelations.gi",
         "../gap/Tools.gi",
         "../gap/Service.gi",
         "../gap/Basic.gi",
         "../gap/ResidueClassRingForHomalg.gd",
         "../gap/ResidueClassRingForHomalg.gi",
         "../gap/ResidueClassRing.gd",
         "../gap/ResidueClassRing.gi",
         "../gap/ResidueClassRingBasic.gd",
         "../gap/ResidueClassRingBasic.gi",
         "../gap/ResidueClassRingTools.gd",
         "../gap/ResidueClassRingTools.gi",
         ];

MakeGAPDocDoc( "doc", "MatricesForHomalg", list, "MatricesForHomalg" );

GAPDocManualLab( "MatricesForHomalg" );

quit;
