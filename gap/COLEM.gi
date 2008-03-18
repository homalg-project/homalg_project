#############################################################################
##
##  COLEM.gi                    COLEM subpackage             Mohamed Barakat
##
##         COLEM = Clever Operations for Lazy Evaluated Matrices
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for COLEM subpackage.
##
#############################################################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

InstallValue( COLEM,
        rec(
            color := "\033[4;30;46m" ) );

####################################
#
# methods for operations:
#
####################################

#-----------------------------------
# \=
#-----------------------------------

##
InstallMethod( \=,
        "for homalg matrices",
        [ IsHomalgMatrix and IsZeroMatrix, IsHomalgMatrix and IsZeroMatrix ],
        
  function( M1, M2 )
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: IsZeroMatrix = IsZeroMatrix", "\033[0m" );
    
    return AreComparableMatrices( M1, M2 );
    
end );

##
InstallMethod( \=,
        "for homalg matrices",
        [ IsHomalgMatrix and IsIdentityMatrix, IsHomalgMatrix and IsIdentityMatrix ],
        
  function( M1, M2 )
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: IsIdentityMatrix = IsIdentityMatrix", "\033[0m" );
    
    return AreComparableMatrices( M1, M2 );
    
end );

#-----------------------------------
# Involution
#-----------------------------------

##
InstallMethod( Involution,
        "for homalg matrices",
        [ IsHomalgMatrix and IsZeroMatrix ],
        
  function( M )
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: Involution( IsZeroMatrix )", "\033[0m" );
    
    return HomalgMatrix( "zero", NrColumns( M ), NrRows( M ), HomalgRing( M ) );
    
end );

##
InstallMethod( Involution,
        "for homalg matrices",
        [ IsHomalgMatrix and IsIdentityMatrix ],
        
  function( M )
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: Involution( IsIdentityMatrix )", "\033[0m" );
    
    return M;
    
end );

##
InstallMethod( Involution,
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalInvolution ],
        
  function( M )
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: Involution( Involution )", "\033[0m" );
    
    return EvalInvolution( M );
    
end );

#-----------------------------------
# CertainRows
#-----------------------------------

##
InstallMethod( CertainRows,
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalCertainRows, IsList ],
        
  function( M, plist )
    local A, plistA;
    
    if not IsSubset( [ 1 .. NrRows( M ) ], plist ) then
        Error( "the list of row positions ", plist, " must be in the range [ 1 .. ", NrRows( M ), " ]\n" );
    fi;
    
    if NrRows( M ) = 0 or plist = [ 1 .. NrRows( M ) ] then
        return M;
    fi;
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: CertainRows( CertainRows )", "\033[0m" );
    
    A := EvalCertainRows( M )[1];
    plistA := EvalCertainRows( M )[2];
    
    return CertainRows( A, plistA{plist} );
    
end );

##
InstallMethod( CertainRows,
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalUnionOfRows, IsList ],
        
  function( M, plist )
    local A, B, plistA, plistB;
    
    if not IsSubset( [ 1 .. NrRows( M ) ], plist ) then
        Error( "the list of row positions ", plist, " must be in the range [ 1 .. ", NrRows( M ), " ]\n" );
    fi;
    
    if NrRows( M ) = 0 or plist = [ 1 .. NrRows( M ) ] then
        return M;
    fi;
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: CertainRows( UnionOfRows )", "\033[0m" );
    
    A := EvalUnionOfRows( M )[1];
    B := EvalUnionOfRows( M )[2];
    
    plistA := Intersection2( plist, [ 1 .. NrRows( A ) ] );
    plistB := Intersection2( plist - NrRows( A ), [ 1 .. NrRows( B ) ] );
    
    return UnionOfRows( CertainRows( A, plistA ), CertainRows( B, plistB ) );
    
end );

##
InstallMethod( CertainRows,
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalUnionOfColumns, IsList ],
        
  function( M, plist )
    local A, B;
    
    if not IsSubset( [ 1 .. NrRows( M ) ], plist ) then
        Error( "the list of row positions ", plist, " must be in the range [ 1 .. ", NrRows( M ), " ]\n" );
    fi;
    
    if NrRows( M ) = 0 or plist = [ 1 .. NrRows( M ) ] then
        return M;
    fi;
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: CertainRows( UnionOfColumns )", "\033[0m" );
    
    A := EvalUnionOfColumns( M )[1];
    B := EvalUnionOfColumns( M )[2];
    
    return UnionOfColumns( CertainRows( A, plist ), CertainRows( B, plist ) );
    
end );

##
InstallMethod( CertainRows,
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalCompose, IsList ],
        
  function( M, plist )
    local A, B;
    
    if not IsSubset( [ 1 .. NrRows( M ) ], plist ) then
        Error( "the list of row positions ", plist, " must be in the range [ 1 .. ", NrRows( M ), " ]\n" );
    fi;
    
    if NrRows( M ) = 0 or plist = [ 1 .. NrRows( M ) ] then
        return M;
    fi;
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: CertainRows( Compose )", "\033[0m" );
    
    A := EvalCompose( M )[1];
    B := EvalCompose( M )[2];
    
    return CertainRows( A, plist ) * B;
    
end );

#-----------------------------------
# CertainColumns
#-----------------------------------

##
InstallMethod( CertainColumns,
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalCertainColumns, IsList ],
        
  function( M, plist )
    local A, plistA;
    
    if not IsSubset( [ 1 .. NrColumns( M ) ], plist ) then
        Error( "the list of column positions ", plist, " must be in the range [ 1 .. ", NrColumns( M ), " ]\n" );
    fi;
    
    if NrColumns( M ) = 0 or plist = [ 1 .. NrColumns( M ) ] then
        return M;
    fi;
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: CertainColumns( CertainColumns )", "\033[0m" );
    
    A := EvalCertainColumns( M )[1];
    plistA := EvalCertainColumns( M )[2];
    
    return CertainColumns( A, plistA{plist} );
    
end );

##
InstallMethod( CertainColumns,
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalUnionOfColumns, IsList ],
        
  function( M, plist )
    local A, B, plistA, plistB;
    
    if not IsSubset( [ 1 .. NrColumns( M ) ], plist ) then
        Error( "the list of column positions ", plist, " must be in the range [ 1 .. ", NrColumns( M ), " ]\n" );
    fi;
    
    if NrColumns( M ) = 0 or plist = [ 1 .. NrColumns( M ) ] then
        return M;
    fi;
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: CertainColumns( UnionOfColumns )", "\033[0m" );
    
    A := EvalUnionOfColumns( M )[1];
    B := EvalUnionOfColumns( M )[2];
    
    plistA := Intersection2( plist, [ 1 .. NrColumns( A ) ] );
    plistB := Intersection2( plist - NrColumns( A ), [ 1 .. NrColumns( B ) ] );
    
    return UnionOfColumns( CertainColumns( A, plistA ), CertainColumns( B, plistB ) );
    
end );

##
InstallMethod( CertainColumns,
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalUnionOfRows, IsList ],
        
  function( M, plist )
    local A, B;
    
    if not IsSubset( [ 1 .. NrColumns( M ) ], plist ) then
        Error( "the list of column positions ", plist, " must be in the range [ 1 .. ", NrColumns( M ), " ]\n" );
    fi;
    
    if NrColumns( M ) = 0 or plist = [ 1 .. NrColumns( M ) ] then
        return M;
    fi;
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: CertainColumns( UnionOfRows )", "\033[0m" );
    
    A := EvalUnionOfRows( M )[1];
    B := EvalUnionOfRows( M )[2];
    
    return UnionOfRows( CertainColumns( A, plist ), CertainColumns( B, plist ) );
    
end );

##
InstallMethod( CertainColumns,
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalCompose, IsList ],
        
  function( M, plist )
    local A, B;
    
    if not IsSubset( [ 1 .. NrColumns( M ) ], plist ) then
        Error( "the list of column positions ", plist, " must be in the range [ 1 .. ", NrColumns( M ), " ]\n" );
    fi;
    
    if NrColumns( M ) = 0 or plist = [ 1 .. NrColumns( M ) ] then
        return M;
    fi;
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: CertainColumns( Compose )", "\033[0m" );
    
    A := EvalCompose( M )[1];
    B := EvalCompose( M )[2];
    
    return A * CertainColumns( B, plist );
    
end );

#-----------------------------------
# UnionOfRows
#-----------------------------------

##
InstallMethod( UnionOfRows,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and IsEmptyMatrix ],
        
  function( A, B )
    
    if NrColumns( A ) <> NrColumns( B ) then
        Error( "the two matrices are not stackable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrColumns( B ), "\n" );
    fi;
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: UnionOfRows( IsHomalgMatrix, IsEmptyMatrix )", "\033[0m" );
    
    return A;
    
end );

##
InstallMethod( UnionOfRows,
        "of two homalg matrices",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix ],
        
  function( A, B )
    
    if NrColumns( A ) <> NrColumns( B ) then
        Error( "the two matrices are not stackable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrColumns( B ), "\n" );
    fi;
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: UnionOfRows( IsEmptyMatrix, IsHomalgMatrix )", "\033[0m" );
    
    return B;
    
end );

##
InstallMethod( UnionOfRows,
        "of two homalg matrices",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix and IsEmptyMatrix ],
        
  function( A, B )
    
    if NrColumns( A ) <> NrColumns( B ) then
        Error( "the two matrices are not stackable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrColumns( B ), "\n" );
    fi;
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: UnionOfRows( IsEmptyMatrix, IsEmptyMatrix )", "\033[0m" );
    
    return HomalgMatrix( "zero", NrRows( A ) + NrRows( B ), NrColumns( A ), HomalgRing( A ) );
    
end );

#-----------------------------------
# UnionOfColumns
#-----------------------------------

##
InstallMethod( UnionOfColumns,
        "of two homalg matrices",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix ],
        
  function( A, B )
    
    if NrRows( A ) <> NrRows( B ) then
        Error( "the two matrices are not augmentable, since the first one has ", NrRows( A ), " row(s), while the second ", NrRows( B ), "\n" );
    fi;
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: UnionOfColumns( IsEmptyMatrix, IsHomalgMatrix )", "\033[0m" );
    
    return B;
    
end );

##
InstallMethod( UnionOfColumns,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and IsEmptyMatrix ],
        
  function( A, B )
    
    if NrRows( A ) <> NrRows( B ) then
        Error( "the two matrices are not augmentable, since the first one has ", NrRows( A ), " row(s), while the second ", NrRows( B ), "\n" );
    fi;
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: UnionOfColumns( IsHomalgMatrix, IsEmptyMatrix )", "\033[0m" );
    
    return A;
    
end );

##
InstallMethod( UnionOfColumns,
        "of two homalg matrices",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix and IsEmptyMatrix ],
        
  function( A, B )
    
    if NrRows( A ) <> NrRows( B ) then
        Error( "the two matrices are not augmentable, since the first one has ", NrRows( A ), " row(s), while the second ", NrRows( B ), "\n" );
    fi;
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: UnionOfColumns( IsEmptyMatrix, IsEmptyMatrix )", "\033[0m" );
    
    return HomalgMatrix( "zero", NrRows( A ), NrColumns( A ) + NrColumns( B ), HomalgRing( A ) );
    
end );

#-----------------------------------
# MulMat
#-----------------------------------

##
InstallMethod( \*,
        "of homalg matrices with ring elements",
        [ IsRingElement and IsZero, IsHomalgMatrix ],
        
  function( a, A )
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: IsZero * IsHomalgMatrix", "\033[0m" );
    
    return 0 * A;
    
end );

##
InstallMethod( \*,
        "of homalg matrices with ring elements",
        [ IsRingElement and IsOne, IsHomalgMatrix ],
        
  function( a, A )
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: IsOne * IsHomalgMatrix", "\033[0m" );
    
    return A;
    
end );

##
InstallMethod( \*,
        "of homalg matrices",
        [ IsRingElement, IsHomalgMatrix and IsZeroMatrix ],
        
  function( a, A )
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: IsRingElement * IsZeroMatrix", "\033[0m" );
    
    return A;
    
end );

#-----------------------------------
# AddMat
#-----------------------------------

##
InstallMethod( \+,
        "of two homalg matrices",
        [ IsHomalgMatrix and IsZeroMatrix, IsHomalgMatrix ],
        
  function( A, B )
    
    if NrRows( A ) <> NrRows( B ) then
        Error( "the two matrices are not summable, since the first one has ", NrRows( A ), " row(s), while the second ", NrRows( B ), "\n" );
    fi;
    
    if NrColumns( A ) <> NrColumns( B ) then
        Error( "the two matrices are not summable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrColumns( B ), "\n" );
    fi;
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: IsZeroMatrix + IsHomalgMatrix", "\033[0m" );
    
    return B;
    
end );

##
InstallMethod( \+,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and IsZeroMatrix ],
        
  function( A, B )
    
    if NrRows( A ) <> NrRows( B ) then
        Error( "the two matrices are not summable, since the first one has ", NrRows( A ), " row(s), while the second ", NrRows( B ), "\n" );
    fi;
    
    if NrColumns( A ) <> NrColumns( B ) then
        Error( "the two matrices are not summable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrColumns( B ), "\n" );
    fi;
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: IsHomalgMatrix + IsZeroMatrix", "\033[0m" );
    
    return A;
    
end );

##
InstallMethod( \+,
        "of two homalg matrices",
        [ IsHomalgMatrix and HasEvalCompose, IsHomalgMatrix and HasEvalCompose ],
        
  function( A, B )
    local C;
    
    if NrRows( A ) <> NrRows( B ) then
        Error( "the two matrices are not summable, since the first one has ", NrRows( A ), " row(s), while the second ", NrRows( B ), "\n" );
    fi;
    
    if NrColumns( A ) <> NrColumns( B ) then
        Error( "the two matrices are not summable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrColumns( B ), "\n" );
    fi;
    
    C := EvalCompose( A )[1];
    
    if IsIdenticalObj( C , EvalCompose( B )[1] ) then
        
        Info( InfoCOLEM, 2, COLEM.color, "COLEM: C * E + C * F", "\033[0m" );
        
        return C * ( EvalCompose( A )[2] + EvalCompose( B )[2] );
        
    fi;
    
    C := EvalCompose( A )[2];
    
    if IsIdenticalObj( C , EvalCompose( B )[2] ) then
        
        Info( InfoCOLEM, 2, COLEM.color, "COLEM: E * C + F * C", "\033[0m" );
        
        return ( EvalCompose( A )[1] + EvalCompose( B )[1] ) * C;
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \+,
        "of two homalg matrices",
        [ IsHomalgMatrix and HasEvalMulMat, IsHomalgMatrix ],
        
  function( A, B )
    local R;
    
    if NrRows( A ) <> NrRows( B ) then
        Error( "the two matrices are not summable, since the first one has ", NrRows( A ), " row(s), while the second ", NrRows( B ), "\n" );
    fi;
    
    if NrColumns( A ) <> NrColumns( B ) then
        Error( "the two matrices are not summable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrColumns( B ), "\n" );
    fi;
    
    R := HomalgRing( A );
    
    if EvalMulMat( A )[1] = MinusOne( R ) then
        
        Info( InfoCOLEM, 2, COLEM.color, "COLEM: -A + B", "\033[0m" );
        
        return B - EvalMulMat( A )[2];
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \+,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and HasEvalMulMat ],
        
  function( A, B )
    local R;
    
    if NrRows( A ) <> NrRows( B ) then
        Error( "the two matrices are not summable, since the first one has ", NrRows( A ), " row(s), while the second ", NrRows( B ), "\n" );
    fi;
    
    if NrColumns( A ) <> NrColumns( B ) then
        Error( "the two matrices are not summable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrColumns( B ), "\n" );
    fi;
    
    R := HomalgRing( B );
    
    if EvalMulMat( B )[1] = MinusOne( R ) then
        
        Info( InfoCOLEM, 2, COLEM.color, "COLEM: A + (-B)", "\033[0m" );
        
        return A - EvalMulMat( B )[2];
        
    fi;
    
    TryNextMethod( );
    
end );

#-----------------------------------
# AdditiveInverseMutable
#-----------------------------------

## a synonym of `-<elm>':
InstallMethod( AdditiveInverseMutable,
        "of homalg matrices",
        [ IsHomalgMatrix and IsZeroMatrix ],
        
  function( A )
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: -IsZeroMatrix", "\033[0m" );
    
    return A;
    
end );

## a synonym of `-<elm>':
InstallMethod( AdditiveInverseMutable,
        "of homalg matrices",
        [ IsHomalgMatrix and HasEvalMulMat ],
        
  function( A )
    local R;
    
    R := HomalgRing( A );
    
    if EvalMulMat( A )[1] = MinusOne( R ) then
        
        Info( InfoCOLEM, 2, COLEM.color, "COLEM: -(-IsHomalgMatrix)", "\033[0m" );
        
        return EvalMulMat( A )[2];
    fi;
    
    TryNextMethod( );
    
end );

#-----------------------------------
# SubMat
#-----------------------------------

##
InstallMethod( \-,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ], 1000,
        
  function( A, B )
    
    if IsIdenticalObj( A, B ) then
        
        Info( InfoCOLEM, 2, COLEM.color, "COLEM: M - M", "\033[0m" );
        
        return 0 * A;
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \-,
        "of two homalg matrices",
        [ IsHomalgMatrix and IsZeroMatrix, IsHomalgMatrix ],
        
  function( A, B )
    
    if NrRows( A ) <> NrRows( B ) then
        Error( "the two matrices are not subtractable, since the first one has ", NrRows( A ), " row(s), while the second ", NrRows( B ), "\n" );
    fi;
    
    if NrColumns( A ) <> NrColumns( B ) then
        Error( "the two matrices are not subtractable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrColumns( B ), "\n" );
    fi;
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: IsZeroMatrix - IsHomalgMatrix", "\033[0m" );
    
    return -B;
    
end );

##
InstallMethod( \-,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and IsZeroMatrix ],
        
  function( A, B )
    
    if NrRows( A ) <> NrRows( B ) then
        Error( "the two matrices are not subtractable, since the first one has ", NrRows( A ), " row(s), while the second ", NrRows( B ), "\n" );
    fi;
    
    if NrColumns( A ) <> NrColumns( B ) then
        Error( "the two matrices are not subtractable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrColumns( B ), "\n" );
    fi;
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: IsHomalgMatrix - IsZeroMatrix", "\033[0m" );
    
    return A;
    
end );

##
InstallMethod( \-,
        "of two homalg matrices",
        [ IsHomalgMatrix and HasEvalCompose, IsHomalgMatrix and HasEvalCompose ],
        
  function( A, B )
    local C;
    
    if NrRows( A ) <> NrRows( B ) then
        Error( "the two matrices are not summable, since the first one has ", NrRows( A ), " row(s), while the second ", NrRows( B ), "\n" );
    fi;
    
    if NrColumns( A ) <> NrColumns( B ) then
        Error( "the two matrices are not summable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrColumns( B ), "\n" );
    fi;
    
    C := EvalCompose( A )[1];
    
    if IsIdenticalObj( C , EvalCompose( B )[1] ) then
        
        Info( InfoCOLEM, 2, COLEM.color, "COLEM: C * E - C * F", "\033[0m" );
        
        return C * ( EvalCompose( A )[2] - EvalCompose( B )[2] );
        
    fi;
    
    C := EvalCompose( A )[2];
    
    if IsIdenticalObj( C , EvalCompose( B )[2] ) then
        
        Info( InfoCOLEM, 2, COLEM.color, "COLEM: E * C - F * C", "\033[0m" );
        
        return ( EvalCompose( A )[1] - EvalCompose( B )[1] ) * C;
        
    fi;
    
    TryNextMethod( );
    
end );

#-----------------------------------
# Compose
#-----------------------------------

##
InstallMethod( \*,
        "of two homalg matrices",
        [ IsHomalgMatrix and IsZeroMatrix, IsHomalgMatrix ],
        
  function( A, B )
    
    if NrColumns( A ) <> NrRows( B ) then
        Error( "the two matrices are not composable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrRows( B ), " row(s)\n" );
    fi;
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: IsZeroMatrix * IsHomalgMatrix", "\033[0m" );
    
    if NrRows( B ) = NrColumns( B ) then
        return A;
    else
        return HomalgMatrix( "zero", NrRows( A ), NrColumns( B ), HomalgRing( A ) );
    fi;
    
end );

##
InstallMethod( \*,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and IsZeroMatrix ],
        
  function( A, B )
    
    if NrColumns( A ) <> NrRows( B ) then
        Error( "the two matrices are not composable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrRows( B ), " row(s)\n" );
    fi;
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: IsHomalgMatrix * IsZeroMatrix", "\033[0m" );
    
    if NrRows( A ) = NrColumns( A ) then
        return B;
    else
        return HomalgMatrix( "zero", NrRows( A ), NrColumns( B ), HomalgRing( B ) );
    fi;
    
end );

##
InstallMethod( \*,
        "of two homalg matrices",
        [ IsHomalgMatrix and IsIdentityMatrix, IsHomalgMatrix ],
        
  function( A, B )
    
    if NrColumns( A ) <> NrRows( B ) then
        Error( "the two matrices are not composable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrRows( B ), " row(s)\n" );
    fi;
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: IsIdentityMatrix * IsHomalgMatrix", "\033[0m" );
    
    return B;
    
end );

##
InstallMethod( \*,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and IsIdentityMatrix ],
        
  function( A, B )
    
    if NrColumns( A ) <> NrRows( B ) then
        Error( "the two matrices are not composable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrRows( B ), " row(s)\n" );
    fi;
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: IsHomalgMatrix * IsIdentityMatrix", "\033[0m" );
    
    return A;
    
end );

##
InstallMethod( \*,
        "of two homalg matrices",
        [ IsHomalgMatrix and HasEvalUnionOfRows, IsHomalgMatrix ],
        
  function( A, B )
    local A1, A2;
    
    if NrColumns( A ) <> NrRows( B ) then
        Error( "the two matrices are not composable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrRows( B ), " row(s)\n" );
    fi;
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: UnionOfRows * IsHomalgMatrix", "\033[0m" );
    
    A1 := EvalUnionOfRows( A )[1];
    A2 := EvalUnionOfRows( A )[2];
    
    return UnionOfRows( A1 * B, A2* B );
    
end );

##
InstallMethod( \*,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and HasEvalUnionOfColumns ],
        
  function( A, B )
    local B1, B2;
    
    if NrColumns( A ) <> NrRows( B ) then
        Error( "the two matrices are not composable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrRows( B ), " row(s)\n" );
    fi;
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: IsHomalgMatrix * UnionOfColumns", "\033[0m" );
    
    B1 := EvalUnionOfColumns( B )[1];
    B2 := EvalUnionOfColumns( B )[2];
    
    return UnionOfColumns( A * B1, A * B2 );
    
end );

##
InstallMethod( \*,
        "of two homalg matrices",
        [ IsHomalgMatrix and HasEvalUnionOfColumns, IsHomalgMatrix ],
        
  function( A, B )
    local A1, A2, B1, B2;
    
    if NrColumns( A ) <> NrRows( B ) then
        Error( "the two matrices are not composable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrRows( B ), " row(s)\n" );
    fi;
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: UnionOfColumns * IsHomalgMatrix", "\033[0m" );
    
    A1 := EvalUnionOfColumns( A )[1];
    A2 := EvalUnionOfColumns( A )[2];
    
    B1 := CertainRows( B, [ 1 .. NrColumns( A1 ) ] );
    B2 := CertainRows( B, [ 1 .. NrColumns( A2 ) ] );
    
    return A1 * B1 +  A2 * B2;
    
end );

##
InstallMethod( \*,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and HasEvalUnionOfRows ],
        
  function( A, B )
    local B1, B2, A1, A2;
    
    if NrColumns( A ) <> NrRows( B ) then
        Error( "the two matrices are not composable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrRows( B ), " row(s)\n" );
    fi;
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: IsHomalgMatrix * UnionOfRows", "\033[0m" );
    
    B1 := EvalUnionOfRows( B )[1];
    B2 := EvalUnionOfRows( B )[2];
    
    A1 := CertainColumns( A, [ 1 .. NrRows( B1 ) ] );
    A2 := CertainColumns( A, [ 1 .. NrRows( B2 ) ] );
    
    return A1 * B1 + A2 * B2;
    
end );

#-----------------------------------
# LeftInverse
#-----------------------------------

##
InstallMethod( LeftInverse,
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalRightInverse ], 1,
        
  function( M )
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: LeftInverse( RightInverse )", "\033[0m" );
    
    return EvalRightInverse( M );
    
end );

##
InstallMethod( LeftInverse,
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalInverse ], 2,
        
  function( M )
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: LeftInverse( Inverse )", "\033[0m" );
    
    return EvalInverse( M );
    
end );

##
InstallMethod( LeftInverse,
        "for homalg matrices",
        [ IsHomalgMatrix and IsIdentityMatrix ],
        
  function( M )
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: LeftInverse( IsIdentityMatrix )", "\033[0m" );
    
    return M;
    
end );

#-----------------------------------
# RightInverse
#-----------------------------------

##
InstallMethod( RightInverse,
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalLeftInverse ], 1,
        
  function( M )
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: RightInverse( LeftInverse )", "\033[0m" );
    
    return EvalLeftInverse( M );
    
end );

##
InstallMethod( RightInverse,
        "for homalg matrices",
        [ IsHomalgMatrix and HasEvalInverse ], 2,
        
  function( M )
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: RightInverse( Inverse )", "\033[0m" );
    
    return EvalInverse( M );
    
end );

##
InstallMethod( RightInverse,
        "for homalg matrices",
        [ IsHomalgMatrix and IsIdentityMatrix ],
        
  function( M )
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: RightInverse( IsIdentityMatrix )", "\033[0m" );
    
    return M;
    
end );

#-----------------------------------
# ZeroRows
#-----------------------------------

##
InstallMethod( ZeroRows,			 	## FIXME: make it an InstallImmediateMethod
        "for homalg matrices",
        [ IsHomalgMatrix and IsZeroMatrix and HasNrRows ],
        
  function( C )
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: ZeroRows( IsZeroMatrix )", "\033[0m" );
    
    return [ 1 .. NrRows( C ) ];
    
end );

##
InstallMethod( ZeroRows,			 	## FIXME: make it an InstallImmediateMethod
        "for homalg matrices",
        [ IsHomalgMatrix and IsIdentityMatrix ],
        
  function( C )
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: ZeroRows( IsIdentityMatrix )", "\033[0m" );
    
    return [ ];
    
end );

#-----------------------------------
# ZeroColumns
#-----------------------------------

##
InstallMethod( ZeroColumns,			 	## FIXME: make it an InstallImmediateMethod
        "for homalg matrices",
        [ IsHomalgMatrix and IsZeroMatrix and HasNrColumns ],
        
  function( C )
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: ZeroColumns( IsZeroMatrix )", "\033[0m" );
    
    return [ 1 .. NrColumns( C ) ];
    
end );

##
InstallMethod( ZeroColumns,			 	## FIXME: make it an InstallImmediateMethod
        "for homalg matrices",
        [ IsHomalgMatrix and IsIdentityMatrix ],
        
  function( C )
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: ZeroColumns( IsIdentityMatrix )", "\033[0m" );
    
    return [ ];
    
end );

#-----------------------------------
# NonZeroRows
#-----------------------------------

##
InstallMethod( NonZeroRows,			 	## FIXME: make it an InstallImmediateMethod
        "for homalg matrices",
        [ IsHomalgMatrix and IsZeroMatrix ],
        
  function( C )
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: NonZeroRows( IsZeroMatrix )", "\033[0m" );
    
    return [ ];
    
end );

##
InstallMethod( NonZeroRows,			 	## FIXME: make it an InstallImmediateMethod
        "for homalg matrices",
        [ IsHomalgMatrix and IsIdentityMatrix and HasNrRows ],
        
  function( C )
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: NonZeroRows( IsIdentityMatrix )", "\033[0m" );
    
    return [ 1 .. NrRows( C ) ];
    
end );

#-----------------------------------
# NonZeroColumns
#-----------------------------------

##
InstallMethod( NonZeroColumns,			 	## FIXME: make it an InstallImmediateMethod
        "for homalg matrices",
        [ IsHomalgMatrix and IsZeroMatrix ],
        
  function( C )
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: NonZeroColumns( IsZeroMatrix )", "\033[0m" );
    
    return [ ];
    
end );

##
InstallMethod( NonZeroColumns,			 	## FIXME: make it an InstallImmediateMethod
        "for homalg matrices",
        [ IsHomalgMatrix and IsIdentityMatrix and HasNrColumns ],
        
  function( C )
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: NonZeroColumns( IsIdentityMatrix )", "\033[0m" );
    
    return [ 1 .. NrColumns( C ) ];
    
end );

#-----------------------------------
# RowRankOfMatrix
#-----------------------------------

##
InstallMethod( RowRankOfMatrix,			 	## FIXME: make an extra InstallImmediateMethod when NonZeroRows( M ) is set
        [ IsHomalgMatrix and IsTriangularMatrix ],
        
  function( M )
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: RowRankOfMatrix( IsTriangularMatrix )", "\033[0m" );
    
    return Length( NonZeroRows( M ) );
        
end );

#-----------------------------------
# ColumnRankOfMatrix
#-----------------------------------

##
InstallMethod( ColumnRankOfMatrix,			## FIXME: make an extra InstallImmediateMethod when NonZeroColumns( M ) is set
        [ IsHomalgMatrix and IsTriangularMatrix ],
        
  function( M )
    
    Info( InfoCOLEM, 2, COLEM.color, "COLEM: ColumnRankOfMatrix( IsTriangularMatrix )", "\033[0m" );
    
    return Length( NonZeroColumns( M ) );
        
end );

