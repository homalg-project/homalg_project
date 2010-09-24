#############################################################################
##
##  read.g    GradedRingForHomalg package                  Mohamed Barakat
##                                                    Markus Lange-Hegermann
##
##  Copyright 2009, Mohamed Barakat, Universität des Saarlandes
##           Markus Lange-Hegermann, RWTH-Aachen University
##
##  Reading the implementation part of the GradedRingForHomalg package.
##
#############################################################################

## init
ReadPackage( "GradedRingForHomalg", "gap/GradedRingForHomalg.gi" );

## graded rings
ReadPackage( "GradedRingForHomalg", "gap/GradedRing.gi" );

## matrices over graded rings
ReadPackage( "GradedRingForHomalg", "gap/HomogeneousMatrix.gi" );

## the basic matrix operations
ReadPackage( "GradedRingForHomalg", "gap/GradedRingBasic.gi" );

## the matrix tool operations
ReadPackage( "GradedRingForHomalg", "gap/GradedRingTools.gi" );

## build the homalgTable
ReadPackage( "GradedRingForHomalg", "gap/GradedRingTable.gi" );

## ring element and matrix tools
ReadPackage( "GradedRingForHomalg", "gap/Tools.gi" );

## LogicForHomalg subpackages
ReadPackage( "GradedRingForHomalg", "gap/LIGrRNG.gi" );
ReadPackage( "GradedRingForHomalg", "gap/LIGrMAT.gi" );


if not ( IsBound( LOADED_GradedRingForHomalg_implementation ) and
         LOADED_GradedRingForHomalg_implementation = true ) then

## homalg table entries for the supported external computer algebra systems
ReadPackage( "GradedRingForHomalg", "gap/SingularTools.gi" );
ReadPackage( "GradedRingForHomalg", "gap/Macaulay2Tools.gi" );
ReadPackage( "GradedRingForHomalg", "gap/MAGMATools.gi" );
ReadPackage( "GradedRingForHomalg", "gap/MapleHomalgTools.gi" );

fi;
