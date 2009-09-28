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

## this is introduced to allow internal matrices
## to remain mutable, although Eval is an attribute
DeclareCategory( "IsInternalMatrixHull",
        IsAdditiveElementWithInverse
        and IsExtLElement
        and IsComponentObjectRep ); ## CAUTION: never let such matrix hulls be multiplicative elements!!

##  <#GAPDoc Label="IsHomalgMatrix">
##  <ManSection>
##    <Filt Type="Category" Arg="A" Name="IsHomalgMatrix"/>
##    <Returns>true or false</Returns>
##    <Description>
##      The &GAP; category of &homalg; matrices.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareCategory( "IsHomalgMatrix",
        IsAdditiveElementWithInverse
        and IsExtLElement
        and IsAttributeStoringRep ); ## CAUTION: never let homalg matrices be multiplicative elements!!

####################################
#
# properties:
#
####################################

##  <#GAPDoc Label="IsMutableMatrix">
##  <ManSection>
##    <Filt Arg="A" Name="IsMutableMatrix"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareFilter( "IsMutableMatrix",
        IsHomalgMatrix );

DeclareOperation( "SetIsMutableMatrix",
        [ IsHomalgMatrix, IsBool ] );

DeclareOperation( "HasIsMutableMatrix",
        [ IsHomalgMatrix ] );

##  <#GAPDoc Label="IsInitialMatrix">
##  <ManSection>
##    <Prop Arg="A" Name="IsInitialMatrix"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsInitialMatrix",
        IsHomalgMatrix );

##  <#GAPDoc Label="IsInitialIdentityMatrix">
##  <ManSection>
##    <Prop Arg="A" Name="IsInitialIdentityMatrix"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsInitialIdentityMatrix",
        IsHomalgMatrix );

##  <#GAPDoc Label="IsVoidMatrix">
##  <ManSection>
##    <Prop Arg="A" Name="IsVoidMatrix"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsVoidMatrix",
        IsHomalgMatrix );

##  <#GAPDoc Label="IsZero:matrix">
##  <ManSection>
##    <Prop Arg="A" Name="IsZero" Label="for matrices"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##      (&see; <Ref Meth="IsZero" Label="a method for matrices"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##

##  <#GAPDoc Label="IsIdentityMatrix">
##  <ManSection>
##    <Prop Arg="A" Name="IsIdentityMatrix"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsIdentityMatrix",
        IsHomalgMatrix );

##  <#GAPDoc Label="IsPermutationMatrix">
##  <ManSection>
##    <Prop Arg="A" Name="IsPermutationMatrix"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsPermutationMatrix",
        IsHomalgMatrix );

##  <#GAPDoc Label="IsSubidentityMatrix">
##  <ManSection>
##    <Prop Arg="A" Name="IsSubidentityMatrix"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsSubidentityMatrix",
        IsHomalgMatrix );

##  <#GAPDoc Label="IsLeftRegularMatrix">
##  <ManSection>
##    <Prop Arg="A" Name="IsLeftRegularMatrix"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsLeftRegularMatrix",
        IsHomalgMatrix );

##  <#GAPDoc Label="IsRightRegularMatrix">
##  <ManSection>
##    <Prop Arg="A" Name="IsRightRegularMatrix"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsRightRegularMatrix",
        IsHomalgMatrix );

##  <#GAPDoc Label="IsInvertibleMatrix">
##  <ManSection>
##    <Prop Arg="A" Name="IsInvertibleMatrix"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsInvertibleMatrix",
        IsHomalgMatrix );

##  <#GAPDoc Label="IsLeftInvertibleMatrix">
##  <ManSection>
##    <Prop Arg="A" Name="IsLeftInvertibleMatrix"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsLeftInvertibleMatrix",
        IsHomalgMatrix );

##  <#GAPDoc Label="IsRightInvertibleMatrix">
##  <ManSection>
##    <Prop Arg="A" Name="IsRightInvertibleMatrix"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsRightInvertibleMatrix",
        IsHomalgMatrix );

