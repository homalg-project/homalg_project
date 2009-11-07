#############################################################################
##
##  HomalgMatrix.gi             homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for homalg matrices.
##
#############################################################################

####################################
#
# representations:
#
####################################

##
DeclareRepresentation( "IshomalgInternalMatrixHullRep",
        IsInternalMatrixHull,
        [ ] );

##  <#GAPDoc Label="IsHomalgInternalMatrixRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="A" Name="IsHomalgInternalMatrixRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The internal representation of &homalg; matrices. <P/>
##      (It is a representation of the &GAP; category <Ref Filt="IsHomalgMatrix"/>.)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareRepresentation( "IsHomalgInternalMatrixRep",
        IsHomalgMatrix,
        [ ] );

####################################
#
# families and types:
#
####################################

# two new family:
BindGlobal( "TheFamilyOfInternalMatrixHulls",
        NewFamily( "TheFamilyOfInternalMatrixHulls" ) );

BindGlobal( "TheFamilyOfHomalgMatrices",
        NewFamily( "TheFamilyOfHomalgMatrices" ) );

# two new types:
BindGlobal( "TheTypeInternalMatrixHull",
        NewType( TheFamilyOfInternalMatrixHulls,
                IshomalgInternalMatrixHullRep ) );

BindGlobal( "TheTypeHomalgInternalMatrix",
        NewType( TheFamilyOfHomalgMatrices,
                IsHomalgInternalMatrixRep ) );

####################################
#
# methods for operations:
#
####################################

##-----------------------------------------------------------------------------
#
# put all methods to trace errors in LIMAT.gi with the very high priority 10001
#
##-----------------------------------------------------------------------------

##
InstallMethod( Rank,
        "for homalg matrices",
        [ IsInternalMatrixHull ],
        
  function( M )
    
    return Rank( M!.matrix );
    
end );

##  <#GAPDoc Label="HomalgRing:matrix">
##  <ManSection>
##    <Oper Arg="mat" Name="HomalgRing" Label="for matrices"/>
##    <Returns>a &homalg; ring</Returns>
##    <Description>
##      The &homalg; ring of the &homalg; matrix <A>mat</A>.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );
##  <A homalg internal ring>
##  gap> d := HomalgDiagonalMatrix( [ 2 .. 4 ], ZZ );
##  <An unevaluated diagonal homalg internal 3 by 3 matrix>
##  gap> R := HomalgRing( d );
##  <A homalg internal ring>
##  gap> IsIdenticalObj( R, ZZ );
##  true
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( HomalgRing,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    
    return M!.ring;
    
end );

##
InstallMethod( BlindlyCopyMatrixProperties,	## under construction
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( S, T )
    
    ## if the new ring only interprets the 1x1 submatrices as elements
    ## then it is safe to at least copy the following attributes
    
    if HasNrRows( S ) then
        SetNrRows( T, NrRows( S ) );
    fi;
    
    if HasNrColumns( S ) then
        SetNrColumns( T, NrColumns( S ) );
    fi;
    
end );

##
InstallMethod( ShallowCopy,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, MM;
    
    R := HomalgRing( M );
    RP := homalgTable( R );
    
    if IsBound(RP!.ShallowCopy) then
        
        MM := HomalgMatrixWithAttributes( [
                      Eval, RP!.ShallowCopy( M )
                      ], R );
        
        MatchPropertiesAndAttributes( M, MM, LIMAT.intrinsic_properties, LIMAT.intrinsic_attributes );
        
        return MM;
    fi;
    
    ## we have no other choice
    return M;
    
end );

##
InstallMethod( ShallowCopy,
        "for homalg internal matrices",
        [ IsHomalgInternalMatrixRep ],
        
  function( M )
    local R, RP, MM;
    
    R := HomalgRing( M );
    RP := homalgTable( R );
    
    if IsBound(RP!.ShallowCopy) then
        
        MM := HomalgMatrixWithAttributes( [
                      Eval, RP!.ShallowCopy( M )
                      ], R );
        
        if not IsIdenticalObj( Eval( M ), Eval( MM ) ) then
            
            MatchPropertiesAndAttributes( M, MM, LIMAT.intrinsic_properties, LIMAT.intrinsic_attributes );
            
            return MM;
            
        fi;
    fi;
    
    if not IsInternalMatrixHull( Eval( M ) ) then
        TryNextMethod( );
    fi;
    
    return HomalgMatrix( One( R ) * Eval( M )!.matrix, NrRows( M ), NrColumns( M ), R );
    
end );

##
InstallMethod( ShallowCopy,
        "for homalg matrices",
        [ IsHomalgMatrix and IsIdentityMatrix ],
        
  function( M )
    
    ## do not use HomalgIdentityMatrix since
    ## we might want to alter the result
    return HomalgInitialIdentityMatrix( NrRows( M ), HomalgRing( M ) );
    
end );

##
InstallMethod( ShallowCopy,
        "for homalg matrices",
        [ IsHomalgMatrix and IsZero ],
        
  function( M )
    
    ## do not use HomalgZeroMatrix since
    ## we might want to alter the result
    return HomalgInitialMatrix( NrRows( M ), NrColumns( M ), HomalgRing( M ) );
    
end );

##
InstallMethod( SetConvertHomalgMatrixViaSparseString,
        "for homalg matrices",
        [ IsHomalgMatrix, IsBool ],
        
  function( M, b )
    
    M!.ConvertHomalgMatrixViaSparseString := b;
    
end );

##
InstallMethod( SetConvertHomalgMatrixViaFile,
        "for homalg matrices",
        [ IsHomalgMatrix, IsBool ],
        
  function( M, b )
    
    M!.ConvertHomalgMatrixViaFile := b;
    
end );

##
InstallMethod( SetEntryOfHomalgMatrix,
        "for homalg internal matrices",
        [ IsHomalgInternalMatrixRep and IsMutableMatrix, IsInt, IsInt, IsString, IsHomalgInternalRingRep ],
        
  function( M, r, c, s, R )
    
    SetEntryOfHomalgMatrix( M, r, c, One( R ) * EvalString( s ), R );
    
end );

##
InstallMethod( SetEntryOfHomalgMatrix,
        "for homalg matrices",
        [ IsHomalgMatrix, IsInt, IsInt, IsString ],
        
  function( M, r, c, s )
    
    Error( "the homalg matrix is write-protected\n" );
    
end );

##
InstallMethod( SetEntryOfHomalgMatrix,
        "for homalg matrices",
        [ IsHomalgMatrix and IsMutableMatrix, IsInt, IsInt, IsString ],
        
  function( M, r, c, s )
    
    SetEntryOfHomalgMatrix( M, r, c, s, HomalgRing( M ) );
    
end );

##
InstallMethod( SetEntryOfHomalgMatrix,
        "for homalg internal matrices",
        [ IsHomalgInternalMatrixRep and IsMutableMatrix, IsInt, IsInt, IsRingElement, IsHomalgInternalRingRep ],
        
  function( M, r, c, a, R )
    
    if not IsInternalMatrixHull( Eval( M ) ) then
        TryNextMethod( );
    fi;
    
    Eval( M )!.matrix[r][c] := One( R ) * a;
    
end );

##
InstallMethod( SetEntryOfHomalgMatrix,
        "for homalg matrices",
        [ IsHomalgMatrix, IsInt, IsInt, IsRingElement ],
        
  function( M, r, c, a )
    
    Error( "the homalg matrix is write-protected\n" );
    
end );

##
InstallMethod( SetEntryOfHomalgMatrix,
        "for homalg matrices",
        [ IsHomalgMatrix and IsMutableMatrix, IsInt, IsInt, IsRingElement ],
        
  function( M, r, c, a )
    
    SetEntryOfHomalgMatrix( M, r, c, a, HomalgRing( M ) );
    
end );

##
InstallMethod( AddToEntryOfHomalgMatrix,
        "for homalg matrices",
        [ IsHomalgMatrix, IsInt, IsInt, IsRingElement ],
        
  function( M, r, c, a )
    
    Error( "the homalg matrix is write-protected\n" );
    
end );

##
InstallMethod( AddToEntryOfHomalgMatrix,
        "for homalg matrices",
        [ IsHomalgMatrix and IsMutableMatrix, IsInt, IsInt, IsRingElement, IsHomalgRing ],
        
  function( M, r, c, a, R )
    
    SetEntryOfHomalgMatrix( M, r, c, a + GetEntryOfHomalgMatrix( M, r, c, R ), R );
    
end );

##
InstallMethod( AddToEntryOfHomalgMatrix,
        "for homalg matrices",
        [ IsHomalgMatrix and IsMutableMatrix, IsInt, IsInt, IsRingElement ],
        
  function( M, r, c, a )
    
    AddToEntryOfHomalgMatrix( M, r, c, a, HomalgRing( M ) );
    
end );

##
InstallMethod( GetEntryOfHomalgMatrixAsString,
        "for homalg internal matrices",
        [ IsHomalgInternalMatrixRep, IsInt, IsInt, IsHomalgInternalRingRep ],
        
  function( M, r, c, R )
    
    return String( GetEntryOfHomalgMatrix( M, r, c ) );
    
end );

##
InstallMethod( GetEntryOfHomalgMatrixAsString,
        "for homalg matrices",
        [ IsHomalgMatrix, IsInt, IsInt ],
        
  function( M, r, c )
    
    return GetEntryOfHomalgMatrixAsString( M, r, c, HomalgRing( M ) );
    
end );

##
InstallMethod( GetEntryOfHomalgMatrix,
        "for homalg internal matrices",
        [ IsHomalgInternalMatrixRep, IsInt, IsInt, IsHomalgInternalRingRep ],
        
  function( M, r, c, R )
    
    if IsInternalMatrixHull( Eval( M ) ) then
        return Eval( M )!.matrix[r][c];
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( GetEntryOfHomalgMatrix,
        "for homalg matrices",
        [ IsHomalgMatrix, IsInt, IsInt ],
        
  function( M, r, c )
    
    return GetEntryOfHomalgMatrix( M, r, c, HomalgRing( M ) );
    
end );

##
InstallMethod( GetListOfHomalgMatrixAsString,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    
    return GetListOfHomalgMatrixAsString( M, HomalgRing( M ) );
    
end );

##
InstallMethod( GetListOfHomalgMatrixAsString,
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgRing ],
        
  function( M, R )
    local c, s;
    
    c := NrColumns( M );
    
    s := List( [ 1 .. NrRows( M ) ], i -> List( [ 1 .. c ], j -> GetEntryOfHomalgMatrixAsString( M, i, j ) ) );
    
    s := JoinStringsWithSeparator( Concatenation( s ) );
    
    return Concatenation( "[", s, "]" );
    
end );

##
InstallMethod( GetListOfHomalgMatrixAsString,
        "for homalg internal matrices",
        [ IsHomalgInternalMatrixRep, IsHomalgInternalRingRep ],
        
  function( M, R )
    local s, m;
    
    if not IsInternalMatrixHull( Eval( M ) ) then
        TryNextMethod( );
    fi;
    
    s := Eval( M )!.matrix;
    
    if HasCharacteristic( R ) then
        m := Characteristic( R );
        if m > 0 and not HasCoefficientsRing( R ) then ## FIXME: we can only deal with Z/mZ and GF(p): m = Size( R ) !!!
            if IsPrime( m ) then
                s := List( s, a -> List( a, IntFFE ) );
            else
                s := List( s, a -> List( a, b -> b![1] ) );
            fi;
        fi;
    fi;
    
    s := String( Concatenation( s ) );
    
    RemoveCharacters( s, "\\\n " );
    
    return s;
    
end );

##
InstallMethod( GetListListOfHomalgMatrixAsString,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    
    return GetListListOfHomalgMatrixAsString( M, HomalgRing( M ) );
    
end );

##
InstallMethod( GetListListOfHomalgMatrixAsString,
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgRing ],
        
  function( M, R )
    local c, s;
    
    c := NrColumns( M );
    
    s := List( [ 1 .. NrRows( M ) ], i -> List( [ 1 .. c ], j -> GetEntryOfHomalgMatrixAsString( M, i, j ) ) );
    
    s := JoinStringsWithSeparator( List( s, JoinStringsWithSeparator ), "],[" );
    
    return Concatenation( "[[", s, "]]" );
    
end );

##
InstallMethod( GetListListOfHomalgMatrixAsString,
        "for homalg internal matrices",
        [ IsHomalgInternalMatrixRep, IsHomalgInternalRingRep ],
        
  function( M, R )
    local s, m;
    
    if not IsInternalMatrixHull( Eval( M ) ) then
        TryNextMethod( );
    fi;
    
    s := Eval( M )!.matrix;
    
    if HasCharacteristic( R ) then
        m := Characteristic( R );
        if m > 0 and not HasCoefficientsRing( R ) then ## FIXME: we can only deal with Z/mZ and GF(p): m = Size( R ) !!!
            if IsPrime( m ) then
                s := List( s, a -> List( a, IntFFE ) );
            else
                s := List( s, a -> List( a, b -> b![1] ) );
            fi;
        fi;
    fi;
    
    s := String( s );
    
    RemoveCharacters( s, "\\\n " );
    
    return s;
    
end );

##
InstallMethod( GetSparseListOfHomalgMatrixAsString,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    
    return GetSparseListOfHomalgMatrixAsString( M, HomalgRing( M ) );
    
end );

##
InstallMethod( GetSparseListOfHomalgMatrixAsString,
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgRing ],
        
  function( M, R )
    local c, s, i, j, e;
    
    c := NrColumns( M );
    
    s := [ ];
    
    for i in [ 1 .. NrRows( M ) ] do
        for j in [ 1 .. c ] do
            e := GetEntryOfHomalgMatrix( M, i, j );
            if not IsZero( e ) then
                Add( s, [ String( i ), String( j ), String( e ) ] );
            fi;
        od;
    od;
    
    s := JoinStringsWithSeparator( List( s, JoinStringsWithSeparator ), "],[" );
    
    return Concatenation( "[[", s, "]]" );
    
end );

##
InstallMethod( GetSparseListOfHomalgMatrixAsString,
        "for homalg internal matrices",
        [ IsHomalgInternalMatrixRep, IsHomalgInternalRingRep ],
        
  function( M, R )
    local r, c, z, s, m;
    
    if not IsInternalMatrixHull( Eval( M ) ) then
        TryNextMethod( );
    fi;
    
    r := NrRows( M );
    c := NrColumns( M );
    z := Zero( R );
    
    s := Eval( M )!.matrix;
    
    if HasCharacteristic( R ) then
        m := Characteristic( R );
        if m > 0 and not HasCoefficientsRing( R ) then ## FIXME: we can only deal with Z/mZ and GF(p): m = Size( R ) !!!
            if IsPrime( m ) then
                s := List( s, a -> List( a, IntFFE ) );
            else
                s := List( s, a -> List( a, b -> b![1] ) );
            fi;
        fi;
    fi;
    
    s := List( [ 1 .. r ], a -> Filtered( List( [ 1 .. c ], function( b ) if s[a][b] <> z then return [ a, b, s[a][b] ]; else return 0; fi; end ), x -> x <> 0 ) );
    
    s := Concatenation( s );
    
    s := String( s );
    
    RemoveCharacters( s, "\\\n " );
    
    return s;
    
end );

##
InstallMethod( EntriesOfHomalgMatrix,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local cols;
    
    cols := [ 1 .. NrColumns( M ) ];
    
    return Flat( List( [ 1 .. NrRows( M ) ], r -> List( cols, c -> GetEntryOfHomalgMatrix( M, r, c ) ) ) );
    
end );

##
InstallMethod( GetUnitPosition,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    
    return GetUnitPosition( M, [ ] );
    
end );

##
InstallMethod( GetCleanRowsPositions,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    
    return GetCleanRowsPositions( M, [ 1 .. NrColumns( M ) ] );
    
end );

##
InstallMethod( GetColumnIndependentUnitPositions,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    
    return GetColumnIndependentUnitPositions( M, [ ] );
    
end );

##
InstallMethod( GetRowIndependentUnitPositions,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    
    return GetRowIndependentUnitPositions( M, [ ] );
    
end );

##
InstallMethod( AreComparableMatrices,
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( M1, M2 )
    
    if HasNrRows( M1 ) or HasNrRows( M2 ) then ## trigger as few as possible operations
        return IsIdenticalObj( HomalgRing( M1 ), HomalgRing( M2 ) )
               and NrRows( M1 ) = NrRows( M2 ) and NrColumns( M1 ) = NrColumns( M2 );
    else ## no other choice
        return IsIdenticalObj( HomalgRing( M1 ), HomalgRing( M2 ) )
               and NrColumns( M1 ) = NrColumns( M2 ) and NrRows( M1 ) = NrRows( M2 );
    fi;
    
end );

##
InstallMethod( \=,
        "for internal matrix hulls",
        [ IsInternalMatrixHull, IsInternalMatrixHull ],
        
  function( M1, M2 )
    
    return M1!.matrix = M2!.matrix;
    
end );

##  <#GAPDoc Label="EQ:matrix">
##  <ManSection>
##    <Oper Arg="A, B" Name="\=" Label="for matrices"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      Check if the &homalg; matrices <A>A</A> and <A>B</A> are equal (enter: <A>A</A> <C>=</C> <A>B</A>;),
##      taking possible ring relations into account.<P/>
##      (for the installed standard method see <Ref Meth="AreEqualMatrices" Label="homalgTable entry"/>)
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );
##  <A homalg internal ring>
##  gap> A := HomalgMatrix( "[ 1 ]", ZZ );
##  <A homalg internal 1 by 1 matrix>
##  gap> B := HomalgMatrix( "[ 3 ]", ZZ );
##  <A homalg internal 1 by 1 matrix>
##  gap> Z2 := ZZ / 2;
##  <A homalg residue class ring>
##  gap> A := Z2 * A;
##  <A homalg residue class 1 by 1 matrix>
##  gap> B := Z2 * B;
##  <A homalg residue class 1 by 1 matrix>
##  gap> Display( A );
##  [ [  1 ] ]
##  
##  modulo [ 2 ]
##  gap> Display( B );
##  [ [  3 ] ]
##  
##  modulo [ 2 ]
##  gap> A = B;
##  true
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( \=,
        "for homalg comparable matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ], 10001,
        
  function( M1, M2 )
    
    if not AreComparableMatrices( M1, M2 ) then
        return false;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \=,
        "for homalg comparable internal matrices",
        [ IsHomalgInternalMatrixRep, IsHomalgInternalMatrixRep ],
        
  function( M1, M2 )
    
    return Eval( M1 ) = Eval( M2 );
    
end );

##
InstallMethod( ZeroMutable,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    
    return HomalgZeroMatrix( NrRows( M ), NrColumns( M ), HomalgRing( M ) );
    
end );

##  <#GAPDoc Label="Involution">
##  <ManSection>
##    <Meth Arg="M" Name="Involution" Label="for matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      The twisted transpose of the &homalg; matrix <A>M</A>.<P/>
##      (for the installed standard method see <Ref Meth="Eval" Label="for matrices created with Involution"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( Involution,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local C;
    
    C := HomalgMatrixWithAttributes( [
                 EvalInvolution, M,
                 NrRows, NrColumns( M ),
                 NrColumns, NrRows( M ),
                 ], HomalgRing( M ) );
    
    SetItsInvolution( M, C );
    
    return C;
    
