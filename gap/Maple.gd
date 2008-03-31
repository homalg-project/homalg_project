#############################################################################
##
##  Maple.gd                  RingsForHomalg package         Mohamed Barakat
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

# constructor methods:

DeclareGlobalFunction( "RingForHomalgInPIRMaple" );

DeclareGlobalFunction( "RingForHomalgInInvolutiveMaple" );

DeclareGlobalFunction( "RingForHomalgInJanetMaple" );

DeclareGlobalFunction( "RingForHomalgInJanetOreMaple" );

DeclareGlobalFunction( "RingForHomalgInOreModulesMaple" );

DeclareOperation( "HomalgMatrixInMaple",
        [ IsHomalgMatrix, IsHomalgRing ] );

DeclareOperation( "HomalgMatrixInMaple",
        [ IsString, IsHomalgRing ] );

