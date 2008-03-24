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

##
InstallTrueMethod( IsFullRowRankMatrix, IsHomalgMatrix and IsRightInvertibleMatrix );

##
InstallTrueMethod( IsFullColumnRankMatrix, IsHomalgMatrix and IsLeftInvertibleMatrix );

##
InstallTrueMethod( IsRightInvertibleMatrix, IsHomalgMatrix and IsInvertibleMatrix );

##
InstallTrueMethod( IsLeftInvertibleMatrix, IsHomalgMatrix and IsInvertibleMatrix );

## a surjective and an injective morphism between two free modules of finite rank is invertible
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
InstallImmediateMethod( IsInitialMatrix,
        IsHomalgMatrix, 0,
        
  function( M )
    
    if not HasIsInitialMatrix( M ) then
        return false;
    fi;
    
    ## no need for a TryNextMethod() here ;)
    
end );

##
InstallImmediateMethod( IsVoidMatrix,
        IsHomalgMatrix, 0,
        
  function( M )
    
    if not HasIsVoidMatrix( M ) then
        return false;
    fi;
    
    ## no need for a TryNextMethod() here ;)
    
end );

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
    
    return HomalgMatrix( "zero", NrColumns( M ), NrRows( M ), HomalgRing( M ) );
    
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
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: UnionOfRows( IsHomalgMatrix, IsEmptyMatrix )", "\033[0m" );
    
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
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: UnionOfRows( IsEmptyMatrix, IsHomalgMatrix )", "\033[0m" );
    
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
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: UnionOfRows( IsEmptyMatrix, IsEmptyMatrix )", "\033[0m" );
    
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
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: UnionOfColumns( IsEmptyMatrix, IsHomalgMatrix )", "\033[0m" );
    
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
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: UnionOfColumns( IsHomalgMatrix, IsEmptyMatrix )", "\033[0m" );
    
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
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: UnionOfColumns( IsEmptyMatrix, IsEmptyMatrix )", "\033[0m" );
    
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
        [ IsHomalgMatrix and IsZeroMatrix, IsHomalgMatrix ],
        
  function( A, B )
    
    if NrRows( A ) <> NrRows( B ) then
        Error( "the two matrices are not summable, since the first one has ", NrRows( A ), " row(s), while the second ", NrRows( B ), "\n" );
    fi;
    
    if NrColumns( A ) <> NrColumns( B ) then
        Error( "the two matrices are not summable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrColumns( B ), "\n" );
    fi;
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: IsZeroMatrix + IsHomalgMatrix", "\033[0m", "	", NrRows( A ), " x ", NrColumns( A ) );
    
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
    
    if NrRows( A ) <> NrRows( B ) then
        Error( "the two matrices are not subtractable, since the first one has ", NrRows( A ), " row(s), while the second ", NrRows( B ), "\n" );
    fi;
    
    if NrColumns( A ) <> NrColumns( B ) then
        Error( "the two matrices are not subtractable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrColumns( B ), "\n" );
    fi;
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: IsZeroMatrix - IsHomalgMatrix", "\033[0m", "	", NrRows( A ), " x ", NrColumns( A ) );
    
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
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: IsHomalgMatrix - IsZeroMatrix", "\033[0m", "	", NrRows( A ), " x ", NrColumns( A ) );
    
    return A;
    
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
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: IsZeroMatrix * IsHomalgMatrix", "\033[0m", "	", NrRows( A ), " x ", NrColumns( A ), " x ", NrColumns( B ) );
    
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
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: IsHomalgMatrix * IsZeroMatrix", "\033[0m", "	", NrRows( A ), " x ", NrColumns( A ), " x ", NrColumns( B ) );
    
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
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: IsIdentityMatrix * IsHomalgMatrix", "\033[0m", "	", NrRows( A ), " x ", NrColumns( A ), " x ", NrColumns( B ) );
    
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
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: IsHomalgMatrix * IsIdentityMatrix", "\033[0m", "	", NrRows( A ), " x ", NrColumns( A ), " x ", NrColumns( B ) );
    
    return A;
    
end );

#-----------------------------------
# LeftInverse
#-----------------------------------

##
InstallMethod( LeftInverse,
        "for homalg matrices",
        [ IsHomalgMatrix and IsIdentityMatrix ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: LeftInverse( IsIdentityMatrix )", "\033[0m" );
    
    return M;
    
end );

#-----------------------------------
# RightInverse
#-----------------------------------

##
InstallMethod( RightInverse,
        "for homalg matrices",
        [ IsHomalgMatrix and IsIdentityMatrix ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "LIMAT: RightInverse( IsIdentityMatrix )", "\033[0m" );
    
    return M;
    
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