end );

##
InstallMethod( Involution,
        "for homalg matrices",
        [ IsHomalgMatrix and HasItsInvolution ],
        
  function( M )
    
    return ItsInvolution( M );
    
end );

##  <#GAPDoc Label="CertainRows">
##  <ManSection>
##    <Meth Arg="M, plist" Name="CertainRows" Label="for matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      The matrix of which the <M>i</M>-th row is the <M>k</M>-th row of the &homalg; matrix <A>M</A>,
##      where <M>k=</M><A>plist</A><M>[i]</M>.<P/>
##      (&see; <Ref Meth="Eval" Label="for matrices created with CertainRows"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( CertainRows,
        "for homalg matrices",
        [ IsHomalgMatrix, IsList ],
        
  function( M, plist )
    
    return HomalgMatrixWithAttributes( [
                   EvalCertainRows, [ M, plist ],
                   NrRows, Length( plist ),
                   NrColumns, NrColumns( M )
                   ], HomalgRing( M ) );
    
end );

##  <#GAPDoc Label="CertainColumns">
##  <ManSection>
##    <Meth Arg="M, plist" Name="CertainColumns" Label="for matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      The matrix of which the <M>j</M>-th column is the <M>l</M>-th column of the &homalg; matrix <A>M</A>,
##      where <M>l=</M><A>plist</A><M>[i]</M>.<P/>
##      (for the installed standard method see <Ref Meth="Eval" Label="for matrices created with CertainColumns"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( CertainColumns,
        "for homalg matrices",
        [ IsHomalgMatrix, IsList ],
        
  function( M, plist )
    
    return HomalgMatrixWithAttributes( [
                   EvalCertainColumns, [ M, plist ],
                   NrColumns, Length( plist ),
                   NrRows, NrRows( M )
                   ], HomalgRing( M ) );
    
end );

##  <#GAPDoc Label="UnionOfRows">
##  <ManSection>
##    <Meth Arg="A, B" Name="UnionOfRows" Label="for matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      Stack the two &homalg; matrices <A>A</A> and <A>B</A>.<P/>
##      (for the installed standard method see <Ref Meth="Eval" Label="for matrices created with UnionOfRows"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( UnionOfRows,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( A, B )
    
    return HomalgMatrixWithAttributes( [
                   EvalUnionOfRows, [ A, B ],
                   NrRows, NrRows( A ) + NrRows( B ),
                   NrColumns, NrColumns( A )
                   ], HomalgRing( A ) );
    
end );

##  <#GAPDoc Label="UnionOfColumns">
##  <ManSection>
##    <Meth Arg="A, B" Name="UnionOfColumns" Label="for matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      Augment the two &homalg; matrices <A>A</A> and <A>B</A>.<P/>
##      (for the installed standard method see <Ref Meth="Eval" Label="for matrices created with UnionOfColumns"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( UnionOfColumns,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( A, B )
    
    return HomalgMatrixWithAttributes( [
                   EvalUnionOfColumns, [ A, B ],
                   NrRows, NrRows( A ),
                   NrColumns, NrColumns( A ) + NrColumns( B )
                   ], HomalgRing( A ) );
    
end );

##  <#GAPDoc Label="DiagMat">
##  <ManSection>
##    <Meth Arg="list" Name="DiagMat" Label="for matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      Build the block diagonal matrix out of the &homalg; matrices listed in <A>list</A>.
##      An error is issued if <A>list</A> is empty or if one of the arguments is not a &homalg; matrix.<P/>
##      (for the installed standard method see <Ref Meth="Eval" Label="for matrices created with DiagMat"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( DiagMat,
        "of two homalg matrices",
        [ IsHomogeneousList ],
        
  function( list )
    
    if IsEmpty( list ) then
        Error( "the given list of diagonal blocks is empty\n" );
    elif not ForAll( list, IsHomalgMatrix ) then
        Error( "expected a list of homalg matrices\n" );
    fi;
    
    return HomalgMatrixWithAttributes( [
                   EvalDiagMat, list,
                   NrRows, Sum( List( list, NrRows ) ),
                   NrColumns, Sum( List( list, NrColumns ) )
                   ], HomalgRing( list[1] ) );
    
end );

##  <#GAPDoc Label="KroneckerMat">
##  <ManSection>
##    <Meth Arg="A, B" Name="KroneckerMat" Label="for matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      The Kronecker (or tensor) product of the two &homalg; matrices <A>A</A> and <A>B</A>.<P/>
##      (for the installed standard method see <Ref Meth="Eval" Label="for matrices created with KroneckerMat"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( KroneckerMat,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( A, B )
    
    return HomalgMatrixWithAttributes( [
                   EvalKroneckerMat, [ A, B ],
                   NrRows, NrRows( A ) * NrRows( B ),
                   NrColumns, NrColumns( A ) * NrColumns ( B )
                   ], HomalgRing( A ) );
    
end );

##
InstallMethod( \*,
        "for internal matrix hulls",
        [ IsRingElement, IsInternalMatrixHull ], 1001, ## it could otherwise run into the method ``PROD: negative integer * additive element with inverse'', value: 24
        
  function( a, A )
    
    return homalgInternalMatrixHull( a * A!.matrix );
    
end );

##  <#GAPDoc Label="MulMat">
##  <ManSection>
##    <Meth Arg="a, A" Name="\*" Label="for ring elements and matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      The product of the ring element <A>a</A> with the &homalg; matrix <A>A</A> (enter: <A>a</A> <C>*</C> <A>A</A>;).<P/>
##      (for the installed standard method see <Ref Meth="Eval" Label="for matrices created with MulMat"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( \*,
        "for homalg matrices",
        [ IsRingElement, IsHomalgMatrix ], 1001, ## it could otherwise run into the method ``PROD: negative integer * additive element with inverse'', value: 24 (if this value is increased, the corresonding values in LIMAT must be increased as well!!!)
        
  function( a, A )
    
    return HomalgMatrixWithAttributes( [
                   EvalMulMat, [ a, A ],
                   NrRows, NrRows( A ),
                   NrColumns, NrColumns( A )
                   ], HomalgRing( A ) );
    
end );

##
InstallMethod( \+,
        "for pairs of internal matrix hulls",
        [ IsInternalMatrixHull, IsInternalMatrixHull ],
        
  function( A, B )
    
    return homalgInternalMatrixHull( A!.matrix + B!.matrix );
    
end );

##  <#GAPDoc Label="AddMat">
##  <ManSection>
##    <Meth Arg="A, B" Name="\+" Label="for matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      The sum of the two &homalg; matrices <A>A</A> and <A>B</A> (enter: <A>A</A> <C>+</C> <A>B</A>;).<P/>
##      (for the installed standard method see <Ref Meth="Eval" Label="for matrices created with AddMat"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( \+,
        "for pairs of homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( A, B )
    
    return HomalgMatrixWithAttributes( [
                   EvalAddMat, [ A, B ],
                   NrRows, NrRows( A ),
                   NrColumns, NrColumns( A )
                   ], HomalgRing( A ) );
    
end );

## a synonym of `-<elm>':
InstallMethod( AdditiveInverseMutable,
        "for internal matrix hulls",
        [ IsInternalMatrixHull ],
        
  function( A )
    
    return homalgInternalMatrixHull( -A!.matrix );
    
end );

## a synonym of `-<elm>':
InstallMethod( AdditiveInverseMutable,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( A )
    local R, C;
    
    R := HomalgRing( A );
    
    C := MinusOne( R ) * A;
    
    if HasIsZero( A ) then
        SetIsZero( C, IsZero( A ) );
    fi;
    
    return C;
    
end );

## a synonym of `-<elm>':
InstallMethod( AdditiveInverseMutable,
        "for homalg matrices",
        [ IsHomalgMatrix and IsZero ],
        
  function( A )
    
    return A;
    
end );

##
InstallMethod( \-,
        "for pairs of internal matrix hulls",
        [ IsInternalMatrixHull, IsInternalMatrixHull ],
        
  function( A, B )
    
    return homalgInternalMatrixHull( A!.matrix - B!.matrix );
    
end );

##  <#GAPDoc Label="SubMat">
##  <ManSection>
##    <Meth Arg="A, B" Name="\-" Label="for matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      The difference of the two &homalg; matrices <A>A</A> and <A>B</A> (enter: <A>A</A> <C>-</C> <A>B</A>;).<P/>
##      (for the installed standard method see <Ref Meth="Eval" Label="for matrices created with SubMat"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( \-,
        "for pairs of of homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( A, B )
    
    return HomalgMatrixWithAttributes( [
                   EvalSubMat, [ A, B ],
                   NrRows, NrRows( A ),
                   NrColumns, NrColumns( A )
                   ], HomalgRing( A ) );
    
end );

##
InstallMethod( \*,
        "for pairs of internal matrix hulls",
        [ IsInternalMatrixHull, IsInternalMatrixHull ],
        
  function( A, B )
    
    return homalgInternalMatrixHull( A!.matrix * B!.matrix );
    
end );

##  <#GAPDoc Label="Compose:matrix">
##  <ManSection>
##    <Meth Arg="A, B" Name="\*" Label="for composable matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      The matrix product of the two &homalg; matrices <A>A</A> and <A>B</A> (enter: <A>A</A> <C>*</C> <A>B</A>;).<P/>
##      (for the installed standard method see <Ref Meth="Eval" Label="for matrices created with Compose"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( \*,
        "for pairs of homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( A, B )
    
    return HomalgMatrixWithAttributes( [
                   EvalCompose, [ A, B ],
                   NrRows, NrRows( A ),
                   NrColumns, NrColumns( B )
                   ], HomalgRing( A ) );
    
end );

