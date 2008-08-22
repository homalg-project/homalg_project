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

# three new representations for the GAP-category IsHomalgMatrix:
DeclareRepresentation( "IshomalgInternalMatrixHullRep",
        IsInternalMatrixHull,
        [ ] );

DeclareRepresentation( "IsHomalgInternalMatrixRep",
        IsHomalgMatrix,
        [ ] );

DeclareRepresentation( "IsHomalgExternalMatrixRep",
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

# three new types:
BindGlobal( "TheTypeInternalMatrixHull",
        NewType( TheFamilyOfInternalMatrixHulls,
                IshomalgInternalMatrixHullRep ) );

BindGlobal( "TheTypeHomalgInternalMatrix",
        NewType( TheFamilyOfHomalgMatrices,
                IsHomalgInternalMatrixRep ) );

BindGlobal( "TheTypeHomalgExternalMatrix",
        NewType( TheFamilyOfHomalgMatrices,
                IsHomalgExternalMatrixRep ) );

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

##
InstallMethod( HomalgRing,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    
    return M!.ring;
    
end );

##
InstallMethod( ShallowCopy,
        "for homalg matrices",
        [ IsHomalgInternalMatrixRep ],
        
  function( M )
    local R, RP, MM;
    
    R := HomalgRing( M );
    RP := homalgTable( R );
    
    if IsBound(RP!.CopyMatrix) then
        MM := RP!.CopyMatrix( M );
        if not IsIdenticalObj( M, MM ) then
            return MM;
        fi;
    fi;
    
    return HomalgMatrix( One( R ) * Eval( M )!.matrix, NrRows( M ), NrColumns( M ), R );	## HomalgMatrix shallow copies its first argument if it is of type IsMatrix
    
end );

##
InstallMethod( ShallowCopy,
        "for homalg matrices",
        [ IsHomalgExternalMatrixRep ],
        
  function( M )
    local R, RP;
    
    R := HomalgRing( M );
    RP := homalgTable( R );
    
    if IsBound(RP!.CopyMatrix) then
        return RP!.CopyMatrix( M );
    fi;
    
    return M;
    
end );

##
InstallMethod( ShallowCopy,
        "for homalg matrices",
        [ IsHomalgMatrix and IsIdentityMatrix ],
        
  function( M )
    
    return HomalgIdentityMatrix( NrRows( M ), NrColumns( M ), HomalgRing( M ) );
    
end );

##
InstallMethod( ShallowCopy,
        "for homalg matrices",
        [ IsHomalgMatrix and IsZero ],
        
  function( M )
    
    return HomalgZeroMatrix( NrRows( M ), NrColumns( M ), HomalgRing( M ) );
    
end );

##
InstallMethod( SetExtractHomalgMatrixAsSparse,
        "for homalg matrices",
        [ IsHomalgMatrix, IsBool ],
        
  function( M, b )
    
    M!.ExtractHomalgMatrixAsSparse := b;
    
end );

##
InstallMethod( SetExtractHomalgMatrixToFile,
        "for homalg matrices",
        [ IsHomalgMatrix, IsBool ],
        
  function( M, b )
    
    M!.ExtractHomalgMatrixToFile := b;
    
end );

##
InstallMethod( SetEntryOfHomalgMatrix,
        "for homalg matrices",
        [ IsHomalgMatrix and IsMutableMatrix, IsInt, IsInt, IsString, IsHomalgInternalRingRep ],
        
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
        "for homalg matrices",
        [ IsHomalgMatrix and IsMutableMatrix, IsInt, IsInt, IsRingElement, IsHomalgInternalRingRep ],
        
  function( M, r, c, a, R )
    
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
InstallMethod( SetEntryOfHomalgMatrix,
        "for homalg matrices",
        [ IsHomalgMatrix and IsMutableMatrix, IsInt, IsInt, IsHomalgExternalRingElement ],
        
  function( M, r, c, s )
    
    SetEntryOfHomalgMatrix( M, r, c, homalgPointer( s ), HomalgRing( M ) );
    
end );

##
InstallMethod( SetEntryOfHomalgMatrix,
        "for homalg matrices",
        [ IsHomalgMatrix and IsMutableMatrix, IsInt, IsInt, IsHomalgExternalRingElement, IsHomalgExternalRingRep ],
        
  function( M, r, c, s, R )
    
    SetEntryOfHomalgMatrix( M, r, c, homalgPointer( s ), R );
    
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
InstallMethod( CreateHomalgMatrix,
        "for homalg matrices",
        [ IsString, IsHomalgInternalRingRep ],
        
  function( S, R )
    local s;
    
    s := ShallowCopy( S );
    
    RemoveCharacters( s, "\\\n\" " );
    
    return HomalgMatrix( EvalString( s ), R );
    
end );

##
InstallMethod( CreateHomalgMatrix,
        "for homalg matrices",
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
InstallMethod( CreateHomalgSparseMatrix,
        "for homalg matrices",
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
InstallMethod( GetEntryOfHomalgMatrixAsString,
        "for homalg matrices",
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
        "for homalg matrices",
        [ IsHomalgInternalMatrixRep, IsInt, IsInt, IsHomalgInternalRingRep ],
        
  function( M, r, c, R )
    
    return Eval( M )!.matrix[r][c];
    
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
        [ IsHomalgInternalMatrixRep, IsHomalgInternalRingRep ],
        
  function( M, R )
    local s, m;
    
    s := Eval( M )!.matrix;
    
    if HasCharacteristic( R ) then
        m := Characteristic( R );
        if m > 0 and not HasCoefficientsRing( R ) then ## FIXME: we can only deal with Z/mZ and GF(p): c = Size( R ) !!!
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
        [ IsHomalgInternalMatrixRep, IsHomalgInternalRingRep ],
        
  function( M, R )
    local s, m;
    
    s := Eval ( M )!.matrix;
    
    if HasCharacteristic( R ) then
        m := Characteristic( R );
        if m > 0 and not HasCoefficientsRing( R ) then ## FIXME: we can only deal with Z/mZ and GF(p): c = Size( R ) !!!
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
        [ IsHomalgInternalMatrixRep, IsHomalgInternalRingRep ],
        
  function( M, R )
    local r, c, z, s, m;
    
    r := NrRows( M );
    c := NrColumns( M );
    z := Zero( R );
    
    s := Eval( M )!.matrix;
    
    if HasCharacteristic( R ) then
        m := Characteristic( R );
        if m > 0 and not HasCoefficientsRing( R ) then ## FIXME: we can only deal with Z/mZ and GF(p): c = Size( R ) !!!
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

##
InstallMethod( \=,
        "for homalg comparable matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( M1, M2 )
    
    if not AreComparableMatrices( M1, M2 ) then
        return false;
    fi;
    
    return DecideZero( M1 ) = DecideZero( M2 );
    
end );

##
InstallMethod( \=,
        "for homalg comparable matrices",
        [ IsHomalgInternalMatrixRep and IsReducedModuloRingRelations,
          IsHomalgInternalMatrixRep and IsReducedModuloRingRelations ],
        
  function( M1, M2 )
    
    if not AreComparableMatrices( M1, M2 ) then
        return false;
    fi;
    
    return Eval( M1 ) = Eval( M2 );
    
end );

##
InstallMethod( ZeroMutable,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    
    return HomalgZeroMatrix( NrRows( M ), NrColumns( M ), HomalgRing( M ) );
    
end );

##
InstallMethod( Involution,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, C;
    
    R := HomalgRing( M );
    
    C := HomalgMatrix( R );
    
    if HasNrColumns( M ) then
        SetNrRows( C, NrColumns( M ) );
    fi;
    
    if HasNrRows( M ) then
        SetNrColumns( C, NrRows( M ) );
    fi;
    
    SetEvalInvolution( C, M );
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

##
InstallMethod( CertainRows,
        "for homalg matrices",
        [ IsHomalgMatrix, IsList ],
        
  function( M, plist )
    local R, C;
    
    R := HomalgRing( M );
    
    C := HomalgMatrix( R );
    
    SetNrRows( C, Length( plist ) );
    SetNrColumns( C, NrColumns( M ) );
    
    SetEvalCertainRows( C, [ M, plist ] );
    
    return C;
    
end );

##
InstallMethod( CertainColumns,
        "for homalg matrices",
        [ IsHomalgMatrix, IsList ],
        
  function( M, plist )
    local R, C;
    
    R := HomalgRing( M );
    
    C := HomalgMatrix( R );
    
    SetNrColumns( C, Length( plist ) );
    SetNrRows( C, NrRows( M ) );
    
    SetEvalCertainColumns( C, [ M, plist ] );
    
    return C;
    
end );

##
InstallMethod( UnionOfRows,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( A, B )
    local R, C;
    
    R := HomalgRing( A );
    
    C := HomalgMatrix( R );
    
    SetNrRows( C, NrRows( A ) + NrRows( B ) );
    SetNrColumns( C, NrColumns( A ) );
    
    SetEvalUnionOfRows( C, [ A, B ] );
    
    return C;
    
end );

##
InstallMethod( UnionOfColumns,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( A, B )
    local R, C;
    
    R := HomalgRing( A );
    
    C := HomalgMatrix( R );
    
    SetNrRows( C, NrRows( A ) );
    SetNrColumns( C, NrColumns( A ) + NrColumns( B ) );
    
    SetEvalUnionOfColumns( C, [ A, B ] );
    
    return C;
    
end );

##
InstallMethod( DiagMat,
        "of two homalg matrices",
        [ IsHomogeneousList ],
        
  function( l )
    local R, C;
    
    R := HomalgRing( l[1] );
    
    C := HomalgMatrix( R );
    
    SetNrRows( C, Sum( List( l, NrRows ) ) );
    SetNrColumns( C, Sum( List( l, NrColumns ) ) );
    
    SetEvalDiagMat( C, l );
    
    return C;
    
end );

##
InstallMethod( KroneckerMat,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( A, B )
    local R, C;
    
    R := HomalgRing( A );
    
    C := HomalgMatrix( R );
    
    SetNrRows( C, NrRows( A ) * NrRows( B ) );
    SetNrColumns( C, NrColumns( A ) * NrColumns ( B ) );
    
    SetEvalKroneckerMat( C, [ A, B ] );
    
    return C;
    
end );

##
InstallMethod( \*,
        "for internal matrix hulls",
        [ IsRingElement, IsInternalMatrixHull ], 1001, ## it could otherwise run into the method ``PROD: negative integer * additive element with inverse'', value: 24
        
  function( a, A )
    
    return homalgInternalMatrixHull( a * A!.matrix );
    
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
InstallMethod( \*,
        "for homalg matrices",
        [ IsRingElement, IsHomalgMatrix ], 1001, ## it could otherwise run into the method ``PROD: negative integer * additive element with inverse'', value: 24
        
  function( a, A )
    local R, C;
    
    R := HomalgRing( A );
    
    C := HomalgMatrix( R );
    
    SetNrRows( C, NrRows( A ) );
    SetNrColumns( C, NrColumns( A ) );
    
    SetEvalMulMat( C, [ a, A ] );
    
    return C;
    
end );

##
InstallMethod( \+,
        "for pairs of internal matrix hulls",
        [ IsInternalMatrixHull, IsInternalMatrixHull ],
        
  function( A, B )
    
    return homalgInternalMatrixHull( A!.matrix + B!.matrix );
    
end );

##
InstallMethod( \+,
        "for pairs of homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( A, B )
    local R, C;
    
    R := HomalgRing( A );
    
    C := HomalgMatrix( R );
    
    SetNrRows( C, NrRows( A ) );
    SetNrColumns( C, NrColumns( A ) );
    
    SetEvalAddMat( C, [ A, B ] );
    
    return C;
    
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

##
InstallMethod( \-,
        "for pairs of of homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( A, B )
    local R, C;
    
    R := HomalgRing( A );
    
    C := HomalgMatrix( R );
    
    SetNrRows( C, NrRows( A ) );
    SetNrColumns( C, NrColumns( A ) );
    
    SetEvalSubMat( C, [ A, B ] );
    
    return C;
    
end );

##
InstallMethod( \*,
        "for pairs of internal matrix hulls",
        [ IsInternalMatrixHull, IsInternalMatrixHull ],
        
  function( A, B )
    
    return homalgInternalMatrixHull( A!.matrix * B!.matrix );
    
end );

##
InstallMethod( \*,
        "for pairs of homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( A, B )
    local R, C;
    
    R := HomalgRing( A );
    
    C := HomalgMatrix( R );
    
    SetNrRows( C, NrRows( A ) );
    SetNrColumns( C, NrColumns( B ) );
    
    SetEvalCompose( C, [ A, B ] );
    
    return C;
    
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
    local R, C;
    
    R := HomalgRing( M );
    
    C := HomalgMatrix( R );
    
    SetNrRows( C, NrColumns( M ) );
    SetNrColumns( C, NrRows( M ) );
    
    SetEvalLeftInverse( C, M );
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
    local R, C;
    
    R := HomalgRing( M );
    
    C := HomalgMatrix( R );
    
    SetNrColumns( C, NrRows( M ) );
    SetNrRows( C, NrColumns( M ) );
    
    SetEvalRightInverse( C, M );
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
InstallGlobalFunction( HomalgMatrix,
  function( arg )
    local nargs, R, M, ar, type, matrix, RP, nr_rows, nr_columns;
    
    nargs := Length( arg );
    
    ## "copy" the matrix:
    if nargs = 1 and IsHomalgMatrix( arg[1] ) then
        return HomalgMatrix( arg[1], HomalgRing( arg[1] ) );
    fi;
    
    if nargs > 1 and arg[1] <> [ ] then
        if ( IsHomalgMatrix( arg[1] ) and IsHomalgRing( arg[nargs] ) ) and
           not ( IsHomalgInternalMatrixRep( arg[1] ) and IsHomalgInternalRingRep( arg[nargs] ) ) then
            R := arg[nargs];
            if IsIdenticalObj( HomalgRing( arg[1] ), R ) then
                M := ShallowCopy( arg[1] );
                if not IsIdenticalObj( M, arg[1] ) then
                    return M;
                fi;
            fi;
            
            if LoadPackage( "IO_ForHomalg" ) <> true then
                Error( "the package IO_ForHomalg failed to load\n" );
            fi;
            
            return CallFuncList( ConvertHomalgMatrix, arg );
            
        elif IsString( arg[1] ) then
            
            if LoadPackage( "IO_ForHomalg" ) <> true then
                Error( "the package IO_ForHomalg failed to load\n" );
            fi;
            
            return CallFuncList( ConvertHomalgMatrix, arg );
            
        elif IsHomalgExternalRingRep( arg[nargs] ) and IsList( arg[1] ) then
            if Length( arg[1] ) > 0 and not IsList( arg[1][1] )
               and not ( nargs > 1 and IsInt( arg[2]) ) and not ( nargs > 2 and IsInt( arg[3] ) ) then ## CAUTION: some CAS only accept a list and not a listlist
                M := List( arg[1], a -> [a] );
            else
                M := arg[1];
            fi;
            
            ar := Concatenation( [ M ], arg{[ 2 .. nargs ]} );
            
            if LoadPackage( "IO_ForHomalg" ) <> true then
                Error( "the package IO_ForHomalg failed to load\n" );
            fi;
            
            return CallFuncList( ConvertHomalgMatrix, ar );
            
        fi;
    fi;
    
    R := arg[nargs];
    
    if not IsHomalgRing( R ) then
        Error( "the last argument must be an IsHomalgRing\n" );
    fi;
    
    if nargs > 1 and arg[1] = [ ] then
        return HomalgZeroMatrix( 0, 0, R );
    fi;
    
    if IsHomalgInternalRingRep( R ) then
        type := TheTypeHomalgInternalMatrix;
    else
        type := TheTypeHomalgExternalMatrix;
    fi;
    
    matrix := rec( ring := R );
    
    if nargs = 1 then ## only the ring is given
    ## an empty matrix
        
        ## Objectify:
        Objectify( type, matrix );
        
        return matrix;
        
    fi;
    
    if IsList( arg[1] ) and Length( arg[1] ) > 0 and not IsList( arg[1][1] ) then
        M := List( arg[1], a -> [a] );	## NormalizeInput
        RP := homalgTable( R );
        if IsBound(RP!.ConvertMatrix) then
            M := RP!.ConvertMatrix( One( R ) * M, R!.ring );
        fi;
    elif IsHomalgInternalMatrixRep( arg[1] ) and IsHomalgInternalRingRep( R ) then
        M := Eval( arg[1] );
        if IsInternalMatrixHull( M ) then
            M := M!.matrix;
        fi;
        RP := homalgTable( R );
        if IsBound(RP!.ConvertMatrix) then
            M := RP!.ConvertMatrix( One( R ) * M, R!.ring );
        fi;
    elif IsInternalMatrixHull( arg[1] ) then
        M := arg[1]!.matrix;
    else
        RP := homalgTable( R );
        if IsMatrix( arg[1] ) and IsBound(RP!.ConvertMatrix) then
            M := RP!.ConvertMatrix( One( R ) * arg[1], R!.ring );
        else
            M := ShallowCopy( arg[1] );	## by this we are sure that possible changes to a mutable internal matrix arg[1] does not destroy the logic of homalg
        fi;
    fi;
    
    if IsHomalgInternalRingRep( R ) then ## TheTypeHomalgInternalMatrix
        
        if IsMatrix( M ) then
            ## Objectify:
            ObjectifyWithAttributes(
                    matrix, TheTypeHomalgInternalMatrix,
                    NrRows, Length( M ),
                    NrColumns, Length( M[1] ),
                    Eval, homalgInternalMatrixHull( M ) );
        elif IsList( M ) then
            ## Objectify:
            ObjectifyWithAttributes(
                    matrix, TheTypeHomalgInternalMatrix,
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
                    matrix, TheTypeHomalgInternalMatrix,
                    Eval, M );
            ## don't know how to get the number of rows/columns
        fi;
        
    else ## TheTypeHomalgExternalMatrix
        
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
                    matrix, TheTypeHomalgExternalMatrix,
                    NrRows, arg[2],
                    NrColumns, arg[3],
                    Eval, M );
        else
            ## Objectify:
            ObjectifyWithAttributes(
                    matrix, TheTypeHomalgExternalMatrix,
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
InstallGlobalFunction( HomalgZeroMatrix,
  function( arg )				## the zero matrix
    local R, type, matrix, nr_rows, nr_columns;
    
    R := arg[Length( arg )];
    
    if not IsHomalgRing( R ) then
        Error( "the last argument must be an IsHomalgRing\n" );
    fi;
    
    if IsHomalgInternalRingRep( R ) then
        type := TheTypeHomalgInternalMatrix;
    else
        type := TheTypeHomalgExternalMatrix;
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

##
InstallGlobalFunction( HomalgIdentityMatrix,
  function( arg )		## the identity matrix
    local R, type, matrix;
    
    R := arg[Length( arg )];
    
    if not IsHomalgRing( R ) then
        Error( "the last argument must be an IsHomalgRing\n" );
    fi;
    
    if IsHomalgInternalRingRep( R ) then
        type := TheTypeHomalgInternalMatrix;
    else
        type := TheTypeHomalgExternalMatrix;
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

##
InstallGlobalFunction( HomalgInitialMatrix,
  function( arg )	        		## an initial matrix having the flag IsInitialMatrix
    local R, type, matrix, nr_rows, nr_columns;	## and filled with zeros BUT NOT marked as an IsZero
    
    R := arg[Length( arg )];
    
    if not IsHomalgRing( R ) then
        Error( "the last argument must be an IsHomalgRing\n" );
    fi;
    
    if IsHomalgInternalRingRep( R ) then
        type := TheTypeHomalgInternalMatrix;
    else
        type := TheTypeHomalgExternalMatrix;
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
                IsInitialMatrix, true,
                IsMutableMatrix, true );
    else
        ## Objectify:
        ObjectifyWithAttributes(
                matrix, type,
                IsInitialMatrix, true,
                IsMutableMatrix, true );
        
        if nr_rows then
            SetNrRows( matrix, arg[1] );
        fi;
        
        if nr_columns then
            SetNrColumns( matrix, arg[2] );
        fi;
    fi;
    
    return matrix;
    
end );

##
InstallGlobalFunction( HomalgInitialIdentityMatrix,
  function( arg )		## an square initial matrix having the flag IsInitialIdentityMatrix
    local R, type, matrix;	## and filled with an identity matrix BUT NOT marked as an IsIdentityMatrix
    
    R := arg[Length( arg )];
    
    if not IsHomalgRing( R ) then
        Error( "the last argument must be an IsHomalgRing\n" );
    fi;
    
    if IsHomalgInternalRingRep( R ) then
        type := TheTypeHomalgInternalMatrix;
    else
        type := TheTypeHomalgExternalMatrix;
    fi;
    
    matrix := rec( ring := R );
    
    if Length( arg ) > 1 and arg[1] in NonnegativeIntegers then
        ## Objectify:
        ObjectifyWithAttributes(
                matrix, type,
                NrRows, arg[1],
                NrColumns, arg[1],
                IsInitialIdentityMatrix, true,
                IsMutableMatrix, true );
    else
        ## Objectify:
        ObjectifyWithAttributes(
                matrix, type,
                IsInitialIdentityMatrix, true,
                IsMutableMatrix, true );
    fi;
    
    return matrix;
    
end );

## 
InstallGlobalFunction( HomalgVoidMatrix,
  function( arg )	## a void matrix filled with nothing having the flag IsVoidMatrix
    local R, type, matrix, nr_rows, nr_columns;
    
    R := arg[Length( arg )];
    
    if not IsHomalgRing( R ) then
        Error( "the last argument must be an IsHomalgRing\n" );
    fi;
    
    if IsHomalgInternalRingRep( R ) then
        type := TheTypeHomalgInternalMatrix;
    else
        type := TheTypeHomalgExternalMatrix;
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
    
    if IsRingElement( arg[1] ) or IsHomalgExternalRingElement( arg[1] ) then
        diag := [ arg[1] ];
    elif ForAll( arg[1], IsRingElement ) or ForAll( arg[1], IsHomalgExternalRingElement ) then
        diag := arg[1];
    fi;
    
    if not IsBound( R ) and IsBound( diag ) and diag <> [ ] and IsHomalgExternalRingElement( diag[1] ) then
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
    local first_attribute;
    
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
    
    if not ( HasNrRows( o ) and NrRows( o ) = 1 and HasNrColumns( o ) and NrColumns( o ) = 1 ) then
        if HasIsDiagonalMatrix( o ) and IsDiagonalMatrix( o ) then
            Print( " diagonal" );
        elif HasIsUpperStairCaseMatrix( o ) and IsUpperStairCaseMatrix( o ) then
            if not first_attribute then
                Print( "n upper staircase" );
            else
                Print( " upper staircase" );
            fi;
        elif HasIsStrictUpperTriangularMatrix( o ) and IsStrictUpperTriangularMatrix( o ) then
            Print( " strict upper triangular" );
        elif HasIsLowerStairCaseMatrix( o ) and IsLowerStairCaseMatrix( o ) then
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
        elif HasIsTriangularMatrix( o ) and IsTriangularMatrix( o ) and not ( HasNrRows( o ) and NrRows( o ) = 1 ) and not ( HasNrColumns( o ) and NrColumns( o ) = 1 ) then
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
    
    if IsHomalgInternalMatrixRep( o ) then
        Print( "internal " );
    else
        Print( "external " );
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
    
    if HasEval( o ) then
        Print( "<A " );
    else
        Print( "<An unevaluated " );
    fi;
    
    Print( "homalg " );
    
    if IsHomalgInternalMatrixRep( o ) then
        Print( "internal " );
    else
        Print( "external " );
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
    
    if HasEval( o ) then
        Print( "<A " );
    else
        Print( "<An unevaluated " );
    fi;
    
    Print( "homalg " );
    
    if IsHomalgInternalMatrixRep( o ) then
        Print( "internal " );
    else
        Print( "external " );
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
    
    if HasEval( o ) then
        Print( "<A" );
    else
        Print( "<An unevaluated" );
    fi;
    
    Print( " homalg " );
    
    if IsHomalgInternalMatrixRep( o ) then
        Print( "internal " );
    else
        Print( "external " );
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

