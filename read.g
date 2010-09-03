#############################################################################
##
##  read.g                Modules package                    Mohamed Barakat
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##
##  Reading the implementation part of the homalg package.
##
#############################################################################

## init
ReadPackage( "Modules", "gap/ModulesForHomalg.gi" );

## rings
ReadPackage( "Modules", "gap/HomalgRingMap.gi" );

## relations/generators
ReadPackage( "Modules", "gap/HomalgRelations.gi" );
ReadPackage( "Modules", "gap/SetsOfRelations.gi" );
ReadPackage( "Modules", "gap/HomalgGenerators.gi" );
ReadPackage( "Modules", "gap/SetsOfGenerators.gi" );

## modules/submodules
ReadPackage( "Modules", "gap/HomalgModule.gi" );
ReadPackage( "Modules", "gap/HomalgSubmodule.gi" );

## maps
ReadPackage( "Modules", "gap/HomalgMap.gi" );

## filtrations
ReadPackage( "Modules", "gap/HomalgFiltration.gi" );

## complexes
ReadPackage( "Modules", "gap/HomalgComplex.gi" );

## chain maps
ReadPackage( "Modules", "gap/HomalgChainMap.gi" );

## bicomplexes
ReadPackage( "Modules", "gap/HomalgBicomplex.gi" );

## bigraded objects
ReadPackage( "Modules", "gap/HomalgBigradedObject.gi" );

## functors
ReadPackage( "Modules", "gap/HomalgFunctor.gi" );

## main
ReadPackage( "Modules", "gap/Modules.gi" );
ReadPackage( "Modules", "gap/ToolFunctors.gi" );
ReadPackage( "Modules", "gap/BasicFunctors.gi" );
ReadPackage( "Modules", "gap/OtherFunctors.gi" );

## tools
ReadPackage( "Modules", "gap/Tools.gi" );

## LogicForHomalg subpackages
ReadPackage( "Modules", "gap/LIMAP.gi" );
ReadPackage( "Modules", "gap/LIREL.gi" );
ReadPackage( "Modules", "gap/LIMOD.gi" );
ReadPackage( "Modules", "gap/LIHOM.gi" );
ReadPackage( "Modules", "gap/LICPX.gi" );
