#############################################################################
##
##  init.g                homalg package                    Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Reading the declaration part of the homalg package.
##
#############################################################################

ReadPackage( "homalg", "gap/homalg.gd" );

## rings
ReadPackage( "homalg", "gap/HomalgRingMap.gd" );

## relations/generators
ReadPackage( "homalg", "gap/HomalgRelations.gd" );
ReadPackage( "homalg", "gap/SetsOfRelations.gd" );
ReadPackage( "homalg", "gap/HomalgGenerators.gd" );
ReadPackage( "homalg", "gap/SetsOfGenerators.gd" );

## objects/subobjects
ReadPackage( "homalg", "gap/HomalgObject.gd" );
ReadPackage( "homalg", "gap/HomalgSubobject.gd" );

## morphisms
ReadPackage( "homalg", "gap/HomalgMorphism.gd" );

## modules/submodules
ReadPackage( "homalg", "gap/Modules/HomalgModule.gd" );
ReadPackage( "homalg", "gap/Modules/HomalgSubmodule.gd" );

## gap/Modules/
ReadPackage( "homalg", "gap/Modules/HomalgMap.gd" );

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

ReadPackage( "homalg", "gap/Maps.gd" );

ReadPackage( "homalg", "gap/Complexes.gd" );

ReadPackage( "homalg", "gap/ChainMaps.gd" );

ReadPackage( "homalg", "gap/SpectralSequences.gd" );

ReadPackage( "homalg", "gap/Filtrations.gd" );

ReadPackage( "homalg", "gap/ToolFunctors.gd" );
ReadPackage( "homalg", "gap/BasicFunctors.gd" );
ReadPackage( "homalg", "gap/OtherFunctors.gd" );

## gap/Modules/
ReadPackage( "homalg", "gap/Modules/Modules.gd" );
ReadPackage( "homalg", "gap/Modules/HomalgComplex.gd" );
ReadPackage( "homalg", "gap/Modules/ToolFunctors.gd" );
ReadPackage( "homalg", "gap/Modules/BasicFunctors.gd" );

## LogicForHomalg subpackages
ReadPackage( "homalg", "gap/LIMAP.gd" );
ReadPackage( "homalg", "gap/LIREL.gd" );
ReadPackage( "homalg", "gap/LIMOD.gd" );
ReadPackage( "homalg", "gap/LIMOR.gd" );
ReadPackage( "homalg", "gap/LICPX.gd" );

