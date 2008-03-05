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
        [ IsHomalgMatrix ] );

DeclareOperation( "BasisOfColumnsCoeff",
        [ IsHomalgMatrix ] );

DeclareOperation( "EffectivelyDecideZeroRows",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "EffectivelyDecideZeroColumns",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "SyzygiesBasisOfRows",
        [ IsHomalgMatrix ] );

DeclareOperation( "SyzygiesBasisOfColumns",
        [ IsHomalgMatrix ] );

DeclareOperation( "SyzygiesBasisOfRows",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "SyzygiesBasisOfColumns",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "RightDivide",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "Leftinverse",
        [ IsHomalgMatrix ] );

# global functions:

DeclareGlobalFunction( "BetterEquivalentMatrix" );

