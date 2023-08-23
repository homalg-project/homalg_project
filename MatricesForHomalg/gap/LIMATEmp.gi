# SPDX-License-Identifier: GPL-2.0-or-later
# MatricesForHomalg: Matrices for the homalg project
#
# Implementations
#

##
InstallImmediateMethod( IsOne,
        IsHomalgMatrix and HasNumberRows and HasNumberColumns, 0,
        
  function( M )
    
    if NumberRows( M ) = 0 and NumberColumns( M ) = 0 then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsEmptyMatrix,
        IsHomalgMatrix and HasNumberRows and HasNumberColumns, 0,
        
  function( M )
    
    if NumberRows( M ) = 0 or NumberColumns( M ) = 0 then
        return true;
    else
        return false;
    fi;
    
end );

##
InstallImmediateMethod( IsZero,
        IsHomalgMatrix and HasIsEmptyMatrix and IsEmptyMatrix, 0,
        
  function( M )
    
    return true;
    
end );


##
InstallImmediateMethod( IsLeftInvertibleMatrix,
        IsHomalgMatrix and HasNumberColumns, 0,
        
  function( M )
    
    if NumberColumns( M ) = 0 then
        return true;
    fi;
    
    TryNextMethod( );
    
end );


##
InstallImmediateMethod( ZeroRows,
        IsHomalgMatrix and IsEmptyMatrix and HasNumberRows, 0,
        
  function( M )
    
    return [ 1 .. NumberRows( M ) ];
        
end );


##
InstallImmediateMethod( ZeroColumns,
        IsHomalgMatrix and IsEmptyMatrix and HasNumberColumns, 0,
        
  function( M )
    
    return [ 1 .. NumberColumns( M ) ];
        
end );

##
InstallMethod( UnionOfRowsOp,
        "LIMAT: of a homalg ring, an integer and a list of homalg matrices (check input, drop empty matrices)",
        [ IsHomalgRing, IsInt, IsList ], 10001,
        
  function( R, nr_cols, L )
    local c, filtered_L;
    
    if not ForAll( L, IsHomalgMatrix ) then
        Error( "L must be a list of homalg matrices" );
    fi;
    
    c := nr_cols;
    
    if Length( L ) = 1 then
        
        Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "UnionOfRows( [ single matrix ] )", "\033[0m" );
        
        return L[1];
        
    fi;
    
    if not ForAll( L, x -> IsIdenticalObj( HomalgRing( x ), R ) ) then
        Error( "the matrices are not defined over identically the same ring\n" );
    fi;
    
    if not ForAll( L, x -> NumberColumns( x ) = c ) then
        Error( "the matrices are not stackable, since they do not all have the same number of columns\n" );
    fi;
    
    filtered_L := Filtered( L, x -> not IsEmptyMatrix( x ) );
    
    if Length( filtered_L ) = 0 then
        
        Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "UnionOfRows( [ empty matrices ] )", "\033[0m" );
        
        return HomalgZeroMatrix( Sum( List( L, NumberRows ) ), c, R );
        
    elif Length( filtered_L ) <> Length( L ) then
        
        Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "UnionOfRows( <dropped empty matrices> )", "\033[0m" );
        
        return UnionOfRowsOp( R, nr_cols, filtered_L );
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \=,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix and IsEmptyMatrix ],
        
  function( M1, M2 )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsZero(Matrix) = IsZero(Matrix)", "\033[0m" );
    
    return AreComparableMatrices( M1, M2 );
    
end );

