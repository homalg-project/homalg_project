#############################################################################
##
##  Sage.gd                   RingsForHomalg package          Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for the external computer algebra system Sage.
##
#############################################################################

####################################
#
# global variables:
#
####################################

DeclareGlobalVariable( "HOMALG_IO_Sage" );

DeclareGlobalVariable( "SageMacros" );

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "_Sage_multiple_delete" );

DeclareGlobalFunction( "InitializeSageMacros" );

# constructor methods:

DeclareGlobalFunction( "RingForHomalgInSage" );

DeclareGlobalFunction( "HomalgRingOfIntegersInSage" );

DeclareGlobalFunction( "HomalgFieldOfRationalsInSage" );

# basic operations:



