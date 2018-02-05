
##
InstallImmediateMethod( IsOne,
        IsHomalgMatrix and HasNrRows and HasNrColumns, 0,
        
  function( M )
    
    if NrRows( M ) = 0 and NrColumns( M ) = 0 then
        return true;
    fi;
    
    TryNextMethod( );
    
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
InstallImmediateMethod( IsZero,
        IsHomalgMatrix and HasIsEmptyMatrix and IsEmptyMatrix, 0,
        
  function( M )
    
    return true;
    
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
InstallImmediateMethod( ZeroRows,
        IsHomalgMatrix and IsEmptyMatrix and HasNrRows, 0,
        
  function( M )
    
    return [ 1 .. NrRows( M ) ];
        
end );


##
InstallImmediateMethod( ZeroColumns,
        IsHomalgMatrix and IsEmptyMatrix and HasNrColumns, 0,
        
  function( M )
    
    return [ 1 .. NrColumns( M ) ];
        
end );

##
InstallMethod( UnionOfRowsOp,
        "LIMAT: for two homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsEmptyMatrix ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "UnionOfRows( IsHomalgMatrix, IsEmptyMatrix )", "\033[0m" );
    
    return A;
    
end );

##
InstallMethod( UnionOfRowsOp,
        "LIMAT: for two homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "UnionOfRows( IsEmptyMatrix, IsHomalgMatrix )", "\033[0m" );
    
    return B;
    
end );

## without this method the above two methods will be called in the wrong context!!!
InstallMethod( UnionOfRowsOp,
        "LIMAT: for two homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix and IsEmptyMatrix ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "UnionOfRows( IsEmptyMatrix, IsEmptyMatrix )", "\033[0m" );
    
    return HomalgZeroMatrix( NrRows( A ) + NrRows( B ), NrColumns( A ), HomalgRing( A ) );
    
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
        "LIMAT: for two homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "UnionOfColumns( IsEmptyMatrix, IsHomalgMatrix )", "\033[0m" );
    
    return B;
    
end );

##
InstallMethod( UnionOfColumnsOp,
        "LIMAT: for two homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsEmptyMatrix ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "UnionOfColumns( IsHomalgMatrix, IsEmptyMatrix )", "\033[0m" );
    
    return A;
    
end );

## without this method the above two methods will be called in the wrong context!!!
InstallMethod( UnionOfColumnsOp,
        "LIMAT: for two homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix and IsEmptyMatrix ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "UnionOfColumns( IsEmptyMatrix, IsEmptyMatrix )", "\033[0m" );
    
    return HomalgZeroMatrix( NrRows( A ), NrColumns( A ) + NrColumns( B ), HomalgRing( A ) );
    
end );

##
InstallMethod( DiagMat,
        "LIMAT: for homalg matrices",
        [ IsHomogeneousList ], 2,
        
  function( l )
    local R;
    
    if ForAll( l, HasIsZero and IsEmptyMatrix ) then
        
        R := HomalgRing( l[1] );
        
        Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DiagMat( [ zero matrices ] )", "\033[0m" );
        
        return HomalgZeroMatrix( Sum( List( l, NrRows ) ), Sum( List( l, NrColumns ) ), R );
        
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
    
    return HomalgZeroMatrix( NrRows( A ) * NrRows( B ), NrColumns( A ) * NrColumns( B ), R );
    
end );

##
InstallMethod( KroneckerMat,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsEmptyMatrix ],
        
  function( A, B )
    local R;
    
    R := HomalgRing( A );
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "KroneckerMat( IsHomalgMatrix, IsZero(Matrix) )", "\033[0m" );
    
    return HomalgZeroMatrix( NrRows( A ) * NrRows( B ), NrColumns( A ) * NrColumns( B ), R );
    
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
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsZero(Matrix) + IsHomalgMatrix", "\033[0m", "  ", NrRows( A ), " x ", NrColumns( A ) );
    
    return B;
    
end );

##
InstallMethod( \+,
        "LIMAT: for two homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsEmptyMatrix ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsHomalgMatrix + IsZero(Matrix)", "\033[0m", "  ", NrRows( A ), " x ", NrColumns( A ) );
    
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
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsZero(Matrix) - IsHomalgMatrix", "\033[0m", "  ", NrRows( A ), " x ", NrColumns( A ) );
    
    return -B;
    
end );

##
InstallMethod( \-,
        "LIMAT: for two homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsEmptyMatrix ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsHomalgMatrix - IsZero(Matrix)", "\033[0m", "  ", NrRows( A ), " x ", NrColumns( A ) );
    
    return A;
    
end );

##
InstallMethod( \*,
        "LIMAT: for two homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix ], 17001,
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsZero(Matrix) * IsHomalgMatrix", "\033[0m", "  ", NrRows( A ), " x ", NrColumns( A ), " x ", NrColumns( B ) );
    
    if NrRows( B ) = NrColumns( B ) then
        return A;
    else
        return HomalgZeroMatrix( NrRows( A ), NrColumns( B ), HomalgRing( A ) );
    fi;
    
end );

##
InstallMethod( \*,
        "LIMAT: for two homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsEmptyMatrix ], 17001,
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsHomalgMatrix * IsZero(Matrix)", "\033[0m", "  ", NrRows( A ), " x ", NrColumns( A ), " x ", NrColumns( B ) );
    
    if NrRows( A ) = NrColumns( A ) then
        return B;
    else
        return HomalgZeroMatrix( NrRows( A ), NrColumns( B ), HomalgRing( B ) );
    fi;
    
end );

##
InstallMethod( RightDivide,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix ],
        
  function( B, A )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "RightDivide( IsZero(Matrix), IsHomalgMatrix )", "\033[0m" );
    
    return HomalgZeroMatrix( NrRows( B ), NrRows( A ), HomalgRing( B ) );
    
end );

##
InstallMethod( RightDivide,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix, IsHomalgMatrix ],
        
  function( B, A, L )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "RightDivide( IsZero(Matrix), IsHomalgMatrix, IsHomalgMatrix )", "\033[0m" );
    
    return HomalgZeroMatrix( NrRows( B ), NrRows( A ), HomalgRing( B ) );
    
end );

##
InstallMethod( LeftDivide,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsEmptyMatrix ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "LeftDivide( IsHomalgMatrix, IsZero(Matrix) )", "\033[0m" );
    
    return HomalgZeroMatrix( NrColumns( A ), NrColumns( B ), HomalgRing( B ) );
    
end );

##
InstallMethod( LeftDivide,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix ],
        
  function( A, B, L )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "LeftDivide( IsHomalgMatrix, IsZero(Matrix), IsHomalgMatrix )", "\033[0m" );
    
    return HomalgZeroMatrix( NrColumns( A ), NrColumns( B ), HomalgRing( B ) );
    
end );

##
InstallMethod( LeftInverse,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix ],
        
  function( M )
    
    if NrColumns( M ) = 0 then
        
        Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "LeftInverse( ? x 0 -- IsZero(Matrix) )", "\033[0m" );
        
        return HomalgZeroMatrix( 0, NrRows( M ), HomalgRing( M ) );
        
    else
        Error( "a zero matrix with positive number of columns has no left inverse!\n" );
    fi;
    
end );