##
InstallMethod( UnionOfColumnsOp,
        "LIMAT: of a homalg ring, an integer and a list of homalg matrices (check input, drop empty matrices)",
        [ IsHomalgRing, IsInt, IsList ], 10001,
        
  function( R, nr_rows, L )
    local r, filtered_L;
    
    if not ForAll( L, IsHomalgMatrix ) then
        Error( "L must be a list of homalg matrices" );
    fi;
    
    r := nr_rows;
    
    if Length( L ) = 1 then
        
        Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "UnionOfColumns( [ single matrix ] )", "\033[0m" );
        
        return L[1];
        
    fi;
    
    if not ForAll( L, x -> IsIdenticalObj( HomalgRing( x ), R ) ) then
        Error( "the matrices are not defined over identically the same ring\n" );
    fi;
    
    if not ForAll( L, x -> NumberRows( x ) = r ) then
        Error( "the matrices are not augmentable, since they do not all have the same number of rows\n" );
    fi;
    
    filtered_L := Filtered( L, x -> not IsEmptyMatrix( x ) );
    
    if Length( filtered_L ) = 0 then
        
        Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "UnionOfColumns( [ empty matrices ] )", "\033[0m" );
        
        return HomalgZeroMatrix( r, Sum( List( L, NumberColumns ) ), R );
        
    elif Length( filtered_L ) <> Length( L ) then
        
        Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "UnionOfColumns( <dropped empty matrices> )", "\033[0m" );
        
        return UnionOfColumnsOp( R, nr_rows, filtered_L );
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( DiagMat,
        "LIMAT: of a homalg ring and a list of homalg matrices",
        [ IsHomalgRing, IsHomogeneousList ], 2,
        
  function( R, l )
    
    if ForAll( l, HasIsZero and IsEmptyMatrix ) then
        
        Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DiagMat( [ zero matrices ] )", "\033[0m" );
        
        return HomalgZeroMatrix( Sum( List( l, NumberRows ) ), Sum( List( l, NumberColumns ) ), R );
        
    fi;
    
    TryNextMethod( );
    
end );


##
InstallMethod( KroneckerMat,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix ], 1001,  ## FIXME: this must be ranked higher than the "KroneckerMat( IsOne, IsHomalgMatrix )", why?
        
  function( A, B )
    local R;
    
    R := HomalgRing( A );
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "KroneckerMat( IsZero(Matrix), IsHomalgMatrix )", "\033[0m" );
    
    return HomalgZeroMatrix( NumberRows( A ) * NumberRows( B ), NumberColumns( A ) * NumberColumns( B ), R );
    
end );

##
InstallMethod( KroneckerMat,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsEmptyMatrix ],
        
  function( A, B )
    local R;
    
    R := HomalgRing( A );
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "KroneckerMat( IsHomalgMatrix, IsZero(Matrix) )", "\033[0m" );
    
    return HomalgZeroMatrix( NumberRows( A ) * NumberRows( B ), NumberColumns( A ) * NumberColumns( B ), R );
    
end );

##
InstallMethod( DualKroneckerMat,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix ], 1001,  ## FIXME: this must be ranked higher than the "DualKroneckerMat( IsOne, IsHomalgMatrix )", why?
        
  function( A, B )
    local R;
    
    R := HomalgRing( A );
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DualKroneckerMat( IsZero(Matrix), IsHomalgMatrix )", "\033[0m" );
    
    return HomalgZeroMatrix( NumberRows( A ) * NumberRows( B ), NumberColumns( A ) * NumberColumns( B ), R );
    
end );

##
InstallMethod( DualKroneckerMat,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsEmptyMatrix ],
        
  function( A, B )
    local R;
    
    R := HomalgRing( A );
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DualKroneckerMat( IsHomalgMatrix, IsZero(Matrix) )", "\033[0m" );
    
    return HomalgZeroMatrix( NumberRows( A ) * NumberRows( B ), NumberColumns( A ) * NumberColumns( B ), R );
    
end );

##
InstallMethod( \*,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsRingElement, IsHomalgMatrix and IsEmptyMatrix ], 10001,
        
  function( a, A )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsRingElement * IsZero(Matrix)", "\033[0m" );
    
    return A;
    
end );

##
InstallMethod( \+,
        "LIMAT: for two homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsZero(Matrix) + IsHomalgMatrix", "\033[0m", "  ", NumberRows( A ), " x ", NumberColumns( A ) );
    
    return B;
    
end );

##
InstallMethod( \+,
        "LIMAT: for two homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsEmptyMatrix ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsHomalgMatrix + IsZero(Matrix)", "\033[0m", "  ", NumberRows( A ), " x ", NumberColumns( A ) );
    
    return A;
    
end );


## a synonym of `-<elm>':
InstallMethod( AdditiveInverseMutable,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix ],
        
  function( A )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "-IsZero(Matrix)", "\033[0m" );
    
    return A;
    
end );


##
InstallMethod( \-,
        "LIMAT: for two homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsZero(Matrix) - IsHomalgMatrix", "\033[0m", "  ", NumberRows( A ), " x ", NumberColumns( A ) );
    
    return -B;
    
end );

