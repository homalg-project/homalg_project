# SPDX-License-Identifier: GPL-2.0-or-later
# MatricesForHomalg: Matrices for the homalg project
#
# Implementations
#

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
# compatibility code for the new
# IsMatrixObj interface
#
####################################

InstallMethod( Length,
        [ IsHomalgMatrix ], 0,

  NumberColumns );

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
##  gap> zz := HomalgRingOfIntegers( );
##  Z
##  gap> d := HomalgDiagonalMatrix( [ 2 .. 4 ], zz );
##  <An unevaluated diagonal 3 x 3 matrix over an internal ring>
##  gap> R := HomalgRing( d );
##  Z
##  gap> IsIdenticalObj( R, zz );
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
InstallMethod( BaseDomain,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  HomalgRing );

##
InstallMethod( BlindlyCopyMatrixProperties, ## under construction
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( S, T )
    
    ## if the new ring only interprets the 1x1 submatrices as elements
    ## then it is safe to at least copy the following attributes
    
    if HasNumberRows( S ) then
        SetNumberRows( T, NumberRows( S ) );
    fi;
    
    if HasNumberColumns( S ) then
        SetNumberColumns( T, NumberColumns( S ) );
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
                      Eval, RP!.ShallowCopy( M ),
                      NumberRows, NumberRows( M ),
                      NumberColumns, NumberColumns( M ),
                      ], R );
        
        MatchPropertiesAndAttributes( M, MM,
                LIMAT.intrinsic_properties,
                LIMAT.intrinsic_attributes,
                LIMAT.intrinsic_components,
                LIMAT.intrinsic_attributes_do_not_check_their_equality
                );
        
        return MM;
    fi;
    
    ## we have no other choice
    return M;
    
end );

##
InstallMethod( MutableCopyMat,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, MM;
    
    R := HomalgRing( M );
    RP := homalgTable( R );
    
    if IsBound(RP!.ShallowCopy) then
        
        MM := HomalgMatrixWithAttributes( [
                      Eval, RP!.ShallowCopy( M ),
                      NumberRows, NumberRows( M ),
                      NumberColumns, NumberColumns( M ),
                      ], R );
        
        SetIsMutableMatrix( MM, true );
        
        return MM;
    fi;
    
    ## we have no other choice
    TryNextMethod( );
    
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
                      Eval, RP!.ShallowCopy( M ),
                      NumberRows, NumberRows( M ),
                      NumberColumns, NumberColumns( M ),
                      ], R );
        
        if not IsIdenticalObj( Eval( M ), Eval( MM ) ) then
            
            MatchPropertiesAndAttributes( M, MM,
                    LIMAT.intrinsic_properties,
                    LIMAT.intrinsic_attributes,
                    LIMAT.intrinsic_components,
                    LIMAT.intrinsic_attributes_do_not_check_their_equality
                    );
            
            return MM;
            
        fi;
    fi;
    
    if not IsInternalMatrixHull( Eval( M ) ) then
        TryNextMethod( );
    fi;
    
    return HomalgMatrix( One( R ) * Eval( M )!.matrix, NumberRows( M ), NumberColumns( M ), R );
    
end );

##
InstallMethod( MutableCopyMat,
        "for homalg internal matrices",
        [ IsHomalgInternalMatrixRep ],
        
  function( M )
    local R, RP, MM;
    
    R := HomalgRing( M );
    RP := homalgTable( R );
    
    if IsBound(RP!.ShallowCopy) then
        
        MM := HomalgMatrixWithAttributes( [
                      Eval, RP!.ShallowCopy( M ),
                      NumberRows, NumberRows( M ),
                      NumberColumns, NumberColumns( M ),
                      ], R );
        
        if not IsIdenticalObj( Eval( M ), Eval( MM ) ) then
            
            SetIsMutableMatrix( MM, true );
            
            return MM;
            
        fi;
    fi;
    
    if not IsInternalMatrixHull( Eval( M ) ) then
        TryNextMethod( );
    fi;
    
    MM := HomalgMatrix( One( R ) * Eval( M )!.matrix, NumberRows( M ), NumberColumns( M ), R );
    
    SetIsMutableMatrix( MM, true );
    
    return MM;
    
end );

##
InstallMethod( ShallowCopy,
        "for homalg matrices",
        [ IsHomalgMatrix and IsOne ],
        
  function( M )
    
    return HomalgIdentityMatrix( NumberRows( M ), HomalgRing( M ) );
    
end );

##
InstallMethod( MutableCopyMat,
        "for homalg matrices",
        [ IsHomalgMatrix and IsOne ],
        
  function( M )
    
    ## do not use HomalgIdentityMatrix since
    ## we might want to alter the result
    return HomalgInitialIdentityMatrix( NumberRows( M ), HomalgRing( M ) );
    
end );

##
InstallMethod( ShallowCopy,
        "for homalg matrices",
        [ IsHomalgMatrix and IsZero ],
        
  function( M )
    
    return HomalgZeroMatrix( NumberRows( M ), NumberColumns( M ), HomalgRing( M ) );
    
end );

