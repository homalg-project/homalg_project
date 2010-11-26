#############################################################################
##
##  read.g                homalg package
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##
##  Reading the implementation part of the homalg package.
##
#############################################################################

## init
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
ReadPackage( "homalg", "gap/LIOBJ.gi" );
ReadPackage( "homalg", "gap/LIMOR.gi" );
ReadPackage( "homalg", "gap/LICPX.gi" );
ReadPackage( "homalg", "gap/LICHM.gi" );

