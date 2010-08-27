#############################################################################
##
##  init.g    GradedRingForHomalg package                  Mohamed Barakat
##                                                    Markus Lange-Hegermann
##
##  Copyright 2010
##
##  Reading the declaration part of the GradedRingForHomalg package.
##
#############################################################################

## init
ReadPackage( "GradedRingForHomalg", "gap/GradedRingForHomalg.gd" );

## graded rings
ReadPackage( "GradedRingForHomalg", "gap/GradedRing.gd" );

## matrices over graded rings
ReadPackage( "GradedRingForHomalg", "gap/GradedMatrix.gd" );

## the basic matrix operations
ReadPackage( "GradedRingForHomalg", "gap/GradedRingBasic.gd" );

## the matrix tool operations
ReadPackage( "GradedRingForHomalg", "gap/GradedRingTools.gd" );

## build the homalgTable
ReadPackage( "GradedRingForHomalg", "gap/GradedRingTable.gd" );

## ring element and matrix tools
ReadPackage( "GradedRingForHomalg", "gap/Tools.gd" );

## LogicForHomalg subpackages
ReadPackage( "GradedRingForHomalg", "gap/LIGrRNG.gd" );
ReadPackage( "GradedRingForHomalg", "gap/LIGrMAT.gd" );

## homalg table entries for the supported external computer algebra systems
ReadPackage( "GradedRingForHomalg", "gap/SingularTools.gd" );
ReadPackage( "GradedRingForHomalg", "gap/Macaulay2Tools.gd" );
ReadPackage( "GradedRingForHomalg", "gap/MAGMATools.gd" );
ReadPackage( "GradedRingForHomalg", "gap/MapleHomalgTools.gd" );

## This is a workaround since GAP (<=4.4.12) does not load
## the implementation parts of the different packages
## in the same order as the declaration parts;
## I hope this becomes obsolete in the future
LOADED_GradedRingForHomalg_implementation := true;

## homalg table entries for the supported external computer algebra systems
ReadPackage( "GradedRingForHomalg", "gap/SingularTools.gi" );
ReadPackage( "GradedRingForHomalg", "gap/Macaulay2Tools.gi" );
ReadPackage( "GradedRingForHomalg", "gap/MAGMATools.gi" );
ReadPackage( "GradedRingForHomalg", "gap/MapleHomalgTools.gi" );
