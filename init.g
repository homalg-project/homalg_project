#############################################################################
##
##  init.g                Modules package                    Mohamed Barakat
##
##  Copyright 2007-2011, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH-Aachen
##
##  Reading the declaration part of the homalg package.
##
#############################################################################

## init
ReadPackage( "Modules", "gap/ModulesForHomalg.gd" );

## rings
ReadPackage( "Modules", "gap/HomalgRingMap.gd" );

## relations/generators
ReadPackage( "Modules", "gap/HomalgRelations.gd" );
ReadPackage( "Modules", "gap/SetsOfRelations.gd" );
ReadPackage( "Modules", "gap/HomalgGenerators.gd" );
ReadPackage( "Modules", "gap/SetsOfGenerators.gd" );

## modules/submodules
ReadPackage( "Modules", "gap/HomalgModule.gd" );
ReadPackage( "Modules", "gap/HomalgSubmodule.gd" );

## maps
ReadPackage( "Modules", "gap/HomalgMap.gd" );

## filtrations
ReadPackage( "Modules", "gap/HomalgFiltration.gd" );

## complexes
ReadPackage( "Modules", "gap/HomalgComplex.gd" );

## chain maps
ReadPackage( "Modules", "gap/HomalgChainMap.gd" );

## bicomplexes
ReadPackage( "Modules", "gap/HomalgBicomplex.gd" );

## bigraded objects
ReadPackage( "Modules", "gap/HomalgBigradedObject.gd" );

## functors
ReadPackage( "Modules", "gap/HomalgFunctor.gd" );

## main
ReadPackage( "Modules", "gap/Modules.gd" );
ReadPackage( "Modules", "gap/ToolFunctors.gd" );
ReadPackage( "Modules", "gap/BasicFunctors.gd" );
ReadPackage( "Modules", "gap/OtherFunctors.gd" );

## tools
ReadPackage( "Modules", "gap/Tools.gd" );

## LogicForHomalg subpackages
ReadPackage( "Modules", "gap/LIMAP.gd" );
ReadPackage( "Modules", "gap/LIREL.gd" );
ReadPackage( "Modules", "gap/LIMOD.gd" );
ReadPackage( "Modules", "gap/LIHOM.gd" );
