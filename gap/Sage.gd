#############################################################################
##
##  Sage.gd                   RingsForHomalg package         Simon Goertzen
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

####################################
#
# global functions and operations:
#
####################################

# constructor methods:

DeclareGlobalFunction( "RingForHomalgInSage" );

DeclareGlobalFunction( "HomalgRingOfIntegersInSage" );

DeclareGlobalFunction( "HomalgFieldOfRationalsInSage" );

# basic operations:

DeclareOperation( "HomalgMatrixInSage",
        [ IsHomalgMatrix, IsHomalgRing ] );

DeclareOperation( "HomalgMatrixInSage",
        [ IsString, IsHomalgRing ] );

