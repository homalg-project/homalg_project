#############################################################################
##
##  LocalizeRingForHomalg.gd                   LocalizeRingForHomalg package  
##
##  Copyright 2013, Mohamed Barakat, University of Kaiserslautern
##                  Markus Lange-Hegermann, RWTH-Aachen University
##                  Vinay Wagh, Indian Institute of Technology Guwahati
##
##  Declaration stuff for LocalizeRingForHomalg.
##
#############################################################################


# our info class:
DeclareInfoClass( "InfoLocalizeRingForHomalg" );
SetInfoLevel( InfoLocalizeRingForHomalg, 1 );

# a central place for configurations:
DeclareGlobalVariable( "HOMALG_LOCALIZE_RING" );

##
DeclareGlobalVariable( "CommonHomalgTableForLocalizedRings" );

##
DeclareGlobalVariable( "CommonHomalgTableForLocalizedRingsAtPrimeIdeals" );
