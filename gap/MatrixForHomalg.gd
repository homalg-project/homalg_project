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

DeclareAttribute( "EvalMul",
        IsMatrixForHomalg );

DeclareAttribute( "EvalAdd",
        IsMatrixForHomalg );

DeclareAttribute( "EvalSub",
        IsMatrixForHomalg );

DeclareAttribute( "EvalCompose",
        IsMatrixForHomalg );

DeclareAttribute( "RightHandSide",
        IsMatrixForHomalg );

DeclareAttribute( "LeftHandSide",
        IsMatrixForHomalg );

DeclareAttribute( "UpSide",
        IsMatrixForHomalg );

DeclareAttribute( "BottomSide",
        IsMatrixForHomalg );

DeclareAttribute( "CompatiblityConditions",
        IsMatrixForHomalg );

####################################
#
# synonyms:
#
####################################

DeclareSynonym( "AddRhs",
        SetRightHandSide );

DeclareSynonym ( "AddLhs",
        SetLeftHandSide );

DeclareSynonym( "AddBts",
        SetBottomSide );

DeclareSynonym ( "AddUps",
        SetUpSide );

DeclareSynonymAttr( "CompCond",
        CompatiblityConditions );

####################################
#
# global functions and operations:
#
####################################

# constructor methods:

DeclareGlobalFunction( "MatrixForHomalg" );

# basic operations:

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

DeclareOperation( "+",
        [ IsMatrixForHomalg, IsMatrixForHomalg ] );

DeclareOperation( "-",
        [ IsMatrixForHomalg, IsMatrixForHomalg ] );

DeclareOperation( "*",
        [ IsMatrixForHomalg, IsMatrixForHomalg ] );

