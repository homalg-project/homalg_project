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
         "../gap/homalg.gi",
         "../gap/HomalgDiagram.gd",
         "../gap/HomalgDiagram.gi",
         "../gap/Modules/HomalgRingMap.gd",
         "../gap/Modules/HomalgRingMap.gi",
         "../gap/Modules/HomalgRelations.gd",
         "../gap/Modules/HomalgRelations.gi",
         "../gap/Modules/HomalgGenerators.gd",
         "../gap/Modules/HomalgGenerators.gi",
         "../gap/HomalgObject.gd",
         "../gap/HomalgObject.gi",
         "../gap/HomalgSubobject.gd",
         "../gap/HomalgSubobject.gi",
         "../gap/HomalgMorphism.gd",
         "../gap/HomalgMorphism.gi",
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
         "../gap/StaticObjects.gi",
         "../gap/Modules/HomalgModule.gd",
         "../gap/Modules/HomalgModule.gi",
         "../gap/Modules/HomalgSubmodule.gd",
         "../gap/Modules/HomalgSubmodule.gi",
         "../gap/Modules/HomalgMap.gd",
         "../gap/Modules/HomalgMap.gi",
         "../gap/Modules/Modules.gi",
         "../gap/Modules/LIMAP.gi",
         "../gap/Modules/BasicFunctors.gi",
         "../examples/RHom_Z.g",
         "../examples/LTensorProduct_Z.g",
         "../examples/ExtExt.g",
         "../examples/Purity.g",
         "../examples/Grothendieck_TorExt.g",
         "../examples/TorExt.g",
         "../examples/Hom(Hom(-,Z128),Z16)_On_Seq.g",
         "../examples/Saturate.g",
         ];

MakeGAPDocDoc( "doc", "homalg", list, "homalg" );

GAPDocManualLab( "homalg" );

quit;
