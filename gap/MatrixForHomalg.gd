#############################################################################
##
##  MatrixForHomalg.gd          homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declaration stuff for homalg matrices.
##
#############################################################################

####################################
#
# categories:
#
####################################

# a new category of objects:

DeclareCategory( "IsHomalgMatrix",
        IsAttributeStoringRep );

####################################
#
# properties:
#
####################################

DeclareProperty( "IsInitialMatrix",
        IsHomalgMatrix );

DeclareProperty( "IsZeroMatrix",
        IsHomalgMatrix );

DeclareProperty( "IsIdentityMatrix",
        IsHomalgMatrix );

DeclareProperty( "IsFullRowRankMatrix",
        IsHomalgMatrix );

DeclareProperty( "IsFullColumnRankMatrix",
        IsHomalgMatrix );

DeclareProperty( "IsEmptyMatrix",
        IsHomalgMatrix );

DeclareProperty( "IsDiagonalMatrix",
        IsHomalgMatrix );

DeclareProperty( "IsUpperTriangularMatrix",
        IsHomalgMatrix );

DeclareProperty( "IsLowerTriangularMatrix",
        IsHomalgMatrix );

DeclareProperty( "IsStrictUpperTriangularMatrix",
        IsHomalgMatrix );

DeclareProperty( "IsStrictLowerTriangularMatrix",
        IsHomalgMatrix );

DeclareProperty( "IsTriangularMatrix",
        IsHomalgMatrix );

DeclareProperty( "EvalAddRhs",
        IsHomalgMatrix );

DeclareProperty( "EvalAddBts",
        IsHomalgMatrix );

####################################
#
# attributes:
#
####################################

DeclareAttribute( "Eval",
        IsHomalgMatrix );

DeclareAttribute( "EvalInvolution",
        IsHomalgMatrix );

DeclareAttribute( "EvalCertainRows",
        IsHomalgMatrix );

DeclareAttribute( "EvalCertainColumns",
        IsHomalgMatrix );

DeclareAttribute( "EvalUnionOfRows",
        IsHomalgMatrix );

DeclareAttribute( "EvalUnionOfColumns",
        IsHomalgMatrix );

DeclareAttribute( "EvalDiagMat",
        IsHomalgMatrix );

DeclareAttribute( "EvalMulMat",
        IsHomalgMatrix );

DeclareAttribute( "EvalAddMat",
        IsHomalgMatrix );

DeclareAttribute( "EvalSubMat",
        IsHomalgMatrix );

DeclareAttribute( "EvalCompose",
        IsHomalgMatrix );

DeclareAttribute( "EvalGetSide",
        IsHomalgMatrix );

DeclareAttribute( "PreEval",
        IsHomalgMatrix );

DeclareAttribute( "NrRows",
        IsHomalgMatrix );

DeclareAttribute( "NrColumns",
        IsHomalgMatrix );

DeclareAttribute( "RowRankOfMatrix",
        IsHomalgMatrix );

DeclareAttribute( "ColumnRankOfMatrix",
        IsHomalgMatrix );

DeclareAttribute( "RightHandSide",
        IsHomalgMatrix );

DeclareAttribute( "BottomSide",
        IsHomalgMatrix );

DeclareAttribute( "CompatibilityConditions",
        IsHomalgMatrix );

DeclareAttribute( "ZeroRows",
        IsHomalgMatrix );

DeclareAttribute( "ZeroColumns",
        IsHomalgMatrix );

DeclareAttribute( "NonZeroRows",
        IsHomalgMatrix );

DeclareAttribute( "NonZeroColumns",
        IsHomalgMatrix );

####################################
#
# synonyms:
#
####################################

DeclareSynonymAttr( "CompCond",
        CompatibilityConditions );

####################################
#
# global functions and operations:
#
####################################

# constructor methods:

DeclareGlobalFunction( "MatrixForHomalg" );

# basic operations:

DeclareOperation( "HomalgRing",
        [ IsHomalgMatrix ] );

DeclareOperation( "HomalgPointer",
        [ IsHomalgMatrix ] );

DeclareOperation( "HomalgExternalCASystem",
        [ IsHomalgMatrix ] );

DeclareOperation( "HomalgExternalCASystemVersion",
        [ IsHomalgMatrix ] );

DeclareOperation( "HomalgStream",
        [ IsHomalgMatrix ] );

DeclareOperation( "HomalgExternalCASystemPID",
        [ IsHomalgMatrix ] );

DeclareOperation( "Involution",
        [ IsHomalgMatrix ] );

DeclareOperation( "CertainRows",
        [ IsHomalgMatrix, IsList ] );

DeclareOperation( "CertainColumns",
        [ IsHomalgMatrix, IsList ] );

DeclareOperation( "UnionOfRows",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "UnionOfColumns",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "DiagMat",
        [ IsList ] );

DeclareOperation( "*",
        [ IsRingElement, IsHomalgMatrix ] );

DeclareOperation( "*",
        [ IsHomalgExternalObject, IsHomalgMatrix ] );

DeclareOperation( "+",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "AdditiveInverseSameMutability",
        [ IsHomalgMatrix ] );

DeclareOperation( "-",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "*",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "AddRhs",
        [ IsHomalgMatrix ] );

DeclareOperation( "AddRhs",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "AddBts",
        [ IsHomalgMatrix ] );

DeclareOperation( "AddBts",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "GetSide",
        [ IsString, IsHomalgMatrix ] );

