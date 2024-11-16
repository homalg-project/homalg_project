# SPDX-License-Identifier: GPL-2.0-or-later
# RingsForHomalg: Dictionaries of external rings
#
# Declarations
#

##  Declaration stuff for RingsForHomalg.

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

DeclareGlobalFunction( "_PrepareInputForShiftAlgebra" );

DeclareGlobalFunction( "_PrepareInputForPseudoDoubleShiftAlgebra" );

# constructor methods:

DeclareGlobalFunction( "HomalgRingOfIntegersInDefaultCAS" );

DeclareGlobalFunction( "HomalgFieldOfRationalsInDefaultCAS" );