##
InstallMethod( \-,
        "LIMAT: for two homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsEmptyMatrix ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsHomalgMatrix - IsZero(Matrix)", "\033[0m", "  ", NumberRows( A ), " x ", NumberColumns( A ) );
    
    return A;
    
end );

##
InstallMethod( \*,
        "LIMAT: for two homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix ], 17001,
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsZero(Matrix) * IsHomalgMatrix", "\033[0m", "  ", NumberRows( A ), " x ", NumberColumns( A ), " x ", NumberColumns( B ) );
    
    if NumberRows( B ) = NumberColumns( B ) then
        return A;
    else
        return HomalgZeroMatrix( NumberRows( A ), NumberColumns( B ), HomalgRing( A ) );
    fi;
    
end );

##
InstallMethod( \*,
        "LIMAT: for two homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsEmptyMatrix ], 17001,
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsHomalgMatrix * IsZero(Matrix)", "\033[0m", "  ", NumberRows( A ), " x ", NumberColumns( A ), " x ", NumberColumns( B ) );
    
    if NumberRows( A ) = NumberColumns( A ) then
        return B;
    else
        return HomalgZeroMatrix( NumberRows( A ), NumberColumns( B ), HomalgRing( B ) );
    fi;
    
end );

##
InstallMethod( RightDivide,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix ],
        
  function( B, A )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "RightDivide( IsZero(Matrix), IsHomalgMatrix )", "\033[0m" );
    
    return HomalgZeroMatrix( NumberRows( B ), NumberRows( A ), HomalgRing( B ) );
    
end );

##
InstallMethod( RightDivide,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix, IsHomalgMatrix ],
        
  function( B, A, L )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "RightDivide( IsZero(Matrix), IsHomalgMatrix, IsHomalgMatrix )", "\033[0m" );
    
    return HomalgZeroMatrix( NumberRows( B ), NumberRows( A ), HomalgRing( B ) );
    
end );

##
InstallMethod( LeftDivide,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsEmptyMatrix ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "LeftDivide( IsHomalgMatrix, IsZero(Matrix) )", "\033[0m" );
    
    return HomalgZeroMatrix( NumberColumns( A ), NumberColumns( B ), HomalgRing( B ) );
    
end );

##
InstallMethod( LeftDivide,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix ],
        
  function( A, B, L )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "LeftDivide( IsHomalgMatrix, IsZero(Matrix), IsHomalgMatrix )", "\033[0m" );
    
    return HomalgZeroMatrix( NumberColumns( A ), NumberColumns( B ), HomalgRing( B ) );
    
end );

##
InstallMethod( LeftInverse,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix ],
        
  function( M )
    
    if NumberColumns( M ) = 0 then
        
        Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "LeftInverse( ? x 0 -- IsZero(Matrix) )", "\033[0m" );
        
        return HomalgZeroMatrix( 0, NumberRows( M ), HomalgRing( M ) );
        
    else
        Error( "a zero matrix with positive number of columns has no left inverse!\n" );
    fi;
    
end );

##
InstallMethod( RightInverse,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix ],
        
  function( M )
    
    if NumberRows( M ) = 0 then
        
        Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "RightInverse( 0 x ? -- IsZero(Matrix) )", "\033[0m" );
        
        return HomalgZeroMatrix( NumberColumns( M ), 0, HomalgRing( M ) );
        
    else
        Error( "a zero matrix with positive number of rows has no left inverse!\n" );
    fi;
    
end );

##
InstallMethod( BasisOfRowModule,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "BasisOfRowModule( IsZero(Matrix) )", "\033[0m" );
    
    return HomalgZeroMatrix( 0, NumberColumns( M ), HomalgRing( M ) );
    
end );

##
InstallMethod( BasisOfColumnModule,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "BasisOfColumnModule( IsZero(Matrix) )", "\033[0m" );
    
    return HomalgZeroMatrix( NumberRows( M ), 0, HomalgRing( M ) );
    
end );

##
InstallMethod( ReducedBasisOfRowModule,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "ReducedBasisOfRowModule( IsZero(Matrix) )", "\033[0m" );
    
    return HomalgZeroMatrix( 0, NumberColumns( M ), HomalgRing( M ) );
    
end );

