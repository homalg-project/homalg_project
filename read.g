#############################################################################
##
##  read.g                MatricesForHomalg package          Mohamed Barakat
##
##  Copyright 2007-2010 Mohamed Barakat, RWTH Aachen University
##
##  Reading the implementation part of the MatricesForHomalg package.
##
#############################################################################

if not ( IsBound( LOADED_MatricesForHomalg_implementation ) and
         LOADED_MatricesForHomalg_implementation = true ) then

## init
ReadPackage( "MatricesForHomalg", "gap/MatricesForHomalg.gi" );

## rings
ReadPackage( "MatricesForHomalg", "gap/homalgTable.gi" );
ReadPackage( "MatricesForHomalg", "gap/HomalgRing.gi" );
ReadPackage( "MatricesForHomalg", "gap/HomalgRingMap.gi" );

## matrices
ReadPackage( "MatricesForHomalg", "gap/HomalgMatrix.gi" );

fi;

## ring relations
ReadPackage( "MatricesForHomalg", "gap/HomalgRingRelations.gi" );

## tools/service/basic
ReadPackage( "MatricesForHomalg", "gap/Tools.gi" );
ReadPackage( "MatricesForHomalg", "gap/Service.gi" );
ReadPackage( "MatricesForHomalg", "gap/Basic.gi" );

## LogicForHomalg subpackages

if not ( IsBound( LOADED_MatricesForHomalg_implementation ) and
         LOADED_MatricesForHomalg_implementation = true ) then

ReadPackage( "MatricesForHomalg", "gap/LIRNG.gi" );
ReadPackage( "MatricesForHomalg", "gap/LIMAP.gi" );

fi;

## NEVER EVER preload LIMAT.gi and COLEM.gi; i.e.
## they must be loaded after Tools.gi, Service.gi, and Basic.gi,
## otherwise the logical methods get a lower rank than the generic ones
ReadPackage( "MatricesForHomalg", "gap/COLEM.gi" );
ReadPackage( "MatricesForHomalg", "gap/LIMAT.gi" );

## specific GAP4 internal rings
ReadPackage( "MatricesForHomalg", "gap/Integers.gi" );
#ReadPackage( "MatricesForHomalg", "gap/EDIM.gi" );

## the subpackage ResidueClassRingForHomalg
ReadPackage( "MatricesForHomalg", "gap/ResidueClassRingForHomalg.gi" );
ReadPackage( "MatricesForHomalg", "gap/ResidueClassRing.gi" );
ReadPackage( "MatricesForHomalg", "gap/ResidueClassRingBasic.gi" );
ReadPackage( "MatricesForHomalg", "gap/ResidueClassRingTools.gi" );
