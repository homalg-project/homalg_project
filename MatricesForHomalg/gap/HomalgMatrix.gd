# SPDX-License-Identifier: GPL-2.0-or-later
# MatricesForHomalg: Matrices for the homalg project
#
# Declarations
#

####################################
#
# categories:
#
####################################

# two new GAP-categories:

## this is introduced to allow internal matrices
## to remain mutable, although Eval is an attribute
DeclareCategory( "IsInternalMatrixHull",
        IsAdditiveElementWithInverse and
        IsExtLElement and
        IsComponentObjectRep ); ## CAUTION: never let such matrix hulls be multiplicative elements!!

##  <#GAPDoc Label="IsHomalgMatrix">
##  <ManSection>
##    <Filt Type="Category" Arg="A" Name="IsHomalgMatrix"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; category of &homalg; matrices.
##    <Listing Type="Code"><![CDATA[
DeclareCategory( "IsHomalgMatrix",
        IsMatrixObj and
        IsAttributeStoringRep );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

####################################
#
# properties:
#
####################################

DeclareOperation( "SetIsMutableMatrix",
        [ IsHomalgMatrix, IsBool ] );

##  <#GAPDoc Label="IsInitialMatrix">
##  <ManSection>
##    <Filt Arg="A" Name="IsInitialMatrix"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareFilter( "IsInitialMatrix",
        IsHomalgMatrix );

##  <#GAPDoc Label="IsInitialIdentityMatrix">
##  <ManSection>
##    <Filt Arg="A" Name="IsInitialIdentityMatrix"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareFilter( "IsInitialIdentityMatrix",
        IsHomalgMatrix );

##  <#GAPDoc Label="IsVoidMatrix">
##  <ManSection>
##    <Filt Arg="A" Name="IsVoidMatrix"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareFilter( "IsVoidMatrix",
        IsHomalgMatrix );

##  <#GAPDoc Label="IsZero:matrix">
##  <ManSection>
##    <Prop Arg="A" Name="IsZero" Label="for matrices"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; matrix <A>A</A> is a zero matrix, taking possible ring relations into account.<P/>
##      (for the installed standard method see <Ref Meth="IsZeroMatrix" Label="homalgTable entry"/>)
##      <Example><![CDATA[
##  gap> zz := HomalgRingOfIntegers( );
##  Z
##  gap> A := HomalgMatrix( "[ 2 ]", zz );
##  <A 1 x 1 matrix over an internal ring>
##  gap> Z2 := zz / 2;
##  Z/( 2 )
##  gap> A := Z2 * A;
##  <A 1 x 1 matrix over a residue class ring>
##  gap> Display( A );
##  [ [  2 ] ]
##  
##  modulo [ 2 ]
##  gap> IsZero( A );
##  true
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

##  <#GAPDoc Label="IsOne:matrix">
##  <ManSection>
##    <Prop Arg="A" Name="IsOne"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; matrix <A>A</A> is an identity matrix, taking possible ring relations into account.<P/>
##      (for the installed standard method see <Ref Meth="IsIdentityMatrix" Label="homalgTable entry"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##

##  <#GAPDoc Label="IsPermutationMatrix">
##  <ManSection>
##    <Prop Arg="A" Name="IsPermutationMatrix"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsPermutationMatrix",
        IsHomalgMatrix );

##  <#GAPDoc Label="IsSpecialSubidentityMatrix">
##  <ManSection>
##    <Prop Arg="A" Name="IsSpecialSubidentityMatrix"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsSpecialSubidentityMatrix",
        IsHomalgMatrix );

##  <#GAPDoc Label="IsSubidentityMatrix">
##  <ManSection>
##    <Prop Arg="A" Name="IsSubidentityMatrix"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsSubidentityMatrix",
        IsHomalgMatrix );

##  <#GAPDoc Label="IsLeftRegular">
##  <ManSection>
##    <Prop Arg="A" Name="IsLeftRegular"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsLeftRegular",
        IsHomalgMatrix );

##  <#GAPDoc Label="IsRightRegular">
##  <ManSection>
##    <Prop Arg="A" Name="IsRightRegular"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsRightRegular",
        IsHomalgMatrix );

