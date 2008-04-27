#############################################################################
##
##  LIMAT.gi                    LIMAT subpackage             Mohamed Barakat
##
##         LIMAT = Logical Implications for homalg MATrices
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for the LIMAT subpackage.
##
#############################################################################

####################################
#
# global variables:
#
####################################

# a central place for configuration variables:

InstallValue( LIMAT,
        rec(
            color := "\033[4;30;46m" ) );

####################################
#
# logical implications methods:
#
####################################

##
InstallTrueMethod( IsReducedModuloRingRelations, IsHomalgMatrix and IsZeroMatrix );

##
InstallTrueMethod( IsZeroMatrix, IsHomalgMatrix and IsEmptyMatrix );

##
InstallTrueMethod( IsPermutationMatrix, IsHomalgMatrix and IsIdentityMatrix );

##
InstallTrueMethod( IsPermutationMatrix, IsHomalgMatrix and IsSubidentityMatrix and IsInvertibleMatrix );

##
InstallTrueMethod( IsInvertibleMatrix, IsHomalgMatrix and IsPermutationMatrix );

##
InstallTrueMethod( IsSubidentityMatrix, IsHomalgMatrix and IsPermutationMatrix );

##
InstallTrueMethod( IsSubidentityMatrix, IsHomalgMatrix and IsEmptyMatrix );

##
InstallTrueMethod( IsLeftInvertibleMatrix, IsHomalgMatrix and IsPermutationMatrix );

##
InstallTrueMethod( IsRightInvertibleMatrix, IsHomalgMatrix and IsPermutationMatrix );

## a split injective morphism (of free modules) is injective
InstallTrueMethod( IsFullRowRankMatrix, IsHomalgMatrix and IsRightInvertibleMatrix );

##
InstallTrueMethod( IsFullColumnRankMatrix, IsHomalgMatrix and IsLeftInvertibleMatrix );

## an isomorphism is split injective
InstallTrueMethod( IsRightInvertibleMatrix, IsHomalgMatrix and IsInvertibleMatrix );

## an isomorphism is split surjective
InstallTrueMethod( IsLeftInvertibleMatrix, IsHomalgMatrix and IsInvertibleMatrix );

## a split surjective and split injective morphism (of free modules) is an isomorphism
InstallTrueMethod( IsInvertibleMatrix, IsHomalgMatrix and IsLeftInvertibleMatrix and IsRightInvertibleMatrix );

##
InstallTrueMethod( IsUpperTriangularMatrix, IsHomalgMatrix and IsDiagonalMatrix );

##
InstallTrueMethod( IsLowerTriangularMatrix, IsHomalgMatrix and IsDiagonalMatrix );

##
InstallTrueMethod( IsUpperTriangularMatrix, IsHomalgMatrix and IsStrictUpperTriangularMatrix );

##
InstallTrueMethod( IsLowerTriangularMatrix, IsHomalgMatrix and IsStrictLowerTriangularMatrix );

##
InstallTrueMethod( IsTriangularMatrix, IsHomalgMatrix and IsUpperTriangularMatrix );

##
InstallTrueMethod( IsTriangularMatrix, IsHomalgMatrix and IsLowerTriangularMatrix );

##
InstallTrueMethod( IsDiagonalMatrix, IsHomalgMatrix and IsUpperTriangularMatrix and IsLowerTriangularMatrix );

##
InstallTrueMethod( IsDiagonalMatrix, IsHomalgMatrix and IsZeroMatrix );

##
InstallTrueMethod( IsStrictUpperTriangularMatrix, IsHomalgMatrix and IsZeroMatrix );

##
InstallTrueMethod( IsStrictLowerTriangularMatrix, IsHomalgMatrix and IsZeroMatrix );

##
InstallTrueMethod( IsDiagonalMatrix, IsHomalgMatrix and IsIdentityMatrix );

##
InstallTrueMethod( IsZeroMatrix, IsHomalgMatrix and IsStrictUpperTriangularMatrix and IsStrictLowerTriangularMatrix );

####################################
#
# immediate methods for properties:
#
####################################

##
InstallImmediateMethod( IsEmptyMatrix,
        IsHomalgMatrix and HasNrRows and HasNrColumns, 0,
        
  function( M )
    
    if NrRows( M ) = 0 or NrColumns( M ) = 0 then
        return true;
    else
        return false;
    fi;
    
end );

