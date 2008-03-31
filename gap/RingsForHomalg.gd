#############################################################################
##
##  RingsForHomalg.gd         RingsForHomalg package         Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for homalg.
##
#############################################################################


# our info class:
DeclareInfoClass( "InfoRingsForHomalg" );
SetInfoLevel( InfoRingsForHomalg, 1 );

# a central place for configurations:
DeclareGlobalVariable( "HOMALG_RINGS" );

####################################
#
# global functions and operations:
#
####################################

# constructor methods:

DeclareGlobalFunction( "RingForHomalg" );

DeclareGlobalFunction( "RingForHomalgInExternalGAP" );

DeclareGlobalFunction( "RingForHomalgInSingular" );

DeclareGlobalFunction( "RingForHomalgInSage" );

DeclareGlobalFunction( "RingForHomalgInMacaulay2" );

DeclareGlobalFunction( "RingForHomalgInMAGMA" );

DeclareGlobalFunction( "RingForHomalgInPIRMaple" );

DeclareGlobalFunction( "RingForHomalgInInvolutiveMaple" );

DeclareGlobalFunction( "RingForHomalgInJanetMaple" );

DeclareGlobalFunction( "RingForHomalgInJanetOreMaple" );

DeclareGlobalFunction( "RingForHomalgInOreModulesMaple" );

