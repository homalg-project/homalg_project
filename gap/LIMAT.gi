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
# logical implications methods:
#
####################################

InstallLogicalImplicationsForHomalgBasicObjects( LogicalImplicationsForHomalgMatrices, IsHomalgMatrix );

InstallLogicalImplicationsForHomalgBasicObjects( LogicalImplicationsForHomalgMatricesOverSpecialRings, IsHomalgMatrix, IsHomalgRing );

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
InstallImmediateMethod( IsOne,
        IsHomalgMatrix and HasNrRows and HasNrColumns, 0,
        
  function( M )
    
    if NrRows( M ) = 0 or NrColumns( M ) = 0 then
        return NrRows( M ) = NrColumns( M );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsOne,
        IsHomalgMatrix and HasNrRows and HasNrColumns, 0,
        
  function( M )
    
    if NrRows( M ) <> NrColumns( M ) then
        return false;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZero,
        IsHomalgMatrix and HasIsRightRegular and HasIsEmptyMatrix, 0,
        
  function( M )
    
    if not IsEmptyMatrix( M ) and IsRightRegular( M ) then
        return false;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZero,
        IsHomalgMatrix and HasIsLeftRegular and HasIsEmptyMatrix, 0,
        
  function( M )
    
    if not IsEmptyMatrix( M ) and IsLeftRegular( M ) then
        return false;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZero,
        IsHomalgMatrix and HasZeroRows and HasNrRows, 0,
        
  function( M )
    
    return Length( ZeroRows( M ) ) = NrRows( M );
    
end );

##
InstallImmediateMethod( IsZero,
        IsHomalgMatrix and HasZeroColumns and HasNrColumns, 0,
        
  function( M )
    
    return Length( ZeroColumns( M ) ) = NrColumns( M );
    
end );