##
InstallMethod( ReducedBasisOfColumnModule,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "ReducedBasisOfColumnModule( IsZero(Matrix) )", "\033[0m" );
    
    return HomalgZeroMatrix( NumberRows( M ), 0, HomalgRing( M ) );
    
end );

##
InstallMethod( BasisOfRowsCoeff,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix and IsVoidMatrix ],
        
  function( M, T )
    local R;
    
    R := HomalgRing( M );
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "BasisOfRowsCoeff( IsZero(Matrix), T )", "\033[0m" );
    
    SetPreEval( T, HomalgZeroMatrix( 0, NumberRows( M ), R ) ); ResetFilterObj( T, IsVoidMatrix );
    
    return HomalgZeroMatrix( 0, NumberColumns( M ), R );
    
end );

##
InstallMethod( BasisOfColumnsCoeff,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix and IsVoidMatrix ],
        
  function( M, T )
    local R;
    
    R := HomalgRing( M );
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "BasisOfColumnsCoeff( IsZero(Matrix), T )", "\033[0m" );
    
    SetPreEval( T, HomalgZeroMatrix( NumberColumns( M ), 0, R ) ); ResetFilterObj( T, IsVoidMatrix );
    
    return HomalgZeroMatrix( NumberRows( M ), 0, R );
    
end );

##
InstallMethod( DecideZeroRows,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsEmptyMatrix ],
        
  function( L, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DecideZeroRows( IsHomalgMatrix, IsZero(Matrix) )", "\033[0m" );
    
    ## calling IsZero( L ) causes too much unnecessary trafic
    #IsZero( L );
    
    return L;
    
end );

##
InstallMethod( DecideZeroRows,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix ],
        
  function( L, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DecideZeroRows( IsZero(Matrix), IsHomalgMatrix )", "\033[0m" );
    
    return L;
    
end );

##
InstallMethod( DecideZeroColumns,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsEmptyMatrix ],
        
  function( L, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DecideZeroColumns( IsHomalgMatrix, IsZero(Matrix) )", "\033[0m" );
    
    ## calling IsZero( L ) causes too much unnecessary trafic
    #IsZero( L );
    
    return L;
    
end );

##
InstallMethod( DecideZeroColumns,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix ],
        
  function( L, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DecideZeroColumns( IsZero(Matrix), IsHomalgMatrix )", "\033[0m" );
    
    return L;
    
end );

##
InstallMethod( DecideZeroRowsEffectively,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsEmptyMatrix, IsVoidMatrix ],
        
  function( A, B, T )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DecideZeroRowsEffectively( IsHomalgMatrix, IsZero(Matrix), T )", "\033[0m" );
    
    SetPreEval( T, HomalgZeroMatrix( NumberRows( A ), NumberRows( B ), HomalgRing( A ) ) ); ResetFilterObj( T, IsVoidMatrix );
    
    return A;
    
end );

##
InstallMethod( DecideZeroRowsEffectively,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix, IsVoidMatrix ],
        
  function( A, B, T )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DecideZeroRowsEffectively( IsZero(Matrix), IsHomalgMatrix, T )", "\033[0m" );
    
    SetPreEval( T, HomalgZeroMatrix( NumberRows( A ), NumberRows( B ), HomalgRing( A ) ) ); ResetFilterObj( T, IsVoidMatrix );
    
    return A;
    
end );

##
InstallMethod( DecideZeroColumnsEffectively,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsEmptyMatrix, IsVoidMatrix ],
        
  function( A, B, T )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DecideZeroColumnsEffectively( IsHomalgMatrix, IsZero(Matrix), T )", "\033[0m" );
    
    SetPreEval( T, HomalgZeroMatrix( NumberColumns( B ), NumberColumns( A ), HomalgRing( A ) ) ); ResetFilterObj( T, IsVoidMatrix );
    
    return A;
    
end );

##
InstallMethod( DecideZeroColumnsEffectively,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix, IsVoidMatrix ],
        
  function( A, B, T )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DecideZeroColumnsEffectively( IsZero(Matrix), IsHomalgMatrix, T )", "\033[0m" );
    
    SetPreEval( T, HomalgZeroMatrix( NumberColumns( B ), NumberColumns( A ), HomalgRing( A ) ) ); ResetFilterObj( T, IsVoidMatrix );
    
    return A;
    
end );

##
InstallMethod( SyzygiesGeneratorsOfRows,
        "LIMAT: for homalg matrices (IsOne)",
        [ IsHomalgMatrix and IsEmptyMatrix and HasNumberRows and HasNumberColumns, IsHomalgMatrix ],
        
  function( M1, M2 )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "SyzygiesGeneratorsOfRows(IsOne(Matrix),IsHomalgMatrix)", "\033[0m" );
    
    if NumberRows( M1 ) = NumberRows( M2 ) then
      return M2;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( SyzygiesGeneratorsOfRows,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsEmptyMatrix ],
        
  function( M1, M2 )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "SyzygiesGeneratorsOfRows(IsHomalgMatrix,IsZero(Matrix))", "\033[0m" );
    
    return SyzygiesGeneratorsOfRows( M1 );
    
end );

##
InstallMethod( SyzygiesGeneratorsOfRows,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "SyzygiesGeneratorsOfRows( IsZero(Matrix) )", "\033[0m" );
    
    return HomalgIdentityMatrix( NumberRows( M ), HomalgRing( M ) );
    
end );

##
InstallMethod( SyzygiesGeneratorsOfRows,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix ],
        
  function( M1, M2 )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "SyzygiesGeneratorsOfRows(IsZero(Matrix),IsHomalgMatrix)", "\033[0m" );
    
    return HomalgIdentityMatrix( NumberRows( M1 ), HomalgRing( M1 ) );
    
