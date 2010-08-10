#############################################################################
##
##  read.g                homalg package                    Mohamed Barakat
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##
##  Reading the implementation part of the homalg package.
##
#############################################################################

ReadPackage( "homalg", "gap/homalg.gi" );

## objects/subobjects
ReadPackage( "homalg", "gap/HomalgObject.gi" );
ReadPackage( "homalg", "gap/HomalgSubobject.gi" );

## morphisms
ReadPackage( "homalg", "gap/HomalgMorphism.gi" );

## filtrations
ReadPackage( "homalg", "gap/HomalgFiltration.gi" );

## complexes
ReadPackage( "homalg", "gap/HomalgComplex.gi" );

## chain maps
ReadPackage( "homalg", "gap/HomalgChainMap.gi" );

## bicomplexes
ReadPackage( "homalg", "gap/HomalgBicomplex.gi" );

## bigraded objects
ReadPackage( "homalg", "gap/HomalgBigradedObject.gi" );

## spectral sequences
ReadPackage( "homalg", "gap/HomalgSpectralSequence.gi" );

## functors
ReadPackage( "homalg", "gap/HomalgFunctor.gi" );

## diagrams
ReadPackage( "homalg", "gap/HomalgDiagram.gi" );

## main
ReadPackage( "homalg", "gap/StaticObjects.gi" );

ReadPackage( "homalg", "gap/Morphisms.gi" );

ReadPackage( "homalg", "gap/Complexes.gi" );

ReadPackage( "homalg", "gap/ChainMaps.gi" );

ReadPackage( "homalg", "gap/SpectralSequences.gi" );

ReadPackage( "homalg", "gap/Filtrations.gi" );

ReadPackage( "homalg", "gap/ToolFunctors.gi" );
ReadPackage( "homalg", "gap/BasicFunctors.gi" );
ReadPackage( "homalg", "gap/OtherFunctors.gi" );

## LogicForHomalg subpackages
ReadPackage( "homalg", "gap/LICPX.gi" );

##
## ModulesForHomalg
##

## init
ReadPackage( "homalg", "gap/Modules/ModulesForHomalg.gi" );

## rings
ReadPackage( "homalg", "gap/Modules/HomalgRingMap.gi" );

## relations/generators
ReadPackage( "homalg", "gap/Modules/HomalgRelations.gi" );
ReadPackage( "homalg", "gap/Modules/SetsOfRelations.gi" );
ReadPackage( "homalg", "gap/Modules/HomalgGenerators.gi" );
ReadPackage( "homalg", "gap/Modules/SetsOfGenerators.gi" );

## modules/submodules
ReadPackage( "homalg", "gap/Modules/HomalgModule.gi" );
ReadPackage( "homalg", "gap/Modules/HomalgSubmodule.gi" );

## maps
ReadPackage( "homalg", "gap/Modules/HomalgMap.gi" );

## filtrations
ReadPackage( "homalg", "gap/Modules/HomalgFiltration.gi" );

## complexes
ReadPackage( "homalg", "gap/Modules/HomalgComplex.gi" );

## chain maps
ReadPackage( "homalg", "gap/Modules/HomalgChainMap.gi" );

## bicomplexes
ReadPackage( "homalg", "gap/Modules/HomalgBicomplex.gi" );

## bigraded objects
ReadPackage( "homalg", "gap/Modules/HomalgBigradedObject.gi" );

## functors
ReadPackage( "homalg", "gap/Modules/HomalgFunctor.gi" );

## main
ReadPackage( "homalg", "gap/Modules/Modules.gi" );
ReadPackage( "homalg", "gap/Modules/ToolFunctors.gi" );
ReadPackage( "homalg", "gap/Modules/BasicFunctors.gi" );
ReadPackage( "homalg", "gap/Modules/OtherFunctors.gi" );

## LogicForHomalg subpackages
ReadPackage( "homalg", "gap/LIMOR.gi" );

ReadPackage( "homalg", "gap/Modules/LIMAP.gi" );
ReadPackage( "homalg", "gap/Modules/LIREL.gi" );

ReadPackage( "homalg", "gap/Modules/LIMOD.gi" );