##  <#GAPDoc Label="IsEmptyMatrix">
##  <ManSection>
##    <Prop Arg="A" Name="IsEmptyMatrix"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsEmptyMatrix",
        IsHomalgMatrix );

##  <#GAPDoc Label="IsDiagonalMatrix">
##  <ManSection>
##    <Prop Arg="A" Name="IsDiagonalMatrix"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsDiagonalMatrix",
        IsHomalgMatrix );

##  <#GAPDoc Label="IsScalarMatrix">
##  <ManSection>
##    <Prop Arg="A" Name="IsScalarlMatrix"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsScalarMatrix",
        IsHomalgMatrix );

##  <#GAPDoc Label="IsUpperTriangularMatrix">
##  <ManSection>
##    <Prop Arg="A" Name="IsUpperTriangularMatrix"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsUpperTriangularMatrix",
        IsHomalgMatrix );

##  <#GAPDoc Label="IsLowerTriangularMatrix">
##  <ManSection>
##    <Prop Arg="A" Name="IsLowerTriangularMatrix"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsLowerTriangularMatrix",
        IsHomalgMatrix );

##  <#GAPDoc Label="IsStrictUpperTriangularMatrix">
##  <ManSection>
##    <Prop Arg="A" Name="IsStrictUpperTriangularMatrix"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsStrictUpperTriangularMatrix",
        IsHomalgMatrix );

##  <#GAPDoc Label="IsStrictLowerTriangularMatrix">
##  <ManSection>
##    <Prop Arg="A" Name="IsStrictLowerTriangularMatrix"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsStrictLowerTriangularMatrix",
        IsHomalgMatrix );

##  <#GAPDoc Label="IsUpperStairCaseMatrix">
##  <ManSection>
##    <Prop Arg="A" Name="IsUpperStairCaseMatrix"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsUpperStairCaseMatrix",
        IsHomalgMatrix );

##  <#GAPDoc Label="IsLowerStairCaseMatrix">
##  <ManSection>
##    <Prop Arg="A" Name="IsLowerStairCaseMatrix"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsLowerStairCaseMatrix",
        IsHomalgMatrix );

##  <#GAPDoc Label="IsTriangularMatrix">
##  <ManSection>
##    <Prop Arg="A" Name="IsTriangularMatrix"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsTriangularMatrix",
        IsHomalgMatrix );

##  <#GAPDoc Label="IsBasisOfRowsMatrix">
##  <ManSection>
##    <Prop Arg="A" Name="IsBasisOfRowsMatrix"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsBasisOfRowsMatrix",
        IsHomalgMatrix );

##  <#GAPDoc Label="IsBasisOfColumnsMatrix">
##  <ManSection>
##    <Prop Arg="A" Name="IsBasisOfColumnsMatrix"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsBasisOfColumnsMatrix",
        IsHomalgMatrix );

##  <#GAPDoc Label="IsReducedBasisOfRowsMatrix">
##  <ManSection>
##    <Prop Arg="A" Name="IsReducedBasisOfRowsMatrix"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsReducedBasisOfRowsMatrix",
        IsHomalgMatrix );

##  <#GAPDoc Label="IsReducedBasisOfColumnsMatrix">
##  <ManSection>
##    <Prop Arg="A" Name="IsReducedBasisOfColumnsMatrix"/>
##    <Returns>true or false</Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsReducedBasisOfColumnsMatrix",
        IsHomalgMatrix );

####################################
#
# attributes:
#
####################################

DeclareAttribute( "Eval",
        IsHomalgMatrix );

DeclareAttribute( "EvalMatrixOperation",
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

DeclareAttribute( "PreEval",
        IsHomalgMatrix );

##  <#GAPDoc Label="NrRows">
##  <ManSection>
##    <Attr Arg="A" Name="NrRows"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      The number of rows of the matrix <A>A</A>.
##      (&see; <Ref Meth="NrRows" Label="for matrices"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "NrRows",
        IsHomalgMatrix );