end );

##
InstallMethod( SyzygiesGeneratorsOfColumns,
        "LIMAT: for homalg matrices (IsOne)",
        [ IsHomalgMatrix and IsEmptyMatrix and HasNumberRows and HasNumberColumns, IsHomalgMatrix ],
        
  function( M1, M2 )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "SyzygiesGeneratorsOfColumns(IsOne(Matrix),IsHomalgMatrix)", "\033[0m" );
    
    if NumberRows( M1 ) = NumberColumns( M1 ) then
      return M2;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( SyzygiesGeneratorsOfColumns,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsEmptyMatrix ],
        
  function( M1, M2 )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "SyzygiesGeneratorsOfColumns(IsHomalgMatrix,IsZero(Matrix))", "\033[0m" );
    
    return SyzygiesGeneratorsOfColumns( M1 );
    
end );

##
InstallMethod( SyzygiesGeneratorsOfColumns,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "SyzygiesGeneratorsOfColumns( IsZero(Matrix) )", "\033[0m" );
    
    return HomalgIdentityMatrix( NumberColumns( M ), HomalgRing( M ) );
    
end );

##
InstallMethod( SyzygiesGeneratorsOfColumns,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix ],
        
  function( M1, M2 )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "SyzygiesGeneratorsOfColumns(IsZero(Matrix),IsHomalgMatrix)", "\033[0m" );
    
    return HomalgIdentityMatrix( NumberColumns( M1 ), HomalgRing( M1 ) );
    
end );

##
InstallMethod( ReducedSyzygiesGeneratorsOfRows,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "ReducedSyzygiesGeneratorsOfRows( IsZero(Matrix) )", "\033[0m" );
    
    return HomalgIdentityMatrix( NumberRows( M ), HomalgRing( M ) );
    
end );

##
InstallMethod( ReducedSyzygiesGeneratorsOfColumns,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "ReducedSyzygiesGeneratorsOfColumns( IsZero(Matrix) )", "\033[0m" );
    
    return HomalgIdentityMatrix( NumberColumns( M ), HomalgRing( M ) );
    
end );

##
InstallMethod( GetUnitPosition,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "GetUnitPosition( IsZero(Matrix) )", "\033[0m" );
    
    return fail;
    
end );

##
InstallMethod( GetUnitPosition,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomogeneousList ],
        
  function( M, poslist )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "GetUnitPosition( IsZero(Matrix), poslist )", "\033[0m" );
    
    return fail;
    
end );

##
InstallMethod( GetColumnIndependentUnitPositions,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix, IsList ],
        
  function( M, pos_list )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "GetColumnIndependentUnitPositions( IsZero(Matrix) )", "\033[0m" );
    
    return [ ];
    
end );

##
InstallMethod( GetRowIndependentUnitPositions,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix, IsList ],
        
  function( M, pos_list )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "GetRowIndependentUnitPositions( IsZero(Matrix) )", "\033[0m" );
    
    return [ ];
    
end );





