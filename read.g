#############################################################################
##
##  read.g                                     LocalizeRingForHomalg package
##
##  Copyright 2009-2011, Mohamed Barakat, University of Kaiserslautern
##                       Markus Lange-Hegermann, RWTH-Aachen University
##
##  Reading the implementation part of the LocalizeRingForHomalg package.
##
#############################################################################

##
ReadPackage( "LocalizeRingForHomalg", "gap/LocalizeRingForHomalg.gi" );

## LocalizeRing
ReadPackage( "LocalizeRingForHomalg", "gap/LocalizeRing.gi" );

ReadPackage( "LocalizeRingForHomalg", "gap/LocalizeRingBasic.gi" );
ReadPackage( "LocalizeRingForHomalg", "gap/LocalizeRingTools.gi" );

ReadPackage( "LocalizeRingForHomalg", "gap/LocalizeRingGroebner.gi" );

ReadPackage( "LocalizeRingForHomalg", "gap/LocalizeRingMora.gi" );

## Singular
ReadPackage( "LocalizeRingForHomalg", "gap/SingularTools.gi" );
