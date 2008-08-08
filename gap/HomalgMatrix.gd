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

# two new GAP-categories:

DeclareCategory( "IsInternalMatrixHull",	## this is introduced to allow internal matrices to remain mutable, although Eval is an attribute
        IsAdditiveElementWithInverse
        and IsExtLElement
        and IsAttributeStoringRep ); ## CAUTION: never let such matrix hulls be multiplicative elements!!

DeclareCategory( "IsHomalgMatrix",
        IsAdditiveElementWithInverse
        and IsExtLElement
        and IsAttributeStoringRep ); ## CAUTION: never let homalg matrices be multiplicative elements!!

####################################
#
# properties:
#
####################################

DeclareProperty( "IsMutableMatrix",
        IsHomalgMatrix );

DeclareProperty( "IsInitialMatrix",
        IsHomalgMatrix );

DeclareProperty( "IsInitialIdentityMatrix",
        IsHomalgMatrix );

DeclareProperty( "IsVoidMatrix",
        IsHomalgMatrix );

DeclareProperty( "IsReducedModuloRingRelations",
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

DeclareProperty( "IsBasisOfRowsMatrix",
        IsHomalgMatrix );

DeclareProperty( "IsBasisOfColumnsMatrix",
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

DeclareAttribute( "EvalKroneckerMat",
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

DeclareGlobalFunction( "homalgInternalMatrixHull" );

DeclareGlobalFunction( "HomalgMatrix" );

DeclareGlobalFunction( "HomalgZeroMatrix" );

DeclareGlobalFunction( "HomalgIdentityMatrix" );

DeclareGlobalFunction( "HomalgInitialMatrix" );

DeclareGlobalFunction( "HomalgInitialIdentityMatrix" );

DeclareGlobalFunction( "HomalgVoidMatrix" );

DeclareGlobalFunction( "HomalgDiagonalMatrix" );

DeclareGlobalFunction( "ConvertHomalgMatrix" );

DeclareGlobalFunction( "ListToListList" );

# basic operations:

DeclareOperation( "HomalgRing",
        [ IsHomalgMatrix ] );

DeclareOperation( "SetExtractHomalgMatrixAsSparse",
        [ IsHomalgMatrix, IsBool ] );

DeclareOperation( "SetExtractHomalgMatrixToFile",
        [ IsHomalgMatrix, IsBool ] );

DeclareOperation( "SetEntryOfHomalgMatrix",
        [ IsHomalgMatrix, IsInt, IsInt, IsString, IsHomalgRing ] );

DeclareOperation( "SetEntryOfHomalgMatrix",
        [ IsHomalgMatrix, IsInt, IsInt, IsString ] );

DeclareOperation( "SetEntryOfHomalgMatrix",
        [ IsHomalgMatrix, IsInt, IsInt, IsRingElement, IsHomalgRing ] );

DeclareOperation( "SetEntryOfHomalgMatrix",
        [ IsHomalgMatrix, IsInt, IsInt, IsRingElement ] );

DeclareOperation( "AddToEntryOfHomalgMatrix",
        [ IsHomalgMatrix, IsInt, IsInt, IsRingElement ] );

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

DeclareOperation( "GetEntryOfHomalgMatrixAsString",
        [ IsHomalgMatrix, IsInt, IsInt, IsHomalgRing ] );

DeclareOperation( "GetEntryOfHomalgMatrixAsString",
        [ IsHomalgMatrix, IsInt, IsInt ] );

DeclareOperation( "GetEntryOfHomalgMatrix",
        [ IsHomalgMatrix, IsInt, IsInt, IsHomalgRing ] );

DeclareOperation( "GetEntryOfHomalgMatrix",
        [ IsHomalgMatrix, IsInt, IsInt ] );

DeclareOperation( "GetListOfHomalgMatrixAsString",
        [ IsHomalgMatrix, IsHomalgRing ] );

DeclareOperation( "GetListOfHomalgMatrixAsString",
        [ IsHomalgMatrix ] );

DeclareOperation( "GetListListOfHomalgMatrixAsString",
        [ IsHomalgMatrix, IsHomalgRing ] );

DeclareOperation( "GetListListOfHomalgMatrixAsString",
        [ IsHomalgMatrix ] );

DeclareOperation( "GetSparseListOfHomalgMatrixAsString",
        [ IsHomalgMatrix, IsHomalgRing ] );

DeclareOperation( "GetSparseListOfHomalgMatrixAsString",
        [ IsHomalgMatrix ] );

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

DeclareOperation( "GetUnitPosition",
        [ IsHomalgMatrix, IsList ] );

DeclareOperation( "GetUnitPosition",
        [ IsHomalgMatrix ] );

DeclareOperation( "GetCleanRowsPositions",
        [ IsHomalgMatrix, IsList ] );

DeclareOperation( "GetCleanRowsPositions",
        [ IsHomalgMatrix ] );

DeclareOperation( "GetColumnIndependentUnitPositions",
        [ IsHomalgMatrix, IsList ] );

DeclareOperation( "GetColumnIndependentUnitPositions",
        [ IsHomalgMatrix ] );

DeclareOperation( "GetRowIndependentUnitPositions",
        [ IsHomalgMatrix, IsList ] );

DeclareOperation( "GetRowIndependentUnitPositions",
        [ IsHomalgMatrix ] );

DeclareOperation( "DivideEntryByUnit",
        [ IsHomalgMatrix, IsInt, IsInt, IsRingElement ] );

DeclareOperation( "DivideRowByUnit",
        [ IsHomalgMatrix, IsInt, IsRingElement, IsInt ] );

DeclareOperation( "DivideColumnByUnit",
        [ IsHomalgMatrix, IsInt, IsRingElement, IsInt ] );

DeclareOperation( "CopyRowToIdentityMatrix",
        [ IsHomalgMatrix, IsInt, IsList, IsInt ] );

DeclareOperation( "CopyColumnToIdentityMatrix",
        [ IsHomalgMatrix, IsInt, IsList, IsInt ] );

DeclareOperation( "SetColumnToZero",
        [ IsHomalgMatrix, IsInt, IsInt ] );

DeclareOperation( "ConvertRowToMatrix",
        [ IsHomalgMatrix, IsInt, IsInt ] );

DeclareOperation( "ConvertColumnToMatrix",
        [ IsHomalgMatrix, IsInt, IsInt ] );

DeclareOperation( "ConvertMatrixToRow",
        [ IsHomalgMatrix ] );

DeclareOperation( "ConvertMatrixToColumn",
        [ IsHomalgMatrix ] );

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

DeclareOperation( "KroneckerMat",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "*",						## this must remain, since an element in IsInternalMatrixHull
        [ IsInternalMatrixHull, IsInternalMatrixHull ] );	## is not a priori IsMultiplicativeElement

DeclareOperation( "*",				## this must remain, since an element in IsHomalgMatrix
        [ IsHomalgMatrix, IsHomalgMatrix ] );	## is not a priori IsMultiplicativeElement

DeclareOperation( "DiagonalEntries",
        [ IsHomalgMatrix ] );

DeclareOperation( "BasisOfRowModule",
        [ IsHomalgMatrix ] );

DeclareOperation( "BasisOfColumnModule",
        [ IsHomalgMatrix ] );

####################################
#
# synonyms:
#
####################################

DeclareSynonym( "Leftinverse",
        LeftInverse );

DeclareSynonym( "Rightinverse",
        RightInverse );

