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

DeclareCategory( "IsMatrixForHomalg",
        IsAttributeStoringRep );

####################################
#
# properties:
#
####################################

DeclareProperty( "IsZeroMatrix",
        IsMatrixForHomalg );

DeclareProperty( "IsIdentityMatrix",
        IsMatrixForHomalg );

DeclareProperty( "IsFullRowRankMatrix",
        IsMatrixForHomalg );

DeclareProperty( "IsFullColumnRankMatrix",
        IsMatrixForHomalg );

DeclareProperty( "IsEmptyMatrix",
        IsMatrixForHomalg );

####################################
#
# attributes:
#
####################################

DeclareAttribute( "Eval",
        IsMatrixForHomalg );

DeclareAttribute( "NrRows",
        IsMatrixForHomalg );

DeclareAttribute( "NrColumns",
        IsMatrixForHomalg );

DeclareAttribute( "RowRankOfMatrix",
        IsMatrixForHomalg );

DeclareAttribute( "ColumnRankOfMatrix",
        IsMatrixForHomalg );

DeclareAttribute( "EvalCertainRows",
        IsMatrixForHomalg );

DeclareAttribute( "EvalCertainColumns",
        IsMatrixForHomalg );

DeclareAttribute( "EvalUnionOfRows",
        IsMatrixForHomalg );

DeclareAttribute( "EvalUnionOfColumns",
        IsMatrixForHomalg );

DeclareAttribute( "EvalDiagMat",
        IsMatrixForHomalg );

DeclareAttribute( "EvalMulMat",
        IsMatrixForHomalg );

DeclareAttribute( "EvalAddMat",
        IsMatrixForHomalg );

DeclareAttribute( "EvalSubMat",
        IsMatrixForHomalg );

DeclareAttribute( "EvalCompose",
        IsMatrixForHomalg );

DeclareAttribute( "EvalAddRhs",
        IsMatrixForHomalg );

DeclareAttribute( "EvalAddBts",
        IsMatrixForHomalg );

DeclareAttribute( "EvalGetSide",
        IsMatrixForHomalg );

DeclareAttribute( "RightHandSide",
        IsMatrixForHomalg );

DeclareAttribute( "BottomSide",
        IsMatrixForHomalg );

DeclareAttribute( "CompatibilityConditions",
        IsMatrixForHomalg );

DeclareAttribute( "PreEval",
        IsMatrixForHomalg );

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
        [ IsMatrixForHomalg ] );

DeclareOperation( "CertainRows",
        [ IsMatrixForHomalg, IsList ] );

DeclareOperation( "CertainColumns",
        [ IsMatrixForHomalg, IsList ] );

DeclareOperation( "UnionOfRows",
        [ IsMatrixForHomalg, IsMatrixForHomalg ] );

DeclareOperation( "UnionOfColumns",
        [ IsMatrixForHomalg, IsMatrixForHomalg ] );

DeclareOperation( "DiagMat",
        [ IsList ] );

DeclareOperation( "*",
        [ IsRingElement, IsMatrixForHomalg ] );

DeclareOperation( "+",
        [ IsMatrixForHomalg, IsMatrixForHomalg ] );

DeclareOperation( "AdditiveInverseSameMutability",
        [ IsMatrixForHomalg ] );

DeclareOperation( "-",
        [ IsMatrixForHomalg, IsMatrixForHomalg ] );

DeclareOperation( "*",
        [ IsMatrixForHomalg, IsMatrixForHomalg ] );

DeclareOperation( "AddRhs",
        [ IsMatrixForHomalg ] );

DeclareOperation( "AddRhs",
        [ IsMatrixForHomalg, IsMatrixForHomalg ] );

DeclareOperation( "AddBts",
        [ IsMatrixForHomalg ] );

DeclareOperation( "AddBts",
        [ IsMatrixForHomalg, IsMatrixForHomalg ] );

DeclareOperation( "GetSide",
        [ IsString, IsMatrixForHomalg ] );