##
InstallMethod( MutableCopyMat,
        "for homalg matrices",
        [ IsHomalgMatrix and IsZero ],
        
  function( M )
    
    ## do not use HomalgZeroMatrix since
    ## we might want to alter the result
    return HomalgInitialMatrix( NumberRows( M ), NumberColumns( M ), HomalgRing( M ) );
    
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
InstallMethod( SetMatElm,
        "for homalg matrices",
        [ IsHomalgMatrix and IsMutable, IsPosInt, IsPosInt, IsString, IsHomalgRing ],
        
  function( M, r, c, s, R )
    
    SetMatElm( M, r, c, s / R, R );
    
end );

##
InstallMethod( SetMatElm,
        "for homalg internal matrices",
        [ IsHomalgInternalMatrixRep and IsMutable, IsPosInt, IsPosInt, IsString, IsHomalgInternalRingRep ],
        
  function( M, r, c, s, R )
    
    SetMatElm( M, r, c, One( R ) * EvalString( s ), R );
    
end );

##
InstallMethod( SetMatElm,
        "for homalg matrices",
        [ IsHomalgMatrix, IsPosInt, IsPosInt, IsString ],
        
  function( M, r, c, s )
    
    Error( "the homalg matrix is write-protected\n" );
    
end );

##
InstallMethod( SetMatElm,
        "for homalg matrices",
        [ IsHomalgMatrix and IsMutable, IsPosInt, IsPosInt, IsString ],
        
  function( M, r, c, s )
    
    SetMatElm( M, r, c, s, HomalgRing( M ) );
    
end );

##
InstallMethod( SetMatElm,
        "for homalg internal matrices",
        [ IsHomalgInternalMatrixRep and IsMutable, IsPosInt, IsPosInt, IsRingElement, IsHomalgInternalRingRep ],
        
  function( M, r, c, a, R )
    
    if not IsInternalMatrixHull( Eval( M ) ) then
        TryNextMethod( );
    fi;
    
    Eval( M )!.matrix[r][c] := One( R ) * a;
    
end );

##
InstallMethod( SetMatElm,
        "for homalg matrices",
        [ IsHomalgMatrix, IsPosInt, IsPosInt, IsRingElement ],
        
  function( M, r, c, a )
    
    Error( "the homalg matrix is write-protected\n" );
    
end );

##
InstallMethod( SetMatElm,
        "for homalg matrices",
        [ IsHomalgMatrix and IsMutable, IsPosInt, IsPosInt, IsRingElement ],
        
  function( M, r, c, a )
    
    SetMatElm( M, r, c, a, HomalgRing( M ) );
    
end );

##
InstallMethod( AddToMatElm,
        "for homalg matrices",
        [ IsHomalgMatrix, IsPosInt, IsPosInt, IsRingElement ],
        
  function( M, r, c, a )
    
    Error( "the homalg matrix is write-protected\n" );
    
end );

##
InstallMethod( AddToMatElm,
        "for homalg matrices",
        [ IsHomalgMatrix and IsMutable, IsPosInt, IsPosInt, IsRingElement, IsHomalgRing ],
        
  function( M, r, c, a, R )
    
    SetMatElm( M, r, c, a + MatElm( M, r, c, R ), R );
    
end );

##
InstallMethod( AddToMatElm,
        "for homalg matrices",
        [ IsHomalgMatrix and IsMutable, IsPosInt, IsPosInt, IsRingElement ],
        
  function( M, r, c, a )
    
    AddToMatElm( M, r, c, a, HomalgRing( M ) );
    
end );

##
InstallMethod( MatElmAsString,
        "for homalg internal matrices",
        [ IsHomalgInternalMatrixRep, IsPosInt, IsPosInt, IsHomalgInternalRingRep ],
        
  function( M, r, c, R )
    
    return String( M[ r, c ] );
    
end );

##
InstallMethod( MatElmAsString,
        "for homalg matrices",
        [ IsHomalgMatrix, IsPosInt, IsPosInt ],
        
  function( M, r, c )
    
    return MatElmAsString( M, r, c, HomalgRing( M ) );
    
end );

##
InstallMethod( MatElm,
        "for homalg internal matrices",
        [ IsHomalgInternalMatrixRep, IsPosInt, IsPosInt, IsHomalgInternalRingRep ],
        
  function( M, r, c, R )
    
    if IsInternalMatrixHull( Eval( M ) ) then
        return Eval( M )!.matrix[r][c];
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( MatElm,
        "for homalg matrices",
        [ IsHomalgMatrix, IsPosInt, IsPosInt ],
        
  function( M, r, c )
    
    return MatElm( M, r, c, HomalgRing( M ) );
    
end );

if not CompareVersionNumbers( GAPInfo.Version, "4.10" ) then

## copied from gap-4.10.2/lib/matobj.gi

# Install fallback methods for m[i,j] which delegate MatElm resp. SetMatElm,
# for old MatrixObj implementation which don't provide them. We lower the rank
# so that these are only used as a last resort.
InstallMethod( \[\], "for a matrix object and two positions",
  [ IsMatrixObj, IsPosInt, IsPosInt ],
  -RankFilter(IsMatrixObj),
  function( m, row, col )
    return MatElm( m, row, col );
end );


InstallMethod( \[\]\:\=, "for a matrix object, two positions, and an object",
  [ IsMatrixObj and IsMutable, IsPosInt, IsPosInt, IsObject ],
  -RankFilter(IsMatrixObj),
  function( m, row, col, obj )
    SetMatElm( m, row, col, obj );
end );

fi;

##
InstallMethod( GetListOfMatrixAsString,
        "for matrices",
        [ IsList ],
        
  function( M )
    
    M := List( M, row -> List( row, String ) );
    
    M := List( M, JoinStringsWithSeparator );
    
    M := JoinStringsWithSeparator( M );
    
    return Concatenation( "[", M, "]" );
    
end );

##
InstallMethod( GetListListOfStringsOfMatrix,
        "for matrices and a homalg internal ring",
        [ IsList, IsHomalgInternalRingRep ],
        
  function( M, R )
    local c, d, z;
    
    if not ForAll( M, IsList ) then
        TryNextMethod( );
    fi;
    
    if not HasCharacteristic( R ) then
        Error( "characteristic not set\n" );
    fi;
    
    c := Characteristic( R );
    
    if c = 0 then
        return List( M, a -> List( a, String ) );
    elif IsPrime( c ) then
        if HasDegreeOverPrimeField( R ) and DegreeOverPrimeField( R ) > 1 then
            d := DegreeOverPrimeField( R );
            z := R!.NameOfPrimitiveElement;
            return List( M, a -> List( a, b -> FFEToString( b, c, d, z ) ) );
        fi;
        
        return List( M, a -> List( a, b -> String( IntFFE( b ) ) ) );
    fi;
    
    return List( M, a -> List( a, b -> String( b![1] ) ) );
    
end );

##
InstallMethod( GetListListOfStringsOfHomalgMatrix,
        "for homalg internal matrices",
        [ IsHomalgInternalMatrixRep, IsHomalgInternalRingRep ],
        
  function( M, R )
    
    if not IsInternalMatrixHull( Eval( M ) ) then
        TryNextMethod( );
    fi;
    
    return GetListListOfStringsOfMatrix( Eval( M )!.matrix, R );
    
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
    
    c := NumberColumns( M );
    
    s := List( [ 1 .. NumberRows( M ) ], i -> List( [ 1 .. c ], j -> MatElmAsString( M, i, j ) ) );
    
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
    
    c := NumberColumns( M );
    
    s := List( [ 1 .. NumberRows( M ) ], i -> List( [ 1 .. c ], j -> MatElmAsString( M, i, j ) ) );
    
    s := JoinStringsWithSeparator( List( s, JoinStringsWithSeparator ), "],[" );
    
    return Concatenation( "[[", s, "]]" );
    
end );

##
InstallMethod( GetListListOfHomalgMatrixAsString,
        "for homalg internal matrices",
        [ IsHomalgInternalMatrixRep, IsHomalgInternalRingRep ],
        
  function( M, R )
    local s;
    
    s := GetListListOfStringsOfHomalgMatrix( M, R );
    
    s := List( List( s, JoinStringsWithSeparator ), r -> Concatenation( "[", r, "]" ) );
    
    s := JoinStringsWithSeparator( s );
    
    return Concatenation( "[", s, "]" );
    
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
    
    c := NumberColumns( M );
    
    s := [ ];
    
    for i in [ 1 .. NumberRows( M ) ] do
        for j in [ 1 .. c ] do
            e := M[ i, j ];
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
    local s, m, r, c, z;
    
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
    
    r := NumberRows( M );
    c := NumberColumns( M );
    z := Zero( R );
    
    s := List( [ 1 .. r ], a -> Filtered( List( [ 1 .. c ], function( b ) if s[a][b] <> z then return [ a, b, s[a][b] ]; else return 0; fi; end ), x -> x <> 0 ) );
    
    s := Concatenation( s );
    
    s := String( s );
    
    RemoveCharacters( s, "\\\n " );
    
    return s;
    
end );

##
InstallMethod( EntriesOfHomalgMatrixAsListList,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local cols;
    
    cols := [ 1 .. NumberColumns( M ) ];
    
    return List( [ 1 .. NumberRows( M ) ], r -> List( cols, c -> M[ r, c ] ) );
    
end );

##
InstallMethod( EntriesOfHomalgMatrixAsListList,
        "for homalg matrices",
        [ IsHomalgMatrix and IsHomalgInternalMatrixRep ],
        
  function( M )
    local mat;
    
    if IsEmptyMatrix( M ) then
        TryNextMethod( );
    fi;
    
    mat := Eval( M );
    
    if not IshomalgInternalMatrixHullRep( mat ) then
        TryNextMethod( );
    fi;
    
    mat := mat!.matrix;
    
    if not IsList( mat ) then
        TryNextMethod( );
    fi;
    
    return mat;
    
end );

##
InstallMethod( EntriesOfHomalgMatrix,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    
    return Flat( EntriesOfHomalgMatrixAsListList( M ) );
    
end );

##
InstallMethod( EntriesOfHomalgRowVector,
        "for a homalg row vector",
        [ IsHomalgMatrix ],
        
  function( M )
    
    Assert( 0, NumberRows( M ) = 1 );
    
    return EntriesOfHomalgMatrix( M );
    
end );

##
InstallMethod( EntriesOfHomalgColumnVector,
        "for a homalg column vector",
        [ IsHomalgMatrix ],
        
  function( M )
    
    Assert( 0, NumberColumns( M ) = 1 );
    
    return EntriesOfHomalgMatrix( M );
    
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
    
    return GetCleanRowsPositions( M, [ 1 .. NumberColumns( M ) ] );
    
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
    
    if HasNumberRows( M1 ) or HasNumberRows( M2 ) then ## trigger as few as possible operations
        return IsIdenticalObj( HomalgRing( M1 ), HomalgRing( M2 ) )
               and NumberRows( M1 ) = NumberRows( M2 ) and NumberColumns( M1 ) = NumberColumns( M2 );
    else ## no other choice
        return IsIdenticalObj( HomalgRing( M1 ), HomalgRing( M2 ) )
               and NumberColumns( M1 ) = NumberColumns( M2 ) and NumberRows( M1 ) = NumberRows( M2 );
    fi;
    
end );

##
InstallMethod( \=,
        "for internal matrix hulls",
        [ IsInternalMatrixHull, IsInternalMatrixHull ],
        
  function( M1, M2 )
    
    if M1!.matrix = M2!.matrix then
        return true;
    fi;
    
    return false;
    
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
##  gap> zz := HomalgRingOfIntegers( );
##  Z
##  gap> A := HomalgMatrix( "[ 1 ]", zz );
##  <A 1 x 1 matrix over an internal ring>
##  gap> B := HomalgMatrix( "[ 3 ]", zz );
##  <A 1 x 1 matrix over an internal ring>
##  gap> Z2 := zz / 2;
##  Z/( 2 )
##  gap> A := Z2 * A;
##  <A 1 x 1 matrix over a residue class ring>
##  gap> B := Z2 * B;
##  <A 1 x 1 matrix over a residue class ring>
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
    local RP;
    
    RP := homalgTable( HomalgRing( M1 ) );
    
    if IsBound( RP!.AreEqualMatrices ) then
        
        if RP!.AreEqualMatrices( M1, M2 ) then
            
            ## do not touch mutable matrices
            if not ( IsMutable( M1 ) or IsMutable( M2 ) ) then
                MatchPropertiesAndAttributes( M1, M2,
                        LIMAT.intrinsic_properties,
                        LIMAT.intrinsic_attributes,
                        LIMAT.intrinsic_components,
                        LIMAT.intrinsic_attributes_do_not_check_their_equality
                        );
            fi;
            
            return true;
            
        fi;
        
    elif Eval( M1 ) = Eval( M2 ) then
    
        ## do not touch mutable matrices
        if not ( IsMutable( M1 ) or IsMutable( M2 ) ) then
            MatchPropertiesAndAttributes( M1, M2,
                    LIMAT.intrinsic_properties,
                    LIMAT.intrinsic_attributes,
                    LIMAT.intrinsic_components,
                    LIMAT.intrinsic_attributes_do_not_check_their_equality
                    );
        fi;
        
        return true;
    fi;
    
    return false;
    
end );

##
InstallMethod( ZeroMutable,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    
    return HomalgZeroMatrix( NumberRows( M ), NumberColumns( M ), HomalgRing( M ) );
    
end );

##  <#GAPDoc Label="Involution">
##  <ManSection>
##    <Meth Arg="M" Name="Involution" Label="for matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      The twisted transpose of the &homalg; matrix <A>M</A>. If the underlying ring is commutative, the twist is the identity.<P/>
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
                 NumberRows, NumberColumns( M ),
                 NumberColumns, NumberRows( M ),
                 ], HomalgRing( M ) );
    
    SetItsInvolution( M, C );
    SetItsInvolution( C, M );
    
    return C;
    
end );

##
InstallMethod( Involution,
        "for homalg matrices",
        [ IsHomalgMatrix and HasItsInvolution ],
        
  function( M )
    
    return ItsInvolution( M );
    
end );

##  <#GAPDoc Label="TransposedMatrix">
##  <ManSection>
##    <Meth Arg="M" Name="TransposedMatrix" Label="for matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      The transpose of the &homalg; matrix <A>M</A>.<P/>
##      (for the installed standard method see <Ref Meth="Eval" Label="for matrices created with TransposedMatrix"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( TransposedMatrix,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local C;
    
    C := HomalgMatrixWithAttributes( [
                 EvalTransposedMatrix, M,
                 NumberRows, NumberColumns( M ),
                 NumberColumns, NumberRows( M ),
                 ], HomalgRing( M ) );
    
    SetItsTransposedMatrix( M, C );
    SetItsTransposedMatrix( C, M );
    
    return C;
    
end );

##
InstallMethod( TransposedMatrix,
        "for homalg matrices",
        [ IsHomalgMatrix and HasItsTransposedMatrix ],
        
  function( M )
    
    return ItsTransposedMatrix( M );
    
end );

