#############################################################################
##
##  HomalgMatrix.gd             homalg package               Mohamed Barakat
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
        IsAdditiveElementWithInverse
        and IsExtLElement
        and IsAttributeStoringRep ); ## CAUTION: never let homalg matrices be multiplicative elements!!

####################################
#
# properties:
#
####################################

DeclareProperty( "IsInitialMatrix",
        IsHomalgMatrix );

DeclareProperty( "IsVoidMatrix",
        IsHomalgMatrix );

DeclareProperty( "IsReducedModuloRingRelations",
        IsHomalgMatrix );

DeclareProperty( "IsZeroMatrix",
        IsHomalgMatrix );

DeclareProperty( "IsIdentityMatrix",
        IsHomalgMatrix );

DeclareProperty( "IsPermutationMatrix",
        IsHomalgMatrix );

DeclareProperty( "IsSubidentityMatrix",
        IsHomalgMatrix );

DeclareProperty( "IsFullRowRankMatrix",
        IsHomalgMatrix );

DeclareProperty( "IsFullColumnRankMatrix",
        IsHomalgMatrix );

DeclareProperty( "IsInvertibleMatrix",
        IsHomalgMatrix );

DeclareProperty( "IsLeftInvertibleMatrix",
        IsHomalgMatrix );

DeclareProperty( "IsRightInvertibleMatrix",
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

DeclareAttribute( "ItsInvolution",
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

DeclareAttribute( "EvalLeftInverse",
        IsHomalgMatrix );

DeclareAttribute( "ItsLeftInverse",
        IsHomalgMatrix );

DeclareAttribute( "EvalRightInverse",
        IsHomalgMatrix );

DeclareAttribute( "ItsRightInverse",
        IsHomalgMatrix );

DeclareAttribute( "EvalInverse",
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

DeclareAttribute( "PositionOfFirstNonZeroEntryPerRow",
        IsHomalgMatrix );

DeclareAttribute( "PositionOfFirstNonZeroEntryPerColumn",
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

DeclareGlobalFunction( "HomalgMatrix" );

DeclareGlobalFunction( "HomalgZeroMatrix" );

DeclareGlobalFunction( "HomalgIdentityMatrix" );

DeclareGlobalFunction( "HomalgInitialMatrix" );

DeclareGlobalFunction( "HomalgVoidMatrix" );

DeclareGlobalFunction( "ConvertHomalgMatrix" );

DeclareGlobalFunction( "ListToListList" );

# basic operations:

DeclareOperation( "HomalgRing",
        [ IsHomalgMatrix ] );

DeclareOperation( "SetExtractHomalgMatrixAsSparse",
        [ IsHomalgMatrix, IsBool ] );

DeclareOperation( "SetExtractHomalgMatrixToFile",
        [ IsHomalgMatrix, IsBool ] );

# basic operations:

DeclareOperation( "SetElementOfHomalgMatrix",
        [ IsHomalgMatrix, IsInt, IsInt, IsString ] );

DeclareOperation( "SetElementOfHomalgMatrix",
        [ IsHomalgMatrix, IsInt, IsInt, IsString, IsHomalgRing ] );

DeclareOperation( "CreateHomalgMatrix",
        [ IsString, IsHomalgRing ] );

DeclareOperation( "CreateHomalgMatrix",
        [ IsString, IsInt, IsInt, IsHomalgRing ] );

DeclareOperation( "CreateHomalgMatrix",
        [ IsHomalgMatrix, IsHomalgRing ] );

DeclareOperation( "CreateHomalgSparseMatrix",
        [ IsString, IsInt, IsInt, IsHomalgRing ] );

DeclareOperation( "CreateHomalgSparseMatrix",
        [ IsHomalgMatrix, IsHomalgRing ] );

DeclareOperation( "GetElementOfHomalgMatrixAsString",
        [ IsHomalgMatrix, IsInt, IsInt, IsHomalgRing ] );

DeclareOperation( "GetListOfHomalgMatrixAsString",
        [ IsHomalgMatrix ] );

DeclareOperation( "GetListOfHomalgMatrixAsString",
        [ IsHomalgMatrix, IsHomalgRing ] );

DeclareOperation( "GetListListOfHomalgMatrixAsString",
        [ IsHomalgMatrix ] );

DeclareOperation( "GetListListOfHomalgMatrixAsString",
        [ IsHomalgMatrix, IsHomalgRing ] );

DeclareOperation( "GetSparseListOfHomalgMatrixAsString",
        [ IsHomalgMatrix ] );

DeclareOperation( "GetSparseListOfHomalgMatrixAsString",
        [ IsHomalgMatrix, IsHomalgRing ] );

DeclareOperation( "homalgPointer",
        [ IsHomalgMatrix ] );

DeclareOperation( "homalgExternalCASystem",
        [ IsHomalgMatrix ] );

DeclareOperation( "homalgExternalCASystemVersion",
        [ IsHomalgMatrix ] );

DeclareOperation( "homalgStream",
        [ IsHomalgMatrix ] );

DeclareOperation( "homalgExternalCASystemPID",
        [ IsHomalgMatrix ] );

DeclareOperation( "AreComparableMatrices",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "Involution",
        [ IsHomalgMatrix ] );

DeclareOperation( "LeftInverse",
        [ IsHomalgMatrix ] );

DeclareOperation( "RightInverse",
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

DeclareOperation( "*",				## this must remain, since an element in IsHomalgMatrix
        [ IsHomalgMatrix, IsHomalgMatrix ] );	## is not a priori IsMultiplicativeElement

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

####################################
#
# synonyms:
#
####################################

DeclareSynonym( "Leftinverse",
        LeftInverse );

DeclareSynonym( "Rightinverse",
        RightInverse );