##
InstallMethod( RightInverse,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix ],
        
  function( M )
    
    if NrRows( M ) = 0 then
        
        Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "RightInverse( 0 x ? -- IsZero(Matrix) )", "\033[0m" );
        
        return HomalgZeroMatrix( NrColumns( M ), 0, HomalgRing( M ) );
        
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
    
    return HomalgZeroMatrix( 0, NrColumns( M ), HomalgRing( M ) );
    
end );

##
InstallMethod( BasisOfColumnModule,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "BasisOfColumnModule( IsZero(Matrix) )", "\033[0m" );
    
    return HomalgZeroMatrix( NrRows( M ), 0, HomalgRing( M ) );
    
end );

##
InstallMethod( ReducedBasisOfRowModule,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "ReducedBasisOfRowModule( IsZero(Matrix) )", "\033[0m" );
    
    return HomalgZeroMatrix( 0, NrColumns( M ), HomalgRing( M ) );
    
end );

##
InstallMethod( ReducedBasisOfColumnModule,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "ReducedBasisOfColumnModule( IsZero(Matrix) )", "\033[0m" );
    
    return HomalgZeroMatrix( NrRows( M ), 0, HomalgRing( M ) );
    
end );

##
InstallMethod( BasisOfRowsCoeff,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix and IsVoidMatrix ],
        
  function( M, T )
    local R;
    
    R := HomalgRing( M );
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "BasisOfRowsCoeff( IsZero(Matrix), T )", "\033[0m" );
    
    SetPreEval( T, HomalgZeroMatrix( 0, NrRows( M ), R ) ); ResetFilterObj( T, IsVoidMatrix );
    
    return HomalgZeroMatrix( 0, NrColumns( M ), R );
    
end );

