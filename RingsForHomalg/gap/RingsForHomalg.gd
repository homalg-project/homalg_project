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

####################################
#
# global functions and operations:
#
####################################

DeclareGlobalFunction( "_PrepareInputForRingOfDerivations" );

DeclareGlobalFunction( "_PrepareInputForExteriorRing" );

DeclareGlobalFunction( "_PrepareInputForPseudoDoubleShiftAlgebra" );

# constructor methods:

DeclareGlobalFunction( "HomalgRingOfIntegersInDefaultCAS" );

DeclareGlobalFunction( "HomalgFieldOfRationalsInDefaultCAS" );