##  <#GAPDoc Label="CertainRows">
##  <ManSection>
##    <Meth Arg="M, plist" Name="CertainRows" Label="for matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      The matrix of which the <M>i</M>-th row is the <M>k</M>-th row of the &homalg; matrix <A>M</A>,
##      where <M>k=</M><A>plist</A><M>[i]</M>.<P/>
##      (for the installed standard method see <Ref Meth="Eval" Label="for matrices created with CertainRows"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( CertainRows,
        "for homalg matrices",
        [ IsHomalgMatrix, IsList ],
        
  function( M, plist )
    
    plist := ShallowCopy( plist );
    ConvertToRangeRep( plist );
    
    return HomalgMatrixWithAttributes( [
                   EvalCertainRows, [ M, plist ],
                   NumberRows, Length( plist ),
                   NumberColumns, NumberColumns( M )
                   ], HomalgRing( M ) );
    
end );

##
InstallOtherMethod( \[\],
        "for a homalg matrix and a positive integer",
        [ IsHomalgMatrix, IsInt ],
        
  function( M, r )
    
    return CertainRows( M, [ r ] );
    
end );

##
InstallOtherMethod( \{\},
        "for a homalg matrix and a positive integer",
        [ IsHomalgMatrix, IsList ],
        
  CertainRows );

##  <#GAPDoc Label="CertainColumns">
##  <ManSection>
##    <Meth Arg="M, plist" Name="CertainColumns" Label="for matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      The matrix of which the <M>j</M>-th column is the <M>l</M>-th column of the &homalg; matrix <A>M</A>,
##      where <M>l=</M><A>plist</A><M>[j]</M>.<P/>
##      (for the installed standard method see <Ref Meth="Eval" Label="for matrices created with CertainColumns"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( CertainColumns,
        "for homalg matrices",
        [ IsHomalgMatrix, IsList ],
        
  function( M, plist )
    
    plist := ShallowCopy( plist );
    ConvertToRangeRep( plist );
    
    return HomalgMatrixWithAttributes( [
                   EvalCertainColumns, [ M, plist ],
                   NumberColumns, Length( plist ),
                   NumberRows, NumberRows( M )
                   ], HomalgRing( M ) );
    
end );

##  <#GAPDoc Label="UnionOfRows">
##  <ManSection>
##    <Func Arg="[R, nr_cols, ]L" Name="UnionOfRows" Label="for a homalg ring, an integer and a list of homalg matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      Stack the &homalg; matrices in the list <A>L</A>. The entries of <A>L</A> must be matrices over the &homalg; ring <A>R</A> with <A>nr_cols</A> columns.
##      If <A>L</A> is non-empty, <A>R</A> and <A>nr_cols</A> can be omitted.<P/>
##      
##      (for the installed standard method see <Ref Meth="Eval" Label="for matrices created with UnionOfRows"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( UnionOfRows,
function( arg )
    local R, nr_cols, list;
    
    if IsEmpty( arg ) then
        Error( "<arg> must be nonempty" );
    elif IsHomalgMatrix( arg[1] ) then
        # UnionOfRows( mat1, mat2, ... )
        list := arg;
        R := HomalgRing( list[1] );
        nr_cols := NumberColumns( list[1] );
    elif Length( arg ) = 1 and IsList( arg[1] )  then
        # UnionOfRows( [ mat1, mat2, ... ] )
        if IsEmpty( arg[1] )  then
            Error( "<arg>[1] must be nonempty" );
        fi;
        list := arg[1];
        R := HomalgRing( list[1] );
        nr_cols := NumberColumns( list[1] );
    elif Length( arg ) = 3 and IsHomalgRing( arg[1] ) and IsInt( arg[2] ) and IsList( arg[3] ) then
        # UnionOfRows( ring, nr_cols, [ mat1, mat2, ... ] )
        R := arg[1];
        nr_cols := arg[2];
        list := arg[3];
    else
        Error("usage: UnionOfRows( mat1, mat2, ... ) or UnionOfRows( [ mat1, mat2, ... ] ) or UnionOfRows( ring, nr_cols, [ mat1, mat2, ... ] )");
    fi;
    
    return UnionOfRowsOp( R, nr_cols, list );
    
end );

##
InstallMethod( UnionOfRowsOp,
        "of a homalg ring, an integer and a list of homalg matrices",
        [ IsHomalgRing, IsInt, IsList ],

  function( R, nr_cols, L )
    local result;
    
    result := HomalgMatrixWithAttributes( [
         EvalUnionOfRows, L,
         NumberRows, Sum( List( L, NumberRows ) ),
         NumberColumns, nr_cols
         ], R );
    
    if IsBound( HOMALG_MATRICES.UnionOfRowsEager ) and HOMALG_MATRICES.UnionOfRowsEager = true then
        Eval( result );
    fi;
    
    return result;
    
end );

##
InstallGlobalFunction( UnionOfRowsEager,
  function( arg )
    local nargs;
    
    nargs := Length( arg );
    
    if nargs = 0  then
        Error( "<arg> must be nonempty" );
    elif Length( arg ) = 1 and IsList( arg[1] )  then
        if IsEmpty( arg[1] )  then
            Error( "<arg>[1] must be nonempty" );
        fi;
        arg := arg[1];
    fi;
    
    return UnionOfRowsEagerOp( arg, arg[1] );
    
end );

##
InstallMethod( UnionOfRowsEagerOp,
        "of a list of homalg matrices and a homalg matrix",
        [ IsList, IsHomalgMatrix ],

  function( L, M )
    local result;
    
    result := HomalgMatrixWithAttributes( [
         EvalUnionOfRows, L,
         NumberRows, Sum( List( L, NumberRows ) ),
         NumberColumns, NumberColumns( L[1] )
         ], HomalgRing( L[1] ) );
    
    Eval( result );
    
    return result;
    
end );

##  <#GAPDoc Label="UnionOfColumns">
##  <ManSection>
##    <Func Arg="[R, nr_rows, ]L" Name="UnionOfColumns" Label="for a homalg ring, an integer and a list of homalg matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      Augment the &homalg; matrices in the list <A>L</A>. The entries of <A>L</A> must be matrices over the &homalg; ring <A>R</A> with <A>nr_rows</A> rows.
##      If <A>L</A> is non-empty, <A>R</A> and <A>nr_rows</A> can be omitted.<P/>
##      
##      (for the installed standard method see <Ref Meth="Eval" Label="for matrices created with UnionOfColumns"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( UnionOfColumns,
function( arg )
    local R, nr_rows, list;
    
    if IsEmpty( arg ) then
        Error( "<arg> must be nonempty" );
    elif IsHomalgMatrix( arg[1] ) then
        # UnionOfColumns( mat1, mat2, ... )
        list := arg;
        R := HomalgRing( list[1] );
        nr_rows := NumberRows( list[1] );
    elif Length( arg ) = 1 and IsList( arg[1] )  then
        # UnionOfColumns( [ mat1, mat2, ... ] )
        if IsEmpty( arg[1] )  then
            Error( "<arg>[1] must be nonempty" );
        fi;
        list := arg[1];
        R := HomalgRing( list[1] );
        nr_rows := NumberRows( list[1] );
    elif Length( arg ) = 3 and IsHomalgRing( arg[1] ) and IsInt( arg[2] ) and IsList( arg[3] ) then
        # UnionOfColumns( ring, nr_rows, [ mat1, mat2, ... ] )
        R := arg[1];
        nr_rows := arg[2];
        list := arg[3];
    else
        Error("usage: UnionOfColumns( mat1, mat2, ... ) or UnionOfColumns( [ mat1, mat2, ... ] ) or UnionOfColumns( ring, nr_rows, [ mat1, mat2, ... ] )");
    fi;
    
    return UnionOfColumnsOp( R, nr_rows, list );
    
end );

##
InstallMethod( UnionOfColumnsOp,
        "of a list of homalg matrices and a homalg matrix",
        [ IsHomalgRing, IsInt, IsList ],

  function( R, nr_rows, L )
    local result;
    
    result := HomalgMatrixWithAttributes( [
         EvalUnionOfColumns, L,
         NumberRows, nr_rows,
         NumberColumns, Sum( List( L, NumberColumns ) )
         ], R );
    
    if IsBound( HOMALG_MATRICES.UnionOfColumnsEager ) and HOMALG_MATRICES.UnionOfColumnsEager = true then
        Eval( result );
    fi;
    
    return result;
    
end );

##
InstallGlobalFunction( UnionOfColumnsEager,
  function( arg )
    local nargs;
    
    nargs := Length( arg );
    
    if nargs = 0  then
        Error( "<arg> must be nonempty" );
    elif Length( arg ) = 1 and IsList( arg[1] )  then
        if IsEmpty( arg[1] )  then
            Error( "<arg>[1] must be nonempty" );
        fi;
        arg := arg[1];
    fi;
    
    return UnionOfColumnsEagerOp( arg, arg[1] );
    
end );

##
InstallMethod( UnionOfColumnsEagerOp,
        "of a list of homalg matrices and a homalg matrix",
        [ IsList, IsHomalgMatrix ],

  function( L, M )
    local result;
    
    result := HomalgMatrixWithAttributes( [
         EvalUnionOfColumns, L,
         NumberRows, NumberRows( L[1] ),
         NumberColumns, Sum( List( L, NumberColumns ) )
         ], HomalgRing( L[1] ) );
    
    Eval( result );
    
    return result;
    
end );

##  <#GAPDoc Label="ConvertRowToMatrix">
##  <ManSection>
##    <Meth Arg="M, r, c" Name="ConvertRowToMatrix" Label="for matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      Fold the row <A>M</A> to an <A>r</A>x<A>c</A>-matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( ConvertRowToMatrix,
        "for a homalg matrix and two integers",
        [ IsHomalgMatrix, IsInt, IsInt ],
        
  function( M, r, c )
    local R, C;
    
    if NumberRows( M ) <> 1 then
        Error( "expecting a single row matrix as a first argument\n" );
    fi;
    
    if NumberColumns( M ) <> r * c then
        Error( "the row has not the expected length\n" );
    fi;
    
    R := HomalgRing( M );
    
    if r = 1 then
        return M;
    elif r * c = 0 or ( HasIsZero( M ) and IsZero( M ) ) then
        return HomalgZeroMatrix( r, c, R );
    fi;
    
    C := HomalgMatrixWithAttributes( [
                 EvalConvertRowToMatrix, [ M, r, c ],
                 NumberRows, r,
                 NumberColumns, c,
                 ], R );
    
    return C;
    