##  <#GAPDoc Label="IsInvertibleMatrix">
##  <ManSection>
##    <Prop Arg="A" Name="IsInvertibleMatrix"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
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
##    <Returns><C>true</C> or <C>false</C></Returns>
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
##    <Returns><C>true</C> or <C>false</C></Returns>
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
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
if not IsBound(IsEmptyMatrix) then # GAP >= 4.11 already provides this property
DeclareProperty( "IsEmptyMatrix",
        IsHomalgMatrix );
fi;

##  <#GAPDoc Label="IsDiagonalMatrix">
##  <ManSection>
##    <Prop Arg="A" Name="IsDiagonalMatrix"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; matrix <A>A</A> is a diagonal matrix, taking possible ring relations into account.<P/>
##      (for the installed standard method see <Ref Meth="IsDiagonalMatrix" Label="homalgTable entry"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
if not IsBound(IsDiagonalMatrix) then # GAP >= 4.11 already provides this property
DeclareProperty( "IsDiagonalMatrix",
        IsHomalgMatrix );
fi;

##  <#GAPDoc Label="IsScalarMatrix">
##  <ManSection>
##    <Prop Arg="A" Name="IsScalarMatrix"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
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
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
if not IsBound(IsUpperTriangularMatrix) then # GAP >= 4.11 already provides this property
DeclareProperty( "IsUpperTriangularMatrix",
        IsHomalgMatrix );
fi;

##  <#GAPDoc Label="IsLowerTriangularMatrix">
##  <ManSection>
##    <Prop Arg="A" Name="IsLowerTriangularMatrix"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
if not IsBound(IsLowerTriangularMatrix) then # GAP >= 4.11 already provides this property
DeclareProperty( "IsLowerTriangularMatrix",
        IsHomalgMatrix );
fi;

##  <#GAPDoc Label="IsStrictUpperTriangularMatrix">
##  <ManSection>
##    <Prop Arg="A" Name="IsStrictUpperTriangularMatrix"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
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
##    <Returns><C>true</C> or <C>false</C></Returns>
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
##    <Returns><C>true</C> or <C>false</C></Returns>
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
##    <Returns><C>true</C> or <C>false</C></Returns>
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
##    <Returns><C>true</C> or <C>false</C></Returns>
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
##    <Returns><C>true</C> or <C>false</C></Returns>
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
##    <Returns><C>true</C> or <C>false</C></Returns>
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
##    <Returns><C>true</C> or <C>false</C></Returns>
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
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsReducedBasisOfColumnsMatrix",
        IsHomalgMatrix );

##  <#GAPDoc Label="IsUnitFree">
##  <ManSection>
##    <Prop Arg="A" Name="IsUnitFree"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsUnitFree",
        IsHomalgMatrix );

