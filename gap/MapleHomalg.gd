#############################################################################
##
##  MapleHomalg.gd            RingsForHomalg package         Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for the external computer algebra system Maple.
##
#############################################################################

####################################
#
# global variables:
#
####################################

DeclareGlobalVariable( "HOMALG_IO_Maple" );

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "_Maple_multiple_delete" );

# constructor methods:

DeclareGlobalFunction( "RingForHomalgInMapleUsingPIR" );

DeclareGlobalFunction( "RingForHomalgInMapleUsingInvolutive" );

DeclareGlobalFunction( "RingForHomalgInMapleUsingInvolutiveLocal" );

DeclareGlobalFunction( "RingForHomalgInMapleUsingJanet" );

DeclareGlobalFunction( "RingForHomalgInMapleUsingJanetOre" );

DeclareGlobalFunction( "RingForHomalgInMapleUsingOreModules" );

DeclareGlobalFunction( "HomalgRingOfIntegersInMaple" );

DeclareGlobalFunction( "HomalgFieldOfRationalsInMaple" );

DeclareGlobalFunction( "MapleHomalgOptions" );

# basic operations:

