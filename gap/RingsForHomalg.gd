#############################################################################
##
##  RingsForHomalg.gd         RingsForHomalg package         Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for RingsForHomalg.
##
#############################################################################


# our info class:
DeclareInfoClass( "InfoRingsForHomalg" );
SetInfoLevel( InfoRingsForHomalg, 1 );

# a central place for configurations:
DeclareGlobalVariable( "HOMALG_RINGS" );

##
DeclareGlobalVariable( "CommonHomalgTableForRings" );

####################################
#
# global functions and operations:
#
####################################

# constructor methods:

DeclareGlobalFunction( "HomalgRingOfIntegersInDefaultCAS" );

DeclareGlobalFunction( "HomalgFieldOfRationalsInDefaultCAS" );

DeclareGlobalFunction( "_PrepareInputForPolynomialRing" );

DeclareGlobalFunction( "_PrepareInputForRingOfDerivations" );

DeclareGlobalFunction( "_PrepareInputForExteriorRing" );

