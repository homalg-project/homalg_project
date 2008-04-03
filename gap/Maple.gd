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

DeclareGlobalFunction( "RingForHomalgInMaplePIR" );

DeclareGlobalFunction( "RingForHomalgInMapleInvolutive" );

DeclareGlobalFunction( "RingForHomalgInMapleJanet" );

DeclareGlobalFunction( "RingForHomalgInMapleJanetOre" );

DeclareGlobalFunction( "RingForHomalgInMapleOreModules" );

# basic operations:

DeclareOperation( "HomalgMatrixInMaple",
        [ IsHomalgMatrix, IsHomalgRing ] );

DeclareOperation( "HomalgMatrixInMaple",
        [ IsString, IsHomalgRing ] );

