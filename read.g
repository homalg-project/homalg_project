#############################################################################
##
##  read.g                MatricesForHomalg package          Mohamed Barakat
##
##  Copyright 2007-2010 Mohamed Barakat, RWTH Aachen University
##
##  Reading the implementation part of the MatricesForHomalg package.
##
#############################################################################

ReadPackage( "MatricesForHomalg", "gap/MatricesForHomalg.gi" );

## rings
ReadPackage( "MatricesForHomalg", "gap/homalgTable.gi" );
ReadPackage( "MatricesForHomalg", "gap/HomalgRing.gi" );
ReadPackage( "MatricesForHomalg", "gap/HomalgRingMap.gi" );

## matrices
ReadPackage( "MatricesForHomalg", "gap/HomalgMatrix.gi" );

## ring relations
ReadPackage( "MatricesForHomalg", "gap/HomalgRingRelations.gi" );

## tools/service/basic
ReadPackage( "MatricesForHomalg", "gap/Tools.gi" );
ReadPackage( "MatricesForHomalg", "gap/Service.gi" );
ReadPackage( "MatricesForHomalg", "gap/Basic.gi" );

## LogicForHomalg subpackages
ReadPackage( "MatricesForHomalg", "gap/LIRNG.gi" );
ReadPackage( "MatricesForHomalg", "gap/LIMAP.gi" );
ReadPackage( "MatricesForHomalg", "gap/LIMAT.gi" );
ReadPackage( "MatricesForHomalg", "gap/COLEM.gi" );

## specific GAP4 internal rings
ReadPackage( "MatricesForHomalg", "gap/Integers.gi" );
#ReadPackage( "MatricesForHomalg", "gap/EDIM.gi" );

## the subpackage ResidueClassRingForHomalg
ReadPackage( "MatricesForHomalg", "gap/ResidueClassRingForHomalg.gi" );
ReadPackage( "MatricesForHomalg", "gap/ResidueClassRing.gi" );
ReadPackage( "MatricesForHomalg", "gap/ResidueClassRingBasic.gi" );
ReadPackage( "MatricesForHomalg", "gap/ResidueClassRingTools.gi" );