DeclareProperty( "IsPrimeModule",
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

DeclareAttribute( "EvalTransposedMatrix",
        IsHomalgMatrix );

DeclareAttribute( "ItsTransposedMatrix",
        IsHomalgMatrix );

DeclareAttribute( "EvalCoercedMatrix",
        IsHomalgMatrix );

DeclareAttribute( "EvalCertainRows",
        IsHomalgMatrix );

DeclareAttribute( "EvalCertainColumns",
        IsHomalgMatrix );

DeclareAttribute( "EvalUnionOfRows",
        IsHomalgMatrix );

DeclareAttribute( "EvalUnionOfColumns",
        IsHomalgMatrix );

DeclareAttribute( "EvalConvertRowToMatrix",
        IsHomalgMatrix );

DeclareAttribute( "EvalConvertColumnToMatrix",
        IsHomalgMatrix );

DeclareAttribute( "EvalConvertMatrixToRow",
        IsHomalgMatrix );

DeclareAttribute( "EvalConvertMatrixToColumn",
        IsHomalgMatrix );

DeclareAttribute( "EvalDiagMat",
        IsHomalgMatrix );

DeclareAttribute( "EvalKroneckerMat",
        IsHomalgMatrix );

DeclareAttribute( "EvalDualKroneckerMat",
        IsHomalgMatrix );

DeclareAttribute( "EvalCoefficientsWithGivenMonomials",
        IsHomalgMatrix );

DeclareAttribute( "EvalMulMat",
        IsHomalgMatrix );

DeclareAttribute( "EvalMulMatRight",
        IsHomalgMatrix );

DeclareAttribute( "EvalAddMat",
        IsHomalgMatrix );

DeclareAttribute( "EvalSubMat",
        IsHomalgMatrix );

DeclareAttribute( "EvalCompose",
        IsHomalgMatrix );

DeclareAttribute( "EvalSyzygiesOfRows",
        IsHomalgMatrix );

DeclareAttribute( "EvalSyzygiesOfColumns",
        IsHomalgMatrix );

DeclareAttribute( "EvalLeftInverse",
        IsHomalgMatrix );

DeclareAttribute( "EvalRightInverse",
        IsHomalgMatrix );

DeclareAttribute( "EvalInverse",
        IsHomalgMatrix );

DeclareAttribute( "PreEval",
        IsHomalgMatrix );

##  <#GAPDoc Label="NumberRows">
##  <ManSection>
##    <Attr Arg="A" Name="NumberRows"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      The number of rows of the matrix <A>A</A>.<P/>
##      (for the installed standard method see <Ref Meth="NumberRows" Label="homalgTable entry"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
if false then
DeclareAttribute( "NumberRows",
        IsHomalgMatrix );
fi;

##  <#GAPDoc Label="NumberColumns">
##  <ManSection>
##    <Attr Arg="A" Name="NumberColumns"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      The number of columns of the matrix <A>A</A>.<P/>
##      (for the installed standard method see <Ref Meth="NumberColumns" Label="homalgTable entry"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
if false then
DeclareAttribute( "NumberColumns",
        IsHomalgMatrix );
fi;

DeclareSynonymAttr( "NrColumns", NumberColumns );

##  <#GAPDoc Label="DeterminantMat">
##  <ManSection>
##    <Attr Arg="A" Name="DeterminantMat"/>
##    <Returns>a ring element</Returns>
##    <Description>
##      The determinant of the quadratic matrix <A>A</A>.<P/>
##      You can invoke it with <C>Determinant</C>( <A>A</A> ).<P/>
##      (for the installed standard method see <Ref Meth="Determinant" Label="homalgTable entry"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
if not IsBound( DeterminantMatrix ) then
DeclareAttribute( "DeterminantMat",
        IsHomalgMatrix );
fi;

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
##      The list of zero rows of the matrix <A>A</A>. <P/>
##      (for the installed standard method see <Ref Meth="ZeroRows" Label="homalgTable entry"/>)
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
##      The list of zero columns of the matrix <A>A</A>. <P/>
##      (for the installed standard method see <Ref Meth="ZeroColumns" Label="homalgTable entry"/>)
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

##
DeclareAttribute( "AdjunctMatrix",
        IsHomalgMatrix );

##  <#GAPDoc Label="LeftInverse">
##  <ManSection>
##    <Attr Arg="M" Name="LeftInverse"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      A left inverse <M>C</M> of the matrix <A>M</A>. If no left inverse exists then
##      <C>false</C> is returned. (&see; <Ref Oper="RightDivide" Label="for pairs of matrices"/>) <P/>
##      (for the installed standard method see <Ref Meth="LeftInverse" Label="for matrices"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "LeftInverse",
        IsHomalgMatrix );

##  <#GAPDoc Label="RightInverse">
##  <ManSection>
##    <Attr Arg="M" Name="RightInverse"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      A right inverse <M>C</M> of the matrix <A>M</A>. If no right inverse exists then
##      <C>false</C> is returned. (&see; <Ref Oper="LeftDivide" Label="for pairs of matrices"/>) <P/>
##      (for the installed standard method see <Ref Meth="RightInverse" Label="for matrices"/>)
##
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "RightInverse",
        IsHomalgMatrix );

DeclareAttribute( "IndicatorMatrixOfNonZeroEntries",
        IsHomalgMatrix );

##  <#GAPDoc Label="CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries">
##  <ManSection>
##    <Attr Arg="A" Name="CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries"/>
##    <Returns>a list of integers</Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix (row convention).
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries",
        IsHomalgMatrix );

##  <#GAPDoc Label="CoefficientsOfNumeratorOfHilbertPoincareSeries">
##  <ManSection>
##    <Attr Arg="A" Name="CoefficientsOfNumeratorOfHilbertPoincareSeries"/>
##    <Returns>a list of integers</Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix (row convention).
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "CoefficientsOfNumeratorOfHilbertPoincareSeries",
        IsHomalgMatrix );

##  <#GAPDoc Label="UnreducedNumeratorOfHilbertPoincareSeries">
##  <ManSection>
##    <Attr Arg="A" Name="UnreducedNumeratorOfHilbertPoincareSeries"/>
##    <Returns>a univariate polynomial with rational coefficients</Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix (row convention).
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "UnreducedNumeratorOfHilbertPoincareSeries",
        IsHomalgMatrix );

##  <#GAPDoc Label="NumeratorOfHilbertPoincareSeries">
##  <ManSection>
##    <Attr Arg="A" Name="NumeratorOfHilbertPoincareSeries"/>
##    <Returns>a univariate polynomial with rational coefficients</Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix (row convention).
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "NumeratorOfHilbertPoincareSeries",
        IsHomalgMatrix );

##  <#GAPDoc Label="HilbertPoincareSeries">
##  <ManSection>
##    <Attr Arg="A" Name="HilbertPoincareSeries"/>
##    <Returns>a univariate rational function with rational coefficients</Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix (row convention).
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "HilbertPoincareSeries",
        IsHomalgMatrix );

##  <#GAPDoc Label="HilbertPolynomial">
##  <ManSection>
##    <Attr Arg="A" Name="HilbertPolynomial"/>
##    <Returns>a univariate polynomial with rational coefficients</Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix (row convention).
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "HilbertPolynomial",
        IsHomalgMatrix );

##  <#GAPDoc Label="AffineDimension">
##  <ManSection>
##    <Attr Arg="A" Name="AffineDimension"/>
##    <Returns>an integer</Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix (row convention).
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "AffineDimension",
        IsHomalgMatrix );

##  <#GAPDoc Label="AffineDegree">
##  <ManSection>
##    <Attr Arg="A" Name="AffineDegree"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix (row convention).
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "AffineDegree",
        IsHomalgMatrix );

##  <#GAPDoc Label="ProjectiveDegree">
##  <ManSection>
##    <Attr Arg="A" Name="ProjectiveDegree"/>
##    <Returns>a nonnegative integer</Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix (row convention).
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ProjectiveDegree",
        IsHomalgMatrix );

##  <#GAPDoc Label="ConstantTermOfHilbertPolynomial">
##  <ManSection>
##    <Attr Arg="A" Name="ConstantTermOfHilbertPolynomialn"/>
##    <Returns>an integer</Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix (row convention).
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "ConstantTermOfHilbertPolynomial",
        IsHomalgMatrix );

##  <#GAPDoc Label="MatrixOfSymbols">
##  <ManSection>
##    <Attr Arg="A" Name="MatrixOfSymbols"/>
##    <Returns>an integer</Returns>
##    <Description>
##      <A>A</A> is a &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "MatrixOfSymbols",
        IsHomalgMatrix );

DeclareAttribute( "MaximalDegreePartOfColumnMatrix",
        IsHomalgMatrix );
        
####################################
#
# global functions and operations:
#
####################################

# constructors:

DeclareGlobalFunction( "homalgInternalMatrixHull" );

DeclareGlobalFunction( "HomalgMatrix" );
DeclareGlobalFunction( "HomalgMatrixListList" );
DeclareGlobalFunction( "HomalgRowVector" );
DeclareGlobalFunction( "HomalgColumnVector" );

DeclareGlobalFunction( "HomalgMatrixWithAttributes" );

DeclareGlobalFunction( "HomalgZeroMatrix" );

DeclareGlobalFunction( "HomalgIdentityMatrix" );

DeclareGlobalFunction( "HomalgInitialMatrix" );

DeclareGlobalFunction( "HomalgInitialIdentityMatrix" );

DeclareGlobalFunction( "HomalgVoidMatrix" );

DeclareGlobalFunction( "HomalgDiagonalMatrix" );

DeclareGlobalFunction( "HomalgScalarMatrix" );

DeclareGlobalFunction( "StringToHomalgColumnMatrix" );

DeclareGlobalFunction( "ListToListList" );

DeclareOperation( "CreateHomalgMatrixFromString",
        [ IsString, IsHomalgRing ] );

DeclareOperation( "CreateHomalgMatrixFromString",
        [ IsString, IsInt, IsInt, IsHomalgRing ] );

DeclareOperation( "CreateHomalgBlockDiagonalMatrixFromStringList",
        [ IsList, IsList, IsList, IsHomalgRing ] );

DeclareOperation( "CreateHomalgMatrixFromSparseString",
        [ IsString, IsInt, IsInt, IsHomalgRing ] );

DeclareOperation( "CreateHomalgMatrixFromList",
        [ IsList, IsHomalgRing ] );

DeclareOperation( "CreateHomalgMatrixFromList",
        [ IsList, IsInt, IsInt, IsHomalgRing ] );

DeclareOperation( "SaveHomalgMatrixToFile",
        [ IsString, IsHomalgMatrix, IsHomalgRing ] );

DeclareOperation( "SaveHomalgMatrixToFile",
        [ IsString, IsHomalgMatrix ] );

DeclareOperation( "LoadHomalgMatrixFromFile",
        [ IsString, IsHomalgRing ] );

DeclareOperation( "LoadHomalgMatrixFromFile",
        [ IsString, IsInt, IsInt, IsHomalgRing ] );

DeclareOperation( "ConvertHomalgMatrixViaListListString",
        [ IsHomalgMatrix, IsHomalgRing ] );

DeclareOperation( "ConvertHomalgMatrixViaListListString",
        [ IsHomalgMatrix, IsInt, IsInt, IsHomalgRing ] );

DeclareOperation( "ConvertHomalgMatrixViaListString",
        [ IsHomalgMatrix, IsHomalgRing ] );

DeclareOperation( "ConvertHomalgMatrixViaListString",
        [ IsHomalgMatrix, IsInt, IsInt, IsHomalgRing ] );

DeclareOperation( "ConvertHomalgMatrixViaSparseString",
        [ IsHomalgMatrix, IsHomalgRing ] );

DeclareOperation( "ConvertHomalgMatrixViaSparseString",
        [ IsHomalgMatrix, IsInt, IsInt, IsHomalgRing ] );

DeclareOperation( "ConvertHomalgMatrix",
        [ IsHomalgMatrix, IsHomalgRing ] );

DeclareOperation( "ConvertHomalgMatrix",
        [ IsHomalgMatrix, IsInt, IsInt, IsHomalgRing ] );

#DeclareOperation( "*",
#        [ IsHomalgRing, IsHomalgMatrix ] );

#DeclareOperation( "*",
#        [ IsHomalgMatrix, IsHomalgRing ] );

# basic operations:

DeclareOperation( "HomalgRing",
        [ IsHomalgMatrix ] );

DeclareOperation( "LeftInverseLazy",
        [ IsHomalgMatrix ] );

DeclareOperation( "RightInverseLazy",
        [ IsHomalgMatrix ] );

DeclareOperation( "GetRidOfObsoleteRows",
        [ IsHomalgMatrix ] );

DeclareOperation( "GetRidOfObsoleteColumns",
        [ IsHomalgMatrix ] );

DeclareOperation( "BlindlyCopyMatrixProperties",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "SetConvertHomalgMatrixViaSparseString",
        [ IsHomalgMatrix, IsBool ] );

DeclareOperation( "SetConvertHomalgMatrixViaFile",
        [ IsHomalgMatrix, IsBool ] );

DeclareOperation( "SetMatElm",
        [ IsHomalgMatrix, IsInt, IsInt, IsString, IsHomalgRing ] );

DeclareOperation( "SetMatElm",
        [ IsHomalgMatrix, IsInt, IsInt, IsRingElement, IsHomalgRing ] );

DeclareOperation( "AddToMatElm",
        [ IsHomalgMatrix, IsInt, IsInt, IsRingElement ] );

DeclareOperation( "AddToMatElm",
        [ IsHomalgMatrix, IsInt, IsInt, IsRingElement, IsHomalgRing ] );

DeclareOperation( "MatElmAsString",
        [ IsHomalgMatrix, IsInt, IsInt, IsHomalgRing ] );

DeclareOperation( "MatElmAsString",
        [ IsHomalgMatrix, IsInt, IsInt ] );

DeclareOperation( "MatElm",
        [ IsHomalgMatrix, IsInt, IsInt, IsHomalgRing ] );

DeclareOperation( "GetListOfMatrixAsString",
        [ IsList ] );

DeclareOperation( "GetListListOfStringsOfMatrix",
        [ IsList, IsHomalgRing ] );

DeclareOperation( "GetListListOfStringsOfHomalgMatrix",
        [ IsHomalgMatrix, IsHomalgRing ] );

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

DeclareOperation( "EntriesOfHomalgMatrixAsListList",
        [ IsHomalgMatrix ] );

DeclareOperation( "EntriesOfHomalgMatrix",
        [ IsHomalgMatrix ] );

DeclareOperation( "EntriesOfHomalgRowVector",
        [ IsHomalgMatrix ] );