##
InstallImmediateMethod( IsZero,
        IsHomalgMatrix and HasEvalUnionOfRows, 0,
        
  function( M )
    local e, A, B;
    
    e := EvalUnionOfRows( M );
    
    A := e[1];
    B := e[2];
    
    if HasIsZero( A ) then
        if not IsZero( A ) then
            return false;
        elif HasIsZero( B ) then
            ## A is zero
            return IsZero( B );
        fi;
    elif HasIsZero( B ) and not IsZero( B ) then
        return false;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZero,
        IsHomalgMatrix and HasEvalUnionOfColumns, 0,
        
  function( M )
    local e, A, B;
    
    e := EvalUnionOfColumns( M );
    
    A := e[1];
    B := e[2];
    
    if HasIsZero( A ) then
        if not IsZero( A ) then
            return false;
        elif HasIsZero( B ) then
            ## A is zero
            return IsZero( B );
        fi;
    elif HasIsZero( B ) and not IsZero( B ) then
        return false;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZero,
        IsHomalgMatrix and HasEvalDiagMat, 0,
        
  function( M )
    local e;
    
    e := EvalDiagMat( M );
    
    if ForAll( e, B -> HasIsZero( B ) and IsZero( B ) ) then
        return true;
    elif ForAny( e, B -> HasIsZero( B ) and not IsZero( B ) ) then
        return false;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsZero,
        IsHomalgMatrix and HasEvalMulMat, 0,
        
  function( M )
    local e, a, A, R;
    
    e := EvalMulMat( M );
    
    a := e[1];
    A := e[2];
    
    if HasIsZero( a ) and IsZero( a ) then
        return true;
    elif HasIsZero( A ) then
        if IsZero( A ) then
            return true;
        elif IsHomalgRingElement( a ) and IsRegular( a ) then
            ## A is not zero
            return false;
        else
            R := HomalgRing( A );
            if HasIsIntegralDomain( R ) and IsIntegralDomain( R ) then
                ## A is not zero
                return IsZero( a );
            elif IsUnit( a ) then
                ## A is not zero
                return false;
            fi;
        fi;
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
InstallImmediateMethod( IsRightRegular,
        IsHomalgMatrix and HasNrColumns and HasIsZero, 0,
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if NrColumns( M ) = 1 and not IsZero( M ) and HasIsIntegralDomain( R ) and IsIntegralDomain( R ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsLeftRegular,
        IsHomalgMatrix and HasNrRows and HasIsZero, 0,
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if NrRows( M ) = 1 and not IsZero( M ) and HasIsIntegralDomain( R ) and IsIntegralDomain( R ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsUpperStairCaseMatrix,
        IsHomalgMatrix and HasNrRows, 0,
        
  function( M )
    
    if NrRows( M ) = 1 then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsLowerStairCaseMatrix,
        IsHomalgMatrix and HasNrColumns, 0,
        
  function( M )
    
    if NrColumns( M ) = 1 then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsDiagonalMatrix,
        IsHomalgMatrix and HasEvalDiagMat, 0,
        
  function( M )
    local e;
    
    e := EvalDiagMat( M );
    
    if ForAll( e, HasIsDiagonalMatrix ) then
        return ForAll( List( e, IsDiagonalMatrix ), a -> a = true );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsDiagonalMatrix,
        IsHomalgMatrix and HasEvalUnionOfRows, 0,
        
  function( M )
    local e, A, B;
    
    e := EvalUnionOfRows( M );
    
    A := e[1];
    B := e[2];
    
    if HasIsDiagonalMatrix( A ) and IsDiagonalMatrix( A )
       and HasIsZero( B ) and IsZero( B ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsDiagonalMatrix,
        IsHomalgMatrix and HasEvalUnionOfColumns, 0,
        
  function( M )
    local e, A, B;
    
    e := EvalUnionOfColumns( M );
    
    A := e[1];
    B := e[2];
    
    if HasIsDiagonalMatrix( A ) and IsDiagonalMatrix( A )
       and HasIsZero( B ) and IsZero( B ) then
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
        IsHomalgMatrix and IsOne and HasNrRows, 0,
        
  function( M )
    
    return NrRows( M );
        
end );

##
InstallImmediateMethod( ColumnRankOfMatrix,
        IsHomalgMatrix and IsOne and HasNrColumns, 0,
        
  function( M )
    
    return NrColumns( M );
        
end );

##
InstallImmediateMethod( RowRankOfMatrix,
        IsHomalgMatrix and IsZero, 0,
        
  function( M )
    
    return 0;
        
end );

##
InstallImmediateMethod( ColumnRankOfMatrix,
        IsHomalgMatrix and IsZero, 0,
        
  function( M )
    
    return 0;
        
end );

##
InstallImmediateMethod( ZeroRows,
        IsHomalgMatrix and IsOne, 0,
        
  function( M )
    
    return [ ];
        
end );

##
InstallImmediateMethod( ZeroRows,
        IsHomalgMatrix and IsZero and HasNrRows, 0,
        
  function( M )
    
    return [ 1 .. NrRows( M ) ];
        
end );

##
InstallImmediateMethod( ZeroRows,
        IsHomalgMatrix and HasEvalInvolution, 0,
        
  function( M )
    local MI;
    
    MI := EvalInvolution( M );
    
    if HasZeroColumns( MI ) then
        return ZeroColumns( MI );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( ZeroColumns,
        IsHomalgMatrix and IsOne, 0,
        
  function( M )
    
    return [ ];
        
end );

##
InstallImmediateMethod( ZeroColumns,
        IsHomalgMatrix and IsZero and HasNrColumns, 0,
        
  function( M )
    
    return [ 1 .. NrColumns( M ) ];
        
end );

##
InstallImmediateMethod( ZeroColumns,
        IsHomalgMatrix and HasEvalInvolution, 0,
        
  function( M )
    local MI;
    
    MI := EvalInvolution( M );
    
    if HasZeroRows( MI ) then
        return ZeroRows( MI );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( NonZeroRows,
        IsHomalgMatrix and IsOne and HasNrRows, 0,
        
  function( M )
    
    return [ 1 .. NrRows( M ) ];
        
end );

##
InstallImmediateMethod( NonZeroRows,
        IsHomalgMatrix and IsZero, 0,
        
  function( M )
    
    return [ ];
        
end );

##
InstallImmediateMethod( NonZeroColumns,
        IsHomalgMatrix and IsOne and HasNrColumns, 0,
        
  function( M )
    
    return [ 1 .. NrColumns( M ) ];
        
end );

##
InstallImmediateMethod( NonZeroColumns,
        IsHomalgMatrix and IsZero, 0,
        
  function( M )
    
    return [ ];
        
end );

##
InstallImmediateMethod( PositionOfFirstNonZeroEntryPerRow,
        IsHomalgMatrix and IsOne and HasNrRows, 0,
        
  function( M )
    
    if not ( HasIsZero( M ) and IsZero( M ) ) then
        return [ 1 .. NrRows( M ) ];
    fi;
    
    TryNextMethod( );
        
end );

####################################
#
# methods for attributes:
#
####################################

#-----------------------------------
# RowRankOfMatrix
#-----------------------------------

##
InstallMethod( RowRankOfMatrix,
        "LIMAT: for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, B;
    
    R := HomalgRing( M );
    
    if HasIsDivisionRingForHomalg( R ) and
       IsDivisionRingForHomalg( R ) then
        
        return Length( NonZeroRows( BasisOfRows( M ) ) );
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( RowRankOfMatrix,
        "LIMAT: for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local RP, B;
    
    RP := homalgTable( HomalgRing( M ) );
    
    if IsBound( RP!.RowRankOfMatrix ) then
        
        return RP!.RowRankOfMatrix( M );
        
    elif IsBound( RP!.RowReducedEchelonForm ) then
        
        B := RP!.RowReducedEchelonForm( M );
        
        if HasRowRankOfMatrix( B ) then
            return RowRankOfMatrix( B );
        fi;
        
    else
        
        BasisOfRowModule( M );
        
        if HasRowRankOfMatrix( M ) then
            return RowRankOfMatrix( M );
        fi;
        
    fi;
    
    TryNextMethod( );
    
end );

#-----------------------------------
# ColumnRankOfMatrix
#-----------------------------------

##
InstallMethod( ColumnRankOfMatrix,
        "LIMAT: for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, B;
    
    R := HomalgRing( M );
    
    if HasIsDivisionRingForHomalg( R ) and
       IsDivisionRingForHomalg( R ) then
        
        return Length( NonZeroColumns( BasisOfColumns( M ) ) );
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( ColumnRankOfMatrix,
        "LIMAT: for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local RP, B, N;
    
    RP := homalgTable( HomalgRing( M ) );
    
    if IsBound( RP!.ColumnRankOfMatrix ) then
        
        return RP!.ColumnRankOfMatrix( M );
        
    elif IsBound( RP!.RowRankOfMatrix ) then
        
        return RP!.RowRankOfMatrix( Involution( M ) );	## in most cases Involution is obsolete
        
    elif IsBound( RP!.ColumnReducedEchelonForm ) then
        
        B := RP!.ColumnReducedEchelonForm( M );
        
        if HasColumnRankOfMatrix( B ) then
            return ColumnRankOfMatrix( B );
        fi;
        
    elif IsBound( RP!.RowReducedEchelonForm ) then
        
        N := Involution( M );
        
        B := RP!.RowReducedEchelonForm( N );
        
        if HasRowRankOfMatrix( B ) then
            return RowRankOfMatrix( B );
        fi;
        
    else
        
        BasisOfColumnModule( M );
        
        if HasColumnRankOfMatrix( M ) then
            return ColumnRankOfMatrix( M );
        fi;
    fi;
    
    TryNextMethod( );
    
end );

#-----------------------------------
# ZeroColumns
#-----------------------------------

##
InstallMethod( ZeroColumns,
        "LIMAT: for homalg matrices (HasEvalInvolution)",
        [ IsHomalgMatrix and HasEvalInvolution ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "ZeroColumns( Involution( M ) ) = ZeroRows( M )", "\033[0m" );
    
    return ZeroRows( EvalInvolution( M ) );
    
end );

####################################
#
# methods properties:
#
####################################
    
##
InstallMethod( IsEmptyMatrix,
        "LIMAT: for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    
    return NrRows( M ) = 0 or NrColumns( M ) = 0;
    
end );

##
InstallMethod( IsZero,
        "LIMAT: for homalg matrices",
        [ IsHomalgMatrix and HasEvalUnionOfRows ],
        
  function( M )
    local e, A, B;
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsZero( UnionOfRows )", "\033[0m" );
    
    e := EvalUnionOfRows( M );
    
    A := e[1];
    B := e[2];
    
    return IsZero( A ) and IsZero( B );
    
end );

##
InstallMethod( IsZero,
        "LIMAT: for homalg matrices",
        [ IsHomalgMatrix and HasEvalUnionOfColumns ],
        
  function( M )
    local e, A, B;
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsZero( UnionOfColumns )", "\033[0m" );
    
    e := EvalUnionOfColumns( M );
    
    A := e[1];
    B := e[2];
    
    return IsZero( A ) and IsZero( B );
    
end );

##
InstallMethod( IsZero,
        "LIMAT: for homalg matrices",
        [ IsHomalgMatrix and HasEvalDiagMat ],
        
  function( M )
    local e;
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsZero( DiagMat )", "\033[0m" );
    
    e := EvalDiagMat( M );
    
    return ForAll( e, IsZero );
    
end );

##
InstallMethod( IsZero,
        "LIMAT: for homalg matrices",
        [ IsHomalgMatrix and HasEvalMulMat ],
        
  function( M )
    local e, a, A;
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsZero( a * A )", "\033[0m" );
    
    e := EvalMulMat( M );
    
    a := e[1];
    A := e[2];
    
    if IsZero( a ) then
        return true;
    elif IsZero( A ) then
        return true;
    elif HasIsMinusOne( a ) and IsMinusOne( a ) then
        ## A is not zero
        return false;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( IsRightRegular,
        "LIMAT: for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    
    return NrColumns( SyzygiesGeneratorsOfColumns( M ) ) = 0;
    
end );

##
InstallMethod( IsLeftRegular,
        "LIMAT: for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    
    return NrRows( SyzygiesGeneratorsOfRows( M ) ) = 0;
    
end );

##
InstallMethod( IsSpecialSubidentityMatrix,
        "LIMAT: for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local r, c, nz, l;
    
    r := NrRows( M );
    c := NrColumns( M );
    
    if r = 0 or c = 0 then
        return true;
    elif r = c then
        return IsOne( M );
    elif r < c then
        nz := NonZeroColumns( M );
        l := Length( nz );
        if not ( l = 0  or l <> r or nz <> [ nz[1] .. nz[l] ] ) then
            l := IsOne( CertainColumns( M, nz ) );
            if l then
                SetZeroRows( M, [ ] );
                return true;
            fi;
        fi;
    else
        nz := NonZeroRows( M );
        l := Length( nz );
        if not ( l = 0  or l <> r or nz <> [ nz[1] .. nz[l] ] ) then
            l := IsOne( CertainRows( M, nz ) );
            if l then
                SetZeroColumns( M, [ ] );
                return true;
            fi;
        fi;
    fi;
    
    return false;
    
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
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero, IsHomalgMatrix and IsZero ],
        
  function( M1, M2 )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsZero(Matrix) = IsZero(Matrix)", "\033[0m" );
    
    return AreComparableMatrices( M1, M2 );
    
end );

##
InstallMethod( \=,
        "LIMAT: for homalg matrices (IsOne)",
        [ IsHomalgMatrix and IsOne, IsHomalgMatrix and IsOne ],
        
  function( M1, M2 )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsOne(Matrix) = IsOne(Matrix)", "\033[0m" );
    
    return AreComparableMatrices( M1, M2 );
    
end );

#-----------------------------------
# Involution
#-----------------------------------

##
InstallMethod( Involution,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "Involution( IsZero(Matrix) )", "\033[0m" );
    
    return HomalgZeroMatrix( NrColumns( M ), NrRows( M ), HomalgRing( M ) );
    
end );

##
InstallMethod( Involution,
        "LIMAT: for homalg matrices (IsOne)",
        [ IsHomalgMatrix and IsOne ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "Involution( IsOne(Matrix) )", "\033[0m" );
    
    return M;
    
end );

#-----------------------------------
# CertainRows
#-----------------------------------

##
InstallMethod( CertainRows,
        "LIMAT: for homalg matrices (check input and trivial cases)",
        [ IsHomalgMatrix, IsList ], 10001,
        
  function( M, plist )
    
    if not IsSubset( [ 1 .. NrRows( M ) ], plist ) then
        Error( "the list of row positions ", plist, " must be in the range [ 1 .. ", NrRows( M ), " ]\n" );
    fi;
    
    if NrRows( M ) = 0 or plist = [ 1 .. NrRows( M ) ] then
        return M;
    elif plist = [ ] then
        return HomalgZeroMatrix( 0, NrColumns( M ), HomalgRing( M ) );
    fi;
    
    TryNextMethod( );
    
end );

#-----------------------------------
# CertainColumns
#-----------------------------------

##
InstallMethod( CertainColumns,
        "LIMAT: for homalg matrices (check input and trivial cases)",
        [ IsHomalgMatrix, IsList ], 10001,
        
  function( M, plist )
    
    if not IsSubset( [ 1 .. NrColumns( M ) ], plist ) then
        Error( "the list of column positions ", plist, " must be in the range [ 1 .. ", NrColumns( M ), " ]\n" );
    fi;
    
    if NrColumns( M ) = 0 or plist = [ 1 .. NrColumns( M ) ] then
        return M;
    elif plist = [ ] then
        return HomalgZeroMatrix( NrRows( M ), 0, HomalgRing( M ) );
    fi;
    
    TryNextMethod( );
    
end );

#-----------------------------------
# UnionOfRows
#-----------------------------------

##
InstallMethod( UnionOfRows,
        "LIMAT: for two homalg matrices (check input)",
        [ IsHomalgMatrix, IsHomalgMatrix ], 10001,
        
  function( A, B )
    
    if not IsIdenticalObj( HomalgRing( A ), HomalgRing( B ) ) then
        Error( "the two matrices are not defined over identically the same ring\n" );
    fi;
    
    if NrColumns( A ) <> NrColumns( B ) then
        Error( "the two matrices are not stackable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrColumns( B ), "\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( UnionOfRows,
        "LIMAT: for two homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsEmptyMatrix ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "UnionOfRows( IsHomalgMatrix, IsEmptyMatrix )", "\033[0m" );
    
    return A;
    
end );

##
InstallMethod( UnionOfRows,
        "LIMAT: for two homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "UnionOfRows( IsEmptyMatrix, IsHomalgMatrix )", "\033[0m" );
    
    return B;
    
end );

## without this method the above two methods will be called in the wrong context!!!
InstallMethod( UnionOfRows,
        "LIMAT: for two homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix and IsEmptyMatrix ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "UnionOfRows( IsEmptyMatrix, IsEmptyMatrix )", "\033[0m" );
    
    return HomalgZeroMatrix( NrRows( A ) + NrRows( B ), NrColumns( A ), HomalgRing( A ) );
    
end );

#-----------------------------------
# UnionOfColumns
#-----------------------------------

##
InstallMethod( UnionOfColumns,
        "LIMAT: for two homalg matrices (check input)",
        [ IsHomalgMatrix, IsHomalgMatrix ], 10001,
        
  function( A, B )
    
    if not IsIdenticalObj( HomalgRing( A ), HomalgRing( B ) ) then
        Error( "the two matrices are not defined over identically the same ring\n" );
    fi;
    
    if NrRows( A ) <> NrRows( B ) then
        Error( "the two matrices are not augmentable, since the first one has ", NrRows( A ), " row(s), while the second ", NrRows( B ), "\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( UnionOfColumns,
        "LIMAT: for two homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "UnionOfColumns( IsEmptyMatrix, IsHomalgMatrix )", "\033[0m" );
    
    return B;
    
end );

##
InstallMethod( UnionOfColumns,
        "LIMAT: for two homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsEmptyMatrix ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "UnionOfColumns( IsHomalgMatrix, IsEmptyMatrix )", "\033[0m" );
    
    return A;
    
end );

## without this method the above two methods will be called in the wrong context!!!
InstallMethod( UnionOfColumns,
        "LIMAT: for two homalg matrices (IsEmptyMatrix)",
        [ IsHomalgMatrix and IsEmptyMatrix, IsHomalgMatrix and IsEmptyMatrix ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "UnionOfColumns( IsEmptyMatrix, IsEmptyMatrix )", "\033[0m" );
    
    return HomalgZeroMatrix( NrRows( A ), NrColumns( A ) + NrColumns( B ), HomalgRing( A ) );
    
end );

#-----------------------------------
# DiagMat
#-----------------------------------

##
InstallMethod( DiagMat,
        "LIMAT: for homalg matrices (check input)",
        [ IsHomogeneousList ], 10001,
        
  function( l )
    local R;
    
    if l = [ ] then
        Error( "recieved an empty list\n" );
    fi;
    
    if not ForAll( l, IsHomalgMatrix ) then
        Error( "at least one of the matrices in the list is not a homalg matrix\n" );
    fi;
    
    if Length( l ) = 1 then
        return l[1];
    fi;
    
    R := HomalgRing( l[1] );
    
    if not ForAll( l{[ 2 .. Length( l ) ]}, a -> IsIdenticalObj( HomalgRing( a ), R ) ) then
        Error( "the matrices are not defined over identically the same ring\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( DiagMat,
        "LIMAT: for homalg matrices",
        [ IsHomogeneousList ], 2,
        
  function( l )
    local R;
    
    if ForAll( l, HasIsOne and IsOne ) then
        
        R := HomalgRing( l[1] );
        
        Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DiagMat( [ identity matrices ] )", "\033[0m" );
        
        return HomalgIdentityMatrix( Sum( List( l, NrRows ) ), Sum( List( l, NrColumns ) ), R );
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( DiagMat,
        "LIMAT: for homalg matrices",
        [ IsHomogeneousList ], 2,
        
  function( l )
    local R;
    
    if ForAll( l, HasIsZero and IsZero ) then
        
        R := HomalgRing( l[1] );
        
        Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DiagMat( [ zero matrices ] )", "\033[0m" );
        
        return HomalgZeroMatrix( Sum( List( l, NrRows ) ), Sum( List( l, NrColumns ) ), R );
        
    fi;
    
    TryNextMethod( );
    
end );

#-----------------------------------
# KroneckerMat
#-----------------------------------

##
InstallMethod( KroneckerMat,
        "LIMAT: for homalg matrices (check input)",
        [ IsHomalgMatrix, IsHomalgMatrix ], 10001,
        
  function( A, B )
    
    if not IsIdenticalObj( HomalgRing( A ), HomalgRing( B ) ) then
        Error( "the two matrices are not defined over identically the same ring\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( KroneckerMat,
        "LIMAT: for homalg matrices (IsOne)",
        [ IsHomalgMatrix and IsOne, IsHomalgMatrix ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "KroneckerMat( IsOne(Matrix), IsHomalgMatrix )", "\033[0m" );
    
    return DiagMat( ListWithIdenticalEntries( NrRows( A ), B ) );
    
end );

##
InstallMethod( KroneckerMat,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero, IsHomalgMatrix ], 1001,	## FIXME: this must be ranked higher than the "KroneckerMat( IsOne, IsHomalgMatrix )", why?
        
  function( A, B )
    local R;
    
    R := HomalgRing( A );
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "KroneckerMat( IsZero(Matrix), IsHomalgMatrix )", "\033[0m" );
    
    return HomalgZeroMatrix( NrRows( A ) * NrRows( B ), NrColumns( A ) * NrColumns( B ), R );
    
end );

##
InstallMethod( KroneckerMat,
        "LIMAT: for homalg matrices (IsOne)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsOne ],
        
  function( A, B )
    local R;
    
    R := HomalgRing( A );
    
    if ( HasNrRows( B ) and NrRows( B ) = 1 )
       or ( HasNrRows( B ) and NrRows( B ) = 1 ) then
        
        Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "KroneckerMat( IsHomalgMatrix, (1) )", "\033[0m" );
        
        return A;
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( KroneckerMat,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsZero ],
        
  function( A, B )
    local R;
    
    R := HomalgRing( A );
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "KroneckerMat( IsHomalgMatrix, IsZero(Matrix) )", "\033[0m" );
    
    return HomalgZeroMatrix( NrRows( A ) * NrRows( B ), NrColumns( A ) * NrColumns( B ), R );
    
end );

#-----------------------------------
# MulMat
#-----------------------------------

##
InstallMethod( \*,
        "LIMAT: for a ring element and a homalg matrix (check input)",
        [ IsHomalgRingElement, IsHomalgMatrix ], 12001,
        
  function( a, A )
    local R;
    
    R := HomalgRing( a );
    
    if R <> fail and not IsIdenticalObj( R, HomalgRing( A ) ) then
        Error( "the ring element and the matrix are not defined over identically the same ring\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \*,
        "LIMAT: for homalg matrices with ring elements",
        [ IsRingElement and IsZero, IsHomalgMatrix ], 10001,
        
  function( a, A )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsZero * IsHomalgMatrix", "\033[0m" );
    
    return HomalgZeroMatrix( NrRows( A ), NrColumns( A ), HomalgRing( A ) );
    
end );

##
InstallMethod( \*,
        "LIMAT: for homalg matrices with ring elements",
        [ IsRingElement and IsOne, IsHomalgMatrix ], 10001,
        
  function( a, A )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsOne(Matrix) * IsHomalgMatrix", "\033[0m" );
    
    return A;
    
end );

##
InstallMethod( \*,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsRingElement, IsHomalgMatrix and IsZero ], 10001,
        
  function( a, A )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsRingElement * IsZero(Matrix)", "\033[0m" );
    
    return A;
    
end );

#-----------------------------------
# AddMat
#-----------------------------------

##
InstallMethod( \+,
        "LIMAT: for two homalg matrices (check input)",
        [ IsHomalgMatrix, IsHomalgMatrix ], 10001,
        
  function( A, B )
    
    if not IsIdenticalObj( HomalgRing( A ), HomalgRing( B ) ) then
        Error( "the two matrices are not defined over identically the same ring\n" );
    fi;
    
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
        "LIMAT: for two homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero, IsHomalgMatrix ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsZero(Matrix) + IsHomalgMatrix", "\033[0m", "	", NrRows( A ), " x ", NrColumns( A ) );
    
    return B;
    
end );

##
InstallMethod( \+,
        "LIMAT: for two homalg matrices (IsZero)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsZero ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsHomalgMatrix + IsZero(Matrix)", "\033[0m", "	", NrRows( A ), " x ", NrColumns( A ) );
    
    return A;
    
end );

#-----------------------------------
# AdditiveInverseMutable
#-----------------------------------

## a synonym of `-<elm>':
InstallMethod( AdditiveInverseMutable,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero ],
        
  function( A )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "-IsZero(Matrix)", "\033[0m" );
    
    return A;
    
end );

#-----------------------------------
# SubMat
#-----------------------------------

##
InstallMethod( \-,
        "LIMAT: for two homalg matrices (check input)",
        [ IsHomalgMatrix, IsHomalgMatrix ], 10001,
        
  function( A, B )
    
    if not IsIdenticalObj( HomalgRing( A ), HomalgRing( B ) ) then
        Error( "the two matrices are not defined over identically the same ring\n" );
    fi;
    
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
        "LIMAT: for two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ], 1000,
        
  function( A, B )
    
    if IsIdenticalObj( A, B ) then
        
        Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "M - M", "\033[0m", "	", NrRows( A ), " x ", NrColumns( A ) );
        
        return 0 * A;
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \-,
        "LIMAT: for two homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero, IsHomalgMatrix ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsZero(Matrix) - IsHomalgMatrix", "\033[0m", "	", NrRows( A ), " x ", NrColumns( A ) );
    
    return -B;
    
end );

##
InstallMethod( \-,
        "LIMAT: for two homalg matrices (IsZero)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsZero ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsHomalgMatrix - IsZero(Matrix)", "\033[0m", "	", NrRows( A ), " x ", NrColumns( A ) );
    
    return A;
    
end );

#-----------------------------------
# Compose
#-----------------------------------

##
InstallMethod( \*,
        "LIMAT: for two homalg matrices (check input)",
        [ IsHomalgMatrix, IsHomalgMatrix ], 20001,
        
  function( A, B )
    
    if not IsIdenticalObj( HomalgRing( A ), HomalgRing( B ) ) then
        Error( "the two matrices are not defined over identically the same ring\n" );
    fi;
    
    if NrColumns( A ) <> NrRows( B ) then
        Error( "the two matrices are not composable, since the first one has ", NrColumns( A ), " column(s), while the second ", NrRows( B ), " row(s)\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \*,
        "LIMAT: for two homalg matrices (IsOne)",
        [ IsHomalgMatrix and IsOne, IsHomalgMatrix ], 17001,
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsOne(Matrix) * IsHomalgMatrix", "\033[0m", "	", NrRows( A ), " x ", NrColumns( A ), " x ", NrColumns( B ) );
    
    return B;
    
end );

##
InstallMethod( \*,
        "LIMAT: for two homalg matrices (IsOne)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsOne ], 17001,
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsHomalgMatrix * IsOne(Matrix)", "\033[0m", "	", NrRows( A ), " x ", NrColumns( A ), " x ", NrColumns( B ) );
    
    return A;
    
end );

##
InstallMethod( \*,
        "LIMAT: for two homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero, IsHomalgMatrix ], 17001,
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsZero(Matrix) * IsHomalgMatrix", "\033[0m", "	", NrRows( A ), " x ", NrColumns( A ), " x ", NrColumns( B ) );
    
    if NrRows( B ) = NrColumns( B ) then
        return A;
    else
        return HomalgZeroMatrix( NrRows( A ), NrColumns( B ), HomalgRing( A ) );
    fi;
    
end );

##
InstallMethod( \*,
        "LIMAT: for two homalg matrices (IsZero)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsZero ], 17001,
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsHomalgMatrix * IsZero(Matrix)", "\033[0m", "	", NrRows( A ), " x ", NrColumns( A ), " x ", NrColumns( B ) );
    
    if NrRows( A ) = NrColumns( A ) then
        return B;
    else
        return HomalgZeroMatrix( NrRows( A ), NrColumns( B ), HomalgRing( B ) );
    fi;
    
end );

#-----------------------------------
# RightDivide
#-----------------------------------

##
InstallMethod( RightDivide,
        "LIMAT: for homalg matrices (check input)",
        [ IsHomalgMatrix, IsHomalgMatrix ], 10001,
        
  function( B, A )
    
    if NrColumns( A ) <> NrColumns( B ) then
        Error( "the first and the second matrix must have the same number of columns\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( RightDivide,
        "LIMAT: for homalg matrices (IsIdenticalObj)",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( B, A )
    
    if IsIdenticalObj( B, A ) then
        
        Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "RightDivide( A, A )", "\033[0m" );
        
        return HomalgIdentityMatrix( NrRows( A ), HomalgRing( A ) );
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( RightDivide,
        "LIMAT: for homalg matrices (IsOne)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsOne ],
        
  function( B, A )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "RightDivide( IsHomalgMatrix, IsOne(Matrix) )", "\033[0m" );
    
    return B;
    
end );

##
InstallMethod( RightDivide,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero, IsHomalgMatrix ],
        
  function( B, A )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "RightDivide( IsZero(Matrix), IsHomalgMatrix )", "\033[0m" );
    
    return HomalgZeroMatrix( NrRows( B ), NrRows( A ), HomalgRing( B ) );
    
end );

##
InstallMethod( RightDivide,
        "LIMAT: for homalg matrices (check input)",
        [ IsHomalgMatrix, IsHomalgMatrix, IsHomalgMatrix ], 10001,
        
  function( B, A, L )
    
    if NrColumns( A ) <> NrColumns( B ) then
        Error( "the first and the second matrix must have the same number of columns\n" );
    fi;
    
    if NrColumns( A ) <> NrColumns( L ) then
        Error( "the first and the third matrix must have the same number of columns\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( RightDivide,
        "LIMAT: for homalg matrices (IsIdenticalObj)",
        [ IsHomalgMatrix, IsHomalgMatrix, IsHomalgMatrix ],
        
  function( B, A, L )
    
    if IsIdenticalObj( B, A ) then
        
        Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "RightDivide( A, A, IsHomalgMatrix )", "\033[0m" );
        
        return HomalgIdentityMatrix( NrRows( A ), HomalgRing( A ) );
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( RightDivide,
        "LIMAT: for homalg matrices (IsOne)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsOne, IsHomalgMatrix ],
        
  function( B, A, L )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "RightDivide( IsHomalgMatrix, IsOne(Matrix), IsHomalgMatrix )", "\033[0m" );
    
    return B;
    
end );

##
InstallMethod( RightDivide,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero, IsHomalgMatrix, IsHomalgMatrix ],
        
  function( B, A, L )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "RightDivide( IsZero(Matrix), IsHomalgMatrix, IsHomalgMatrix )", "\033[0m" );
    
    return HomalgZeroMatrix( NrRows( B ), NrRows( A ), HomalgRing( B ) );
    
end );

#-----------------------------------
# LeftDivide
#-----------------------------------

##
InstallMethod( LeftDivide,
        "LIMAT: for homalg matrices (check input)",
        [ IsHomalgMatrix, IsHomalgMatrix ], 10001,
        
  function( A, B )
    
    if NrRows( A ) <> NrRows( B ) then
        Error( "the first and the second matrix must have the same number of rows\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( LeftDivide,
        "LIMAT: for homalg matrices (IsIdenticalObj)",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( A, B )
    
    if IsIdenticalObj( A, B ) then
        
        Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "LeftDivide( A, A )", "\033[0m" );
        
        return HomalgIdentityMatrix( NrColumns( A ), HomalgRing( A ) );
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( LeftDivide,
        "LIMAT: for homalg matrices (IsOne)",
        [ IsHomalgMatrix and IsOne, IsHomalgMatrix ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "LeftDivide( IsOne(Matrix), IsHomalgMatrix )", "\033[0m" );
    
    return B;
    
end );

##
InstallMethod( LeftDivide,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsZero ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "LeftDivide( IsHomalgMatrix, IsZero(Matrix) )", "\033[0m" );
    
    return HomalgZeroMatrix( NrColumns( A ), NrColumns( B ), HomalgRing( B ) );
    
end );

##
InstallMethod( LeftDivide,
        "LIMAT: for homalg matrices (check input)",
        [ IsHomalgMatrix, IsHomalgMatrix, IsHomalgMatrix ], 10001,
        
  function( A, B, L )
    
    if NrRows( A ) <> NrRows( B ) then
        Error( "the first and the second matrix must have the same number of rows\n" );
    fi;
    
    if NrRows( A ) <> NrRows( L ) then
        Error( "the first and the third matrix must have the same number of rows\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( LeftDivide,
        "LIMAT: for homalg matrices (IsIdenticalObj)",
        [ IsHomalgMatrix, IsHomalgMatrix, IsHomalgMatrix ],
        
  function( A, B, L )
    
    if IsIdenticalObj( A, B ) then
        
        Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "LeftDivide( A, A, IsHomalgMatrix )", "\033[0m" );
        
        return HomalgIdentityMatrix( NrColumns( A ), HomalgRing( A ) );
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( LeftDivide,
        "LIMAT: for homalg matrices (IsOne)",
        [ IsHomalgMatrix and IsOne, IsHomalgMatrix, IsHomalgMatrix ],
        
  function( A, B, L )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "LeftDivide( IsOne(Matrix), IsHomalgMatrix, IsHomalgMatrix )", "\033[0m" );
    
    return B;
    
end );

##
InstallMethod( LeftDivide,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsZero, IsHomalgMatrix ],
        
  function( A, B, L )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "LeftDivide( IsHomalgMatrix, IsZero(Matrix), IsHomalgMatrix )", "\033[0m" );
    
    return HomalgZeroMatrix( NrColumns( A ), NrColumns( B ), HomalgRing( B ) );
    
end );

#-----------------------------------
# LeftInverse
#-----------------------------------

##
InstallMethod( LeftInverse,
        "LIMAT: for homalg matrices (check input)",
        [ IsHomalgMatrix ], 10001,
        
  function( M )
    
    if NrRows( M ) < NrColumns( M ) then
        Error( "the number of rows ", NrRows( M ), " is smaller than the number of columns ", NrColumns( M ), "\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( LeftInverse,
        "LIMAT: for homalg matrices (IsOne)",
        [ IsHomalgMatrix and IsOne ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "LeftInverse( IsOne(Matrix) )", "\033[0m" );
    
    return M;
    
end );

##
InstallMethod( LeftInverse,
        "LIMAT: for homalg matrices (IsSubidentityMatrix)",
        [ IsHomalgMatrix and IsSubidentityMatrix ],
        
  function( M )
    local C;
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "LeftInverse( IsSubidentityMatrix )", "\033[0m" );
    
    C := Involution( M );
    
    SetEvalRightInverse( M, C );
    
    return C;
    
end );

##
InstallMethod( LeftInverse,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero ],
        
  function( M )
    
    if NrColumns( M ) = 0 then
        
        Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "LeftInverse( ? x 0 -- IsZero(Matrix) )", "\033[0m" );
        
        return HomalgZeroMatrix( 0, NrRows( M ), HomalgRing( M ) );
        
    else
        Error( "a zero matrix with positive number of columns has no left inverse!\n" );
    fi;
    
end );

#-----------------------------------
# RightInverse
#-----------------------------------

##
InstallMethod( RightInverse,
        "LIMAT: for homalg matrices (check input)",
        [ IsHomalgMatrix ], 10001,
        
  function( M )
    
    if NrColumns( M ) < NrRows( M ) then
        Error( "the number of columns ", NrColumns( M ), " is smaller than the number of rows ", NrRows( M ), "\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( RightInverse,
        "LIMAT: for homalg matrices (IsOne)",
        [ IsHomalgMatrix and IsOne ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "RightInverse( IsOne(Matrix) )", "\033[0m" );
    
    return M;
    
end );

##
InstallMethod( RightInverse,
        "LIMAT: for homalg matrices (IsSubidentityMatrix)",
        [ IsHomalgMatrix and IsSubidentityMatrix ],
        
  function( M )
    local C;
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "RightInverse( IsSubidentityMatrix )", "\033[0m" );
    
    C := Involution( M );
    
    SetEvalLeftInverse( M, C );
    
    return C;
    
end );

##
InstallMethod( RightInverse,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero ],
        
  function( M )
    
    if NrRows( M ) = 0 then
        
        Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "RightInverse( 0 x ? -- IsZero(Matrix) )", "\033[0m" );
        
        return HomalgZeroMatrix( NrColumns( M ), 0, HomalgRing( M ) );
        
    else
        Error( "a zero matrix with positive number of rows has no left inverse!\n" );
    fi;
    
end );

#-----------------------------------
# RowRankOfMatrix
#-----------------------------------

##
InstallMethod( RowRankOfMatrix,			 	## FIXME: make an extra InstallImmediateMethod when NonZeroRows( M ) is set
        "LIMAT: for homalg matrices (IsUpperStairCaseMatrix)",
        [ IsHomalgMatrix and IsUpperStairCaseMatrix ],
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if not ( HasIsIntegralDomain( R ) and IsIntegralDomain( R ) ) then
        TryNextMethod( );
    fi;
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "RowRankOfMatrix( IsTriangularMatrix over domain )", "\033[0m" );
    
    return Length( NonZeroRows( M ) );
    
end );

#-----------------------------------
# ColumnRankOfMatrix
#-----------------------------------

##
InstallMethod( ColumnRankOfMatrix,			## FIXME: make an extra InstallImmediateMethod when NonZeroColumns( M ) is set
        "LIMAT: for homalg matrices (IsLowerStairCaseMatrix)",
        [ IsHomalgMatrix and IsLowerStairCaseMatrix ],
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if not ( HasIsIntegralDomain( R ) and IsIntegralDomain( R ) ) then
        TryNextMethod( );
    fi;
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "ColumnRankOfMatrix( IsTriangularMatrix over domain )", "\033[0m" );
    
    return Length( NonZeroColumns( M ) );
    
end );

#-----------------------------------
# BasisOfRowModule
#-----------------------------------

##
InstallMethod( BasisOfRowModule,
        "LIMAT: for homalg matrices (IsBasisOfRowsMatrix)",
        [ IsHomalgMatrix and IsBasisOfRowsMatrix ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "BasisOfRowModule( IsBasisOfRowsMatrix )", "\033[0m" );
    
    return M;
    
end );

##
InstallMethod( BasisOfRowModule,
        "LIMAT: for homalg matrices (IsOne)",
        [ IsHomalgMatrix and IsOne ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "BasisOfRowModule( IsOne(Matrix) )", "\033[0m" );
    
    return M;
    
end );

##
InstallMethod( BasisOfRowModule,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "BasisOfRowModule( IsZero(Matrix) )", "\033[0m" );
    
    return HomalgZeroMatrix( 0, NrColumns( M ), HomalgRing( M ) );
    
end );

#-----------------------------------
# BasisOfColumnModule
#-----------------------------------

##
InstallMethod( BasisOfColumnModule,
        "LIMAT: for homalg matrices (IsBasisOfColumnsMatrix)",
        [ IsHomalgMatrix and IsBasisOfColumnsMatrix ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "BasisOfColumnModule( IsBasisOfColumnsMatrix )", "\033[0m" );
    
    return M;
    
end );

##
InstallMethod( BasisOfColumnModule,
        "LIMAT: for homalg matrices (IsOne)",
        [ IsHomalgMatrix and IsOne ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "BasisOfColumnModule( IsOne(Matrix) )", "\033[0m" );
    
    return M;
    
end );

##
InstallMethod( BasisOfColumnModule,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "BasisOfColumnModule( IsZero(Matrix) )", "\033[0m" );
    
    return HomalgZeroMatrix( NrRows( M ), 0, HomalgRing( M ) );
    
end );

#-----------------------------------
# ReducedBasisOfRowModule
#-----------------------------------

##
InstallMethod( ReducedBasisOfRowModule,
        "LIMAT: for homalg matrices (IsReducedBasisOfRowsMatrix)",
        [ IsHomalgMatrix and IsReducedBasisOfRowsMatrix ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "ReducedBasisOfRowModule( IsReducedBasisOfRowsMatrix )", "\033[0m" );
    
    return M;
    
end );

##
InstallMethod( ReducedBasisOfRowModule,
        "LIMAT: for homalg matrices (IsOne)",
        [ IsHomalgMatrix and IsOne ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "ReducedBasisOfRowModule( IsOne(Matrix) )", "\033[0m" );
    
    return M;
    
end );

##
InstallMethod( ReducedBasisOfRowModule,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "ReducedBasisOfRowModule( IsZero(Matrix) )", "\033[0m" );
    
    return HomalgZeroMatrix( 0, NrColumns( M ), HomalgRing( M ) );
    
end );

#-----------------------------------
# ReducedBasisOfColumnModule
#-----------------------------------

##
InstallMethod( ReducedBasisOfColumnModule,
        "LIMAT: for homalg matrices (IsReducedBasisOfColumnsMatrix)",
        [ IsHomalgMatrix and IsReducedBasisOfColumnsMatrix ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "ReducedBasisOfColumnModule( IsReducedBasisOfColumnsMatrix )", "\033[0m" );
    
    return M;
    
end );

##
InstallMethod( ReducedBasisOfColumnModule,
        "LIMAT: for homalg matrices (IsOne)",
        [ IsHomalgMatrix and IsOne ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "ReducedBasisOfColumnModule( IsOne(Matrix) )", "\033[0m" );
    
    return M;
    
end );

##
InstallMethod( ReducedBasisOfColumnModule,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "ReducedBasisOfColumnModule( IsZero(Matrix) )", "\033[0m" );
    
    return HomalgZeroMatrix( NrRows( M ), 0, HomalgRing( M ) );
    
end );

#-----------------------------------
# BasisOfRowsCoeff
#-----------------------------------

##
InstallMethod( BasisOfRowsCoeff,
        "LIMAT: for homalg matrices (IsBasisOfRowsMatrix)",
        [ IsHomalgMatrix and IsBasisOfRowsMatrix, IsHomalgMatrix and IsVoidMatrix ],
        
  function( M, T )
    local R;
    
    R := HomalgRing( M );
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "BasisOfRowsCoeff( IsBasisOfRowsMatrix, T )", "\033[0m" );
    
    SetPreEval( T, HomalgIdentityMatrix( NrRows( M ), R ) ); ResetFilterObj( T, IsVoidMatrix );
    
    return M;
    
end );

##
InstallMethod( BasisOfRowsCoeff,
        "LIMAT: for homalg matrices (IsOne)",
        [ IsHomalgMatrix and IsOne, IsHomalgMatrix and IsVoidMatrix ],
        
  function( M, T )
    local R;
    
    R := HomalgRing( M );
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "BasisOfRowsCoeff( IsOne(Matrix), T )", "\033[0m" );
    
    SetPreEval( T, HomalgIdentityMatrix( NrRows( M ), R ) ); ResetFilterObj( T, IsVoidMatrix );
    
    return M;
    
end );

##
InstallMethod( BasisOfRowsCoeff,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero, IsHomalgMatrix and IsVoidMatrix ],
        
  function( M, T )
    local R;
    
    R := HomalgRing( M );
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "BasisOfRowsCoeff( IsZero(Matrix), T )", "\033[0m" );
    
    SetPreEval( T, HomalgZeroMatrix( 0, NrRows( M ), R ) ); ResetFilterObj( T, IsVoidMatrix );
    
    return HomalgZeroMatrix( 0, NrColumns( M ), R );
    
end );

#-----------------------------------
# BasisOfColumnsCoeff
#-----------------------------------

##
InstallMethod( BasisOfColumnsCoeff,
        "LIMAT: for homalg matrices (IsBasisOfColumnsMatrix)",
        [ IsHomalgMatrix and IsBasisOfColumnsMatrix, IsHomalgMatrix and IsVoidMatrix ],
        
  function( M, T )
    local R;
    
    R := HomalgRing( M );
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "BasisOfColumnsCoeff( IsBasisOfColumnsMatrix, T )", "\033[0m" );
    
    SetPreEval( T, HomalgIdentityMatrix( NrColumns( M ), R ) ); ResetFilterObj( T, IsVoidMatrix );
    
    return M;
    
end );

##
InstallMethod( BasisOfColumnsCoeff,
        "LIMAT: for homalg matrices (IsOne)",
        [ IsHomalgMatrix and IsOne, IsHomalgMatrix and IsVoidMatrix ],
        
  function( M, T )
    local R;
    
    R := HomalgRing( M );
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "BasisOfColumnsCoeff( IsOne(Matrix), T )", "\033[0m" );
    
    SetPreEval( T, HomalgIdentityMatrix( NrColumns( M ), R ) ); ResetFilterObj( T, IsVoidMatrix );
    
    return M;
    
end );

##
InstallMethod( BasisOfColumnsCoeff,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero, IsHomalgMatrix and IsVoidMatrix ],
        
  function( M, T )
    local R;
    
    R := HomalgRing( M );
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "BasisOfColumnsCoeff( IsZero(Matrix), T )", "\033[0m" );
    
    SetPreEval( T, HomalgZeroMatrix( NrColumns( M ), 0, R ) ); ResetFilterObj( T, IsVoidMatrix );
    
    return HomalgZeroMatrix( NrRows( M ), 0, R );
    