end );

##  <#GAPDoc Label="ConvertColumnToMatrix">
##  <ManSection>
##    <Meth Arg="M, r, c" Name="ConvertColumnToMatrix" Label="for matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      Fold the column <A>M</A> to an <A>r</A>x<A>c</A>-matrix.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( ConvertColumnToMatrix,
        "for a homalg matrix and two integers",
        [ IsHomalgMatrix, IsInt, IsInt ],
        
  function( M, r, c )
    local R, C;
    
    if NumberColumns( M ) <> 1 then
        Error( "expecting a single column matrix as a first argument\n" );
    fi;
    
    if NumberRows( M ) <> r * c then
        Error( "the column has not the expected height\n" );
    fi;
    
    R := HomalgRing( M );
    
    if c = 1 then
        return M;
    elif r * c = 0 or ( HasIsZero( M ) and IsZero( M ) ) then
        return HomalgZeroMatrix( r, c, R );
    fi;
    
    C := HomalgMatrixWithAttributes( [
                 EvalConvertColumnToMatrix, [ M, r, c ],
                 NumberRows, r,
                 NumberColumns, c,
                 ], R );
    
    return C;
    
end );

##  <#GAPDoc Label="ConvertMatrixToRow">
##  <ManSection>
##    <Meth Arg="M" Name="ConvertMatrixToRow" Label="for matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      Unfold the matrix <A>M</A> row-wise into a row.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( ConvertMatrixToRow,
        "for a homalg matrix",
        [ IsHomalgMatrix ],
        
  function( M )
    local r, c, R, C;
    
    r := NumberRows( M );
    
    if r = 1 then
        return M;
    fi;
    
    c := NumberColumns( M );
    
    R := HomalgRing( M );
    
    if r = 0 or ( HasIsZero( M ) and IsZero( M ) ) then
        return HomalgZeroMatrix( 1, r * c, R );
    fi;
    
    C := HomalgMatrixWithAttributes( [
                 EvalConvertMatrixToRow, M,
                 NumberRows, 1,
                 NumberColumns, r * c,
                 ], R );
    
    return C;
    
end );

##  <#GAPDoc Label="ConvertMatrixToColumn">
##  <ManSection>
##    <Meth Arg="M" Name="ConvertMatrixToColumn" Label="for matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      Unfold the matrix <A>M</A> column-wise into a column.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( ConvertMatrixToColumn,
        "for a homalg matrix",
        [ IsHomalgMatrix ],
        
  function( M )
    local c, r, R, C;
    
    c := NumberColumns( M );
    
    if c = 1 then
        return M;
    fi;
    
    r := NumberRows( M );
    
    R := HomalgRing( M );
    
    if c = 0 or ( HasIsZero( M ) and IsZero( M ) ) then
        return HomalgZeroMatrix( r * c, 1, R );
    fi;
    
    C := HomalgMatrixWithAttributes( [
                 EvalConvertMatrixToColumn, M,
                 NumberRows, r * c,
                 NumberColumns, 1,
                 ], R );
    
    return C;
    
end );

##  <#GAPDoc Label="DiagMat">
##  <ManSection>
##    <Meth Arg="[R, ]list" Name="DiagMat" Label="for a homalg ring and a list of homalg matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      Build the block diagonal matrix out of the &homalg; matrices listed in <A>list</A>.
##      If <A>list</A> is non-empty, <A>R</A> can be omitted.<P/>
##      
##      (for the installed standard method see <Ref Meth="Eval" Label="for matrices created with DiagMat"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( DiagMat,
        "of a homalg ring and a list of homalg matrices",
        [ IsHomalgRing, IsHomogeneousList ],
        
  function( R, list )
    
    return HomalgMatrixWithAttributes( [
                   EvalDiagMat, list,
                   NumberRows, Sum( List( list, NumberRows ) ),
                   NumberColumns, Sum( List( list, NumberColumns ) )
                   ], R );
    
end );

##
# convenience
InstallOtherMethod( DiagMat,
        "of a list of homalg matrices",
        [ IsHomogeneousList ],
        
  function( list )
    
    if IsEmpty( list ) then
        Error( "the given list of diagonal blocks is empty\n" );
    fi;
    
    return DiagMat( HomalgRing( list[1] ), list );
    
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
                   NumberRows, NumberRows( A ) * NumberRows( B ),
                   NumberColumns, NumberColumns( A ) * NumberColumns ( B )
                   ], HomalgRing( A ) );
    
end );

