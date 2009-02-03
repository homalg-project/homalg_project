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
         "../gap/HomalgDiagram.gd",
         "../gap/HomalgDiagram.gi",
         "../gap/HomalgRing.gd",
         "../gap/HomalgRing.gi",
         "../gap/LIRNG.gi",
         "../gap/HomalgMatrix.gd",
         "../gap/HomalgMatrix.gi",
         "../gap/HomalgRelations.gd",
         "../gap/HomalgRelations.gi",
         "../gap/HomalgGenerators.gd",
         "../gap/HomalgGenerators.gi",
         "../gap/HomalgModule.gd",
         "../gap/HomalgModule.gi",
         "../gap/HomalgMap.gd",
         "../gap/HomalgMap.gi",
         "../gap/HomalgFiltration.gd",
         "../gap/HomalgFiltration.gi",
         "../gap/HomalgComplex.gd",
         "../gap/HomalgComplex.gi",
         "../gap/HomalgChainMap.gd",
         "../gap/HomalgChainMap.gi",
         "../gap/HomalgBicomplex.gd",
         "../gap/HomalgBicomplex.gi",
         "../gap/HomalgBigradedObject.gd",
         "../gap/HomalgBigradedObject.gi",
         "../gap/HomalgSpectralSequence.gd",
         "../gap/HomalgSpectralSequence.gi",
         "../gap/HomalgFunctor.gd",
         "../gap/HomalgFunctor.gi",
         "../gap/BasicFunctors.gd",
         "../gap/BasicFunctors.gi",
         "../gap/Modules.gi",
         "../tst/RHom_Z.g",
         "../tst/LTensorProduct_Z.g"
         ];

MakeGAPDocDoc( "doc", "homalg", list, "homalg" );

GAPDocManualLab("homalg");

quit;

