#############################################################################
##
##  read.g                homalg package                    Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Reading the implementation part of the homalg package.
##
#############################################################################

ReadPackage( "homalg", "gap/homalg.gi" );

## rings
ReadPackage( "homalg", "gap/HomalgRingMap.gi" );

## relations/generators
ReadPackage( "homalg", "gap/HomalgRelations.gi" );
ReadPackage( "homalg", "gap/SetsOfRelations.gi" );
ReadPackage( "homalg", "gap/HomalgGenerators.gi" );
ReadPackage( "homalg", "gap/SetsOfGenerators.gi" );

## modules/submodules
ReadPackage( "homalg", "gap/HomalgModule.gi" );
ReadPackage( "homalg", "gap/HomalgSubmodule.gi" );

## morphisms
ReadPackage( "homalg", "gap/HomalgMap.gi" );

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
ReadPackage( "homalg", "gap/Modules.gi" );

ReadPackage( "homalg", "gap/Maps.gi" );

ReadPackage( "homalg", "gap/Complexes.gi" );

ReadPackage( "homalg", "gap/ChainMaps.gi" );

ReadPackage( "homalg", "gap/SpectralSequences.gi" );

ReadPackage( "homalg", "gap/Filtrations.gi" );

ReadPackage( "homalg", "gap/ToolFunctors.gi" );
ReadPackage( "homalg", "gap/BasicFunctors.gi" );
ReadPackage( "homalg", "gap/OtherFunctors.gi" );

ReadPackage( "homalg", "gap/Modules/ToolFunctors.gi" );

## LogicForHomalg subpackages
ReadPackage( "homalg", "gap/LIMAP.gi" );
ReadPackage( "homalg", "gap/LIREL.gi" );
ReadPackage( "homalg", "gap/LIMOD.gi" );
ReadPackage( "homalg", "gap/LIMOR.gi" );
ReadPackage( "homalg", "gap/LICPX.gi" );