##  <#GAPDoc Label="DualKroneckerMat">
##  <ManSection>
##    <Meth Arg="A, B" Name="DualKroneckerMat" Label="for matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      The dual Kronecker product of the two &homalg; matrices <A>A</A> and <A>B</A>.<P/>
##      (for the installed standard method see <Ref Meth="Eval" Label="for matrices created with DualKroneckerMat"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( DualKroneckerMat,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( A, B )
    
    return HomalgMatrixWithAttributes( [
                   EvalDualKroneckerMat, [ A, B ],
                   NumberRows, NumberRows( A ) * NumberRows( B ),
                   NumberColumns, NumberColumns( A ) * NumberColumns ( B )
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
        "for a homalg matrix and a homalg ring element",
        [ IsHomalgMatrix, IsRingElement ], 1001, ## it could otherwise run into the method ``PROD: negative integer * additive element with inverse'', value: 24 (if this value is increased, the corresonding values for \* in LIMAT, COLEM, and below must be increased as well!!!)
        
  function( A, a )
    
    return HomalgMatrixWithAttributes( [
                   EvalMulMatRight, [ A, a ],
                   NumberRows, NumberRows( A ),
                   NumberColumns, NumberColumns( A )
                   ], HomalgRing( A ) );
    
end );

##
InstallMethod( \*,
        "for a homalg ring element and a homalg matrix",
        [ IsRingElement, IsHomalgMatrix ], 1001, ## it could otherwise run into the method ``PROD: negative integer * additive element with inverse'', value: 24 (if this value is increased, the corresonding values for \* in LIMAT, COLEM, and below must be increased as well!!!)
        
  function( a, A )
    
    return HomalgMatrixWithAttributes( [
                   EvalMulMat, [ a, A ],
                   NumberRows, NumberRows( A ),
                   NumberColumns, NumberColumns( A )
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
                   NumberRows, NumberRows( A ),
                   NumberColumns, NumberColumns( A )
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
                   NumberRows, NumberRows( A ),
                   NumberColumns, NumberColumns( A )
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
        [ IsHomalgMatrix, IsHomalgMatrix ], 14001, ## it could otherwise run into the method ``PROD: IsRingElement * IsHomalgMatrix'', value: 1001 (if this value is increased, the corresonding values in LIMAT must be increased as well!!!)
        
  function( A, B )
    
    return HomalgMatrixWithAttributes( [
                   EvalCompose, [ A, B ],
                   NumberRows, NumberRows( A ),
                   NumberColumns, NumberColumns( B )
                   ], HomalgRing( A ) );
    
end );

##
InstallMethod( \^,
        "for homalg maps",
        [ IsHomalgMatrix, IsInt ],
        
  function( A, pow )
    local R;
    
    if NumberRows( A ) <> NumberColumns( A ) then
        Error( "the matrix is not quadratic\n" );
    fi;
    
    R := HomalgRing( A );
    
    if pow < 0 then
        
        Error( "not implemented yet\n" );
        
    elif pow = 0 then
        
        return HomalgIdentityMatrix( NumberRows( A ), R );
        
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
    
    return Filtered( [ 1 .. NumberRows( C ) ], x -> not x in zero_rows );
    
end );

##
InstallMethod( NonZeroColumns,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( C )
    local zero_columns;
    
    zero_columns := ZeroColumns( C );
    
    return Filtered( [ 1 .. NumberColumns( C ) ], x -> not x in zero_columns );
    
end );

##
InstallMethod( AdjunctMatrix,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( C )
    local R, m, A;
    
    R := HomalgRing( C );
    
    if not HasIsCommutative( R ) then
        Error( "the ring is not known to be commutative\n" );
    elif not IsCommutative( R ) then
        Error( "the ring is not commutative\n" );
    fi;
    
    m := NumberRows( C );
    
    if not m = NumberColumns( C ) then
        Error( "the input ", m, "x", NumberColumns( C ), "-matrix is not quadratic\n" );
    fi;
    
    m := [ 1 .. m ];
    
    A := List( m, c -> List( m, r -> (-1)^(r+c) * Determinant( CertainRows( CertainColumns( C, Difference( m, [ c ] ) ),  Difference( m, [ r ] ) ) ) ) );
    
    return HomalgMatrix( A, R );
    
end );

##  <#GAPDoc Label="LeftInverseLazy">
##  <ManSection>
##    <Oper Arg="M" Name="LeftInverseLazy" Label="for matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      A lazy evaluated left inverse <M>C</M> of the matrix <A>M</A>. If no left inverse exists then
##      <C>Eval</C>( <A>C</A> ) will issue an error.<P/>
##      (for the installed standard method see <Ref Meth="Eval" Label="for matrices created with LeftInverseLazy"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( LeftInverseLazy,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local C;
    
    ## we assume the LeftInverse exists
    C := HomalgMatrixWithAttributes( [
                 EvalLeftInverse, M,
                 NumberRows, NumberColumns( M ),
                 NumberColumns, NumberRows( M )
                 ], HomalgRing( M ) );
    
    ## check assertion
    Assert( 6, not IsBool( Eval( C ) ) );
    
    ## SetLeftInverse( M, C ) will cause a infinite loop
    
    return C;
    
end );

##  <#GAPDoc Label="RightInverseLazy">
##  <ManSection>
##    <Oper Arg="M" Name="RightInverseLazy" Label="for matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      A lazy evaluated right inverse <M>C</M> of the matrix <A>M</A>. If no right inverse exists then
##      <C>Eval</C>( <A>C</A> ) will issue an error.<P/>
##      (for the installed standard method see <Ref Meth="Eval" Label="for matrices created with RightInverseLazy"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( RightInverseLazy,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local C;
    
    ## we assume the RightInverse exists
    C := HomalgMatrixWithAttributes( [
                 EvalRightInverse, M,
                 NumberColumns, NumberRows( M ),
                 NumberRows, NumberColumns( M )
                 ], HomalgRing( M ) );
    
    ## check assertion
    Assert( 6, not IsBool( Eval( C ) ) );
    
    ## SetRightInverse( M, C )  will cause a infinite loop
    
    return C;
    
end );

##
InstallMethod( DiagonalEntries,
        "of homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local m;
    
    m := Minimum( NumberRows( M ), NumberColumns( M ) );
    
    return List( [ 1 .. m ], a -> M[ a, a ] );
    
end );

##
InstallMethod( Minors,
        "of homalg matrices",
        [ IsInt, IsHomalgMatrix ],
        
  function( d, M )
    local R, r, c, l;
    
    R := HomalgRing( M );
    
    if not HasIsCommutative( R ) then
        Error( "the ring is not known to be commutative\n" );
    elif not IsCommutative( R ) then
        Error( "the ring is not commutative\n" );
    fi;
    
    if d <= 0 then
        return [ One( R ) ];
    fi;
    
    r := NumberRows( M );
    c := NumberColumns( M );
    
    if d > Minimum( r, c ) then
        return [ Zero( R ) ];
    fi;
    
    l := Cartesian( Combinations( [ 1 .. r ], d ), Combinations( [ 1 .. c ], d ) );
    
    l := List( l, rc -> Determinant( CertainColumns( CertainRows( M, rc[1] ), rc[2] ) ) );
    
    if l = [ ] then
        return [ Zero( R ) ];
    fi;
    
    return l;
    
end );

##
InstallMethod( MaximalMinors,
        "of homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    
    return Minors( Minimum( NumberRows( M ), NumberColumns( M ) ), M );
    
end );

##
InstallMethod( PostMakeImmutable,
        "for homalg internal matrices",
        [ IsHomalgInternalMatrixRep and HasEval ],
        
  function( A )
    
    MakeImmutable( Eval( A )!.matrix );
    
end );

##
InstallMethod( SetIsMutableMatrix,
        "for homalg matrices and a Boolean",
        [ IsHomalgMatrix, IsBool ],
        
  function( M, b )
    
    if b = true then;
        SetFilterObj( M, IsMutable );
    else
        ResetFilterObj( M, IsMutable );
    fi;
    
end );

##
InstallMethod( SetIsMutableMatrix,
        "for homalg matrices and a Boolean",
        [ IsHomalgMatrix and IsEmptyMatrix, IsBool ], 1001,
        
  function( M, b )
    
    ## do nothing
    
end );

##
InstallMethod( Iterator,
        "of homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, c, d, rank, iter, save, F, r;
    
    R := HomalgRing( M );
    
    if not IsFieldForHomalg( R ) or
       ( not HasCharacteristic( R ) or Characteristic( R ) = 0 ) or
       ( not HasDegreeOverPrimeField( R ) or not IsInt( DegreeOverPrimeField( R ) ) ) then
        TryNextMethod( );
    fi;
    
    c := Characteristic( R );
    d := DegreeOverPrimeField( R );
    
    M := BasisOfRows( M );
    
    if not IsLeftRegular( M ) then
        TryNextMethod( );
    fi;
    
    rank := RowRankOfMatrix( M );
    
    iter := Iterator( GF(c^d)^rank );
    
    if IsHomalgInternalRingRep( R ) then
        F := R;
    else
        F := HomalgRingOfIntegers( c, d );
    fi;
    
    r := rec(
             ring := R,
             iter := iter,
             matrix := M,
             rank := rank,
             GF := F,
             
             NextIterator :=
             function( i )
               local mat;
               mat := HomalgMatrix( NextIterator( i!.iter ), 1, i!.rank, i!.GF );
               SetNumberRows( mat, 1 );          ## should be obsolete
               SetNumberColumns( mat, i!.rank ); ## should be obsolete
               return ( i!.ring * mat ) * i!.matrix;
             end,
             
             IsDoneIterator :=
             function( i )
               return IsDoneIterator( i!.iter );
             end,
             
             ShallowCopy :=
             function( i );
                 return
                   rec(
                       ring := i!.ring,
                       iter := ShallowCopy( i!.iter ),
                       matrix := i!.matrix,
                       rank := i!.rank,
                       GF := i!.GF,
                       NextIterator := i!.NextIterator,
                       IsDoneIterator := i!.IsDoneIterator,
                       ShallowCopy := i!.ShallowCopy
                       );
             end
             );
    
    return IteratorByFunctions( r );
    
end );

##
InstallMethod( Select,
        "for a matrix and a list",
        [ IsHomalgMatrix, IsList ],
        
  function( M, L )
    local R, indets, zero, map, N;
    
    R := HomalgRing( M );
    
    if HasRelativeIndeterminatesOfPolynomialRing( R ) then
        indets := RelativeIndeterminatesOfPolynomialRing( R );
    elif HasIndeterminatesOfPolynomialRing( R ) then
        indets := IndeterminatesOfPolynomialRing( R );
    else
        TryNextMethod( );
    fi;
    
    if not IsSubset( indets, L ) then
        Error( "the second argument is not a subset of the list of indeterminates\n" );
    fi;
    
    zero := Zero( R );
    
    map := List( indets, function( a ) if a in L then return a; else return zero; fi; end );
    
    map := RingMap( map, R, R );
    
    N := Pullback( map, M );
    
    return CertainRows( M, ZeroRows( M - N ) );
    
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
    
    r := NumberRows( M );
    c := NumberColumns( M );
    
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
    
    r := NumberRows( M );
    c := NumberColumns( M );
    
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
    elif IsList( s ) then
        return HomalgMatrix( ListToListList( s, r, c ), r, c, R );
    else
        Error( "the evaluated string is not in {IsMatrix, IsList}\n" );
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
    
    Perform( s, function( a ) SetMatElm( M, Int( a[1] ), Int( a[2] ), a[3], R ); end );
    
    ResetFilterObj( M, IsMutable );
    
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
    
    if IsList( L[1] ) then
        M := List( L, r -> List( r, String ) );
        M := Concatenation( "[[", JoinStringsWithSeparator( List( M, r -> JoinStringsWithSeparator( r ) ), "],[" ), "]]" );
    else
        ## this resembles NormalizeInput in Maple's homalg ( a legacy ;) )
        M := Concatenation( "[[", JoinStringsWithSeparator( List( L, String ), "],[" ), "]]" );
        ## What is the use case for this? Wouldn't it be better to replace this by an error message?
        # Error( "the number of rows and columns must be specified to construct a matrix from a list" );
    fi;
    
    return CreateHomalgMatrixFromString( M, R );
    
end );

##
InstallMethod( CreateHomalgMatrixFromList,
        "constructor for homalg matrices",
        [ IsList, IsInt, IsInt, IsHomalgRing ],
        
  function( L, r, c, R )
    local M;
    
    if IsList( L[1] ) then
        M := List( Concatenation( L ), String );
        M := Concatenation( "[", JoinStringsWithSeparator( M ), "]" );
    else
        M := Concatenation( "[", JoinStringsWithSeparator( List( L, String ) ), "]" );
    fi;
    
    return CreateHomalgMatrixFromString( M, r, c, R );
    
end );

##  <#GAPDoc Label="HomalgMatrix">
##  <ManSection>
##    <Func Arg="llist, R" Name="HomalgMatrix" Label="constructor for matrices using a listlist"/>
##    <Func Arg="llist, m, n, R" Name="HomalgMatrix" Label="constructor for matrices using a listlist with given dimensions"/>
##    <Func Arg="list, m, n, R" Name="HomalgMatrix" Label="constructor for matrices using a list"/>
##    <Func Arg="str_llist, R" Name="HomalgMatrix" Label="constructor for matrices using a string of a listlist"/>
##    <Func Arg="str_list, m, n, R" Name="HomalgMatrix" Label="constructor for matrices using a string of a list"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      An immutable evaluated <M><A>m</A> \times <A>n</A></M> &homalg; matrix over the &homalg; ring <A>R</A>.
##      <Example><![CDATA[
##  gap> zz := HomalgRingOfIntegers( );
##  Z
##  gap> m := HomalgMatrix( [ [ 1, 2, 3 ], [ 4, 5, 6 ] ], zz );
##  <A 2 x 3 matrix over an internal ring>
##  gap> Display( m );
##  [ [  1,  2,  3 ],
##    [  4,  5,  6 ] ]
##  ]]></Example>
##      <Example><![CDATA[
##  gap> m := HomalgMatrix( [ [ 1, 2, 3 ], [ 4, 5, 6 ] ], 2, 3, zz );
##  <A 2 x 3 matrix over an internal ring>
##  gap> Display( m );
##  [ [  1,  2,  3 ],
##    [  4,  5,  6 ] ]
##  ]]></Example>
##      <Example><![CDATA[
##  gap> m := HomalgMatrix( [ 1, 2, 3,   4, 5, 6 ], 2, 3, zz );
##  <A 2 x 3 matrix over an internal ring>
##  gap> Display( m );
##  [ [  1,  2,  3 ],
##    [  4,  5,  6 ] ]
##  ]]></Example>
##      <Example><![CDATA[
##  gap> m := HomalgMatrix( "[ [ 1, 2, 3 ], [ 4, 5, 6 ] ]", zz );
##  <A 2 x 3 matrix over an internal ring>
##  gap> Display( m );
##  [ [  1,  2,  3 ],
##    [  4,  5,  6 ] ]
##  ]]></Example>
##      <Example><![CDATA[
##  gap> m := HomalgMatrix( "[ [ 1, 2, 3 ], [ 4, 5, 6 ] ]", 2, 3, zz );
##  <A 2 x 3 matrix over an internal ring>
##  gap> Display( m );
##  [ [  1,  2,  3 ],
##    [  4,  5,  6 ] ]
##  ]]></Example>
##      It is nevertheless recommended to use the following form to create &homalg; matrices. This
##      form can also be used to define external matrices. Since whitespaces
##      (&see; <Ref Label="Whitespaces" BookName="Ref"/>) are ignored,
##      they can be used as optical delimiters:
##      <Example><![CDATA[
##  gap> m := HomalgMatrix( "[ 1, 2, 3,   4, 5, 6 ]", 2, 3, zz );
##  <A 2 x 3 matrix over an internal ring>
##  gap> Display( m );
##  [ [  1,  2,  3 ],
##    [  4,  5,  6 ] ]
##  ]]></Example>
##      One can split the input string over several lines using the backslash character '\' to end each line
##      <Example><![CDATA[
##  gap> m := HomalgMatrix( "[ \
##  > 1, 2, 3, \
##  > 4, 5, 6  \
##  > ]", 2, 3, zz );
##  <A 2 x 3 matrix over an internal ring>
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
            
        elif not IsHomalgInternalRingRep( R ) and ## the ring R is not internal,
          ( IsList( M )  or                       ## while M is either a list of ring elements,
            IsMatrix( M ) ) then                  ## or a matrix of (hopefully) ring elements
            
            return CallFuncList( CreateHomalgMatrixFromList, arg );
            
        fi;
    fi;
    
    if not IsHomalgRing( R ) then
        Error( "the last argument must be an IsHomalgRing\n" );
    fi;
    
    ## here we take care of the degenerate input M = [ ] for all rings
    if M = [ ] then ## CreateHomalgMatrixFromString also covers M = "", "[]", etc.
        if nargs = 2 then
            return HomalgZeroMatrix( 0, 0, R );
        else
            return CallFuncList( HomalgZeroMatrix, arg{[ 2 .. nargs ]} );
        fi;
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
        if IsBound( R!.pre_matrix_constructor ) then
            M := R!.pre_matrix_constructor( M ); ## [ 0, x ]
        fi;
        if Length( arg ) > 2 and arg[2] in NonnegativeIntegers then
            M := ListToListList( M, arg[2], Length( M ) / arg[2] );
        else
            M := List( M, a -> [ a ] ); ## this resembles NormalizeInput in Maple's homalg ( a legacy ;) )
        fi;
        
        if IsBound(RP!.ImportMatrix) then
            M := RP!.ImportMatrix( M, R );
        fi;
    elif IsInternalMatrixHull( M ) then ## why are we doing this? for ShallowCopy?
        if IsMatrix( M!.matrix ) then
            M := M!.matrix;
        else
            M := homalgInternalMatrixHull( M!.matrix );
        fi;
    elif IsMatrix( M ) and IsBound(RP!.ImportMatrix) then
        M := RP!.ImportMatrix( M, R );
    elif IsList( M ) and Length( M ) > 0 and IsBound( R!.pre_matrix_constructor ) then
        M := R!.pre_matrix_constructor( M ); ## [ 0, x ]
    else
        M := ShallowCopy( M ); ## by this we are sure that possible changes to a mutable GAP matrix arg[1] does not destroy the logic of homalg
    fi;
    
    if IsHomalgInternalRingRep( R ) and
       not IsInternalMatrixHull( M ) then ## TheTypeHomalgInternalMatrix
        
        if IsMatrix( M ) then
            ## Objectify:
            ObjectifyWithAttributes(
                    matrix, type,
                    NumberRows, Length( M ),
                    NumberColumns, Length( M[1] ),
                    Eval, homalgInternalMatrixHull( M ) );
        elif IsList( M ) then
            ## Objectify:
            ObjectifyWithAttributes(
                    matrix, type,
                    Eval, homalgInternalMatrixHull( M ) );
            if M = [ ] then
                SetNumberRows( matrix, 0 );
                SetNumberColumns( matrix, 0 );
            elif M[1] = [] then
                SetNumberRows( matrix, Length( M ) );
                SetNumberColumns( matrix, 0 );
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
                        NumberRows, arg[2],
                        NumberColumns, arg[3],
                        Eval, M );
            else
                ## Objectify:
                ObjectifyWithAttributes(
                        matrix, type,
                        Eval, M );
                
                if nr_rows then
                    SetNumberRows( matrix, arg[2] );
                fi;
                
                if nr_columns then
                    SetNumberColumns( matrix, arg[3] );
                fi;
            fi;
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
                    NumberRows, arg[2],
                    NumberColumns, arg[3],
                    Eval, M );
        else
            ## Objectify:
            ObjectifyWithAttributes(
                    matrix, type,
                    Eval, M );
            
            if nr_rows then
                SetNumberRows( matrix, arg[2] );
            fi;
            
            if nr_columns then
                SetNumberColumns( matrix, arg[3] );
            fi;
        fi;
        
    fi;
    
    return matrix;
    
