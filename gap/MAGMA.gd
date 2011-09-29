#############################################################################
##
##  MAGMA.gd                  RingsForHomalg package         Mohamed Barakat
##                                                          Markus Kirschmer
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for the external computer algebra system MAGMA.
##
#############################################################################

####################################
#
# global variables:
#
####################################

DeclareGlobalVariable( "HOMALG_IO_MAGMA" );

DeclareGlobalVariable( "MAGMAMacros" );

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "_MAGMA_SetRing" );

DeclareGlobalFunction( "_MAGMA_multiple_delete" );

DeclareGlobalFunction( "InitializeMAGMAMacros" );

# constructor methods:

DeclareGlobalFunction( "RingForHomalgInMAGMA" );

DeclareGlobalFunction( "HomalgRingOfIntegersInMAGMA" );

DeclareGlobalFunction( "HomalgFieldOfRationalsInMAGMA" );

# basic operations:

