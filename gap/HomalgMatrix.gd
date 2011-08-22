#############################################################################
##
##  HomalgMatrix.gd             MatricesForHomalg package    Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Declarations for homalg matrices.
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
if CompareVersionNumbers( "4.4.99", VERSION ) then
    
    ## GAP 4.4 style:
    DeclareCategory( "IsHomalgMatrix",
            IsAdditiveElementWithInverse and
            IsMultiplicativeElementWithInverse and
            IsAttributeStoringRep );
    
else
    
    ## GAP 4.5 style: Max's matrix category
    DeclareCategory( "IsHomalgMatrix",
            IsMatrixObj and
            IsAttributeStoringRep );
    
fi;
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
##    <Prop Arg="A" Name="IsInitialMatrix"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
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
##    <Returns><C>true</C> or <C>false</C></Returns>
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
##    <Returns><C>true</C> or <C>false</C></Returns>
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
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; matrix <A>A</A> is a zero matrix, taking possible ring relations into account.<P/>
##      (for the installed standard method see <Ref Meth="IsZeroMatrix" Label="homalgTable entry"/>)
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );
##  Z
##  gap> A := HomalgMatrix( "[ 2 ]", ZZ );
##  <A 1 x 1 matrix over an internal ring>
##  gap> Z2 := ZZ / 2;
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
DeclareProperty( "IsEmptyMatrix",
        IsHomalgMatrix );

##  <#GAPDoc Label="IsDiagonalMatrix">
##  <ManSection>
##    <Prop Arg="A" Name="IsDiagonalMatrix"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; matrix <A>A</A> is an identity matrix, taking possible ring relations into account.<P/>
##      (for the installed standard method see <Ref Meth="IsDiagonalMatrix" Label="homalgTable entry"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareProperty( "IsDiagonalMatrix",
        IsHomalgMatrix );

##  <#GAPDoc Label="IsScalarMatrix">
##  <ManSection>
##    <Prop Arg="A" Name="IsScalarlMatrix"/>
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
DeclareProperty( "IsUpperTriangularMatrix",
        IsHomalgMatrix );

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
DeclareProperty( "IsLowerTriangularMatrix",
        IsHomalgMatrix );

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

DeclareAttribute( "EvalRightInverse",
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
##      The number of rows of the matrix <A>A</A>.<P/>
##      (for the installed standard method see <Ref Meth="NrRows" Label="homalgTable entry"/>)
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
##      The number of columns of the matrix <A>A</A>.<P/>
##      (for the installed standard method see <Ref Meth="NrColumns" Label="homalgTable entry"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "NrColumns",
        IsHomalgMatrix );

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
DeclareAttribute( "DeterminantMat",
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

DeclareAttribute( "NonZeroEntries",
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

DeclareGlobalFunction( "ListToListList" );

DeclareOperation( "CreateHomalgMatrixFromString",
        [ IsString, IsHomalgRing ] );

DeclareOperation( "CreateHomalgMatrixFromString",
        [ IsString, IsInt, IsInt, IsHomalgRing ] );

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

DeclareOperation( "*",
        [ IsHomalgRing, IsHomalgMatrix ] );

DeclareOperation( "*",
        [ IsHomalgMatrix, IsHomalgRing ] );

DeclareOperation( "RingMap",
        [ IsHomalgMatrix, IsHomalgRing, IsHomalgRing ] );

# basic operations:

DeclareOperation( "HomalgRing",
        [ IsHomalgMatrix ] );

if CompareVersionNumbers( "4.4.99", VERSION ) then
DeclareOperation( "MutableCopyMat",
        [ IsHomalgMatrix ] );
fi;

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

if not IsBound( SetMatElm ) then
DeclareOperation( "SetMatElm",
        [ IsHomalgMatrix, IsInt, IsInt, IsString ] );

DeclareOperation( "SetMatElm",
        [ IsHomalgMatrix, IsInt, IsInt, IsRingElement ] );
fi;

DeclareOperation( "SetMatElm",
        [ IsHomalgMatrix, IsInt, IsInt, IsString, IsHomalgRing ] );

DeclareOperation( "SetMatElm",
        [ IsHomalgMatrix, IsInt, IsInt, IsRingElement, IsHomalgRing ] );

if not IsBound( AddToMatElm ) then
DeclareOperation( "AddToMatElm",
        [ IsHomalgMatrix, IsInt, IsInt, IsRingElement ] );
fi;

DeclareOperation( "AddToMatElm",
        [ IsHomalgMatrix, IsInt, IsInt, IsRingElement, IsHomalgRing ] );

DeclareOperation( "MatElmAsString",
        [ IsHomalgMatrix, IsInt, IsInt, IsHomalgRing ] );

DeclareOperation( "MatElmAsString",
        [ IsHomalgMatrix, IsInt, IsInt ] );

if not IsBound( MatElm ) then
DeclareOperation( "MatElm",
        [ IsHomalgMatrix, IsInt, IsInt ] );
fi;

DeclareOperation( "MatElm",
        [ IsHomalgMatrix, IsInt, IsInt, IsHomalgRing ] );

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

DeclareOperation( "DiagonalEntries",
        [ IsHomalgMatrix ] );

DeclareOperation( "Minors",
        [ IsInt, IsHomalgMatrix ] );

DeclareOperation( "MaximalMinors",
        [ IsHomalgMatrix ] );

DeclareOperation( "CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries",
        [ IsHomalgMatrix, IsList, IsList ] );

DeclareOperation( "CoefficientsOfUnreducedNumeratorOfHilbertPoincareSeries",
        [ IsHomalgMatrix ] );

DeclareOperation( "CoefficientsOfNumeratorOfHilbertPoincareSeries",
        [ IsHomalgMatrix, IsList, IsList ] );

DeclareOperation( "CoefficientsOfNumeratorOfHilbertPoincareSeries",
        [ IsHomalgMatrix ] );

DeclareOperation( "UnreducedNumeratorOfHilbertPoincareSeries",
        [ IsHomalgMatrix, IsList, IsList, IsRingElement ] );

DeclareOperation( "UnreducedNumeratorOfHilbertPoincareSeries",
        [ IsHomalgMatrix, IsList, IsList ] );

DeclareOperation( "UnreducedNumeratorOfHilbertPoincareSeries",
        [ IsHomalgMatrix, IsRingElement ] );

DeclareOperation( "UnreducedNumeratorOfHilbertPoincareSeries",
        [ IsHomalgMatrix ] );

DeclareOperation( "NumeratorOfHilbertPoincareSeries",
        [ IsHomalgMatrix, IsList, IsList, IsRingElement ] );

DeclareOperation( "NumeratorOfHilbertPoincareSeries",
        [ IsHomalgMatrix, IsList, IsList ] );

DeclareOperation( "NumeratorOfHilbertPoincareSeries",
        [ IsHomalgMatrix, IsRingElement ] );

DeclareOperation( "NumeratorOfHilbertPoincareSeries",
        [ IsHomalgMatrix ] );

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

DeclareOperation( "HilbertPoincareSeries",
        [ IsHomalgMatrix ] );

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

DeclareOperation( "HilbertPolynomial",
        [ IsHomalgMatrix ] );

DeclareOperation( "AffineDimension",
        [ IsHomalgMatrix, IsList, IsList ] );

DeclareOperation( "AffineDimension",
        [ IsHomalgMatrix ] );

DeclareOperation( "AffineDegree",
        [ IsHomalgMatrix, IsList, IsList ] );

DeclareOperation( "AffineDegree",
        [ IsHomalgMatrix ] );

DeclareOperation( "ConstantTermOfHilbertPolynomial",
        [ IsHomalgMatrix, IsList, IsList ] );

DeclareOperation( "ConstantTermOfHilbertPolynomial",
        [ IsHomalgMatrix ] );

####################################
#
# synonyms:
#
####################################

