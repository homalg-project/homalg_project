#############################################################################
##
##  init.g                MatricesForHomalg package          Mohamed Barakat
##
##  Copyright 2007-2010 Mohamed Barakat, RWTH Aachen University
##
##  Reading the declaration part of the MatricesForHomalg package.
##
#############################################################################

ReadPackage( "MatricesForHomalg", "gap/MatricesForHomalg.gd" );

## rings
ReadPackage( "MatricesForHomalg", "gap/homalgTable.gd" );
ReadPackage( "MatricesForHomalg", "gap/HomalgRing.gd" );
ReadPackage( "MatricesForHomalg", "gap/HomalgRingMap.gd" );

## matrices
ReadPackage( "MatricesForHomalg", "gap/HomalgMatrix.gd" );

## ring relations
ReadPackage( "MatricesForHomalg", "gap/HomalgRingRelations.gd" );

## tools/service/basic
ReadPackage( "MatricesForHomalg", "gap/Tools.gd" );
ReadPackage( "MatricesForHomalg", "gap/Service.gd" );
ReadPackage( "MatricesForHomalg", "gap/Basic.gd" );

## LogicForHomalg subpackages
ReadPackage( "MatricesForHomalg", "gap/LIRNG.gd" );
ReadPackage( "MatricesForHomalg", "gap/LIMAP.gd" );
ReadPackage( "MatricesForHomalg", "gap/COLEM.gd" );
ReadPackage( "MatricesForHomalg", "gap/LIMAT.gd" );

## the subpackage ResidueClassRingForHomalg
ReadPackage( "MatricesForHomalg", "gap/ResidueClassRingForHomalg.gd" );
ReadPackage( "MatricesForHomalg", "gap/ResidueClassRing.gd" );
ReadPackage( "MatricesForHomalg", "gap/ResidueClassRingBasic.gd" );
ReadPackage( "MatricesForHomalg", "gap/ResidueClassRingTools.gd" );

## This is a workaround since GAP (<=4.4.12) does not load
## the implementation parts of the different packages
## in the same order as the declaration parts;
## I hope this becomes obsolete in the future
LOADED_MatricesForHomalg_implementation := true;

ReadPackage( "MatricesForHomalg", "gap/MatricesForHomalg.gi" );

## rings
ReadPackage( "MatricesForHomalg", "gap/homalgTable.gi" );
ReadPackage( "MatricesForHomalg", "gap/HomalgRing.gi" );
ReadPackage( "MatricesForHomalg", "gap/HomalgRingMap.gi" );

## matrices
ReadPackage( "MatricesForHomalg", "gap/HomalgMatrix.gi" );