end );

#-----------------------------------
# DecideZeroRows
#-----------------------------------

##
InstallMethod( DecideZeroRows,
        "LIMAT: for homalg matrices (check input)",
        [ IsHomalgMatrix, IsHomalgMatrix ], 10001,
        
  function( L, B )
    
    if not IsIdenticalObj( HomalgRing( L ), HomalgRing( B ) ) then
        Error( "the two matrices are not defined over identically the same ring\n" );
    fi;
    
    if NrColumns( L ) <> NrColumns( B ) then
        Error( "the number of columns of the two matrices must coincide\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( DecideZeroRows,
        "LIMAT: for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( L, B )
    
    if IsIdenticalObj( L, B ) then
        
        Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DecideZeroRows( M, M )", "\033[0m" );
        
        return 0 * L;
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( DecideZeroRows,
        "LIMAT: for homalg matrices (IsLeftInvertibleMatrix)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsLeftInvertibleMatrix ],
        
  function( L, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DecideZeroRows( IsHomalgMatrix, IsLeftInvertibleMatrix )", "\033[0m" );
    
    return 0 * L;
    
end );

##
InstallMethod( DecideZeroRows,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsZero ],
        
  function( L, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DecideZeroRows( IsHomalgMatrix, IsZero(Matrix) )", "\033[0m" );
    
    ## calling IsZero( L ) causes too much unnecessary trafic
    #IsZero( L );
    
    return L;
    
end );

##
InstallMethod( DecideZeroRows,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero, IsHomalgMatrix ],
        
  function( L, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DecideZeroRows( IsZero(Matrix), IsHomalgMatrix )", "\033[0m" );
    
    return L;
    
end );

#-----------------------------------
# DecideZeroColumns
#-----------------------------------

##
InstallMethod( DecideZeroColumns,
        "LIMAT: for homalg matrices (check input)",
        [ IsHomalgMatrix, IsHomalgMatrix ], 10001,
        
  function( L, B )
    
    if not IsIdenticalObj( HomalgRing( L ), HomalgRing( B ) ) then
        Error( "the two matrices are not defined over identically the same ring\n" );
    fi;
    
    if NrRows( L ) <> NrRows( B ) then
        Error( "the number of rows of the two matrices must coincide\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( DecideZeroColumns,
        "LIMAT: for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( L, B )
    
    if IsIdenticalObj( L, B ) then
        
        Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DecideZeroColumns( M, M )", "\033[0m" );
        
        return 0 * L;
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( DecideZeroColumns,
        "LIMAT: for homalg matrices (IsRightInvertibleMatrix)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsRightInvertibleMatrix ],
        
  function( L, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DecideZeroColumns( IsHomalgMatrix, IsRightInvertibleMatrix )", "\033[0m" );
    
    return 0 * L;
    
end );

##
InstallMethod( DecideZeroColumns,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsZero ],
        
  function( L, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DecideZeroColumns( IsHomalgMatrix, IsZero(Matrix) )", "\033[0m" );
    
    ## calling IsZero( L ) causes too much unnecessary trafic
    #IsZero( L );
    
    return L;
    
end );

##
InstallMethod( DecideZeroColumns,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero, IsHomalgMatrix ],
        
  function( L, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DecideZeroColumns( IsZero(Matrix), IsHomalgMatrix )", "\033[0m" );
    
    return L;
    
end );

#-----------------------------------
# DecideZeroRowsEffectively
#-----------------------------------

##
InstallMethod( DecideZeroRowsEffectively,
        "LIMAT: for homalg matrices (check input)",
        [ IsHomalgMatrix, IsHomalgMatrix, IsVoidMatrix ], 10001,
        
  function( A, B, T )
    
    if not IsIdenticalObj( HomalgRing( A ), HomalgRing( B ) ) then
        Error( "the two matrices are not defined over identically the same ring\n" );
    fi;
    
    if NrColumns( A ) <> NrColumns( B ) then
        Error( "the number of columns of the two matrices must coincide\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( DecideZeroRowsEffectively,
        "LIMAT: for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix, IsVoidMatrix ],
        
  function( A, B, T )
    
    if IsIdenticalObj( A, B ) then
        
        Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DecideZeroRowsEffectively( M, M, T )", "\033[0m" );
        
        SetPreEval( T, -HomalgIdentityMatrix( NrRows( A ), HomalgRing( A ) ) ); ResetFilterObj( T, IsVoidMatrix );
        
        return 0 * A;
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( DecideZeroRowsEffectively,
        "LIMAT: for homalg matrices (HasItsLeftInverse)",
        [ IsHomalgMatrix, IsHomalgMatrix and HasItsLeftInverse, IsVoidMatrix ],
        
  function( A, B, T )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DecideZeroRowsEffectively( IsHomalgMatrix, HasItsLeftInverse, T )", "\033[0m" );
    
    ## 0 = A + T * B
    SetPreEval( T, -A * ItsLeftInverse( B ) ); ResetFilterObj( T, IsVoidMatrix );
    
    return 0 * A;
    
end );

##
InstallMethod( DecideZeroRowsEffectively,
        "LIMAT: for homalg matrices (IsSpecialSubidentityMatrix)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsSpecialSubidentityMatrix, IsVoidMatrix ],
        
  function( A, B, T )
    local R, nz, l, r, c;
    
    R := HomalgRing( A );
    
    if HasRingRelations( R ) then
        TryNextMethod( );	## FIXME: this can be improved
    fi;
    
    nz := NonZeroColumns( B );
    
    l := Length( nz );
    
    if l = 0 then	## just to be on the safe side
        TryNextMethod( );
    fi;
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DecideZeroRowsEffectively( IsHomalgMatrix, IsSpecialSubidentityMatrix, T )", "\033[0m" );
    
    r := NrRows( A );
    c := NrColumns( A );
    
    ## M = A + T * B
    SetPreEval( T, -CertainColumns( A, nz ) ); ResetFilterObj( T, IsVoidMatrix );
    
    return UnionOfColumns(
                   UnionOfColumns( CertainColumns( A, [ 1 .. nz[1] - 1 ] ),
                           HomalgZeroMatrix( r, l, R ) ),
                   CertainColumns( A, [ nz[l] + 1 .. c ] ) );
    
end );

##
InstallMethod( DecideZeroRowsEffectively,
        "LIMAT: for homalg matrices (IsOne)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsOne, IsVoidMatrix ],
        
  function( A, B, T )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DecideZeroRowsEffectively( IsHomalgMatrix, IsOne(Matrix), T )", "\033[0m" );
    
    ## 0 = A + T * Id
    SetPreEval( T, -A ); ResetFilterObj( T, IsVoidMatrix );
    
    return 0 * A;
    
end );

##
InstallMethod( DecideZeroRowsEffectively,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsZero, IsVoidMatrix ],
        
  function( A, B, T )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DecideZeroRowsEffectively( IsHomalgMatrix, IsZero(Matrix), T )", "\033[0m" );
    
    SetPreEval( T, HomalgZeroMatrix( NrRows( A ), NrRows( B ), HomalgRing( A ) ) ); ResetFilterObj( T, IsVoidMatrix );
    
    return A;
    
end );

##
InstallMethod( DecideZeroRowsEffectively,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero, IsHomalgMatrix, IsVoidMatrix ],
        
  function( A, B, T )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DecideZeroRowsEffectively( IsZero(Matrix), IsHomalgMatrix, T )", "\033[0m" );
    
    SetPreEval( T, HomalgZeroMatrix( NrRows( A ), NrRows( B ), HomalgRing( A ) ) ); ResetFilterObj( T, IsVoidMatrix );
    
    return A;
    
end );

#-----------------------------------
# DecideZeroColumnsEffectively
#-----------------------------------

##
InstallMethod( DecideZeroColumnsEffectively,
        "LIMAT: for homalg matrices (check input)",
        [ IsHomalgMatrix, IsHomalgMatrix, IsVoidMatrix ], 10001,
        
  function( A, B, T )
    
    if not IsIdenticalObj( HomalgRing( A ), HomalgRing( B ) ) then
        Error( "the two matrices are not defined over identically the same ring\n" );
    fi;
    
    if NrRows( A ) <> NrRows( B ) then
        Error( "the number of rows of the two matrices must coincide\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( DecideZeroColumnsEffectively,
        "LIMAT: for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix, IsVoidMatrix ],
        
  function( A, B, T )
    
    if IsIdenticalObj( A, B ) then
        
        Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DecideZeroColumnsEffectively( M, M, T )", "\033[0m" );
        
        SetPreEval( T, -HomalgIdentityMatrix( NrColumns( A ), HomalgRing( A ) ) ); ResetFilterObj( T, IsVoidMatrix );
        
        return 0 * A;
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( DecideZeroColumnsEffectively,
        "LIMAT: for homalg matrices (HasItsRightInverse)",
        [ IsHomalgMatrix, IsHomalgMatrix and HasItsRightInverse, IsVoidMatrix ],
        
  function( A, B, T )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DecideZeroColumnsEffectively( IsHomalgMatrix, HasItsRightInverse, T )", "\033[0m" );
    
    ## 0 = A + B * T
    SetPreEval( T, ItsRightInverse( B ) * -A ); ResetFilterObj( T, IsVoidMatrix );
    
    return 0 * A;
    
end );

##
InstallMethod( DecideZeroColumnsEffectively,
        "LIMAT: for homalg matrices (IsSpecialSubidentityMatrix)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsSpecialSubidentityMatrix, IsVoidMatrix ],
        
  function( A, B, T )
    local R, nz, l, c, r;
    
    R := HomalgRing( A );
    
    if HasRingRelations( R ) then
        TryNextMethod( );	## FIXME: this can be improved
    fi;
    
    nz := NonZeroRows( B );
    
    l := Length( nz );
    
    if l = 0 then	## just to be on the safe side
        TryNextMethod( );
    fi;
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DecideZeroColumnsEffectively( IsHomalgMatrix, IsSpecialSubidentityMatrix, T )", "\033[0m" );
    
    c := NrColumns( A );
    r := NrRows( A );
    
    ## M = A + B * T
    SetPreEval( T, -CertainRows( A, nz ) ); ResetFilterObj( T, IsVoidMatrix );
    
    return UnionOfRows(
                   UnionOfRows( CertainRows( A, [ 1 .. nz[1] - 1 ] ),
                           HomalgZeroMatrix( l, c, R ) ),
                   CertainRows( A, [ nz[l] + 1 .. r ] ) );
    
end );

##
InstallMethod( DecideZeroColumnsEffectively,
        "LIMAT: for homalg matrices (IsOne)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsOne, IsVoidMatrix ],
        
  function( A, B, T )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DecideZeroColumnsEffectively( IsHomalgMatrix, IsOne(Matrix), T )", "\033[0m" );
    
    ## 0 = A + Id * T
    SetPreEval( T, -A ); ResetFilterObj( T, IsVoidMatrix );
    
    return 0 * A;
    
end );

##
InstallMethod( DecideZeroColumnsEffectively,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsZero, IsVoidMatrix ],
        
  function( A, B, T )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DecideZeroColumnsEffectively( IsHomalgMatrix, IsZero(Matrix), T )", "\033[0m" );
    
    SetPreEval( T, HomalgZeroMatrix( NrColumns( B ), NrColumns( A ), HomalgRing( A ) ) ); ResetFilterObj( T, IsVoidMatrix );
    
    return A;
    
end );

##
InstallMethod( DecideZeroColumnsEffectively,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero, IsHomalgMatrix, IsVoidMatrix ],
        
  function( A, B, T )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DecideZeroColumnsEffectively( IsZero(Matrix), IsHomalgMatrix, T )", "\033[0m" );
    
    SetPreEval( T, HomalgZeroMatrix( NrColumns( B ), NrColumns( A ), HomalgRing( A ) ) ); ResetFilterObj( T, IsVoidMatrix );
    
    return A;
    
end );

#-----------------------------------
# SyzygiesGeneratorsOfRows
#-----------------------------------

##
InstallMethod( SyzygiesGeneratorsOfRows,
        "LIMAT: for homalg matrices (check input)",
        [ IsHomalgMatrix, IsHomalgMatrix ], 10001,
        
  function( M1, M2 )
    
    if not IsIdenticalObj( HomalgRing( M1 ), HomalgRing( M2 ) ) then
        Error( "the two matrices are not defined over identically the same ring\n" );
    fi;
    
    if NrColumns( M1 ) <> NrColumns( M2 ) then
        Error( "the number of columns of the two matrices must coincide\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( SyzygiesGeneratorsOfRows,
        "LIMAT: for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( M1, M2 )
    
    if IsIdenticalObj( M1, M2 ) then
        
        Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "SyzygiesGeneratorsOfRows( M, M )", "\033[0m" );
        
        return HomalgIdentityMatrix( NrRows( M1 ), HomalgRing( M1 ) );
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( SyzygiesGeneratorsOfRows,
        "LIMAT: for homalg matrices (IsLeftRegular)",
        [ IsHomalgMatrix and IsLeftRegular ],
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "SyzygiesGeneratorsOfRows( IsLeftRegular )", "\033[0m" );
    
    return HomalgZeroMatrix( 0, NrRows( M ), HomalgRing( M ) );
    
end );

##
InstallMethod( SyzygiesGeneratorsOfRows,
        "LIMAT: for homalg matrices (IsOne)",
        [ IsHomalgMatrix and IsOne, IsHomalgMatrix ],
        
  function( M1, M2 )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "SyzygiesGeneratorsOfRows(IsOne(Matrix),IsHomalgMatrix)", "\033[0m" );
    
    return M2;
    
end );

##
InstallMethod( SyzygiesGeneratorsOfRows,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsZero ],
        
  function( M1, M2 )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "SyzygiesGeneratorsOfRows(IsHomalgMatrix,IsZero(Matrix))", "\033[0m" );
    
    return SyzygiesGeneratorsOfRows( M1 );
    
end );

##
InstallMethod( SyzygiesGeneratorsOfRows,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "SyzygiesGeneratorsOfRows( IsZero(Matrix) )", "\033[0m" );
    
    return HomalgIdentityMatrix( NrRows( M ), HomalgRing( M ) );
    
end );

##
InstallMethod( SyzygiesGeneratorsOfRows,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero, IsHomalgMatrix ],
        
  function( M1, M2 )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "SyzygiesGeneratorsOfRows(IsZero(Matrix),IsHomalgMatrix)", "\033[0m" );
    
    return HomalgIdentityMatrix( NrRows( M1 ), HomalgRing( M1 ) );
    
end );

#-----------------------------------
# SyzygiesGeneratorsOfColumns
#-----------------------------------

##
InstallMethod( SyzygiesGeneratorsOfColumns,
        "LIMAT: for homalg matrices (check input)",
        [ IsHomalgMatrix, IsHomalgMatrix ], 10001,
        
  function( M1, M2 )
    
    if not IsIdenticalObj( HomalgRing( M1 ), HomalgRing( M2 ) ) then
        Error( "the two matrices are not defined over identically the same ring\n" );
    fi;
    
    if NrRows( M1 ) <> NrRows( M2 ) then
        Error( "the number of rows of the two matrices must coincide\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( SyzygiesGeneratorsOfColumns,
        "LIMAT: for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( M1, M2 )
    
    if IsIdenticalObj( M1, M2 ) then
        
        Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "SyzygiesGeneratorsOfColumns( M, M )", "\033[0m" );
        
        return HomalgIdentityMatrix( NrColumns( M1 ), HomalgRing( M1 ) );
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( SyzygiesGeneratorsOfColumns,
        "LIMAT: for homalg matrices (IsRightRegular)",
        [ IsHomalgMatrix and IsRightRegular ],
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "SyzygiesGeneratorsOfColumns( IsRightRegular )", "\033[0m" );
    
    return HomalgZeroMatrix( NrColumns( M ), 0, HomalgRing( M ) );
    
end );

##
InstallMethod( SyzygiesGeneratorsOfColumns,
        "LIMAT: for homalg matrices (IsOne)",
        [ IsHomalgMatrix and IsOne, IsHomalgMatrix ],
        
  function( M1, M2 )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "SyzygiesGeneratorsOfColumns(IsOne(Matrix),IsHomalgMatrix)", "\033[0m" );
    
    return M2;
    
end );

##
InstallMethod( SyzygiesGeneratorsOfColumns,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsZero ],
        
  function( M1, M2 )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "SyzygiesGeneratorsOfColumns(IsHomalgMatrix,IsZero(Matrix))", "\033[0m" );
    
    return SyzygiesGeneratorsOfColumns( M1 );
    
end );

##
InstallMethod( SyzygiesGeneratorsOfColumns,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "SyzygiesGeneratorsOfColumns( IsZero(Matrix) )", "\033[0m" );
    
    return HomalgIdentityMatrix( NrColumns( M ), HomalgRing( M ) );
    
end );

##
InstallMethod( SyzygiesGeneratorsOfColumns,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero, IsHomalgMatrix ],
        
  function( M1, M2 )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "SyzygiesGeneratorsOfColumns(IsZero(Matrix),IsHomalgMatrix)", "\033[0m" );
    
    return HomalgIdentityMatrix( NrColumns( M1 ), HomalgRing( M1 ) );
    
end );

#-----------------------------------
# ReducedSyzygiesGeneratorsOfRows
#-----------------------------------

##
InstallMethod( ReducedSyzygiesGeneratorsOfRows,
        "LIMAT: for homalg matrices (IsLeftRegular)",
        [ IsHomalgMatrix and IsLeftRegular ],
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "ReducedSyzygiesGeneratorsOfRows( IsLeftRegular )", "\033[0m" );
    
    return HomalgZeroMatrix( 0, NrRows( M ), HomalgRing( M ) );
    
end );

##
InstallMethod( ReducedSyzygiesGeneratorsOfRows,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "ReducedSyzygiesGeneratorsOfRows( IsZero(Matrix) )", "\033[0m" );
    
    return HomalgIdentityMatrix( NrRows( M ), HomalgRing( M ) );
    
end );

#-----------------------------------
# ReducedSyzygiesGeneratorsOfColumns
#-----------------------------------

##
InstallMethod( ReducedSyzygiesGeneratorsOfColumns,
        "LIMAT: for homalg matrices (IsRightRegular)",
        [ IsHomalgMatrix and IsRightRegular ],
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "ReducedSyzygiesGeneratorsOfColumns( IsRightRegular )", "\033[0m" );
    
    return HomalgZeroMatrix( NrColumns( M ), 0, HomalgRing( M ) );
    
end );

##
InstallMethod( ReducedSyzygiesGeneratorsOfColumns,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "ReducedSyzygiesGeneratorsOfColumns( IsZero(Matrix) )", "\033[0m" );
    
    return HomalgIdentityMatrix( NrColumns( M ), HomalgRing( M ) );
    
end );

#-----------------------------------
# SyzygiesOfRows
#-----------------------------------

##
InstallMethod( SyzygiesOfRows,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsZero ],
        
  function( M1, M2 )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "SyzygiesOfRows(IsHomalgMatrix,IsZero(Matrix))", "\033[0m" );
    
    return SyzygiesOfRows( M1 );
    
end );

#-----------------------------------
# SyzygiesOfColumns
#-----------------------------------

##
InstallMethod( SyzygiesOfColumns,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsZero ],
        
  function( M1, M2 )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "SyzygiesOfColumns(IsHomalgMatrix,IsZero(Matrix))", "\033[0m" );
    
    return SyzygiesOfColumns( M1 );
    
end );

#-----------------------------------
# ReducedSyzygiesOfRows
#-----------------------------------

##
InstallMethod( ReducedSyzygiesOfRows,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsZero ],
        
  function( M1, M2 )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "ReducedSyzygiesOfRows(IsHomalgMatrix,IsZero(Matrix))", "\033[0m" );
    
    return ReducedSyzygiesOfRows( M1 );
    
end );

#-----------------------------------
# ReducedSyzygiesOfColumns
#-----------------------------------

##
InstallMethod( ReducedSyzygiesOfColumns,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsZero ],
        
  function( M1, M2 )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "ReducedSyzygiesOfColumns(IsHomalgMatrix,IsZero(Matrix))", "\033[0m" );
    
    return ReducedSyzygiesOfColumns( M1 );
    
end );

#-----------------------------------
# GetUnitPosition
#-----------------------------------

##
InstallMethod( GetUnitPosition,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "GetUnitPosition( IsZero(Matrix) )", "\033[0m" );
    
    return fail;
    
end );

#-----------------------------------
# GetColumnIndependentUnitPositions
#-----------------------------------

##
InstallMethod( GetColumnIndependentUnitPositions,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero, IsList ],
        
  function( M, pos_list )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "GetColumnIndependentUnitPositions( IsZero(Matrix) )", "\033[0m" );
    
    return [ ];
    
end );

#-----------------------------------
# GetRowIndependentUnitPositions
#-----------------------------------

##
InstallMethod( GetRowIndependentUnitPositions,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero, IsList ],
        
  function( M, pos_list )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "GetRowIndependentUnitPositions( IsZero(Matrix) )", "\033[0m" );
    
    return [ ];
    
end );

#-----------------------------------
# GetCleanRowsPositions
#-----------------------------------

##
InstallMethod( GetCleanRowsPositions,
        "LIMAT: for homalg matrices (IsEmpty list)",
        [ IsHomalgMatrix, IsList and IsEmpty ],
        
  function( M, pos_list )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "GetCleanRowsPositions( IsHomalgMatrix, IsEmpty(List) )", "\033[0m" );
    
    return [ ];
    
end );