end );

##  <#GAPDoc Label="HomalgMatrixListList">
##  <ManSection>
##    <Func Arg="llist, m, n, R" Name="HomalgMatrixListList" Label="constructor for matrices using a listlist with given dimensions"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      Special case of <Ref Meth="HomalgMatrix" Label="constructor for matrices using a listlist with given dimensions"/>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( HomalgMatrixListList,
  function( llist, m, n, R )
    
    if m > 0 and n > 0 then
        
        Assert( 1, IsList( llist ) and Length( llist ) = m );
        Assert( 1, ForAll( llist, list -> IsList( list ) and Length( list ) = n ) );
        
    fi;
    
    return HomalgMatrix( llist, m, n, R );
    
end );

##  <#GAPDoc Label="HomalgRowVector">
##  <ManSection>
##    <Func Arg="entries, nr_cols, R" Name="HomalgRowVector" Label="constructor for matrices with a single row"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      Special case of <Ref Meth="HomalgMatrix" Label="constructor for matrices using a list"/> for matrices with a single row.
##      <A>entries</A> must be a list of ring elements.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( HomalgRowVector,
  function( entries, c, R )
    
    return HomalgMatrixListList( [ entries ], 1, c, R );
    
end );

##  <#GAPDoc Label="HomalgColumnVector">
##  <ManSection>
##    <Func Arg="entries, nr_rows, R" Name="HomalgColumnVector" Label="constructor for matrices with a single column"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      Special case of <Ref Meth="HomalgMatrix" Label="constructor for matrices using a list"/> for matrices with a single column.
##      <A>entries</A> must be a list of ring elements.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( HomalgColumnVector,
  function( entries, r, R )
    
    return HomalgMatrixListList( List( entries, x -> [ x ] ), r, 1, R );
    
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
    
    if HOMALG_MATRICES.Eager = true and not IsEmptyMatrix( matrix ) then
        Eval( matrix );
    fi;
    
    return matrix;
    
end );

