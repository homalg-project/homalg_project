#############################################################################
##
##  init.g                homalg package                    Mohamed Barakat
##
##  Copyright 2007 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Reading the declaration part of the homalg package.
##
#############################################################################

ReadPackage( "homalg", "gap/homalg.gd" );

## pointers on external objects
ReadPackage( "homalg", "gap/homalgExternalObject.gd" );

## rings
ReadPackage( "homalg", "gap/homalgTable.gd" );
ReadPackage( "homalg", "gap/HomalgRing.gd" );

## matrices
ReadPackage( "homalg", "gap/HomalgMatrix.gd" );

## subpackages
ReadPackage( "homalg", "gap/LIMAT.gd" );
ReadPackage( "homalg", "gap/COLEM.gd" );

## modules
ReadPackage( "homalg", "gap/HomalgRelations.gd" );
ReadPackage( "homalg", "gap/SetsOfRelations.gd" );
ReadPackage( "homalg", "gap/HomalgGenerators.gd" );
ReadPackage( "homalg", "gap/SetsOfGenerators.gd" );
ReadPackage( "homalg", "gap/HomalgModule.gd" );

## morphisms
ReadPackage( "homalg", "gap/HomalgMorphism.gd" );

## complexes
ReadPackage( "homalg", "gap/HomalgComplex.gd" );

## functors
ReadPackage( "homalg", "gap/HomalgFunctor.gd" );

ReadPackage( "homalg", "gap/BasicFunctors.gd" );

## tools/service/basic
ReadPackage( "homalg", "gap/Tools.gd" );
ReadPackage( "homalg", "gap/Service.gd" );
ReadPackage( "homalg", "gap/Basic.gd" );

## main
ReadPackage( "homalg", "gap/Modules.gd" );

