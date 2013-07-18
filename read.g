#############################################################################
##
##  read.g                                     LocalizeRingForHomalg package  
##
##  Copyright 2013, Mohamed Barakat, University of Kaiserslautern
##                  Markus Lange-Hegermann, RWTH-Aachen University
##                  Vinay Wagh, Indian Institute of Technology Guwahati
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

## LocalizeAtPrime
ReadPackage( "LocalizeRingForHomalg", "gap/LocalizeRingAtPrimeBasic.gi" );
ReadPackage( "LocalizeRingForHomalg", "gap/LocalizeRingAtPrimeTools.gi" );
ReadPackage( "LocalizeRingForHomalg", "gap/LocalizeRingAtPrime.gi" );
ReadPackage( "LocalizeRingForHomalg", "gap/FakeLocalizeRing.gi" );

