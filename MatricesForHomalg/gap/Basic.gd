# SPDX-License-Identifier: GPL-2.0-or-later
# MatricesForHomalg: Matrices for the homalg project
#
# Declarations
#

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "BasisOfRows",
        [ IsHomalgMatrix ] );

DeclareOperation( "BasisOfRows",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "BasisOfColumns",
        [ IsHomalgMatrix ] );

DeclareOperation( "BasisOfColumns",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

## this implicitly declares [ IsHomalgMatrix, IsHomalgMatrix ]
DeclareOperation( "DecideZero",
        [ IsRingElement, IsHomalgRingElement ] );

DeclareOperation( "DecideZero",
        [ IsRingElement, IsHomalgMatrix ] );

DeclareOperation( "DecideZero",
        [ IsRingElement, IsHomalgRingRelations ] );

DeclareOperation( "DecideZero",
        [ IsHomalgMatrix, IsList ] );

DeclareOperation( "DecideZero",
        [ IsHomalgMatrix ] );

DeclareOperation( "SyzygiesOfRows",
        [ IsHomalgMatrix ] );

DeclareOperation( "SyzygiesOfRows",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "SyzygiesOfRows",
        [ IsList ] );

DeclareOperation( "LazySyzygiesOfRows",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "SyzygiesOfColumns",
        [ IsHomalgMatrix ] );

DeclareOperation( "SyzygiesOfColumns",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "SyzygiesOfColumns",
        [ IsList ] );

DeclareOperation( "LazySyzygiesOfColumns",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "ReducedSyzygiesOfRows",
        [ IsHomalgMatrix ] );

DeclareOperation( "ReducedSyzygiesOfRows",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "ReducedSyzygiesOfColumns",
        [ IsHomalgMatrix ] );

DeclareOperation( "ReducedSyzygiesOfColumns",
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

DeclareOperation( "LeftDivide",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "RightDivide",
        [ IsHomalgMatrix, IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "LeftDivide",
        [ IsHomalgMatrix, IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "SafeRightDivide",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "SafeLeftDivide",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "UniqueRightDivide",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "UniqueLeftDivide",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "GenerateSameRowModule",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "GenerateSameColumnModule",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

# global functions:

DeclareGlobalFunction( "BestBasis" );

DeclareGlobalFunction( "SimplerEquivalentMatrix" );

# attributes:

DeclareAttribute( "SimplifyHomalgMatrixByLeftAndRightMultiplicationWithInvertibleMatrices",
        IsHomalgMatrix );

DeclareAttribute( "SimplifyHomalgMatrixByLeftMultiplicationWithInvertibleMatrix",
        IsHomalgMatrix );

DeclareAttribute( "SimplifyHomalgMatrixByRightMultiplicationWithInvertibleMatrix",
        IsHomalgMatrix );