##
InstallImmediateMethod( IsReducedModuloRingRelations,
        IsHomalgMatrix, 0,
        
  function( M )
    
    if not HasRingRelations( HomalgRing( M ) ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsRightInvertibleMatrix,
        IsHomalgMatrix and IsSubidentityMatrix, 0,
        
  function( M )
    
    return NrRows( M ) <= NrColumns( M );
    
end );

##
InstallImmediateMethod( IsRightInvertibleMatrix,
        IsHomalgMatrix and HasNrRows, 0,
        
  function( M )
    
    if NrRows( M ) = 0 then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsLeftInvertibleMatrix,
        IsHomalgMatrix and IsSubidentityMatrix, 0,
        
  function( M )
    
    return NrColumns( M ) <= NrRows( M );
    
end );

##
InstallImmediateMethod( IsLeftInvertibleMatrix,
        IsHomalgMatrix and HasNrColumns, 0,
        
  function( M )
    
    if NrColumns( M ) = 0 then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsUpperTriangularMatrix,
        IsHomalgMatrix and HasNrRows, 0,
        
  function( M )
    
    if NrRows( M ) = 1 then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsLowerTriangularMatrix,
        IsHomalgMatrix and HasNrColumns, 0,
        
  function( M )
    
    if NrColumns( M ) = 1 then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

####################################
#
# immediate methods for attributes:
#
####################################

##
InstallImmediateMethod( RowRankOfMatrix,
        IsHomalgMatrix and IsIdentityMatrix and HasNrRows, 0,
        
  function( M )
    
    return NrRows( M );
        
end );

##
InstallImmediateMethod( ColumnRankOfMatrix,
        IsHomalgMatrix and IsIdentityMatrix and HasNrColumns, 0,
        
  function( M )
    
    return NrColumns( M );
        
end );

##
InstallImmediateMethod( RowRankOfMatrix,
        IsHomalgMatrix and IsZeroMatrix, 0,
        
  function( M )
    
    return 0;
        
end );

##
InstallImmediateMethod( ColumnRankOfMatrix,
        IsHomalgMatrix and IsZeroMatrix, 0,
        
  function( M )
    
    return 0;
        
end );

##
InstallImmediateMethod( ZeroRows,
        IsHomalgMatrix and IsIdentityMatrix and IsReducedModuloRingRelations, 0,
        
  function( M )
    
    return [ ];
        
end );

##
InstallImmediateMethod( ZeroRows,
        IsHomalgMatrix and IsZeroMatrix and HasNrRows, 0,
        
  function( M )
    
    return [ 1 .. NrRows( M ) ];
        
end );

##
InstallImmediateMethod( ZeroColumns,
        IsHomalgMatrix and IsIdentityMatrix and IsReducedModuloRingRelations, 0,
        
  function( M )
    
    return [ ];
        
end );

##
InstallImmediateMethod( ZeroColumns,
        IsHomalgMatrix and IsZeroMatrix and HasNrColumns, 0,
        
  function( M )
    
    return [ 1 .. NrColumns( M ) ];
        
end );

##
InstallImmediateMethod( NonZeroRows,
        IsHomalgMatrix and IsIdentityMatrix and IsReducedModuloRingRelations and HasNrRows, 0,
        
  function( M )
    
    return [ 1 .. NrRows( M ) ];
        
end );

##
InstallImmediateMethod( NonZeroRows,
        IsHomalgMatrix and IsZeroMatrix, 0,
        
  function( M )
    
    return [ ];
        
end );

##
InstallImmediateMethod( NonZeroColumns,
        IsHomalgMatrix and IsIdentityMatrix and IsReducedModuloRingRelations and HasNrColumns, 0,
        
  function( M )
    
    return [ 1 .. NrColumns( M ) ];
        
end );

##
InstallImmediateMethod( NonZeroColumns,
        IsHomalgMatrix and IsZeroMatrix, 0,
        
  function( M )
    
    return [ ];
        
end );

##
InstallImmediateMethod( PositionOfFirstNonZeroEntryPerRow,
        IsHomalgMatrix and IsIdentityMatrix and IsReducedModuloRingRelations and HasNrRows, 0,
        
  function( M )
    
    if not ( HasIsZeroMatrix( M ) and IsZeroMatrix( M ) ) then
        return [ 1 .. NrRows( M ) ];
    fi;
    
    TryNextMethod( );
        
end );

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
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: IsZeroMatrix = IsZeroMatrix", "\033[0m" );
    
    return AreComparableMatrices( M1, M2 );
    
end );

##
InstallMethod( \=,
        "for homalg matrices",
        [ IsHomalgMatrix and IsIdentityMatrix, IsHomalgMatrix and IsIdentityMatrix ],
        
  function( M1, M2 )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: IsIdentityMatrix = IsIdentityMatrix", "\033[0m" );
    
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
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: Involution( IsZeroMatrix )", "\033[0m" );
    
    return HomalgZeroMatrix( NrColumns( M ), NrRows( M ), HomalgRing( M ) );
    
end );

##
InstallMethod( Involution,
        "for homalg matrices",
        [ IsHomalgMatrix and IsIdentityMatrix ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: Involution( IsIdentityMatrix )", "\033[0m" );
    
    return M;
    
end );

#-----------------------------------
# CertainRows
#-----------------------------------

##
InstallMethod( CertainRows,
        "for homalg matrices",
        [ IsHomalgMatrix, IsList ], 10001,
        
  function( M, plist )
    
    if not IsSubset( [ 1 .. NrRows( M ) ], plist ) then
        Error( "the list of row positions ", plist, " must be in the range [ 1 .. ", NrRows( M ), " ]\n" );
    fi;
    
    if NrRows( M ) = 0 or plist = [ 1 .. NrRows( M ) ] then
        return M;
    fi;
    
    TryNextMethod( );
    
end );

#-----------------------------------
# CertainColumns
#-----------------------------------

##
InstallMethod( CertainColumns,
        "for homalg matrices",
        [ IsHomalgMatrix, IsList ], 10001,
        
  function( M, plist )
    
    if not IsSubset( [ 1 .. NrColumns( M ) ], plist ) then
        Error( "the list of column positions ", plist, " must be in the range [ 1 .. ", NrColumns( M ), " ]\n" );
    fi;
    
    if NrColumns( M ) = 0 or plist = [ 1 .. NrColumns( M ) ] then
        return M;
    fi;
    
    TryNextMethod( );
    
end );

#-----------------------------------
# UnionOfRows
#-----------------------------------

##
InstallMethod( UnionOfRows,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ], 10001,
        
  function( A, B )
    
    if NrColumns( A ) <> NrColumns( B ) then
        Error( "the two matrices are not stackable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrColumns( B ), "\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( UnionOfRows,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and IsEmptyMatrix ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: UnionOfRows( IsHomalgMatrix, IsEmptyMatrix )", "\033[0m" );
    
    return A;
    
end );

##
InstallMethod( UnionOfRows,
        "of two homalg matrices",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: UnionOfRows( IsEmptyMatrix, IsHomalgMatrix )", "\033[0m" );
    
    return B;
    
end );

##
InstallMethod( UnionOfRows,
        "of two homalg matrices",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix and IsEmptyMatrix ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: UnionOfRows( IsEmptyMatrix, IsEmptyMatrix )", "\033[0m" );
    
    return HomalgZeroMatrix( NrRows( A ) + NrRows( B ), NrColumns( A ), HomalgRing( A ) );
    
end );

#-----------------------------------
# UnionOfColumns
#-----------------------------------

##
InstallMethod( UnionOfColumns,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ], 10001,
        
  function( A, B )
    
    if NrRows( A ) <> NrRows( B ) then
        Error( "the two matrices are not augmentable, since the first one has ", NrRows( A ), " row(s), while the second ", NrRows( B ), "\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( UnionOfColumns,
        "of two homalg matrices",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: UnionOfColumns( IsEmptyMatrix, IsHomalgMatrix )", "\033[0m" );
    
    return B;
    
end );

##
InstallMethod( UnionOfColumns,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and IsEmptyMatrix ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: UnionOfColumns( IsHomalgMatrix, IsEmptyMatrix )", "\033[0m" );
    
    return A;
    
end );

##
InstallMethod( UnionOfColumns,
        "of two homalg matrices",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix and IsEmptyMatrix ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: UnionOfColumns( IsEmptyMatrix, IsEmptyMatrix )", "\033[0m" );
    
    return HomalgZeroMatrix( NrRows( A ), NrColumns( A ) + NrColumns( B ), HomalgRing( A ) );
    
end );

#-----------------------------------
# DiagMat
#-----------------------------------

##
InstallMethod( DiagMat,
        "of homalg matrices",
        [ IsHomogeneousList ], 10001,
        
  function( l )
    
    if l = [ ] then
        Error( "recieved an empty list\n" );
    fi;
    
    if not ForAll( l, IsHomalgMatrix ) then
        Error( "at least one of the matrices in the list is not a homalg matrix\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( DiagMat,
        "of homalg matrices",
        [ IsHomogeneousList ], 2,
        
  function( l )
    local R;
    
    if ForAll( l, HasIsIdentityMatrix and IsIdentityMatrix ) then
        
        R := HomalgRing( l[1] );
        
        Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: DiagMat( [ identity matrices ] )", "\033[0m" );
        
        return HomalgIdentityMatrix( Sum( List( l, NrRows ) ), Sum( List( l, NrColumns ) ), R );
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( DiagMat,
        "of homalg matrices",
        [ IsHomogeneousList ], 2,
        
  function( l )
    local R;
    
    if ForAll( l, HasIsZeroMatrix and IsZeroMatrix ) then
        
        R := HomalgRing( l[1] );
        
        Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: DiagMat( [ zero matrices ] )", "\033[0m" );
        
        return HomalgZeroMatrix( Sum( List( l, NrRows ) ), Sum( List( l, NrColumns ) ), R );
        
    fi;
    
    TryNextMethod( );
    
end );

#-----------------------------------
# KroneckerMat
#-----------------------------------

##
InstallMethod( KroneckerMat,
        "of homalg matrices",
        [ IsHomalgMatrix and IsIdentityMatrix, IsHomalgMatrix ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: KroneckerMat( IsIdentityMatrix, IsHomalgMatrix )", "\033[0m" );
    
    return DiagMat( ListWithIdenticalEntries( NrRows( A ), B ) );
    
end );

##
InstallMethod( KroneckerMat,
        "of homalg matrices",
        [ IsHomalgMatrix and IsZeroMatrix, IsHomalgMatrix ],
        
  function( A, B )
    local R;
    
    R := HomalgRing( A );
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: KroneckerMat( IsZeroMatrix, IsHomalgMatrix )", "\033[0m" );
    
    return HomalgZeroMatrix( NrRows( A ) * NrRows( B ), NrColumns( A ) * NrColumns( B ), R );
    
end );

##
InstallMethod( KroneckerMat,
        "of homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and IsZeroMatrix ],
        
  function( A, B )
    local R;
    
    R := HomalgRing( A );
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: KroneckerMat( IsHomalgMatrix, IsZeroMatrix )", "\033[0m" );
    
    return HomalgZeroMatrix( NrRows( A ) * NrRows( B ), NrColumns( A ) * NrColumns( B ), R );
    
end );

#-----------------------------------
# MulMat
#-----------------------------------

##
InstallMethod( \*,
        "of homalg matrices with ring elements",
        [ IsRingElement and IsZero, IsHomalgMatrix ],
        
  function( a, A )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: IsZero * IsHomalgMatrix", "\033[0m" );
    
    return 0 * A;
    
end );

##
InstallMethod( \*,
        "of homalg matrices with ring elements",
        [ IsRingElement and IsOne, IsHomalgMatrix ],
        
  function( a, A )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: IsOne * IsHomalgMatrix", "\033[0m" );
    
    return A;
    
end );

##
InstallMethod( \*,
        "of homalg matrices",
        [ IsRingElement, IsHomalgMatrix and IsZeroMatrix ],
        
  function( a, A )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: IsRingElement * IsZeroMatrix", "\033[0m" );
    
    return A;
    
end );

#-----------------------------------
# AddMat
#-----------------------------------

##
InstallMethod( \+,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ], 10001,
        
  function( A, B )
    
    if NrRows( A ) <> NrRows( B ) then
        Error( "the two matrices are not summable, since the first one has ", NrRows( A ), " row(s), while the second ", NrRows( B ), "\n" );
    fi;
    
    if NrColumns( A ) <> NrColumns( B ) then
        Error( "the two matrices are not summable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrColumns( B ), "\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \+,
        "of two homalg matrices",
        [ IsHomalgMatrix and IsZeroMatrix, IsHomalgMatrix ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: IsZeroMatrix + IsHomalgMatrix", "\033[0m", "	", NrRows( A ), " x ", NrColumns( A ) );
    
    return B;
    
end );

##
InstallMethod( \+,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and IsZeroMatrix ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: IsHomalgMatrix + IsZeroMatrix", "\033[0m", "	", NrRows( A ), " x ", NrColumns( A ) );
    
    return A;
    
end );

#-----------------------------------
# AdditiveInverseMutable
#-----------------------------------

## a synonym of `-<elm>':
InstallMethod( AdditiveInverseMutable,
        "of homalg matrices",
        [ IsHomalgMatrix and IsZeroMatrix ],
        
  function( A )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: -IsZeroMatrix", "\033[0m" );
    
    return A;
    
end );

#-----------------------------------
# SubMat
#-----------------------------------

##
InstallMethod( \-,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ], 10001,
        
  function( A, B )
    
    if NrRows( A ) <> NrRows( B ) then
        Error( "the two matrices are not subtractable, since the first one has ", NrRows( A ), " row(s), while the second ", NrRows( B ), "\n" );
    fi;
    
    if NrColumns( A ) <> NrColumns( B ) then
        Error( "the two matrices are not subtractable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrColumns( B ), "\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \-,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ], 1000,
        
  function( A, B )
    
    if IsIdenticalObj( A, B ) then
        
        Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: M - M", "\033[0m", "	", NrRows( A ), " x ", NrColumns( A ) );
        
        return 0 * A;
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \-,
        "of two homalg matrices",
        [ IsHomalgMatrix and IsZeroMatrix, IsHomalgMatrix ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: IsZeroMatrix - IsHomalgMatrix", "\033[0m", "	", NrRows( A ), " x ", NrColumns( A ) );
    
    return -B;
    
end );

##
InstallMethod( \-,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and IsZeroMatrix ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: IsHomalgMatrix - IsZeroMatrix", "\033[0m", "	", NrRows( A ), " x ", NrColumns( A ) );
    
    return A;
    
end );

#-----------------------------------
# Compose
#-----------------------------------

##
InstallMethod( \*,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ], 10001,
        
  function( A, B )
    
    if NrColumns( A ) <> NrRows( B ) then
        Error( "the two matrices are not composable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrRows( B ), " row(s)\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \*,
        "of two homalg matrices",
        [ IsHomalgMatrix and IsZeroMatrix, IsHomalgMatrix ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: IsZeroMatrix * IsHomalgMatrix", "\033[0m", "	", NrRows( A ), " x ", NrColumns( A ), " x ", NrColumns( B ) );
    
    if NrRows( B ) = NrColumns( B ) then
        return A;
    else
        return HomalgZeroMatrix( NrRows( A ), NrColumns( B ), HomalgRing( A ) );
    fi;
    
end );

##
InstallMethod( \*,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and IsZeroMatrix ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: IsHomalgMatrix * IsZeroMatrix", "\033[0m", "	", NrRows( A ), " x ", NrColumns( A ), " x ", NrColumns( B ) );
    
    if NrRows( A ) = NrColumns( A ) then
        return B;
    else
        return HomalgZeroMatrix( NrRows( A ), NrColumns( B ), HomalgRing( B ) );
    fi;
    
end );

##
InstallMethod( \*,
        "of two homalg matrices",
        [ IsHomalgMatrix and IsIdentityMatrix, IsHomalgMatrix ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: IsIdentityMatrix * IsHomalgMatrix", "\033[0m", "	", NrRows( A ), " x ", NrColumns( A ), " x ", NrColumns( B ) );
    
    return B;
    
end );

##
InstallMethod( \*,
        "of two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and IsIdentityMatrix ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: IsHomalgMatrix * IsIdentityMatrix", "\033[0m", "	", NrRows( A ), " x ", NrColumns( A ), " x ", NrColumns( B ) );
    
    return A;
    
end );

#-----------------------------------
# LeftInverse
#-----------------------------------

##
InstallMethod( LeftInverse,
        "for homalg matrices",
        [ IsHomalgMatrix ], 10001,
        
  function( M )
    
    if NrRows( M ) < NrColumns( M ) then
        Error( "the number of rows ", NrRows( M ), " is smaller than the number of columns ", NrColumns( M ), "\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( LeftInverse,
        "for homalg matrices",
        [ IsHomalgMatrix and IsIdentityMatrix ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: LeftInverse( IsIdentityMatrix )", "\033[0m" );
    
    return M;
    
end );

##
InstallMethod( LeftInverse,
        "for homalg matrices",
        [ IsHomalgMatrix and IsSubidentityMatrix ],
        
  function( M )
    local C;
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: LeftInverse( IsSubidentityMatrix )", "\033[0m" );
    
    C := Involution( M );
    
    SetEvalRightInverse( M, C );
    
    return C;
    
end );

##
InstallMethod( LeftInverse,
        "for homalg matrices",
        [ IsHomalgMatrix and IsZeroMatrix ],
        
  function( M )
    
    if NrColumns( M ) = 0 then
        
        Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: LeftInverse( ? x 0 -- IsZeroMatrix )", "\033[0m" );
        
        return HomalgZeroMatrix( 0, NrRows( M ), HomalgRing( M ) );
        
    else
        Error( "a zero matrix with positive number of columns has no left inverse!" );
    fi;
    
end );

#-----------------------------------
# RightInverse
#-----------------------------------

##
InstallMethod( RightInverse,
        "for homalg matrices",
        [ IsHomalgMatrix ], 10001,
        
  function( M )
    
    if NrColumns( M ) < NrRows( M ) then
        Error( "the number of columns ", NrColumns( M ), " is smaller than the number of rows ", NrRows( M ), "\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( RightInverse,
        "for homalg matrices",
        [ IsHomalgMatrix and IsIdentityMatrix ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: RightInverse( IsIdentityMatrix )", "\033[0m" );
    
    return M;
    
end );

##
InstallMethod( RightInverse,
        "for homalg matrices",
        [ IsHomalgMatrix and IsSubidentityMatrix ],
        
  function( M )
    local C;
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: RightInverse( IsSubidentityMatrix )", "\033[0m" );
    
    C := Involution( M );
    
    SetEvalLeftInverse( M, C );
    
    return C;
    
end );

##
InstallMethod( RightInverse,
        "for homalg matrices",
        [ IsHomalgMatrix and IsZeroMatrix ],
        
  function( M )
    
    if NrRows( M ) = 0 then
        
        Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: RightInverse( 0 x ? -- IsZeroMatrix )", "\033[0m" );
        
        return HomalgZeroMatrix( NrColumns( M ), 0, HomalgRing( M ) );
        
    else
        Error( "a zero matrix with positive number of rows has no left inverse!" );
    fi;
    
end );

#-----------------------------------
# RowRankOfMatrix
#-----------------------------------

##
InstallMethod( RowRankOfMatrix,			 	## FIXME: make an extra InstallImmediateMethod when NonZeroRows( M ) is set
        [ IsHomalgMatrix and IsTriangularMatrix ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: RowRankOfMatrix( IsTriangularMatrix )", "\033[0m" );
    
    return Length( NonZeroRows( M ) );
        
end );

#-----------------------------------
# ColumnRankOfMatrix
#-----------------------------------

##
InstallMethod( ColumnRankOfMatrix,			## FIXME: make an extra InstallImmediateMethod when NonZeroColumns( M ) is set
        [ IsHomalgMatrix and IsTriangularMatrix ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: ColumnRankOfMatrix( IsTriangularMatrix )", "\033[0m" );
    
    return Length( NonZeroColumns( M ) );
        
end );

#-----------------------------------
# BasisOfRowModule
#-----------------------------------

##
InstallMethod( BasisOfRowModule,
        "for homalg matrices",
        [ IsHomalgMatrix and IsIdentityMatrix ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: BasisOfRowModule( IsIdentityMatrix )", "\033[0m" );
    
    return M;
    
end );

##
InstallMethod( BasisOfRowModule,
        "for homalg matrices",
        [ IsHomalgMatrix and IsZeroMatrix ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: BasisOfRowModule( IsZeroMatrix )", "\033[0m" );
    
    return HomalgZeroMatrix( 0, NrColumns( M ), HomalgRing( M ) );
    
end );

#-----------------------------------
# BasisOfColumnModule
#-----------------------------------

##
InstallMethod( BasisOfColumnModule,
        "for homalg matrices",
        [ IsHomalgMatrix and IsIdentityMatrix ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: BasisOfColumnModule( IsIdentityMatrix )", "\033[0m" );
    
    return M;
    
end );

##
InstallMethod( BasisOfColumnModule,
        "for homalg matrices",
        [ IsHomalgMatrix and IsZeroMatrix ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: BasisOfColumnModule( IsZeroMatrix )", "\033[0m" );
    
    return HomalgZeroMatrix( NrRows( M ), 0, HomalgRing( M ) );
    
end );

#-----------------------------------
# BasisOfRowsCoeff
#-----------------------------------

##
InstallMethod( BasisOfRowsCoeff,
        "for homalg matrices",
        [ IsHomalgMatrix and IsIdentityMatrix, IsHomalgMatrix and IsVoidMatrix ],
        
  function( M, T )
    local R;
    
    R := HomalgRing( M );
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: BasisOfRowsCoeff( IsIdentityMatrix, T )", "\033[0m" );
    
    SetPreEval( T, HomalgIdentityMatrix( NrRows( M ), R ) ); ResetFilterObj( T, IsVoidMatrix );
    
    return M;
    
end );

##
InstallMethod( BasisOfRowsCoeff,
        "for homalg matrices",
        [ IsHomalgMatrix and IsZeroMatrix, IsHomalgMatrix and IsVoidMatrix ],
        
  function( M, T )
    local R;
    
    R := HomalgRing( M );
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: BasisOfRowsCoeff( IsZeroMatrix, T )", "\033[0m" );
    
    SetPreEval( T, HomalgIdentityMatrix( 0, R ) ); ResetFilterObj( T, IsVoidMatrix );
    
    return HomalgZeroMatrix( 0, NrColumns( M ), R );
    
end );

#-----------------------------------
# BasisOfColumnsCoeff
#-----------------------------------

##
InstallMethod( BasisOfColumnsCoeff,
        "for homalg matrices",
        [ IsHomalgMatrix and IsIdentityMatrix, IsHomalgMatrix and IsVoidMatrix ],
        
  function( M, T )
    local R;
    
    R := HomalgRing( M );
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: BasisOfColumnsCoeff( IsIdentityMatrix, T )", "\033[0m" );
    
    SetPreEval( T, HomalgIdentityMatrix( NrColumns( M ), R ) ); ResetFilterObj( T, IsVoidMatrix );
    
    return M;
    
end );

##
InstallMethod( BasisOfColumnsCoeff,
        "for homalg matrices",
        [ IsHomalgMatrix and IsZeroMatrix, IsHomalgMatrix and IsVoidMatrix ],
        
  function( M, T )
    local R;
    
    R := HomalgRing( M );
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: BasisOfColumnsCoeff( IsZeroMatrix, T )", "\033[0m" );
    
    SetPreEval( T, HomalgIdentityMatrix( 0, R ) ); ResetFilterObj( T, IsVoidMatrix );
    
    return HomalgZeroMatrix( NrRows( M ), 0, R );
    
end );

#-----------------------------------
# DecideZeroRows
#-----------------------------------

##
InstallMethod( DecideZeroRows,
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ], 10001,
        
  function( L, B )
    
    if NrColumns( L ) <> NrColumns( B ) then
        Error( "the number of columns of the two matrices must coincide\n" );
    fi;
    
    if not IsIdenticalObj( HomalgRing( L ), HomalgRing( B ) ) then
        Error( "the rings of the two matrices are not identical\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( DecideZeroRows,
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and IsLeftInvertibleMatrix ],
        
  function( L, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: DecideZeroRows( IsHomalgMatrix, IsInvertibleMatrix )", "\033[0m" );
    
    return L;
    
end );

##
InstallMethod( DecideZeroRows,
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and IsZeroMatrix ],
        
  function( L, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: DecideZeroRows( IsHomalgMatrix, IsZeroMatrix )", "\033[0m" );
    
    return L;
    
end );

##
InstallMethod( DecideZeroRows,
        "for homalg matrices",
        [ IsHomalgMatrix and IsZeroMatrix, IsHomalgMatrix ],
        
  function( L, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: DecideZeroRows( IsZeroMatrix, IsHomalgMatrix )", "\033[0m" );
    
    return L;
    
end );

#-----------------------------------
# DecideZeroColumns
#-----------------------------------

##
InstallMethod( DecideZeroColumns,
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ], 10001,
        
  function( L, B )
    
    if NrRows( L ) <> NrRows( B ) then
        Error( "the number of rows of the two matrices must coincide\n" );
    fi;
    
    if not IsIdenticalObj( HomalgRing( L ), HomalgRing( B ) ) then
        Error( "the rings of the two matrices are not identical\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( DecideZeroColumns,
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and IsRightInvertibleMatrix ],
        
  function( L, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: DecideZeroColumns( IsHomalgMatrix, IsInvertibleMatrix )", "\033[0m" );
    
    return L;
    
end );

##
InstallMethod( DecideZeroColumns,
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and IsZeroMatrix ],
        
  function( L, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: DecideZeroColumns( IsHomalgMatrix, IsZeroMatrix )", "\033[0m" );
    
    return L;
    
end );

##
InstallMethod( DecideZeroColumns,
        "for homalg matrices",
        [ IsHomalgMatrix and IsZeroMatrix, IsHomalgMatrix ],
        
  function( L, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: DecideZeroColumns( IsZeroMatrix, IsHomalgMatrix )", "\033[0m" );
    
    return L;
    
end );

#-----------------------------------
# SyzygiesGeneratorsOfRows
#-----------------------------------

##
InstallMethod( SyzygiesGeneratorsOfRows,
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ], 10001,
        
  function( M1, M2 )
    
    if NrColumns( M1 ) <> NrColumns( M2 ) then
        Error( "the number of columns of the two matrices must coincide\n" );
    fi;
    
    if not IsIdenticalObj( HomalgRing( M1 ), HomalgRing( M2 ) ) then
        Error( "the rings of the two matrices are not identical\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( SyzygiesGeneratorsOfRows,
        "for homalg matrices",
        [ IsHomalgMatrix and IsFullRowRankMatrix ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: SyzygiesGeneratorsOfRows( IsFullRowRankMatrix )", "\033[0m" );
    
    return HomalgZeroMatrix( 0, NrRows( M ), HomalgRing( M ) );
    
end );

##
InstallMethod( SyzygiesGeneratorsOfRows,
        "for homalg matrices",
        [ IsHomalgMatrix and IsIdentityMatrix, IsHomalgMatrix ],
        
  function( M1, M2 )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: SyzygiesGeneratorsOfRows(IsIdentityMatrix,IsHomalgMatrix)", "\033[0m" );
    
    return M2;
    
end );

##
InstallMethod( SyzygiesGeneratorsOfRows,
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and IsZeroMatrix ],
        
  function( M1, M2 )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: SyzygiesGeneratorsOfRows(IsHomalgMatrix,IsZeroMatrix)", "\033[0m" );
    
    return SyzygiesGeneratorsOfRows( M1 );
    
end );

##
InstallMethod( SyzygiesGeneratorsOfRows,
        "for homalg matrices",
        [ IsHomalgMatrix and IsZeroMatrix ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: SyzygiesGeneratorsOfRows( IsZeroMatrix )", "\033[0m" );
    
    return HomalgIdentityMatrix( NrRows( M ), HomalgRing( M ) );
    
end );

##
InstallMethod( SyzygiesGeneratorsOfRows,
        "for homalg matrices",
        [ IsHomalgMatrix and IsZeroMatrix, IsHomalgMatrix ],
        
  function( M1, M2 )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: SyzygiesGeneratorsOfRows(IsZeroMatrix,IsHomalgMatrix)", "\033[0m" );
    
    return HomalgIdentityMatrix( NrRows( M1 ), HomalgRing( M1 ) );
    
end );

#-----------------------------------
# SyzygiesGeneratorsOfColumns
#-----------------------------------

##
InstallMethod( SyzygiesGeneratorsOfColumns,
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ], 10001,
        
  function( M1, M2 )
    
    if NrRows( M1 ) <> NrRows( M2 ) then
        Error( "the number of rows of the two matrices must coincide\n" );
    fi;
    
    if not IsIdenticalObj( HomalgRing( M1 ), HomalgRing( M2 ) ) then
        Error( "the rings of the two matrices are not identical\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( SyzygiesGeneratorsOfColumns,
        "for homalg matrices",
        [ IsHomalgMatrix and IsFullColumnRankMatrix ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: SyzygiesGeneratorsOfColumns( IsFullColumnRankMatrix )", "\033[0m" );
    
    return HomalgZeroMatrix( NrColumns( M ), 0, HomalgRing( M ) );
    
end );

##
InstallMethod( SyzygiesGeneratorsOfColumns,
        "for homalg matrices",
        [ IsHomalgMatrix and IsIdentityMatrix, IsHomalgMatrix ],
        
  function( M1, M2 )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: SyzygiesGeneratorsOfCols(IsIdentityMatrix,IsHomalgMatrix)", "\033[0m" );
    
    return M2;
    
end );

##
InstallMethod( SyzygiesGeneratorsOfColumns,
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and IsZeroMatrix ],
        
  function( M1, M2 )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: SyzygiesGeneratorsOfCols(IsHomalgMatrix,IsZeroMatrix)", "\033[0m" );
    
    return SyzygiesGeneratorsOfColumns( M1 );
    
end );

##
InstallMethod( SyzygiesGeneratorsOfColumns,
        "for homalg matrices",
        [ IsHomalgMatrix and IsZeroMatrix ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: SyzygiesGeneratorsOfColumns( IsZeroMatrix )", "\033[0m" );
    
    return HomalgIdentityMatrix( NrColumns( M ), HomalgRing( M ) );
    
end );

##
InstallMethod( SyzygiesGeneratorsOfColumns,
        "for homalg matrices",
        [ IsHomalgMatrix and IsZeroMatrix, IsHomalgMatrix ],
        
  function( M1, M2 )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: SyzygiesGeneratorsOfCols(IsZeroMatrix,IsHomalgMatrix)", "\033[0m" );
    
    return HomalgIdentityMatrix( NrColumns( M1 ), HomalgRing( M1 ) );
    
end );