##
InstallMethod( POW,
        "for homalg maps",
        [ IsHomalgMatrix, IsInt ],
        
  function( A, pow )
    local R;
    
    if NrRows( A ) <> NrColumns( A ) then
        Error( "the matrix is not quadratic\n" );
    fi;
    
    R := HomalgRing( A );
    
    if pow < 0 then
        
        Error( "not implemented yet\n" );
        
    elif pow = 0 then
        
        return HomalgIdentityMatrix( NrRows( A ), R );
        
    elif pow = 1 then
        
        return A;
        
    else
        
        return Iterated( ListWithIdenticalEntries( pow, A ), \* );
        
    fi;
    
end );

##
InstallMethod( NonZeroRows,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( C )
    local zero_rows;
    
    zero_rows := ZeroRows( C );
    
    return Filtered( [ 1 .. NrRows( C ) ], x -> not x in zero_rows );
    
end );

##
InstallMethod( NonZeroColumns,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( C )
    local zero_columns;
    
    zero_columns := ZeroColumns( C );
    
    return Filtered( [ 1 .. NrColumns( C ) ], x -> not x in zero_columns );
    
end );

##
InstallMethod( LeftInverse,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local C;
    
    C := HomalgMatrixWithAttributes( [
                 EvalLeftInverse, M,
                 NrRows, NrColumns( M ),
                 NrColumns, NrRows( M )
                 ], HomalgRing( M ) );
    
    SetItsLeftInverse( M, C );
    
    return C;
    
end );

##
InstallMethod( LeftInverse,
        "for homalg matrices",
        [ IsHomalgMatrix and HasItsLeftInverse ],
        
  function( M )
    
    return ItsLeftInverse( M );
    
end );

##
InstallMethod( RightInverse,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local C;
    
    C := HomalgMatrixWithAttributes( [
                 EvalRightInverse, M,
                 NrColumns, NrRows( M ),
                 NrRows, NrColumns( M )
                 ], HomalgRing( M ) );
    
    SetItsRightInverse( M, C );
    
    return C;
    
end );

##
InstallMethod( RightInverse,
        "for homalg matrices",
        [ IsHomalgMatrix and HasItsRightInverse ],
        
  function( M )
    
    return ItsRightInverse( M );
    
end );

##
InstallMethod( DiagonalEntries,
        "of homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local m;
    
    m := Minimum( NrRows( M ), NrColumns( M ) );
    
    return List( [ 1 .. m ], a -> GetEntryOfHomalgMatrix( M, a, a ) );
    
end );

##
InstallMethod( Minors,
        "of homalg matrices",
        [ IsInt, IsHomalgMatrix ],
        
  function( d, M )
    local R, r, c, l;
    
    R := HomalgRing( M );
    
    if d = 0 then
        return [ HomalgIdentityMatrix( 1, R ) ];
    elif d < 0 then
        Error( "the dimension of minors must be non-negative\n" );
    fi;
    
    r := NrRows( M );
    c := NrColumns( M );
    
    if d > r then
        Error( "the dimension of minors must less or equal to the number of rows\n" );
    elif d > c then
        Error( "the dimension of minors must less or equal to the number of columns\n" );
    fi;
    
    l := Cartesian( Combinations( [ 1 .. r ], d ), Combinations( [ 1 .. c ], d ) );
    
    l := List( l, rc -> Determinant( CertainColumns( CertainRows( M, rc[1] ), rc[2] ) ) );
    
    return l;
    
end );

##
InstallMethod( MaximalMinors,
        "of homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    
    return Minors( Minimum( NrRows( M ), NrColumns( M ) ), M );
    
end );

##
InstallMethod( SetIsMutableMatrix,
        "for homalg matrices",
        [ IsHomalgMatrix, IsBool ],
        
  function( M, b )
    
    if b = true then;
        SetFilterObj( M, IsMutableMatrix );
    else
        ResetFilterObj( M, IsMutableMatrix );
    fi;
    
end );

##
InstallMethod( HasIsMutableMatrix,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    
    return IsMutableMatrix( M );
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallGlobalFunction( homalgInternalMatrixHull,
  function( M )
    
    return Objectify( TheTypeInternalMatrixHull, rec( matrix := M ) );
    
end );

##
InstallMethod( ConvertHomalgMatrixViaListListString,
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgRing ],
        
  function( M, R )
    local s;
    
    s := GetListListOfHomalgMatrixAsString( M );
    
    return CreateHomalgMatrixFromString( s, R );
    
end );

##
InstallMethod( ConvertHomalgMatrixViaListListString,
        "for homalg matrices",
        [ IsHomalgMatrix, IsInt, IsInt, IsHomalgRing ],
        
  function( M, r, c, R )
    local s;
    
    s := GetListListOfHomalgMatrixAsString( M );
    
    return CreateHomalgMatrixFromString( s, R );
    
end );

##
InstallMethod( ConvertHomalgMatrixViaListString,
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgRing ],
        
  function( M, R )
    local r, c, s;
    
    r := NrRows( M );
    c := NrColumns( M );
    
    s := GetListOfHomalgMatrixAsString( M );
    
    return CreateHomalgMatrixFromString( s, r, c, R );
    
end );

##
InstallMethod( ConvertHomalgMatrixViaListString,
        "for homalg matrices",
        [ IsHomalgMatrix, IsInt, IsInt, IsHomalgRing ],
        
  function( M, r, c, R )
    local s;
    
    s := GetListOfHomalgMatrixAsString( M );
    
    return CreateHomalgMatrixFromString( s, r, c, R );
    
end );

##
InstallMethod( ConvertHomalgMatrixViaSparseString,
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgRing ],
        
  function( M, R )
    local r, c, s;
    
    r := NrRows( M );
    c := NrColumns( M );
    
    s := GetSparseListOfHomalgMatrixAsString( M );
    
    return CreateHomalgMatrixFromSparseString( s, r, c, R );
    
end );

##
InstallMethod( ConvertHomalgMatrixViaSparseString,
        "for homalg matrices",
        [ IsHomalgMatrix, IsInt, IsInt, IsHomalgRing ],
        
  function( M, r, c, R )
    local s;
    
    s := GetSparseListOfHomalgMatrixAsString( M );
    
    return CreateHomalgMatrixFromSparseString( s, r, c, R );
    
end );

##
InstallMethod( ConvertHomalgMatrix,
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgRing ],
        
  function( M, R )
    
    if IsBound( M!.ConvertHomalgMatrixViaSparseString ) and M!.ConvertHomalgMatrixViaSparseString = true then
        
        return ConvertHomalgMatrixViaSparseString( M, R );
        
    fi;
    
    return ConvertHomalgMatrixViaListListString( M, R );
    
end );

##
InstallMethod( ConvertHomalgMatrix,
        "for homalg matrices",
        [ IsHomalgMatrix, IsInt, IsInt, IsHomalgRing ],
        
  function( M, r, c, R )
    
    if IsBound( M!.ConvertHomalgMatrixViaSparseString ) and M!.ConvertHomalgMatrixViaSparseString = true then
        
        return ConvertHomalgMatrixViaSparseString( M, r, c, R );
        
    fi;
    
    return ConvertHomalgMatrixViaListString( M, r, c, R );
    
end );

##
InstallMethod( CreateHomalgMatrixFromString,
        "constructor for homalg matrices",
        [ IsString, IsHomalgInternalRingRep ],
        
  function( S, R )
    local s;
    
    s := ShallowCopy( S );
    
    RemoveCharacters( s, "\\\n\" " );
    
    return HomalgMatrix( EvalString( s ), R );
    
end );

##
InstallMethod( CreateHomalgMatrixFromString,
        "constructor for homalg matrices",
        [ IsString, IsInt, IsInt, IsHomalgInternalRingRep ],
        
  function( S, r, c, R )
    local s;
    
    s := ShallowCopy( S );
    
    RemoveCharacters( s, "\\\n\" " );
    
    s := EvalString( s );
    
    if IsMatrix( s ) then
        return HomalgMatrix( s, r, c, R );
    elif IsHomogeneousList( s ) then
        return HomalgMatrix( ListToListList( s, r, c ), R );
    else
        Error( "the evaluated string is not in {IsMatrix, IsHomogeneousList}\n" );
    fi;
    
end );

##
InstallMethod( CreateHomalgMatrixFromSparseString,
        "constructor for homalg matrices",
        [ IsString, IsInt, IsInt, IsHomalgRing ],
        
  function( S, r, c, R )
    local s, M, e;
    
    s := ShallowCopy( S );
    
    RemoveCharacters( s, "[]\\\n\" " );
    
    M := HomalgInitialMatrix( r, c, R );
    
    s := SplitString( s, "," );
    
    s := ListToListList( s, Length( s ) / 3, 3 );
    
    Perform( s, function( a ) SetEntryOfHomalgMatrix( M, Int( a[1] ), Int( a[2] ), a[3], R ); end );
    
    ResetFilterObj( M, IsMutableMatrix );
    
    return M;
    
end );

##
InstallMethod( CreateHomalgMatrixFromSparseString,
        "constructor for homalg matrices",
        [ IsString, IsInt, IsInt, IsHomalgInternalRingRep ],
        
  function( S, r, c, R )
    local s, M, e;
    
    s := ShallowCopy( S );
    
    RemoveCharacters( s, "\\\n\" " );
    
    M := List( [ 1 .. r ], a -> List( [ 1 .. c ], b -> Zero( R ) ) );
    
    for e in EvalString( s ) do
        M[e[1]][e[2]] := e[3];
    od;
    
    return HomalgMatrix( M, r, c, R );
    
end );

##
InstallMethod( CreateHomalgMatrixFromList,
        "constructor for homalg matrices",
        [ IsList, IsHomalgRing ],
        
  function( L, R )
    local M;
    
    if IsMatrix( L ) and ForAll( L, r -> ForAll( r, IsRingElement ) ) then
        M := List( L, r -> List( r, String ) );
        M := Concatenation( "[[", JoinStringsWithSeparator( List( M, r -> JoinStringsWithSeparator( r ) ), "],[" ), "]]" );
    elif IsList( L ) and ForAll( L, IsRingElement ) then
        ## this resembles NormalizeInput in Maple's homalg ( a legacy ;) )
        M := Concatenation( "[[", JoinStringsWithSeparator( List( L, String ), "],[" ), "]]" );
    else
        M := String( L );
    fi;
    
    return CreateHomalgMatrixFromString( M, R );
    
end );

##
InstallMethod( CreateHomalgMatrixFromList,
        "constructor for homalg matrices",
        [ IsList, IsInt, IsInt, IsHomalgRing ],
        
  function( L, r, c, R )
    local M;
    
    if IsMatrix( L ) and ForAll( L, r -> ForAll( r, IsRingElement ) ) then
        M := List( L, r -> List( r, String ) );
        M := Concatenation( "[[", JoinStringsWithSeparator( List( M, r -> JoinStringsWithSeparator( r ) ), "],[" ), "]]" );
    elif IsList( L ) and ForAll( L, IsRingElement ) then
        M := Concatenation( "[", JoinStringsWithSeparator( List( L, String ) ), "]" );
    else
        M := String( L );
    fi;
    
    return CreateHomalgMatrixFromString( M, r, c, R );
    
end );

##  <#GAPDoc Label="HomalgMatrix">
##  <ManSection>
##    <Func Arg="llist, R" Name="HomalgMatrix" Label="constructor for matrices using a listlist"/>
##    <Func Arg="list, m, n, R" Name="HomalgMatrix" Label="constructor for matrices using a list"/>
##    <Func Arg="str_llist, R" Name="HomalgMatrix" Label="constructor for matrices using a string of a listlist"/>
##    <Func Arg="str_list, m, n, R" Name="HomalgMatrix" Label="constructor for matrices using a string of a list"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      An immutable evaluated <M><A>m</A> \times <A>n</A></M> &homalg; matrix over the &homalg; ring <A>R</A>.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );
##  <A homalg internal ring>
##  gap> m := HomalgMatrix( [ [ 1, 2, 3 ], [ 4, 5, 6 ] ], ZZ );
##  <A homalg internal 2 by 3 matrix>
##  gap> Display( m );
##  [ [  1,  2,  3 ],
##    [  4,  5,  6 ] ]
##  ]]></Example>
##      <Example><![CDATA[
##  gap> m := HomalgMatrix( [ [ 1, 2, 3 ], [ 4, 5, 6 ] ], 2, 3, ZZ );
##  <A homalg internal 2 by 3 matrix>
##  gap> Display( m );
##  [ [  1,  2,  3 ],
##    [  4,  5,  6 ] ]
##  ]]></Example>
##      <Example><![CDATA[
##  gap> m := HomalgMatrix( [ 1, 2, 3,   4, 5, 6 ], 2, 3, ZZ );
##  <A homalg internal 2 by 3 matrix>
##  gap> Display( m );
##  [ [  1,  2,  3 ],
##    [  4,  5,  6 ] ]
##  ]]></Example>
##      <Example><![CDATA[
##  gap> m := HomalgMatrix( "[ [ 1, 2, 3 ], [ 4, 5, 6 ] ]", ZZ );
##  <A homalg internal 2 by 3 matrix>
##  gap> Display( m );
##  [ [  1,  2,  3 ],
##    [  4,  5,  6 ] ]
##  ]]></Example>
##      <Example><![CDATA[
##  gap> m := HomalgMatrix( "[ [ 1, 2, 3 ], [ 4, 5, 6 ] ]", 2, 3, ZZ );
##  <A homalg internal 2 by 3 matrix>
##  gap> Display( m );
##  [ [  1,  2,  3 ],
##    [  4,  5,  6 ] ]
##  ]]></Example>
##      It is nevertheless recommended to use the following form to create &homalg; matrices. This
##      form can also be used to define external matrices. Since whitespaces
##      (&see; <Ref Label="Whitespaces" BookName="Ref"/>) are ignored,
##      they can be used as optical delimiters:
##      <Example><![CDATA[
##  gap> m := HomalgMatrix( "[ 1, 2, 3,   4, 5, 6 ]", 2, 3, ZZ );
##  <A homalg internal 2 by 3 matrix>
##  gap> Display( m );
##  [ [  1,  2,  3 ],
##    [  4,  5,  6 ] ]
##  ]]></Example>
##      One can split the input string over several lines using the backslash character '\' to end each line
##      <Example><![CDATA[
##  gap> m := HomalgMatrix( "[ \
##  > 1, 2, 3, \
##  > 4, 5, 6  \
##  > ]", 2, 3, ZZ );
##  <A homalg internal 2 by 3 matrix>
##  gap> Display( m );
##  [ [  1,  2,  3 ],
##    [  4,  5,  6 ] ]
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( HomalgMatrix,
  function( arg )
    local nargs, M, R, RP, type, matrix, nr_rows, nr_columns;
    
    nargs := Length( arg );
    
    M := arg[1];
    
    R := arg[nargs];
    
    if nargs > 1 and M <> [ ] then
        
        if HasConstructorForHomalgMatrices( R ) then
            return CallFuncList( ConstructorForHomalgMatrices( R ), arg );
        fi;
        
        if IsString( M ) then
            
            return CallFuncList( CreateHomalgMatrixFromString, arg );
            
        elif not IsHomalgInternalRingRep( R ) and		## the ring R is not internal,
          ( ( IsList( M ) and ForAll( M, IsRingElement ) ) or	## while M is either a list of ring elements,
            IsMatrix( M ) ) then				## or a matrix of (hopefully) ring elements
            
            return CallFuncList( CreateHomalgMatrixFromList, arg );
            
        fi;
    fi;
    
    if not IsHomalgRing( R ) then
        Error( "the last argument must be an IsHomalgRing\n" );
    fi;
    
    ## here we take care of the degenerate input M = [ ] for all rings
    if nargs > 1 and M = [ ] then
        return HomalgZeroMatrix( 0, 0, R );
    fi;
    
    if HasTypeOfHomalgMatrix( R ) then
        type := TypeOfHomalgMatrix( R );
    elif IsHomalgInternalRingRep( R ) then
        type := TheTypeHomalgInternalMatrix;
    else
        Error( "the homalg ring must contain the type of the matrices as the attribute TypeOfHomalgMatrix\n" );
    fi;
    
    matrix := rec( ring := R );
    
    ## here we take care of the case when only the ring is given
    if nargs = 1 then
        
        ## Objectify:
        Objectify( type, matrix );
        
        ## an empty matrix
        return matrix;
        
    fi;
    
    RP := homalgTable( R );
    
    if IsList( M ) and Length( M ) > 0 and not IsList( M[1] ) and
       ForAll( M, IsRingElement ) then
        if Length( arg ) > 2 and arg[2] in NonnegativeIntegers then
            M := ListToListList( M, arg[2], Length( M ) / arg[2] );
        else
            M := List( M, a -> [ a ] );	## this resembles NormalizeInput in Maple's homalg ( a legacy ;) )
        fi;
        
        if IsBound(RP!.ImportMatrix) then
            M := RP!.ImportMatrix( One( R ) * M, R!.ring );
        fi;
    elif IsInternalMatrixHull( M ) then
        M := M!.matrix;
    elif IsMatrix( M ) and IsBound(RP!.ImportMatrix) then
        M := RP!.ImportMatrix( One( R ) * M, R!.ring );
    else
        M := ShallowCopy( M );	## by this we are sure that possible changes to a mutable GAP matrix arg[1] does not destroy the logic of homalg
    fi;
    
    if IsHomalgInternalRingRep( R ) then ## TheTypeHomalgInternalMatrix
        
        if IsMatrix( M ) then
            ## Objectify:
            ObjectifyWithAttributes(
                    matrix, type,
                    NrRows, Length( M ),
                    NrColumns, Length( M[1] ),
                    Eval, homalgInternalMatrixHull( M ) );
        elif IsList( M ) then
            ## Objectify:
            ObjectifyWithAttributes(
                    matrix, type,
                    Eval, homalgInternalMatrixHull( M ) );
            if M = [ ] then
                SetNrRows( matrix, 0 );
                SetNrColumns( matrix, 0 );
            elif M[1] = [] then
                SetNrRows( matrix, Length( M ) );
                SetNrColumns( matrix, 0 );
            fi;
        else
            ## Objectify:
            ObjectifyWithAttributes(
                    matrix, type,
                    Eval, M );
            ## don't know how to get the number of rows/columns
        fi;
        
    else
        
        if Length( arg ) > 2 and arg[2] in NonnegativeIntegers then
            nr_rows := true;
        else
            nr_rows := false;
        fi;
        
        if Length( arg ) > 3 and arg[3] in NonnegativeIntegers then
            nr_columns := true;
        else
            nr_columns := false;
        fi;
        
        if nr_rows and nr_columns then
            ## Objectify:
            ObjectifyWithAttributes(
                    matrix, type,
                    NrRows, arg[2],
                    NrColumns, arg[3],
                    Eval, M );
        else
            ## Objectify:
            ObjectifyWithAttributes(
                    matrix, type,
                    Eval, M );
            
            if nr_rows then
                SetNrRows( matrix, arg[2] );
            fi;
            
            if nr_columns then
                SetNrColumns( matrix, arg[3] );
            fi;
        fi;
        
    fi;
    
    return matrix;
    
end );
  
##
InstallGlobalFunction( HomalgMatrixWithAttributes,
  function( attributes, R )
    local matrix;
    
    ## for performance reasons this internal function
    ## should not perform syntax checks
    
    matrix := rec( ring := R );
    
    ## ObjectifyWithAttributes:
    CallFuncList( ObjectifyWithAttributes,
            Concatenation( [ matrix, TypeOfHomalgMatrix( R ) ], attributes )
            );
    
    return matrix;
    
end );

##  <#GAPDoc Label="HomalgZeroMatrix">
##  <ManSection>
##    <Func Arg="m, n, R" Name="HomalgZeroMatrix" Label="constructor for zero matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      An immutable unevaluated <M><A>m</A> \times <A>n</A></M> &homalg; zero matrix over the &homalg; ring <A>R</A>.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );
##  <A homalg internal ring>
##  gap> z := HomalgZeroMatrix( 2, 3, ZZ );
##  <An unevaluated homalg internal 2 by 3 zero matrix>
##  gap> Display( z );
##  [ [  0,  0,  0 ],
##    [  0,  0,  0 ] ]
##  gap> z;
##  <A homalg internal 2 by 3 zero matrix>
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( HomalgZeroMatrix,
  function( arg )				## the zero matrix
    local R, type, matrix, nr_rows, nr_columns;
    
    R := arg[Length( arg )];
    
    if not IsHomalgRing( R ) then
        Error( "the last argument must be an IsHomalgRing\n" );
    fi;
    
    if HasTypeOfHomalgMatrix( R ) then
        type := TypeOfHomalgMatrix( R );
    elif IsHomalgInternalRingRep( R ) then
        type := TheTypeHomalgInternalMatrix;
    else
        Error( "the homalg ring must contain the type of the matrices as the attribute TypeOfHomalgMatrix\n" );
    fi;
    
    matrix := rec( ring := R );
    
    if Length( arg ) > 1 and arg[1] in NonnegativeIntegers then
        nr_rows := true;
    else
        nr_rows := false;
    fi;
    
    if Length( arg ) > 2 and arg[2] in NonnegativeIntegers then
        nr_columns := true;
    else
        nr_columns := false;
    fi;
    
    if nr_rows and nr_columns then
        ## Objectify:
        ObjectifyWithAttributes(
                matrix, type,
                NrRows, arg[1],
                NrColumns, arg[2],
                IsZero, true );
    else
        ## Objectify:
        ObjectifyWithAttributes(
                matrix, type,
                IsZero, true );
        
        if nr_rows then
            SetNrRows( matrix, arg[1] );
        fi;
        
        if nr_columns then
            SetNrColumns( matrix, arg[2] );
        fi;
    fi;
    
    return matrix;
    
end );

##  <#GAPDoc Label="HomalgIdentityMatrix">
##  <ManSection>
##    <Func Arg="m, R" Name="HomalgIdentityMatrix" Label="constructor for identity matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      An immutable unevaluated <M><A>m</A> \times <A>m</A></M> &homalg; identity matrix over the &homalg; ring <A>R</A>.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );
##  <A homalg internal ring>
##  gap> id := HomalgIdentityMatrix( 3, ZZ );
##  <An unevaluated homalg internal 3 by 3 identity matrix>
##  gap> Display( id );
##  [ [  1,  0,  0 ],
##    [  0,  1,  0 ],
##    [  0,  0,  1 ] ]
##  gap> id;
##  <A homalg internal 3 by 3 identity matrix>
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( HomalgIdentityMatrix,
  function( arg )		## the identity matrix
    local R, type, matrix;
    
    R := arg[Length( arg )];
    
    if not IsHomalgRing( R ) then
        Error( "the last argument must be an IsHomalgRing\n" );
    fi;
    
    if HasTypeOfHomalgMatrix( R ) then
        type := TypeOfHomalgMatrix( R );
    elif IsHomalgInternalRingRep( R ) then
        type := TheTypeHomalgInternalMatrix;
    else
        Error( "the homalg ring must contain the type of the matrices as the attribute TypeOfHomalgMatrix\n" );
    fi;
    
    matrix := rec( ring := R );
    
    if Length( arg ) > 1 and arg[1] in NonnegativeIntegers then
        ## Objectify:
        ObjectifyWithAttributes(
                matrix, type,
                NrRows, arg[1],
                NrColumns, arg[1],
                IsIdentityMatrix, true );
    else
        ## Objectify:
        ObjectifyWithAttributes(
                matrix, type,
                IsIdentityMatrix, true );
    fi;
    
    return matrix;
    
end );

##  <#GAPDoc Label="HomalgInitialMatrix">
##  <ManSection>
##    <Func Arg="m, n, R" Name="HomalgInitialMatrix" Label="constructor for initial matrices filled with zeros"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      A mutable unevaluated initial <M><A>m</A> \times <A>n</A></M> &homalg; matrix filled with zeros
##      over the &homalg; ring <A>R</A>. This construction is useful in case one wants to define a matrix
##      by assigning its nonzero entries. Avoid asking about properties or attributes of the matrix until
##      you finish filling it, since already computed values of properties and attributes will be cached
##      and not recomputed unless the values are explicitly reset (&see; <Ref Func="ResetFilterObj"
##      BookName="Prg Tutorial" Style="Number"/>).
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );
##  <A homalg internal ring>
##  gap> z := HomalgInitialMatrix( 2, 3, ZZ );
##  <An initial homalg internal 2 by 3 matrix>
##  gap> HasIsZero( z );
##  false
##  gap> IsZero( z );
##  true
##  gap> z;
##  <A homalg internal 2 by 3 zero matrix>
##  ]]></Example>
##      <Example><![CDATA[
##  gap> n := HomalgInitialMatrix( 2, 3, ZZ );
##  <An initial homalg internal 2 by 3 matrix>
##  gap> SetEntryOfHomalgMatrix( n, 1, 1, "1" );
##  gap> SetEntryOfHomalgMatrix( n, 2, 3, "1" );
##  gap> ResetFilterObj( n, IsMutableMatrix );
##  gap> Display( n );
##  [ [  1,  0,  0 ],
##    [  0,  0,  1 ] ]
##  gap> IsZero( n );
##  false
##  gap> n;
##  <A non-zero homalg internal 2 by 3 matrix>
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( HomalgInitialMatrix,
  function( arg )	        		## an initial matrix having the flag IsInitialMatrix
    local R, type, matrix, nr_rows, nr_columns;	## and filled with zeros BUT NOT marked as an IsZero
    
    R := arg[Length( arg )];
    
    if not IsHomalgRing( R ) then
        Error( "the last argument must be an IsHomalgRing\n" );
    fi;
    
    if HasTypeOfHomalgMatrix( R ) then
        type := TypeOfHomalgMatrix( R );
    elif IsHomalgInternalRingRep( R ) then
        type := TheTypeHomalgInternalMatrix;
    else
        Error( "the homalg ring must contain the type of the matrices as the attribute TypeOfHomalgMatrix\n" );
    fi;
    
    matrix := rec( ring := R );
    
    if Length( arg ) > 1 and arg[1] in NonnegativeIntegers then
        nr_rows := true;
    else
        nr_rows := false;
    fi;
    
    if Length( arg ) > 2 and arg[2] in NonnegativeIntegers then
        nr_columns := true;
    else
        nr_columns := false;
    fi;
    
    if nr_rows and nr_columns then
        ## Objectify:
        ObjectifyWithAttributes(
                matrix, type,
                NrRows, arg[1],
                NrColumns, arg[2],
                IsInitialMatrix, true );
    else
        ## Objectify:
        ObjectifyWithAttributes(
                matrix, type,
                IsInitialMatrix, true );
        
        if nr_rows then
            SetNrRows( matrix, arg[1] );
        fi;
        
        if nr_columns then
            SetNrColumns( matrix, arg[2] );
        fi;
    fi;
    
    SetIsMutableMatrix( matrix, true );
    
    return matrix;
    
end );

##  <#GAPDoc Label="HomalgInitialIdentityMatrix">
##  <ManSection>
##    <Func Arg="m, R" Name="HomalgInitialIdentityMatrix" Label="constructor for initial quadratic matrices with ones on the diagonal"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      A mutable unevaluated initial <M><A>m</A> \times <A>m</A></M> &homalg; quadratic matrix with ones
##      on the diagonal over the &homalg; ring <A>R</A>. This construction is useful in case one wants to define
##      an elementary matrix by assigning its off-diagonal nonzero entries. Avoid asking about properties or
##      attributes of the matrix until you finish filling it, since already computed values of properties and
##      attributes will be cached and not recomputed unless the values are explicitly reset
##      (&see; <Ref Func="ResetFilterObj"  BookName="Prg Tutorial" Style="Number"/>).
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );
##  <A homalg internal ring>
##  gap> id := HomalgInitialIdentityMatrix( 3, ZZ );
##  <An initial identity homalg internal 3 by 3 matrix>
##  gap> HasIsIdentityMatrix( id );
##  false
##  gap> IsIdentityMatrix( id );
##  true
##  gap> id;
##  <A homalg internal 3 by 3 identity matrix>
##  ]]></Example>
##      <Example><![CDATA[
##  gap> e := HomalgInitialIdentityMatrix( 3, ZZ );
##  <An initial identity homalg internal 3 by 3 matrix>
##  gap> SetEntryOfHomalgMatrix( e, 1, 2, "1" );
##  gap> SetEntryOfHomalgMatrix( e, 2, 1, "-1" );
##  gap> ResetFilterObj( e, IsMutableMatrix );
##  gap> Display( e );
##  [ [   1,   1,   0 ],
##    [  -1,   1,   0 ],
##    [   0,   0,   1 ] ]
##  gap> IsIdentityMatrix( e );
##  false
##  gap> e;
##  <A homalg internal 3 by 3 matrix>
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( HomalgInitialIdentityMatrix,
  function( arg )		## a square initial matrix having the flag IsInitialIdentityMatrix
    local R, type, matrix;	## and filled with an identity matrix BUT NOT marked as an IsIdentityMatrix
    
    R := arg[Length( arg )];
    
    if not IsHomalgRing( R ) then
        Error( "the last argument must be an IsHomalgRing\n" );
    fi;
    
    if HasTypeOfHomalgMatrix( R ) then
        type := TypeOfHomalgMatrix( R );
    elif IsHomalgInternalRingRep( R ) then
        type := TheTypeHomalgInternalMatrix;
    else
        Error( "the homalg ring must contain the type of the matrices as the attribute TypeOfHomalgMatrix\n" );
    fi;
    
    matrix := rec( ring := R );
    
    if Length( arg ) > 1 and arg[1] in NonnegativeIntegers then
        ## Objectify:
        ObjectifyWithAttributes(
                matrix, type,
                NrRows, arg[1],
                NrColumns, arg[1],
                IsInitialIdentityMatrix, true );
    else
        ## Objectify:
        ObjectifyWithAttributes(
                matrix, type,
                IsInitialIdentityMatrix, true );
    fi;
    
    SetIsMutableMatrix( matrix, true );
    
    return matrix;
    
end );

##  <#GAPDoc Label="HomalgVoidMatrix">
##  <ManSection>
##    <Func Arg="[ m,][ n,] R" Name="HomalgVoidMatrix" Label="constructor for void matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      A void <M><A>m</A> \times <A>n</A></M> &homalg; matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( HomalgVoidMatrix,
  function( arg )	## a void matrix filled with nothing having the flag IsVoidMatrix
    local R, type, matrix, nr_rows, nr_columns;
    
    R := arg[Length( arg )];
    
    if not IsHomalgRing( R ) then
        Error( "the last argument must be an IsHomalgRing\n" );
    fi;
    
    if HasTypeOfHomalgMatrix( R ) then
        type := TypeOfHomalgMatrix( R );
    elif IsHomalgInternalRingRep( R ) then
        type := TheTypeHomalgInternalMatrix;
    else
        Error( "the homalg ring must contain the type of the matrices as the attribute TypeOfHomalgMatrix\n" );
    fi;
    
    matrix := rec( ring := R );
    
    if Length( arg ) > 1 and arg[1] in NonnegativeIntegers then
        nr_rows := true;
    else
        nr_rows := false;
    fi;
    
    if Length( arg ) > 2 and arg[2] in NonnegativeIntegers then
        nr_columns := true;
    else
        nr_columns := false;
    fi;
    
    if nr_rows and nr_columns then
        ## Objectify:
        ObjectifyWithAttributes(
                matrix, type,
                NrRows, arg[1],
                NrColumns, arg[2],
                IsVoidMatrix, true );
    else
        ## Objectify:
        ObjectifyWithAttributes(
                matrix, type,
                IsVoidMatrix, true );
        
        if nr_rows then
            SetNrRows( matrix, arg[1] );
        fi;
        
        if nr_columns then
            SetNrColumns( matrix, arg[2] );
        fi;
    fi;
    
    return matrix;
    
end );

##  <#GAPDoc Label="HomalgDiagonalMatrix">
##  <ManSection>
##    <Func Arg="diag, R" Name="HomalgDiagonalMatrix" Label="constructor for diagonal matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      An immutable unevaluated diagonal &homalg; matrix over the &homalg; ring <A>R</A>. The diagonal
##      consists of the entries of the list <A>diag</A>.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );
##  <A homalg internal ring>
##  gap> d := HomalgDiagonalMatrix( [ 1, 2, 3 ], ZZ );
##  <An unevaluated diagonal homalg internal 3 by 3 matrix>
##  gap> Display( d );
##  [ [  1,  0,  0 ],
##    [  0,  2,  0 ],
##    [  0,  0,  3 ] ]
##  gap> d;
##  <A diagonal homalg internal 3 by 3 matrix>
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( HomalgDiagonalMatrix,
  function( arg )		## the diagonal matrix
    local nargs, R, diag, d, M;
    
    nargs := Length( arg );
    
    if nargs = 0 then
        Error( "no arguments provided\n" );
    fi;
    
    if IsHomalgRing( arg[nargs] ) then
        R := arg[nargs];
    fi;
    
    if IsRingElement( arg[1] ) then
        diag := [ arg[1] ];
    elif ForAll( arg[1], IsRingElement ) then
        diag := arg[1];
    fi;
    
    if not IsBound( R ) and IsBound( diag ) and diag <> [ ] and IsHomalgRingElement( diag[1] ) then
        R := HomalgRing( diag[1] );
    fi;
    
    if not IsBound( diag ) then
        return CallFuncList( DiagMat, arg );
    elif not IsBound( R ) then
        Error( "no homalg ring provided\n" );
    fi;
    
    if diag = [ ] then
        return HomalgZeroMatrix( 0, 0, R );
    fi;
    
    diag := List( diag, a -> HomalgMatrix( [ a ], 1, 1, R ) );	## a listlist would screw Singular
    
    M := DiagMat( diag );
    
    d := Length( diag );
    
    if nargs > 1 and IsInt( arg[2] ) then
        if arg[2] > d then
            M := UnionOfRows( M, HomalgZeroMatrix( arg[2] - d, d, R ) );
        elif arg[2] < d then
            M := CertainRows( M, [ 1 .. arg[2] ] );
        fi;
    fi;
    
    if nargs > 2 and IsInt( arg[3] ) then
        if arg[3] > d then
            M := UnionOfColumns( M, HomalgZeroMatrix( NrRows( M ), arg[3] - d, R ) );
        elif arg[3] < d then
            M := CertainColumns( M, [ 1 .. arg[3] ] );
        fi;
    fi;
    
    return M;
    
end );

##  <#GAPDoc Label="HomalgScalarMatrix">
##  <ManSection>
##    <Func Arg="r, n, R" Name="HomalgScalarMatrix" Label="constructor for scalar matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      An immutable unevaluated <M><A>n</A> \times <A>n</A></M> scalar &homalg; matrix over the &homalg; ring <A>R</A> with
##      the ring element <A>r</A> as diagonal scalar.
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );
##  <A homalg internal ring>
##  gap> d := HomalgScalarMatrix( 2, 3, ZZ );
##  <An unevaluated scalar homalg internal 3 by 3 matrix>
##  gap> Display( d );
##  [ [  2,  0,  0 ],
##    [  0,  2,  0 ],
##    [  0,  0,  2 ] ]
##  gap> d;
##  <A scalar homalg internal 3 by 3 matrix>
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( HomalgScalarMatrix,
  function( arg )		## the scalar matrix
    local nargs, r, n, R, diag, d, M;
    
    nargs := Length( arg );
    
    if nargs = 0 then
        Error( "no arguments provided\n" );
    fi;
    
    if IsRingElement( arg[1] ) then
        r := arg[1];
    else
        Error( "the first argument must be a ring element\n" );
    fi;
    
    if IsInt( arg[2] ) and arg[2] >= 0 then
        n := arg[2];
    else
        Error( "the second argument must be a non-negative integer\n" );
    fi;
    
    if IsHomalgRing( arg[nargs] ) then
        R := arg[nargs];
    fi;
    
    if not IsBound( R ) then
        if IsHomalgRingElement( r ) then
            R := HomalgRing( r );
        else
            Error( "no homalg ring provided\n" );
        fi;
    fi;
    
    if n = 0 then
        return HomalgZeroMatrix( 0, 0, R );
    fi;
    
    diag := ListWithIdenticalEntries( n, HomalgMatrix( [ r ], 1, 1, R ) ); ## a listlist would screw Singular
    
    M := DiagMat( diag );
    
    SetIsScalarMatrix( M, true );
    
    return M;
    
end );

##  <#GAPDoc Label="\*:MatrixBaseChange">
##  <ManSection>
##    <Oper Arg="R, mat" Name="\*" Label="copy a matrix over a different ring"/>
##    <Oper Arg="mat, R" Name="\*" Label="copy a matrix over a different ring (right)"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      An immutable evaluated &homalg; matrix over the &homalg; ring <A>R</A> having the
##      same entries as the matrix <A>mat</A>. Syntax: <A>R</A> <C>*</C> <A>mat</A> or <A>mat</A> <C>*</C> <A>R</A>
##      <Example><![CDATA[
##  gap> ZZ := HomalgRingOfIntegers( );
##  <A homalg internal ring>
##  gap> Z4 := ZZ / 4;
##  <A homalg residue class ring>
##  gap> Display( Z4 );
##  Z/( 4 )
##  gap> d := HomalgDiagonalMatrix( [ 2 .. 4 ], ZZ );
##  <An unevaluated diagonal homalg internal 3 by 3 matrix>
##  gap> d2 := Z4 * d; ## or d2 := d * Z4;
##  <A homalg residue class 3 by 3 matrix>
##  gap> Display( d2 );
##  [ [  2,  0,  0 ],
##    [  0,  3,  0 ],
##    [  0,  0,  4 ] ]
##  
##  modulo [ 4 ]
##  gap> d;
##  <A diagonal homalg internal 3 by 3 matrix>
##  gap> ZeroRows( d );
##  [  ]
##  gap> ZeroRows( d2 );
##  [ 3 ]
##  gap> d;
##  <A non-zero diagonal homalg internal 3 by 3 matrix>
##  gap> d2;
##  <A non-zero homalg residue class 3 by 3 matrix>
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( \*,
        "for homalg matrices",
        [ IsHomalgRing, IsHomalgMatrix ],
        
  function( R, m )
    local RP, mat;
    
    RP := homalgTable( R );
    
    if IsIdenticalObj( HomalgRing( m ), R ) then	## make a copy over the same ring
        
        mat := ShallowCopy( m );
        
        if not IsIdenticalObj( m, mat ) then
            return mat;
        fi;
        
    fi;
    
    mat := ConvertHomalgMatrix( m, R );
    
    BlindlyCopyMatrixProperties( m, mat );
    
    return mat;
    
end );