##  <#GAPDoc Label="NrColumns">
##  <ManSection>
##    <Attr Arg="A" Name="NrColumns"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      The number of columns of the matrix <A>A</A>.
##      (&see; <Ref Meth="NrColumns" Label="for matrices"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "NrColumns",
        IsHomalgMatrix );

##  <#GAPDoc Label="RowRankOfMatrix">
##  <ManSection>
##    <Attr Arg="A" Name="RowRankOfMatrix"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      The row rank of the matrix <A>A</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "RowRankOfMatrix",
        IsHomalgMatrix );

##  <#GAPDoc Label="ColumnRankOfMatrix">
##  <ManSection>
##    <Attr Arg="A" Name="ColumnRankOfMatrix"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      The column rank of the matrix <A>A</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ColumnRankOfMatrix",
        IsHomalgMatrix );

##  <#GAPDoc Label="ZeroRows">
##  <ManSection>
##    <Attr Arg="A" Name="ZeroRows"/>
##    <Returns>a (possibly empty) list of positive integers</Returns>
##    <Description>
##      The list of zero rows of the matrix <A>A</A>.
##      (&see; <Ref Meth="ZeroRows" Label="for matrices"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ZeroRows",
        IsHomalgMatrix );

##  <#GAPDoc Label="ZeroColumns">
##  <ManSection>
##    <Attr Arg="A" Name="ZeroColumns"/>
##    <Returns>a (possibly empty) list of positive integers</Returns>
##    <Description>
##      The list of zero columns of the matrix <A>A</A>.
##      (&see; <Ref Meth="ZeroColumns" Label="for matrices"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ZeroColumns",
        IsHomalgMatrix );

##  <#GAPDoc Label="NonZeroRows">
##  <ManSection>
##    <Attr Arg="A" Name="NonZeroRows"/>
##    <Returns>a (possibly empty) list of positive integers</Returns>
##    <Description>
##      The list of nonzero rows of the matrix <A>A</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "NonZeroRows",
        IsHomalgMatrix );

##  <#GAPDoc Label="NonZeroColumns">
##  <ManSection>
##    <Attr Arg="A" Name="NonZeroColumns"/>
##    <Returns>a (possibly empty) list of positive integers</Returns>
##    <Description>
##      The list of nonzero columns of the matrix <A>A</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "NonZeroColumns",
        IsHomalgMatrix );

##  <#GAPDoc Label="PositionOfFirstNonZeroEntryPerRow">
##  <ManSection>
##    <Attr Arg="A" Name="PositionOfFirstNonZeroEntryPerRow"/>
##    <Returns>a list of nonnegative integers</Returns>
##    <Description>
##      The list of positions of the first nonzero entry per row of the
##      matrix <A>A</A>, else zero.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "PositionOfFirstNonZeroEntryPerRow",
        IsHomalgMatrix );

##  <#GAPDoc Label="PositionOfFirstNonZeroEntryPerColumn">
##  <ManSection>
##    <Attr Arg="A" Name="PositionOfFirstNonZeroEntryPerColumn"/>
##    <Returns>a list of nonnegative integers</Returns>
##    <Description>
##      The list of positions of the first nonzero entry per column of the
##      matrix <A>A</A>, else zero.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "PositionOfFirstNonZeroEntryPerColumn",
        IsHomalgMatrix );

##  <#GAPDoc Label="DegreesOfEntries">
##  <ManSection>
##    <Attr Arg="A" Name="DegreesOfEntries"/>
##    <Returns>a matrix of integers</Returns>
##    <Description>
##      The matrix of degrees of the matrix <A>A</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "DegreesOfEntries",
        IsHomalgMatrix );

####################################
#
# global functions and operations:
#
####################################

# constructors:

DeclareGlobalFunction( "homalgInternalMatrixHull" );

DeclareGlobalFunction( "HomalgMatrix" );

DeclareGlobalFunction( "HomalgMatrixWithAttributes" );

DeclareGlobalFunction( "HomalgZeroMatrix" );

