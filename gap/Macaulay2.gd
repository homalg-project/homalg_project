#############################################################################
##
##  Macaulay2.gd              RingsForHomalg package          Daniel Robertz
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for the external computer algebra system Macaulay2.
##
#############################################################################

####################################
#
# global variables:
#
####################################

DeclareGlobalVariable( "HOMALG_IO_Macaulay2" );

DeclareGlobalVariable( "Macaulay2Tools" );

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "_Macaulay2_SetRing" );

DeclareGlobalFunction( "_Macaulay2_SetInvolution" );

DeclareGlobalFunction( "_Macaulay2_multiple_delete" );

DeclareGlobalFunction( "InitializeMacaulay2Tools" );

# constructor methods:

DeclareGlobalFunction( "RingForHomalgInMacaulay2" );

DeclareGlobalFunction( "HomalgRingOfIntegersInMacaulay2" );

DeclareGlobalFunction( "HomalgFieldOfRationalsInMacaulay2" );

# basic operations:

