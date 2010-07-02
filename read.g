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

## functors

## main

##
## ModulesForHomalg
##

## init
ReadPackage( "homalg", "gap/Modules/ModulesForHomalg.gi" );

## rings
ReadPackage( "homalg", "gap/HomalgRingMap.gi" );

## relations/generators
ReadPackage( "homalg", "gap/HomalgRelations.gi" );
ReadPackage( "homalg", "gap/SetsOfRelations.gi" );
ReadPackage( "homalg", "gap/HomalgGenerators.gi" );
ReadPackage( "homalg", "gap/SetsOfGenerators.gi" );

## modules/submodules
ReadPackage( "homalg", "gap/Modules/HomalgModule.gi" );
ReadPackage( "homalg", "gap/Modules/HomalgSubmodule.gi" );

## gap/Modules/
ReadPackage( "homalg", "gap/Modules/HomalgMap.gi" );

## filtrations
ReadPackage( "homalg", "gap/Modules/HomalgFiltration.gi" );

## complexes
ReadPackage( "homalg", "gap/Modules/HomalgComplex.gi" );

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
ReadPackage( "homalg", "gap/Modules/HomalgFunctor.gi" );

## diagrams
ReadPackage( "homalg", "gap/HomalgDiagram.gi" );

## main
ReadPackage( "homalg", "gap/StaticObjects.gi" );

ReadPackage( "homalg", "gap/Maps.gi" );

ReadPackage( "homalg", "gap/Complexes.gi" );

ReadPackage( "homalg", "gap/ChainMaps.gi" );

ReadPackage( "homalg", "gap/SpectralSequences.gi" );

ReadPackage( "homalg", "gap/Filtrations.gi" );

ReadPackage( "homalg", "gap/ToolFunctors.gi" );
ReadPackage( "homalg", "gap/BasicFunctors.gi" );
ReadPackage( "homalg", "gap/OtherFunctors.gi" );

## gap/Modules/
ReadPackage( "homalg", "gap/Modules/Modules.gi" );
ReadPackage( "homalg", "gap/Modules/ToolFunctors.gi" );
ReadPackage( "homalg", "gap/Modules/BasicFunctors.gi" );

## LogicForHomalg subpackages
ReadPackage( "homalg", "gap/LIMAP.gi" );
ReadPackage( "homalg", "gap/LIREL.gi" );
ReadPackage( "homalg", "gap/LIMOD.gi" );
ReadPackage( "homalg", "gap/LIMOR.gi" );
ReadPackage( "homalg", "gap/LICPX.gi" );

