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

## pointers on external objects
ReadPackage( "homalg", "gap/homalgExternalObject.gi" );

## rings
ReadPackage( "homalg", "gap/homalgTable.gi" );
ReadPackage( "homalg", "gap/HomalgRing.gi" );

## matrices
ReadPackage( "homalg", "gap/HomalgMatrix.gi" );

## relations/generators
ReadPackage( "homalg", "gap/HomalgRelations.gi" );
ReadPackage( "homalg", "gap/SetsOfRelations.gi" );
ReadPackage( "homalg", "gap/HomalgGenerators.gi" );
ReadPackage( "homalg", "gap/SetsOfGenerators.gi" );

## modules
ReadPackage( "homalg", "gap/HomalgModule.gi" );

## morphisms
ReadPackage( "homalg", "gap/HomalgMap.gi" );

## complexes
ReadPackage( "homalg", "gap/HomalgComplex.gi" );

## chain maps
ReadPackage( "homalg", "gap/HomalgChainMap.gi" );

## functors
ReadPackage( "homalg", "gap/HomalgFunctor.gi" );

## tools/service/basic
ReadPackage( "homalg", "gap/Tools.gi" );
ReadPackage( "homalg", "gap/Service.gi" );
ReadPackage( "homalg", "gap/Basic.gi" );

## main
ReadPackage( "homalg", "gap/Modules.gi" );

ReadPackage( "homalg", "gap/Maps.gi" );

ReadPackage( "homalg", "gap/Complexes.gi" );

ReadPackage( "homalg", "gap/ChainMaps.gi" );

ReadPackage( "homalg", "gap/ToolFunctors.gi" );
ReadPackage( "homalg", "gap/BasicFunctors.gi" );
ReadPackage( "homalg", "gap/OtherFunctors.gi" );

## LogicForHomalg subpackages
ReadPackage( "homalg", "gap/LIRNG.gi" );
ReadPackage( "homalg", "gap/LIMAT.gi" );
ReadPackage( "homalg", "gap/COLEM.gi" );
ReadPackage( "homalg", "gap/LIMOD.gi" );
ReadPackage( "homalg", "gap/LIMOR.gi" );
ReadPackage( "homalg", "gap/LICPX.gi" );

## specific GAP4 internal rings
ReadPackage( "homalg", "gap/Integers.gi" );
#ReadPackage( "homalg", "gap/EDIM.gi" );

