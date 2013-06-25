#############################################################################
##
##  init.g                                     LocalizeRingForHomalg package  
##
##  Copyright 2013, Mohamed Barakat, University of Kaiserslautern
##                  Markus Lange-Hegermann, RWTH-Aachen University
##                  Vinay Wagh, Indian Institute of Technology Guwahati
##
##  Reading the declaration part of the LocalizeRingForHomalg package.
##
#############################################################################

##
ReadPackage( "LocalizeRingForHomalg", "gap/LocalizeRingForHomalg.gd" );

## LocalizeRing
ReadPackage( "LocalizeRingForHomalg", "gap/LocalizeRing.gd" );

ReadPackage( "LocalizeRingForHomalg", "gap/LocalizeRingBasic.gd" );
ReadPackage( "LocalizeRingForHomalg", "gap/LocalizeRingTools.gd" );

ReadPackage( "LocalizeRingForHomalg", "gap/LocalizeRingGroebner.gd" );

ReadPackage( "LocalizeRingForHomalg", "gap/LocalizeRingMora.gd" );

## Singular
ReadPackage( "LocalizeRingForHomalg", "gap/SingularTools.gd" );

## LocalizeAtPrime
ReadPackage( "LocalizeRingForHomalg", "gap/LocalizeRingAtPrimeTools.gd" );
ReadPackage( "LocalizeRingForHomalg", "gap/LocalizeRingAtPrime.gd" );
ReadPackage( "LocalizeRingForHomalg", "gap/FakeLocalizeRing.gd" );