DeclareOperation( "EntriesOfHomalgColumnVector",
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

DeclareOperation( "ConvertRowToTransposedMatrix",
        [ IsHomalgMatrix, IsInt, IsInt ] );

DeclareOperation( "ConvertColumnToTransposedMatrix",
        [ IsHomalgMatrix, IsInt, IsInt ] );

DeclareOperation( "ConvertTransposedMatrixToRow",
        [ IsHomalgMatrix ] );

DeclareOperation( "ConvertTransposedMatrixToColumn",
        [ IsHomalgMatrix ] );

DeclareOperation( "Involution",
        [ IsHomalgMatrix ] );

DeclareOperation( "TransposedMatrix",
        [ IsHomalgMatrix ] );

# convenience
DeclareOperation( "CoercedMatrix",
        [ IsHomalgRing, IsHomalgMatrix ] );

DeclareOperation( "CoercedMatrix",
        [ IsHomalgRing, IsHomalgRing, IsHomalgMatrix ] );

DeclareOperation( "CertainRows",
        [ IsHomalgMatrix, IsList ] );

DeclareOperation( "CertainColumns",
        [ IsHomalgMatrix, IsList ] );

## UnionOfRows[Eager][Op]
DeclareGlobalFunction( "UnionOfRows" );

DeclareOperation( "UnionOfRowsOp",
        [ IsHomalgRing, IsInt, IsList ] );

DeclareGlobalFunction( "UnionOfRowsEager" );

DeclareOperation( "UnionOfRowsEagerOp",
        [ IsList, IsHomalgMatrix ] );

## UnionOfColumns[Eager][Op]
DeclareGlobalFunction( "UnionOfColumns" );

DeclareOperation( "UnionOfColumnsOp",
        [ IsHomalgRing, IsInt, IsList ] );

DeclareGlobalFunction( "UnionOfColumnsEager" );

DeclareOperation( "UnionOfColumnsEagerOp",
        [ IsList, IsHomalgMatrix ] );

DeclareOperation( "DiagMat",
        [ IsHomalgRing, IsList ] );

DeclareOperation( "KroneckerMat",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "DualKroneckerMat",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "*",                                    ## this must remain, since an element in IsInternalMatrixHull
        [ IsInternalMatrixHull, IsInternalMatrixHull ] ); ## is not a priori IsMultiplicativeElement

DeclareOperation( "DiagonalEntries",
        [ IsHomalgMatrix ] );

DeclareOperation( "Minors",
        [ IsInt, IsHomalgMatrix ] );

DeclareOperation( "MaximalMinors",
        [ IsHomalgMatrix ] );

DeclareOperation( "Numerator",
        [ IsHomalgMatrix ] );

DeclareOperation( "Denominator",
        [ IsHomalgMatrix ] );

DeclareOperation( "CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries",
        [ IsHomalgMatrix, IsList, IsList ] );

DeclareOperation( "CoefficientsOfNumeratorOfHilbertPoincareSeries",
        [ IsHomalgMatrix, IsList, IsList ] );

DeclareOperation( "UnreducedNumeratorOfHilbertPoincareSeries",
        [ IsHomalgMatrix, IsList, IsList, IsRingElement ] );

DeclareOperation( "UnreducedNumeratorOfHilbertPoincareSeries",
        [ IsHomalgMatrix, IsList, IsList ] );

DeclareOperation( "UnreducedNumeratorOfHilbertPoincareSeries",
        [ IsHomalgMatrix, IsRingElement ] );

DeclareOperation( "NumeratorOfHilbertPoincareSeries",
        [ IsHomalgMatrix, IsList, IsList, IsRingElement ] );

DeclareOperation( "NumeratorOfHilbertPoincareSeries",
        [ IsHomalgMatrix, IsList, IsList ] );

DeclareOperation( "NumeratorOfHilbertPoincareSeries",
        [ IsHomalgMatrix, IsRingElement ] );

DeclareOperation( "HilbertPoincareSeries",
        [ IsHomalgMatrix, IsList, IsList, IsRingElement ] );

DeclareOperation( "HilbertPoincareSeries",
        [ IsHomalgMatrix, IsList, IsList, IsString ] );

DeclareOperation( "HilbertPoincareSeries",
        [ IsHomalgMatrix, IsList, IsList ] );

DeclareOperation( "HilbertPoincareSeries",
        [ IsHomalgMatrix, IsRingElement ] );

DeclareOperation( "HilbertPoincareSeries",
        [ IsHomalgMatrix, IsString ] );

DeclareOperation( "HilbertPolynomial",
        [ IsHomalgMatrix, IsList, IsList, IsRingElement ] );

DeclareOperation( "HilbertPolynomial",
        [ IsHomalgMatrix, IsList, IsList, IsString ] );

DeclareOperation( "HilbertPolynomial",
        [ IsHomalgMatrix, IsList, IsList ] );

DeclareOperation( "HilbertPolynomial",
        [ IsHomalgMatrix, IsRingElement ] );

DeclareOperation( "HilbertPolynomial",
        [ IsHomalgMatrix, IsString ] );

DeclareOperation( "AffineDimension",
        [ IsHomalgMatrix, IsList, IsList ] );

DeclareOperation( "AffineDegree",
        [ IsHomalgMatrix, IsList, IsList ] );

DeclareOperation( "ProjectiveDegree",
        [ IsHomalgMatrix, IsList, IsList ] );

DeclareOperation( "ConstantTermOfHilbertPolynomial",
        [ IsHomalgMatrix, IsList, IsList ] );

DeclareOperation( "NoetherNormalization",
        [ IsHomalgMatrix ] );

DeclareOperation( "Iterator",
        [ IsHomalgMatrix ] );

DeclareOperation( "Select",
        [ IsHomalgMatrix, IsList ] );

DeclareOperation( "ClearDenominatorsRowWise",
        [ IsHomalgMatrix ] );

DeclareOperation( "RandomMatrix",
        [ IsInt, IsInt, IsHomalgRing ] );

DeclareOperation( "CoefficientsWithGivenMonomials",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "CoefficientsWithGivenMonomials",
        [ IsHomalgMatrix, IsList ] );

DeclareOperation( "CoefficientsWithGivenMonomials",
        [ IsHomalgRingElement, IsHomalgMatrix ] );

DeclareOperation( "CoefficientsWithGivenMonomials",
        [ IsHomalgRingElement, IsList ] );

DeclareOperation( "LaTeXOutput",
        [ IsHomalgMatrix ] );

####################################
#
# synonyms:
#
####################################

