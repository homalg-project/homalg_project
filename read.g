#############################################################################
##
##  read.g                homalg package                    Mohamed Barakat
##
##  Copyright 2007 Lehrstuhl B für Mathematik, RWTH Aachen
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

## modules
ReadPackage( "homalg", "gap/HomalgRelations.gi" );
ReadPackage( "homalg", "gap/SetsOfRelations.gi" );
ReadPackage( "homalg", "gap/HomalgGenerators.gi" );
ReadPackage( "homalg", "gap/SetsOfGenerators.gi" );
ReadPackage( "homalg", "gap/HomalgModule.gi" );

## morphisms
ReadPackage( "homalg", "gap/HomalgMorphism.gi" );

## complexes
ReadPackage( "homalg", "gap/HomalgComplex.gi" );

## functors
ReadPackage( "homalg", "gap/HomalgFunctor.gi" );
ReadPackage( "homalg", "gap/BasicFunctors.gi" );
ReadPackage( "homalg", "gap/OtherFunctors.gi" );

## subpackages
ReadPackage( "homalg", "gap/LIRNG.gi" );
ReadPackage( "homalg", "gap/LIMAT.gi" );
ReadPackage( "homalg", "gap/COLEM.gi" );
ReadPackage( "homalg", "gap/LIMOD.gi" );

## tools/service/basic
ReadPackage( "homalg", "gap/Tools.gi" );
ReadPackage( "homalg", "gap/Service.gi" );
ReadPackage( "homalg", "gap/Basic.gi" );

## main
ReadPackage( "homalg", "gap/Modules.gi" );

## specific GAP4 internal rings
ReadPackage( "homalg", "gap/Integers.gi" );
#ReadPackage( "homalg", "gap/EDIM.gi" );
ReadPackage( "homalg", "gap/Fields.gi" );