##  <#GAPDoc Label="HomalgZeroMatrix">
##  <ManSection>
##    <Func Arg="m, n, R" Name="HomalgZeroMatrix" Label="constructor for zero matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      An immutable unevaluated <M><A>m</A> \times <A>n</A></M> &homalg; zero matrix over the &homalg; ring <A>R</A>.
##      <Example><![CDATA[
##  gap> zz := HomalgRingOfIntegers( );
##  Z
##  gap> z := HomalgZeroMatrix( 2, 3, zz );
##  <An unevaluated 2 x 3 zero matrix over an internal ring>
##  gap> Display( z );
##  [ [  0,  0,  0 ],
##    [  0,  0,  0 ] ]
##  gap> z;
##  <A 2 x 3 zero matrix over an internal ring>
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( HomalgZeroMatrix,
  function( arg ) ## the zero matrix
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
        
        ## cache the 1 x 1 zero matrix
        if nr_rows = 1 and nr_columns = 1 then
            if IsBound( R!.OneByOneZeroMatrix ) then
                return R!.OneByOneZeroMatrix;
            else
                R!.OneByOneZeroMatrix := matrix;
            fi;
        fi;
        
        ## Objectify:
        ObjectifyWithAttributes(
                matrix, type,
                NumberRows, arg[1],
                NumberColumns, arg[2],
                IsZero, true );
    else
        ## Objectify:
        ObjectifyWithAttributes(
                matrix, type,
                IsZero, true );
        
        if nr_rows then
            SetNumberRows( matrix, arg[1] );
        fi;
        
        if nr_columns then
            SetNumberColumns( matrix, arg[2] );
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
##  gap> zz := HomalgRingOfIntegers( );
##  Z
##  gap> id := HomalgIdentityMatrix( 3, zz );
##  <An unevaluated 3 x 3 identity matrix over an internal ring>
##  gap> Display( id );
##  [ [  1,  0,  0 ],
##    [  0,  1,  0 ],
##    [  0,  0,  1 ] ]
##  gap> id;
##  <A 3 x 3 identity matrix over an internal ring>
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( HomalgIdentityMatrix,
  function( arg ) ## the identity matrix
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
                NumberRows, arg[1],
                NumberColumns, arg[1],
                IsOne, true );
    else
        ## Objectify:
        ObjectifyWithAttributes(
                matrix, type,
                IsOne, true );
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
##      by assigning its nonzero entries.
##      The property <Ref Prop="IsInitialMatrix"/> is reset as soon as the matrix is evaluated.
##      New computed properties or attributes of the matrix won't be cached,
##      until the matrix is explicitly made immutable using (&see; <Ref Func="MakeImmutable"
##      BookName="Reference" Style="Number"/>).
##      <Example><![CDATA[
##  gap> zz := HomalgRingOfIntegers( );
##  Z
##  gap> z := HomalgInitialMatrix( 2, 3, zz );
##  <An initial 2 x 3 matrix over an internal ring>
##  gap> HasIsZero( z );
##  false
##  gap> IsZero( z );
##  true
##  gap> z;
##  <A 2 x 3 mutable matrix over an internal ring>
##  gap> HasIsZero( z );
##  false
##  ]]></Example>
##      <Example><![CDATA[
##  gap> n := HomalgInitialMatrix( 2, 3, zz );
##  <An initial 2 x 3 matrix over an internal ring>
##  gap> n[ 1, 1 ] := "1";;
##  gap> n[ 2, 3 ] := "1";;
##  gap> MakeImmutable( n );
##  <A 2 x 3 matrix over an internal ring>
##  gap> Display( n );
##  [ [  1,  0,  0 ],
##    [  0,  0,  1 ] ]
##  gap> IsZero( n );
##  false
##  gap> n;
##  <A non-zero 2 x 3 matrix over an internal ring>
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( HomalgInitialMatrix,
  function( arg )                               ## an initial matrix having the flag IsInitialMatrix
    local R, type, matrix, nr_rows, nr_columns; ## and filled with zeros BUT NOT marked as an IsZero
    
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
                NumberRows, arg[1],
                NumberColumns, arg[2],
                IsInitialMatrix, true );
    else
        ## Objectify:
        ObjectifyWithAttributes(
                matrix, type,
                IsInitialMatrix, true );
        
        if nr_rows then
            SetNumberRows( matrix, arg[1] );
        fi;
        
        if nr_columns then
            SetNumberColumns( matrix, arg[2] );
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
##      an elementary matrix by assigning its off-diagonal nonzero entries.
##      The property <Ref Prop="IsInitialIdentityMatrix"/> is reset as soon as the matrix is evaluated.
##      New computed properties or attributes of the matrix won't be cached,
##      until the matrix is explicitly made immutable using (&see; <Ref Func="MakeImmutable"
##      BookName="Reference" Style="Number"/>).
##      <Example><![CDATA[
##  gap> zz := HomalgRingOfIntegers( );
##  Z
##  gap> id := HomalgInitialIdentityMatrix( 3, zz );
##  <An initial identity 3 x 3 matrix over an internal ring>
##  gap> HasIsOne( id );
##  false
##  gap> IsOne( id );
##  true
##  gap> id;
##  <A 3 x 3 mutable matrix over an internal ring>
##  gap> HasIsOne( id );
##  false
##  ]]></Example>
##      <Example><![CDATA[
##  gap> e := HomalgInitialIdentityMatrix( 3, zz );
##  <An initial identity 3 x 3 matrix over an internal ring>
##  gap> e[ 1, 2 ] := "1";;
##  gap> e[ 2, 1 ] := "-1";;
##  gap> MakeImmutable( e );
##  <A 3 x 3 matrix over an internal ring>
##  gap> Display( e );
##  [ [   1,   1,   0 ],
##    [  -1,   1,   0 ],
##    [   0,   0,   1 ] ]
##  gap> IsOne( e );
##  false
##  gap> e;
##  <A 3 x 3 matrix over an internal ring>
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( HomalgInitialIdentityMatrix,
  function( arg )          ## a square initial matrix having the flag IsInitialIdentityMatrix
    local R, type, matrix; ## and filled with an identity matrix BUT NOT marked as an IsOne
    
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
                NumberRows, arg[1],
                NumberColumns, arg[1],
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
  function( arg ) ## a void matrix filled with nothing having the flag IsVoidMatrix
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
                NumberRows, arg[1],
                NumberColumns, arg[2],
                IsVoidMatrix, true );
    else
        ## Objectify:
        ObjectifyWithAttributes(
                matrix, type,
                IsVoidMatrix, true );
        
        if nr_rows then
            SetNumberRows( matrix, arg[1] );
        fi;
        
        if nr_columns then
            SetNumberColumns( matrix, arg[2] );
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
##  gap> zz := HomalgRingOfIntegers( );
##  Z
##  gap> d := HomalgDiagonalMatrix( [ 1, 2, 3 ], zz );
##  <An unevaluated diagonal 3 x 3 matrix over an internal ring>
##  gap> Display( d );
##  [ [  1,  0,  0 ],
##    [  0,  2,  0 ],
##    [  0,  0,  3 ] ]
##  gap> d;
##  <A diagonal 3 x 3 matrix over an internal ring>
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( HomalgDiagonalMatrix,
  function( arg ) ## the diagonal matrix
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
    
    diag := List( diag, a -> HomalgMatrix( [ a ], 1, 1, R ) ); ## a listlist would screw Singular
    
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
            M := UnionOfColumns( M, HomalgZeroMatrix( NumberRows( M ), arg[3] - d, R ) );
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
##  gap> zz := HomalgRingOfIntegers( );
##  Z
##  gap> d := HomalgScalarMatrix( 2, 3, zz );
##  <An unevaluated scalar 3 x 3 matrix over an internal ring>
##  gap> Display( d );
##  [ [  2,  0,  0 ],
##    [  0,  2,  0 ],
##    [  0,  0,  2 ] ]
##  gap> d;
##  <A scalar 3 x 3 matrix over an internal ring>
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallGlobalFunction( HomalgScalarMatrix,
  function( arg ) ## the scalar matrix
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

##
InstallGlobalFunction( StringToHomalgColumnMatrix,
  function( str, R )
    
    if str in [ "", " ", "[]", "[ ]" ] then
        return HomalgZeroMatrix( 0, 1, R );
    fi;
    
    return HomalgMatrix( str, Length( SplitString( str, "," ) ), 1, R );
    
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
##  gap> zz := HomalgRingOfIntegers( );
##  Z
##  gap> Z4 := zz / 4;
##  Z/( 4 )
##  gap> Display( Z4 );
##  <A residue class ring>
##  gap> d := HomalgDiagonalMatrix( [ 2 .. 4 ], zz );
##  <An unevaluated diagonal 3 x 3 matrix over an internal ring>
##  gap> d2 := Z4 * d; ## or d2 := d * Z4;
##  <A 3 x 3 matrix over a residue class ring>
##  gap> Display( d2 );
##  [ [  2,  0,  0 ],
##    [  0,  3,  0 ],
##    [  0,  0,  4 ] ]
##  
##  modulo [ 4 ]
##  gap> d;
##  <A diagonal 3 x 3 matrix over an internal ring>
##  gap> ZeroRows( d );
##  [  ]
##  gap> ZeroRows( d2 );
##  [ 3 ]
##  gap> d;
##  <A non-zero diagonal 3 x 3 matrix over an internal ring>
##  gap> d2;
##  <A non-zero 3 x 3 matrix over a residue class ring>
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
    
    if IsIdenticalObj( HomalgRing( m ), R ) then ## make a copy over the same ring
        
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
    
    return HomalgZeroMatrix( NumberRows( m ), NumberColumns( m ), R );
    
end );

##
InstallMethod( \*,
        "for homalg matrices",
        [ IsHomalgRing, IsHomalgMatrix and IsOne ], 10001,
        
  function( R, m )
    
    return HomalgIdentityMatrix( NumberRows( m ), R );
    
end );

##
InstallMethod( \*,
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgRing ],
        
  function( M, R )
    
    return R * M;
    
end );

##
# convenience
InstallMethod( CoercedMatrix,
        "for a homalg ring and a homalg matrix",
        [ IsHomalgRing, IsHomalgMatrix ],

  function( new_ring, M )
    
    return CoercedMatrix( HomalgRing( M ), new_ring, M );
    
end );

##  <#GAPDoc Label="CoercedMatrix">
##  <ManSection>
##    <Oper Arg="ring_from, ring_to, mat" Name="CoercedMatrix" Label="copy a matrix over a different ring"/>
##    <Oper Arg="ring_to, mat" Name="CoercedMatrix" Label="copy a matrix over a different ring (convenience)"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      A copy of the &homalg; matrix <A>mat</A> with &homalg; ring <A>ring_from</A> in the &homalg; ring <A>ring_to</A>.<P/>
##      (for the installed standard method see <Ref Meth="Eval" Label="for matrices created with CoercedMatrix"/>)
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( CoercedMatrix,
        "for two homalg rings and a homalg matrix",
        [ IsHomalgRing, IsHomalgRing, IsHomalgMatrix ],

  function( old_ring, new_ring, M )
    local C;
    
    if not IsIdenticalObj( old_ring, HomalgRing( M ) ) then
        
        Error( "the matrix <M> must be a matrix over the ring <old_ring>" );
        
    fi;
    
    C := HomalgMatrixWithAttributes( [
                 EvalCoercedMatrix, M
                 ], new_ring );
    
    BlindlyCopyMatrixProperties( M, C );
    
    return C;
    
end );

##
InstallGlobalFunction( ListToListList,
  function( L, r, c )
    
    return List( [ 1 .. r ], i -> L{[ (i-1)*c+1 .. i*c ]} );
    
end );

##  <#GAPDoc Label="CoefficientsWithGivenMonomials">
##  <ManSection>
##    <Meth Arg="M, monomials" Name="CoefficientsWithGivenMonomials" Label="for two homalg matrices"/>
##    <Returns>a &homalg; matrix</Returns>
##    <Description>
##      Let <C>R := HomalgRing(</C><A>M</A><C>)</C>. <C>monomials</C> must be a &homalg; matrix with the same number
##      of columns as <C>M</C> consisting of monomials of <C>R</C>.
##      This method computes a &homalg; matrix <C>coeffs</C> (with entries in the coefficients ring of <C>R</C>,
##      yet still considered as elements of <C>R</C>) such that <C>M = coeffs * monomials</C>.
##      If no such matrix exists, the behavior is undefined.
##      If the first argument is a &homalg; ring element, it is viewed as a &homalg; matrix with a single entry.
##      If the second argument is a list of monomials, it is viewed as a column matrix with the list elements as entries.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
InstallMethod( CoefficientsWithGivenMonomials,
        "for two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( M, monomials )
    local R;
    
    if NumberColumns( monomials ) <> NumberColumns( M ) then
        
        Error( "the given matrices must have the same number of columns" );
        
    fi;
    
    R := HomalgRing( M );
    
    return HomalgMatrixWithAttributes( [
                EvalCoefficientsWithGivenMonomials, [ M, monomials ],
                NumberRows, NumberRows( M ),
                NumberColumns, NumberRows( monomials )
                ], R );
    
end );

##
InstallMethod( CoefficientsWithGivenMonomials,
        "for a homalg column matrix and a list of monomials",
        [ IsHomalgMatrix, IsList ],
        
  function( M, monomials )
    
    return CoefficientsWithGivenMonomials( M, HomalgMatrix( monomials, Length( monomials ), 1, HomalgRing( M ) ) );
    
end );

##
InstallMethod( CoefficientsWithGivenMonomials,
        "for a homalg ring element and a homalg column matrix",
        [ IsHomalgRingElement, IsHomalgMatrix ],
        
  function( poly, monomials )
    
    return CoefficientsWithGivenMonomials( HomalgMatrix( [ poly ], 1, 1, HomalgRing( poly ) ), monomials );
    
end );

##
InstallMethod( CoefficientsWithGivenMonomials,
        "for a homalg ring element and a list of monomials",
        [ IsHomalgRingElement, IsList ],
        
  function( poly, monomials )
    
    return CoefficientsWithGivenMonomials( HomalgMatrix( [ poly ], 1, 1, HomalgRing( poly ) ), monomials );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for weak pointer containers of identity matrices",
        [ IsContainerForWeakPointersOnIdentityMatricesRep ],
        
  function( o )
    
    Print( "<A container for weak pointers on identity matrices: counter = ", o!.counter, ", cache_hits = ", o!.cache_hits, ">" );
    
end );

##
InstallMethod( ViewString,
        "for interal matrix hulls",
        [ IsInternalMatrixHull ],
        
  function( o )
    
    return "<A hull for a homalg internal matrix>";
    
end );

##
InstallMethod( ViewString,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( o )
    local R, first_attribute, str, not_row_or_column_matrix;
    
    R := HomalgRing( o );
    
    first_attribute := true;
    
    str :="";
    
    if IsVoidMatrix( o ) then
        Append( str, "<A void" );
    elif IsInitialMatrix( o ) then
        Append( str, "<An initial" );
    elif IsInitialIdentityMatrix( o ) then
        Append( str, "<An initial identity" );
    elif not HasEval( o ) then
        Append( str, "<An unevaluated" );
    else
        Append( str, "<A" );
        first_attribute := false;
    fi;
    
    if not ( HasIsSubidentityMatrix( o ) and IsSubidentityMatrix( o ) )
       and HasIsZero( o ) then ## if this method applies and HasIsZero is set we already know that o is a non-zero homalg matrix
        Append( str, " non-zero" );
        first_attribute := true;
    fi;
    
    not_row_or_column_matrix := not ( ( HasNumberRows( o ) and NumberRows( o ) = 1 ) or ( HasNumberColumns( o ) and NumberColumns( o ) = 1 ) );
    
    if not ( HasNumberRows( o ) and NumberRows( o ) = 1 and HasNumberColumns( o ) and NumberColumns( o ) = 1 ) then
        if HasIsDiagonalMatrix( o ) and IsDiagonalMatrix( o ) then
            Append( str, " diagonal" );
        elif HasIsUpperStairCaseMatrix( o ) and IsUpperStairCaseMatrix( o ) and not_row_or_column_matrix then
            if not first_attribute then
                Append( str, "n upper staircase" );
            else
                Append( str, " upper staircase" );
            fi;
        elif HasIsStrictUpperTriangularMatrix( o ) and IsStrictUpperTriangularMatrix( o ) then
            Append( str, " strict upper triangular" );
        elif HasIsLowerStairCaseMatrix( o ) and IsLowerStairCaseMatrix( o ) and not_row_or_column_matrix then
            Append( str, " lower staircase" );
        elif HasIsStrictLowerTriangularMatrix( o ) and IsStrictLowerTriangularMatrix( o ) then
            Append( str, " strict lower triangular" );
        elif HasIsUpperTriangularMatrix( o ) and IsUpperTriangularMatrix( o ) and not ( HasNumberRows( o ) and NumberRows( o ) = 1 ) then
            if not first_attribute then
                Append( str, "n upper triangular" );
            else
                Append( str, " upper triangular" );
            fi;
        elif HasIsLowerTriangularMatrix( o ) and IsLowerTriangularMatrix( o ) and not ( HasNumberColumns( o ) and NumberColumns( o ) = 1 ) then
            Append( str, " lower triangular" );
        elif HasIsTriangularMatrix( o ) and IsTriangularMatrix( o ) and not_row_or_column_matrix then
            Append( str, " triangular" );
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
                Append( str, "n invertible" );
            else
                Append( str, " invertible" );
            fi;
        else
            if HasIsRightInvertibleMatrix( o ) and IsRightInvertibleMatrix( o ) then
                Append( str, " right invertible" );
            elif HasIsLeftRegular( o ) and IsLeftRegular( o ) then
                Append( str, " left regular" );
            fi;
            
            if HasIsLeftInvertibleMatrix( o ) and IsLeftInvertibleMatrix( o ) then
                Append( str, " left invertible" );
            elif HasIsRightRegular( o ) and IsRightRegular( o ) then
                Append( str, " right regular" );
            fi;
        fi;
    fi;
    
    if HasIsSubidentityMatrix( o ) and IsSubidentityMatrix( o ) then
        Append( str, " sub-identity" );
    fi;
    
    if HasNumberRows( o ) then
        Append( str, Concatenation( " ", String( NumberRows( o ) ), " " ) );
        if not HasNumberColumns( o ) then
            Append( str, "x ?" );
        fi;
    fi;
    
    if HasNumberColumns( o ) then
        if not HasNumberRows( o ) then
            Append( str, " ? " );
        fi;
        Append( str, Concatenation( "x ", String( NumberColumns( o ) ) ) );
    fi;
    
    if IsMutable( o ) and HasEval( o ) then
        Append( str, " mutable" );
    fi;
    
    Append( str, " matrix over a" );
    
    if IsBound( R!.description ) then
        Append( str, R!.description );
    elif IsHomalgInternalMatrixRep( o ) then
        Append( str, "n internal" );
    fi;
    
    Append( str, " ring>" );
    
    return str;
    
end );

##
InstallMethod( ViewString,
        "for homalg matrices",
        [ IsHomalgMatrix and IsPermutationMatrix ],
        
  function( o )
    local str, R;
    
    str := "";
    
    if HasEval( o ) then
        Append( str, "<A " );
    else
        Append( str, "<An unevaluated " );
    fi;
    
    if HasNumberRows( o ) then
        Append( str, Concatenation( String( NumberRows( o ) ), " " ) );
        if not HasNumberColumns( o ) then
            Append( str, "x ?" );
        fi;
    fi;
    
    if HasNumberColumns( o ) then
        if not HasNumberRows( o ) then
            Append( str, "? " );
        fi;
        Append( str, Concatenation( "x ", String( NumberColumns( o ) ) ) );
    fi;
    
    Append( str, " permutation matrix over a" );
    
    R := HomalgRing( o );
    
    if IsBound( R!.description ) then
        Append( str, R!.description );
    elif IsHomalgInternalMatrixRep( o ) then
        Append( str, "n internal" );
    fi;
    
    Append( str, " ring>" );
    
    return str;
    
end );

##
InstallMethod( ViewString,
        "for homalg matrices",
        [ IsHomalgMatrix and IsOne ],
        
  function( o )
    local str, R;
    
    str := "";
    
    if HasEval( o ) then
        Append( str, "<A " );
    else
        Append( str, "<An unevaluated " );
    fi;
    
    if HasNumberRows( o ) then
        Append( str, Concatenation( String( NumberRows( o ) ), " " ) );
        if not HasNumberColumns( o ) then
            Append( str, "x ?" );
        fi;
    fi;
    
    if HasNumberColumns( o ) then
        if not HasNumberRows( o ) then
            Append( str, "? " );
        fi;
        Append( str, Concatenation( "x ", String( NumberColumns( o ) ) ) );
    fi;
    
    Append( str, " identity matrix over a" );
    
    R := HomalgRing( o );
    
    if IsBound( R!.description ) then
        Append( str, R!.description );
    elif IsHomalgInternalMatrixRep( o ) then
        Append( str, "n internal" );
    fi;
    
    Append( str, " ring>" );
    
    return str;
    
end );

##
InstallMethod( ViewString,
        "for homalg matrices",
        [ IsHomalgMatrix and IsZero ],
        
  function( o )
    local str, R;
    
    str := "";
    
    if HasEval( o ) then
        Append( str, "<A " );
    else
        Append( str, "<An unevaluated " );
    fi;
    
    if HasNumberRows( o ) then
        Append( str, Concatenation( String( NumberRows( o ) ), " " ) );
        if not HasNumberColumns( o ) then
            Append( str, "x ?" );
        fi;
    fi;
    
    if HasNumberColumns( o ) then
        if not HasNumberRows( o ) then
            Append( str, "? " );
        fi;
        Append( str, Concatenation( "x ", String( NumberColumns( o ) ) ) );
    fi;
    
    Append( str, " zero matrix over a" );
    
    R := HomalgRing( o );
    
    if IsBound( R!.description ) then
        Append( str, R!.description );
    elif IsHomalgInternalMatrixRep( o ) then
        Append( str, "n internal" );
    fi;
    
    Append( str, " ring>" );
    
    return str;
    
end );

##
InstallMethod( String,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  ViewString );

##
InstallMethod( LaTeXOutput,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( m )
    local r, c, l, i, j, e;
    
    r := NumberRows( m );
    c := NumberColumns( m );
    
    if IsEmptyMatrix( m ) then
        return Concatenation( "()_{", String( r ), " \\times ", String( c ), "}" );
    fi;
    
    m := EntriesOfHomalgMatrixAsListList( m );
    
    l := "\\left( \\begin{array}";
    
    Append( l, Concatenation( "{", ListWithIdenticalEntries( c, 'r' ), "}\n" ) );
    
    for i in [ 1 .. r ] do
        for j in [ 1 .. c ] do
            Append( l, " " );
            e := m[i][j];
            if IsZero( e ) then
                Append( l, "\\cdot" );
            else
                Append( l, LaTeXOutput( m[i][j] ) );
            fi;
            if j < c then
                Append( l, " &" );
            fi;
        od;
        if i < r then
            Append( l, " \\\\" );
        fi;
        Append( l, " \n" );
    od;
    
    Append( l, "\\end{array} \\right)" );
    
    return l;
    
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
    
    Print( "(an empty ", NumberRows( o ), " x ", NumberColumns( o ), " matrix)\n" );
    
end );

##
InstallMethod( Trace ,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( C )
    local R;
    
    if NumberRows( C ) <> NumberColumns( C ) then
      Error( "the matrix is not a square matrix\n" );
    fi;
    
    R := HomalgRing( C );
    
    if IsZero( C ) then
      return Zero( R );
    elif IsOne( C ) then
      return NumberRows( C ) * One( R );
    fi;
    
    return Sum( [ 1 .. NumberRows( C ) ], i -> C[ i, i ] );
    
end );