##
InstallMethod( \*,
        "for homalg matrices",
        [ IsHomalgRing, IsHomalgMatrix and IsZero ], 10001,
        
  function( R, m )
    
    return HomalgZeroMatrix( NrRows( m ), NrColumns( m ), R );
    
end );

##
InstallMethod( \*,
        "for homalg matrices",
        [ IsHomalgRing, IsHomalgMatrix and IsIdentityMatrix ], 10001,
        
  function( R, m )
    
    return HomalgIdentityMatrix( NrRows( m ), R );
    
end );

##
InstallMethod( \*,
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgRing ],
        
  function( M, R )
    
    return R * M;
    
end );

##
InstallMethod( RingMap,
        "for homalg rings",
        [ IsHomalgMatrix, IsHomalgRing, IsHomalgRing ],
        
  function( images, S, T )
    
    if not ( NrRows( images ) = 1 or NrColumns( images ) = 1 ) then
        Error( "the matrix must either has one row or one column\n" );
    fi;
    
    return RingMap( EntriesOfHomalgMatrix( images ), S, T );
    
end );

##
InstallGlobalFunction( ListToListList,
  function( L, r, c )
    local M, i;
    
    M := [ ];
    
    for i in [ 1 .. r ] do
        Append( M, [ L{[ (i-1)*c+1 .. i*c ]} ] );
    od;
    
    return M;
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for interal matrix hulls",
        [ IsInternalMatrixHull ],
        
  function( o )
    
    Print( "<A hull for an internal matrix>" );
    
end );

##
InstallMethod( ViewObj,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( o )
    local R, first_attribute, not_row_or_column_matrix;
    
    R := HomalgRing( o );
    
    first_attribute := true;
    
    if HasIsVoidMatrix( o ) and IsVoidMatrix( o ) then
        Print( "<A void" );
    elif HasIsInitialMatrix( o ) and IsInitialMatrix( o ) then
        Print( "<An initial" );
    elif HasIsInitialIdentityMatrix( o ) and IsInitialIdentityMatrix( o ) then
        Print( "<An initial identity" );
    elif not HasEval( o ) then
        Print( "<An unevaluated" );
    else
        Print( "<A" );
        first_attribute := false;
    fi;
    
    if not ( HasIsSubidentityMatrix( o ) and IsSubidentityMatrix( o ) )
       and HasIsZero( o ) then ## if this method applies and HasIsZero is set we already know that o is a non-zero homalg matrix
        Print( " non-zero" );
        first_attribute := true;
    fi;
    
    not_row_or_column_matrix := not ( ( HasNrRows( o ) and NrRows( o ) = 1 ) or ( HasNrColumns( o ) and NrColumns( o ) = 1 ) );
    
    if not ( HasNrRows( o ) and NrRows( o ) = 1 and HasNrColumns( o ) and NrColumns( o ) = 1 ) then
        if HasIsDiagonalMatrix( o ) and IsDiagonalMatrix( o ) then
            Print( " diagonal" );
        elif HasIsUpperStairCaseMatrix( o ) and IsUpperStairCaseMatrix( o ) and not_row_or_column_matrix then
            if not first_attribute then
                Print( "n upper staircase" );
            else
                Print( " upper staircase" );
            fi;
        elif HasIsStrictUpperTriangularMatrix( o ) and IsStrictUpperTriangularMatrix( o ) then
            Print( " strict upper triangular" );
        elif HasIsLowerStairCaseMatrix( o ) and IsLowerStairCaseMatrix( o ) and not_row_or_column_matrix then
            Print( " lower staircase" );
        elif HasIsStrictLowerTriangularMatrix( o ) and IsStrictLowerTriangularMatrix( o ) then
            Print( " strict lower triangular" );
        elif HasIsUpperTriangularMatrix( o ) and IsUpperTriangularMatrix( o ) and not ( HasNrRows( o ) and NrRows( o ) = 1 ) then
            if not first_attribute then
                Print( "n upper triangular" );
            else
                Print( " upper triangular" );
            fi;
        elif HasIsLowerTriangularMatrix( o ) and IsLowerTriangularMatrix( o ) and not ( HasNrColumns( o ) and NrColumns( o ) = 1 ) then
            Print( " lower triangular" );
        elif HasIsTriangularMatrix( o ) and IsTriangularMatrix( o ) and not_row_or_column_matrix then
            Print( " triangular" );
        elif not first_attribute then
            first_attribute := fail;
        fi;
        
        if first_attribute <> fail then
            first_attribute := true;
        else
            first_attribute := false;
        fi;
        
        if HasIsInvertibleMatrix( o ) and IsInvertibleMatrix( o ) then
            if not first_attribute then
                Print( "n invertible" );
            else
                Print( " invertible" );
            fi;
        else
            if HasIsRightInvertibleMatrix( o ) and IsRightInvertibleMatrix( o ) then
                Print( " right invertible" );
            elif HasIsLeftRegularMatrix( o ) and IsLeftRegularMatrix( o ) then
                Print( " left regular" );
            fi;
            
            if HasIsLeftInvertibleMatrix( o ) and IsLeftInvertibleMatrix( o ) then
                Print( " left invertible" );
            elif HasIsRightRegularMatrix( o ) and IsRightRegularMatrix( o ) then
                Print( " right regular" );
            fi;
        fi;
    fi;
    
    if HasIsSubidentityMatrix( o ) and IsSubidentityMatrix( o ) then
        Print( " sub-identity" );
    fi;
    
    Print( " homalg " );
    
    if IsBound( R!.description ) then
        Print( R!.description, " " );
    elif IsHomalgInternalMatrixRep( o ) then
        Print( "internal " );
    fi;
    
    if HasNrRows( o ) then
        Print( NrRows( o ), " " );
        if not HasNrColumns( o ) then
            Print( "by (unknown number of columns) " );
        fi;
    fi;
    
    if HasNrColumns( o ) then
        if not HasNrRows( o ) then
            Print( "(unknown number of rows) " );
        fi;
        Print( "by ", NrColumns( o ), " " );
    fi;
    
    Print( "matrix>" );
    
end );

##
InstallMethod( ViewObj,
        "for homalg matrices",
        [ IsHomalgMatrix and IsPermutationMatrix ],
        
  function( o )
    local R;
    
    R := HomalgRing( o );
    
    if HasEval( o ) then
        Print( "<A " );
    else
        Print( "<An unevaluated " );
    fi;
    
    Print( "homalg " );
    
    if IsBound( R!.description ) then
        Print( R!.description, " " );
    elif IsHomalgInternalMatrixRep( o ) then
        Print( "internal " );
    fi;
    
    if HasNrRows( o ) then
        Print( NrRows( o ), " " );
        if not HasNrColumns( o ) then
            Print( "by (unknown number of columns) " );
        fi;
    fi;
    
    if HasNrColumns( o ) then
        if not HasNrRows( o ) then
            Print( "(unknown number of rows) " );
        fi;
        Print( "by ", NrColumns( o ), " " );
    fi;
    
    Print( "permutation matrix>" );
    
end );

##
InstallMethod( ViewObj,
        "for homalg matrices",
        [ IsHomalgMatrix and IsIdentityMatrix ],
        
  function( o )
    local R;
    
    R := HomalgRing( o );
    
    if HasEval( o ) then
        Print( "<A " );
    else
        Print( "<An unevaluated " );
    fi;
    
    Print( "homalg " );
    
    if IsBound( R!.description ) then
        Print( R!.description, " " );
    elif IsHomalgInternalMatrixRep( o ) then
        Print( "internal " );
    fi;
    
    if HasNrRows( o ) then
        Print( NrRows( o ), " " );
        if not HasNrColumns( o ) then
            Print( "by (unknown number of columns) " );
        fi;
    fi;
    
    if HasNrColumns( o ) then
        if not HasNrRows( o ) then
            Print( "(unknown number of rows) " );
        fi;
        Print( "by ", NrColumns( o ), " " );
    fi;
    
    Print( "identity matrix>" );
    
end );

##
InstallMethod( ViewObj,
        "for homalg matrices",
        [ IsHomalgMatrix and IsZero ],
        
  function( o )
    local R;
    
    R := HomalgRing( o );
    
    if HasEval( o ) then
        Print( "<A" );
    else
        Print( "<An unevaluated" );
    fi;
    
    Print( " homalg " );
    
    if IsBound( R!.description ) then
        Print( R!.description, " " );
    elif IsHomalgInternalMatrixRep( o ) then
        Print( "internal " );
    fi;
    
    if HasNrRows( o ) then
        Print( NrRows( o ), " " );
        if not HasNrColumns( o ) then
            Print( "by (unknown number of columns) " );
        fi;
    fi;
    
    if HasNrColumns( o ) then
        if not HasNrRows( o ) then
            Print( "(unknown number of rows) " );
        fi;
        Print( "by ", NrColumns( o ), " " );
    fi;
    
    Print( "zero matrix>" );
    
end );

##
InstallMethod( Display,
        "for internal matrix hulls",
        [ IsInternalMatrixHull ],
        
  function( o )
    
    Display( o!.matrix );
    
end );

##
InstallMethod( Display,
        "for homalg matrices",
        [ IsHomalgInternalMatrixRep ],
        
  function( o )
    
    Display( Eval( o ) );
    
end );

##
InstallMethod( Display,
        "for homalg matrices",
        [ IsHomalgMatrix and IsEmptyMatrix ], 10001,
        
  function( o )
    
    Print( "(an empty ", NrRows( o ), " x ", NrColumns( o ), " matrix)\n" );
    
end );

