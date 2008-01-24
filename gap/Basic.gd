#############################################################################
##
##  Basic.gd                    homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declarations of homalg basic procedures.
##
#############################################################################

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "BasisOfRowsCoeff",
        [ IsMatrixForHomalg ] );

DeclareOperation( "BasisOfColumnsCoeff",
        [ IsMatrixForHomalg ] );

DeclareOperation( "EffectivelyDecideZeroRows",
        [ IsMatrixForHomalg, IsMatrixForHomalg ] );

DeclareOperation( "EffectivelyDecideZeroColumns",
        [ IsMatrixForHomalg, IsMatrixForHomalg ] );