##
InstallMethod( BasisOfColumnsCoeff,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix and IsVoidMatrix ],
        
  function( M, T )
    local R;
    
    R := HomalgRing( M );
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "BasisOfColumnsCoeff( IsZero(Matrix), T )", "\033[0m" );
    
    SetPreEval( T, HomalgZeroMatrix( NrColumns( M ), 0, R ) ); ResetFilterObj( T, IsVoidMatrix );
    
    return HomalgZeroMatrix( NrRows( M ), 0, R );
    
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
    
    SetPreEval( T, HomalgZeroMatrix( NrRows( A ), NrRows( B ), HomalgRing( A ) ) ); ResetFilterObj( T, IsVoidMatrix );
    
    return A;
    
end );

##
InstallMethod( DecideZeroRowsEffectively,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix, IsVoidMatrix ],
        
  function( A, B, T )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DecideZeroRowsEffectively( IsZero(Matrix), IsHomalgMatrix, T )", "\033[0m" );
    
    SetPreEval( T, HomalgZeroMatrix( NrRows( A ), NrRows( B ), HomalgRing( A ) ) ); ResetFilterObj( T, IsVoidMatrix );
    
    return A;
    
end );

##
InstallMethod( DecideZeroColumnsEffectively,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsEmptyMatrix, IsVoidMatrix ],
        
  function( A, B, T )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DecideZeroColumnsEffectively( IsHomalgMatrix, IsZero(Matrix), T )", "\033[0m" );
    
    SetPreEval( T, HomalgZeroMatrix( NrColumns( B ), NrColumns( A ), HomalgRing( A ) ) ); ResetFilterObj( T, IsVoidMatrix );
    
    return A;
    
end );

##
InstallMethod( DecideZeroColumnsEffectively,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix, IsVoidMatrix ],
        
  function( A, B, T )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DecideZeroColumnsEffectively( IsZero(Matrix), IsHomalgMatrix, T )", "\033[0m" );
    
    SetPreEval( T, HomalgZeroMatrix( NrColumns( B ), NrColumns( A ), HomalgRing( A ) ) ); ResetFilterObj( T, IsVoidMatrix );
    
    return A;
    
end );

##
InstallMethod( SyzygiesGeneratorsOfRows,
        "LIMAT: for homalg matrices (IsOne)",
        [ IsHomalgMatrix and IsEmptyMatrix and HasNrRows and HasNrColumns, IsHomalgMatrix ],
        
  function( M1, M2 )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "SyzygiesGeneratorsOfRows(IsOne(Matrix),IsHomalgMatrix)", "\033[0m" );
    
    if NrRows( M1 ) = NrRows( M2 ) then
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
    
    return HomalgIdentityMatrix( NrRows( M ), HomalgRing( M ) );
    
end );

##
InstallMethod( SyzygiesGeneratorsOfRows,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix ],
        
  function( M1, M2 )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "SyzygiesGeneratorsOfRows(IsZero(Matrix),IsHomalgMatrix)", "\033[0m" );
    
    return HomalgIdentityMatrix( NrRows( M1 ), HomalgRing( M1 ) );
    
end );

##
InstallMethod( SyzygiesGeneratorsOfColumns,
        "LIMAT: for homalg matrices (IsOne)",
        [ IsHomalgMatrix and IsEmptyMatrix and HasNrRows and HasNrColumns, IsHomalgMatrix ],
        
  function( M1, M2 )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "SyzygiesGeneratorsOfColumns(IsOne(Matrix),IsHomalgMatrix)", "\033[0m" );
    
    if NrRows( M1 ) = NrColumns( M1 ) then
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
    
    return HomalgIdentityMatrix( NrColumns( M ), HomalgRing( M ) );
    
end );

##
InstallMethod( SyzygiesGeneratorsOfColumns,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix ],
        
  function( M1, M2 )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "SyzygiesGeneratorsOfColumns(IsZero(Matrix),IsHomalgMatrix)", "\033[0m" );
    
    return HomalgIdentityMatrix( NrColumns( M1 ), HomalgRing( M1 ) );
    
end );

##
InstallMethod( ReducedSyzygiesGeneratorsOfRows,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "ReducedSyzygiesGeneratorsOfRows( IsZero(Matrix) )", "\033[0m" );
    
    return HomalgIdentityMatrix( NrRows( M ), HomalgRing( M ) );
    
end );

##
InstallMethod( ReducedSyzygiesGeneratorsOfColumns,
        "LIMAT: for homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "ReducedSyzygiesGeneratorsOfColumns( IsZero(Matrix) )", "\033[0m" );
    
    return HomalgIdentityMatrix( NrColumns( M ), HomalgRing( M ) );
    
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





