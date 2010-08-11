#############################################################################
##
##  init.g                homalg package                    Mohamed Barakat
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##
##  Reading the declaration part of the homalg package.
##
#############################################################################

ReadPackage( "homalg", "gap/homalg.gd" );

## objects/subobjects
ReadPackage( "homalg", "gap/HomalgObject.gd" );
ReadPackage( "homalg", "gap/HomalgSubobject.gd" );

## morphisms
ReadPackage( "homalg", "gap/HomalgMorphism.gd" );

## filtrations
ReadPackage( "homalg", "gap/HomalgFiltration.gd" );

## complexes
ReadPackage( "homalg", "gap/HomalgComplex.gd" );

## chain maps
ReadPackage( "homalg", "gap/HomalgChainMap.gd" );

## bicomplexes
ReadPackage( "homalg", "gap/HomalgBicomplex.gd" );

## bigraded objects
ReadPackage( "homalg", "gap/HomalgBigradedObject.gd" );

## spectral sequences
ReadPackage( "homalg", "gap/HomalgSpectralSequence.gd" );

## functors
ReadPackage( "homalg", "gap/HomalgFunctor.gd" );

## diagrams
ReadPackage( "homalg", "gap/HomalgDiagram.gd" );

## main
ReadPackage( "homalg", "gap/StaticObjects.gd" );

ReadPackage( "homalg", "gap/Morphisms.gd" );

ReadPackage( "homalg", "gap/Complexes.gd" );

ReadPackage( "homalg", "gap/ChainMaps.gd" );

ReadPackage( "homalg", "gap/SpectralSequences.gd" );

ReadPackage( "homalg", "gap/Filtrations.gd" );

ReadPackage( "homalg", "gap/ToolFunctors.gd" );
ReadPackage( "homalg", "gap/BasicFunctors.gd" );
ReadPackage( "homalg", "gap/OtherFunctors.gd" );

## LogicForHomalg subpackages
ReadPackage( "homalg", "gap/LIOBJ.gd" );
ReadPackage( "homalg", "gap/LICPX.gd" );

##
## ModulesForHomalg
##

## init
ReadPackage( "homalg", "gap/Modules/ModulesForHomalg.gd" );

## rings
ReadPackage( "homalg", "gap/Modules/HomalgRingMap.gd" );

## relations/generators
ReadPackage( "homalg", "gap/Modules/HomalgRelations.gd" );
ReadPackage( "homalg", "gap/Modules/SetsOfRelations.gd" );
ReadPackage( "homalg", "gap/Modules/HomalgGenerators.gd" );
ReadPackage( "homalg", "gap/Modules/SetsOfGenerators.gd" );

## modules/submodules
ReadPackage( "homalg", "gap/Modules/HomalgModule.gd" );
ReadPackage( "homalg", "gap/Modules/HomalgSubmodule.gd" );

## maps
ReadPackage( "homalg", "gap/Modules/HomalgMap.gd" );

## filtrations
ReadPackage( "homalg", "gap/Modules/HomalgFiltration.gd" );

## complexes
ReadPackage( "homalg", "gap/Modules/HomalgComplex.gd" );

## chain maps
ReadPackage( "homalg", "gap/Modules/HomalgChainMap.gd" );

## bicomplexes
ReadPackage( "homalg", "gap/Modules/HomalgBicomplex.gd" );

## bigraded objects
ReadPackage( "homalg", "gap/Modules/HomalgBigradedObject.gd" );

## functors
ReadPackage( "homalg", "gap/Modules/HomalgFunctor.gd" );

## main
ReadPackage( "homalg", "gap/Modules/Modules.gd" );
ReadPackage( "homalg", "gap/Modules/ToolFunctors.gd" );
ReadPackage( "homalg", "gap/Modules/BasicFunctors.gd" );
ReadPackage( "homalg", "gap/Modules/OtherFunctors.gd" );

## LogicForHomalg subpackages
ReadPackage( "homalg", "gap/Modules/LIMAP.gd" );
ReadPackage( "homalg", "gap/Modules/LIREL.gd" );
ReadPackage( "homalg", "gap/Modules/LIMOD.gd" );
ReadPackage( "homalg", "gap/Modules/LIHOM.gd" );