DeclareGlobalFunction( "HomalgIdentityMatrix" );

DeclareGlobalFunction( "HomalgInitialMatrix" );

DeclareGlobalFunction( "HomalgInitialIdentityMatrix" );

DeclareGlobalFunction( "HomalgVoidMatrix" );

DeclareGlobalFunction( "HomalgDiagonalMatrix" );

DeclareGlobalFunction( "HomalgScalarMatrix" );

DeclareGlobalFunction( "ConvertHomalgMatrix" );

DeclareGlobalFunction( "ListToListList" );

DeclareOperation( "CreateHomalgMatrixFromString",
        [ IsString, IsHomalgRing ] );

DeclareOperation( "CreateHomalgMatrixFromString",
        [ IsString, IsInt, IsInt, IsHomalgRing ] );

DeclareOperation( "CreateHomalgSparseMatrixFromString",
        [ IsString, IsInt, IsInt, IsHomalgRing ] );

DeclareOperation( "SaveHomalgMatrixToFile",
        [ IsString, IsHomalgMatrix, IsHomalgRing ] );

DeclareOperation( "SaveHomalgMatrixToFile",
        [ IsString, IsHomalgMatrix ] );

DeclareOperation( "LoadHomalgMatrixFromFile",
        [ IsString, IsHomalgRing ] );

DeclareOperation( "LoadHomalgMatrixFromFile",
        [ IsString, IsInt, IsInt, IsHomalgRing ] );

DeclareOperation( "*",
        [ IsHomalgRing, IsHomalgMatrix ] );

DeclareOperation( "*",
        [ IsHomalgMatrix, IsHomalgRing ] );

DeclareOperation( "RingMap",
        [ IsHomalgMatrix, IsHomalgRing, IsHomalgRing ] );

# basic operations:

DeclareOperation( "HomalgRing",
        [ IsHomalgMatrix ] );

DeclareOperation( "GetRidOfObsoleteRows",
        [ IsHomalgMatrix ] );

DeclareOperation( "GetRidOfObsoleteColumns",
        [ IsHomalgMatrix ] );

DeclareOperation( "BlindlyCopyMatrixProperties",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

##  <#GAPDoc Label="NonTrivialDegreePerRow">
##  <ManSection>
##    <Oper Arg="A[, col_degrees]" Name="NonTrivialDegreePerRow"/>
##    <Returns>a list of integers</Returns>
##    <Description>
##      The list of non-trivial degrees per row of the matrix <A>A</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "NonTrivialDegreePerRow",
        [ IsHomalgMatrix ] );

DeclareOperation( "NonTrivialDegreePerRow",
        [ IsHomalgMatrix, IsList ] );

##  <#GAPDoc Label="NonTrivialDegreePerColumn">
##  <ManSection>
##    <Oper Arg="A[, row_degrees]" Name="NonTrivialDegreePerColumn"/>
##    <Returns>a list of integers</Returns>
##    <Description>
##      The list of non-trivial degrees per column of the matrix <A>A</A>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareOperation( "NonTrivialDegreePerColumn",
        [ IsHomalgMatrix ] );

DeclareOperation( "NonTrivialDegreePerColumn",
        [ IsHomalgMatrix, IsList ] );

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
        [ IsHomalgMatrix, IsInt, IsInt, IsRingElement, IsHomalgRing ] );

DeclareOperation( "AddToEntryOfHomalgMatrix",
        [ IsHomalgMatrix, IsInt, IsInt, IsRingElement ] );

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

DeclareOperation( "EntriesOfHomalgMatrix",
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

DeclareOperation( "POW",			## this must remain, since an element in IsHomalgMatrix
        [ IsHomalgMatrix, IsInt ] );		## is not a priori IsMultiplicativeElement

DeclareOperation( "DiagonalEntries",
        [ IsHomalgMatrix ] );

DeclareOperation( "Minors",
        [ IsInt, IsHomalgMatrix ] );

DeclareOperation( "MaximalMinors",
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

