#############################################################################
##
##  MAGMA.gd                  RingsForHomalg package         Mohamed Barakat
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

####################################
#
# global functions and operations:
#
####################################

# constructor methods:

DeclareGlobalFunction( "RingForHomalgInMAGMA" );

DeclareGlobalFunction( "HomalgRingOfIntegersInMAGMA" );

DeclareGlobalFunction( "HomalgFieldOfRationalsInMAGMA" );

# basic operations:

DeclareOperation( "PolynomialRing",
        [ IsHomalgRing, IsList ] );

DeclareOperation( "HomalgMatrixInMAGMA",
        [ IsHomalgMatrix, IsHomalgRing ] );

DeclareOperation( "HomalgMatrixInMAGMA",
        [ IsString, IsHomalgRing ] );

