# SPDX-License-Identifier: GPL-2.0-or-later
# MatricesForHomalg: Matrices for the homalg project
#
# Implementations
#

##         LIMAT = Logical Implications for homalg MATrices

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
        IsHomalgMatrix and HasNumberRows and HasNumberColumns, 0,
        
  function( M )
    
    if NumberRows( M ) = 0 or NumberColumns( M ) = 0 then
        return true;
    else
        return false;
    fi;
    
end );

##
InstallImmediateMethod( IsOne,
        IsHomalgMatrix and HasNumberRows and HasNumberColumns, 0,
        
  function( M )
    
    if NumberRows( M ) = 0 or NumberColumns( M ) = 0 then
        return NumberRows( M ) = NumberColumns( M );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsOne,
        IsHomalgMatrix and HasNumberRows and HasNumberColumns, 0,
        
  function( M )
    
    if NumberRows( M ) <> NumberColumns( M ) then
        return false;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsOne,
        IsHomalgMatrix and IsPermutationMatrix and HasPositionOfFirstNonZeroEntryPerRow and HasNumberRows, 0,
        
  function( M )
    
    return PositionOfFirstNonZeroEntryPerRow( M ) = [ 1 .. NumberRows( M ) ];
    
end );

##
InstallImmediateMethod( IsOne,
        IsHomalgMatrix and IsPermutationMatrix and HasPositionOfFirstNonZeroEntryPerColumn and HasNumberColumns, 0,
        
  function( M )
    
    return PositionOfFirstNonZeroEntryPerColumn( M ) = [ 1 .. NumberColumns( M ) ];
    
end );

##
InstallImmediateMethod( IsZero,
        IsHomalgMatrix and HasPositionOfFirstNonZeroEntryPerRow, 0,
        
  function( M )
    
    return ForAll( PositionOfFirstNonZeroEntryPerRow( M ), IsZero );
    
end );

##
InstallImmediateMethod( IsZero,
        IsHomalgMatrix and HasPositionOfFirstNonZeroEntryPerColumn, 0,
        
  function( M )
    
    return ForAll( PositionOfFirstNonZeroEntryPerColumn( M ), IsZero );
    
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
        IsHomalgMatrix and HasZeroRows and HasNumberRows, 0,
        
  function( M )
    
    return Length( ZeroRows( M ) ) = NumberRows( M );
    
end );

##
InstallImmediateMethod( IsZero,
        IsHomalgMatrix and HasZeroColumns and HasNumberColumns, 0,
        
  function( M )
    
    return Length( ZeroColumns( M ) ) = NumberColumns( M );
    
end );

##
InstallImmediateMethod( IsRightInvertibleMatrix,
        IsHomalgMatrix and IsSubidentityMatrix, 0,
        
  function( M )
    
    return NumberRows( M ) <= NumberColumns( M );
    
end );

##
InstallImmediateMethod( IsRightInvertibleMatrix,
        IsHomalgMatrix and HasNumberRows, 0,
        
  function( M )
    
    if NumberRows( M ) = 0 then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsLeftInvertibleMatrix,
        IsHomalgMatrix and IsSubidentityMatrix, 0,
        
  function( M )
    
    return NumberColumns( M ) <= NumberRows( M );
    
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
InstallImmediateMethod( IsRightRegular,
        IsHomalgMatrix and IsLowerStairCaseMatrix and HasZeroColumns, 0,
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if not ( HasIsIntegralDomain( R ) and IsIntegralDomain( R ) ) then
        TryNextMethod( );
    fi;
    
    return ZeroColumns( M ) = [ ];
    
end );

##
InstallImmediateMethod( IsRightRegular,
        IsHomalgMatrix and HasNumberColumns and HasIsZero, 0,
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if NumberColumns( M ) = 1 and not IsZero( M ) and HasIsIntegralDomain( R ) and IsIntegralDomain( R ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsLeftRegular,
        IsHomalgMatrix and IsUpperStairCaseMatrix and HasZeroRows, 0,
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if not ( HasIsIntegralDomain( R ) and IsIntegralDomain( R ) ) then
        TryNextMethod( );
    fi;
    
    return ZeroRows( M ) = [ ];
    
end );

##
InstallImmediateMethod( IsLeftRegular,
        IsHomalgMatrix and HasNumberRows and HasIsZero, 0,
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if NumberRows( M ) = 1 and not IsZero( M ) and HasIsIntegralDomain( R ) and IsIntegralDomain( R ) then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsUpperStairCaseMatrix,
        IsHomalgMatrix and HasNumberRows, 0,
        
  function( M )
    
    if NumberRows( M ) = 1 then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( IsLowerStairCaseMatrix,
        IsHomalgMatrix and HasNumberColumns, 0,
        
  function( M )
    
    if NumberColumns( M ) = 1 then
        return true;
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( RowRankOfMatrix,
        IsHomalgMatrix and IsUpperStairCaseMatrix and HasNonZeroRows, 0,
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if not ( HasIsIntegralDomain( R ) and IsIntegralDomain( R ) ) then
        TryNextMethod( );
    fi;
    
    return Length( NonZeroRows( M ) );
    
end );

##
InstallImmediateMethod( ColumnRankOfMatrix,
        IsHomalgMatrix and IsLowerStairCaseMatrix and HasNonZeroColumns, 0,
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if not ( HasIsIntegralDomain( R ) and IsIntegralDomain( R ) ) then
        TryNextMethod( );
    fi;
    
    return Length( NonZeroColumns( M ) );
    
end );

####################################
#
# immediate methods for attributes:
#
####################################

##
InstallImmediateMethod( NumberRows,
        IsHomalgMatrix and HasPositionOfFirstNonZeroEntryPerRow, 0,
        
  function( M )
    
    return Length( PositionOfFirstNonZeroEntryPerRow( M ) );
    
end );

##
InstallImmediateMethod( NumberColumns,
        IsHomalgMatrix and HasPositionOfFirstNonZeroEntryPerColumn, 0,
        
  function( M )
    
    return Length( PositionOfFirstNonZeroEntryPerColumn( M ) );
    
end );

##
InstallImmediateMethod( RowRankOfMatrix,
        IsHomalgMatrix and IsOne and HasNumberRows, 0,
        
  function( M )
    
    return NumberRows( M );
        
end );

##
InstallImmediateMethod( ColumnRankOfMatrix,
        IsHomalgMatrix and IsOne and HasNumberColumns, 0,
        
  function( M )
    
    return NumberColumns( M );
        
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
InstallImmediateMethod( RowRankOfMatrix,
        IsHomalgMatrix and HasIsLeftRegular and HasNumberRows, 0,
        
  function( M )
    
    if IsLeftRegular( M ) then
        return NumberRows( M );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( ColumnRankOfMatrix,
        IsHomalgMatrix and HasIsRightRegular and HasNumberColumns, 0,
        
  function( M )
    
    if IsRightRegular( M ) then
        return NumberColumns( M );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( RowRankOfMatrix,
        IsHomalgMatrix and HasColumnRankOfMatrix, 0,
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if HasIsFieldForHomalg( R ) and IsFieldForHomalg( R ) then ## FIXME: make me more general!
        return ColumnRankOfMatrix( M );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( ColumnRankOfMatrix,
        IsHomalgMatrix and HasRowRankOfMatrix, 0,
        
  function( M )
    local R;
    
    R := HomalgRing( M );
    
    if HasIsFieldForHomalg( R ) and IsFieldForHomalg( R ) then ## FIXME: make me more general!
        return RowRankOfMatrix( M );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( ZeroRows,
        IsHomalgMatrix and HasIsZero and HasNumberRows, 0,
        
  function( M )
    
    if not IsZero( M ) and NumberRows( M ) = 1 then
        return [ ];
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( ZeroRows,
        IsHomalgMatrix and IsOne, 0,
        
  function( M )
    
    return [ ];
        
end );

##
InstallImmediateMethod( ZeroRows,
        IsHomalgMatrix and IsZero and HasNumberRows, 0,
        
  function( M )
    
    return [ 1 .. NumberRows( M ) ];
        
end );

##
InstallImmediateMethod( ZeroRows,
        IsHomalgMatrix and HasPositionOfFirstNonZeroEntryPerRow and HasNumberRows, 0,
        
  function( M )
    local pos;
    
    pos := PositionOfFirstNonZeroEntryPerRow( M );
    
    return Filtered( [ 1 .. NumberRows( M ) ], i -> pos[i] = 0 );
    
end );

##
InstallImmediateMethod( ZeroRows,
        IsHomalgMatrix and HasPositionOfFirstNonZeroEntryPerColumn and IsSubidentityMatrix and HasNumberRows, 0,
        
  function( M )
    local pos;
    
    pos := PositionOfFirstNonZeroEntryPerColumn( M );
    
    return Filtered( [ 1 .. NumberRows( M ) ], i -> not i in pos );
    
end );

##
InstallImmediateMethod( ZeroRows,
        IsHomalgMatrix and HasEvalCertainRows, 0,
        
  function( M )
    local e;
    
    e := EvalCertainRows( M );
    
    if not HasZeroRows( e[1] ) then
        TryNextMethod( );
    fi;
    
    return SortedList( List( Intersection2( ZeroRows( e[1] ), e[2] ), i -> Position( e[2], i ) ) );
    
end );

##
InstallImmediateMethod( ZeroColumns,
        IsHomalgMatrix and HasIsZero and HasNumberColumns, 0,
        
  function( M )
    
    if not IsZero( M ) and NumberColumns( M ) = 1 then
        return [ ];
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
        IsHomalgMatrix and IsZero and HasNumberColumns, 0,
        
  function( M )
    
    return [ 1 .. NumberColumns( M ) ];
        
end );

##
InstallImmediateMethod( ZeroColumns,
        IsHomalgMatrix and HasPositionOfFirstNonZeroEntryPerColumn and HasNumberColumns, 0,
        
  function( M )
    local pos;
    
    pos := PositionOfFirstNonZeroEntryPerColumn( M );
    
    return Filtered( [ 1 .. NumberColumns( M ) ], i -> pos[i] = 0 );
    
end );

##
InstallImmediateMethod( ZeroColumns,
        IsHomalgMatrix and HasPositionOfFirstNonZeroEntryPerRow and IsSubidentityMatrix and HasNumberColumns, 0,
        
  function( M )
    local pos;
    
    pos := PositionOfFirstNonZeroEntryPerRow( M );
    
    return Filtered( [ 1 .. NumberColumns( M ) ], i -> not i in pos );
    
end );

##
InstallImmediateMethod( ZeroColumns,
        IsHomalgMatrix and HasEvalCertainColumns, 0,
        
  function( M )
    local e;
    
    e := EvalCertainColumns( M );
    
    if not HasZeroColumns( e[1] ) then
        TryNextMethod( );
    fi;
    
    return SortedList( List( Intersection2( ZeroColumns( e[1] ), e[2] ), i -> Position( e[2], i ) ) );
    
end );

##
InstallImmediateMethod( NonZeroRows,
        IsHomalgMatrix and HasZeroRows and HasNumberRows, 0,
        
  function( M )
    
    return Filtered( [ 1 .. NumberRows( M ) ], a -> not a in ZeroRows( M ) );
        
end );

##
InstallImmediateMethod( NonZeroRows,
        IsHomalgMatrix and IsOne and HasNumberRows, 0,
        
  function( M )
    
    return [ 1 .. NumberRows( M ) ];
        
end );

##
InstallImmediateMethod( NonZeroRows,
        IsHomalgMatrix and IsZero, 0,
        
  function( M )
    
    return [ ];
        
end );

##
InstallImmediateMethod( NonZeroColumns,
        IsHomalgMatrix and HasZeroColumns and HasNumberColumns, 0,
        
  function( M )
    
    return Filtered( [ 1 .. NumberColumns( M ) ], a -> not a in ZeroColumns( M ) );
        
end );

##
InstallImmediateMethod( NonZeroColumns,
        IsHomalgMatrix and IsOne and HasNumberColumns, 0,
        
  function( M )
    
    return [ 1 .. NumberColumns( M ) ];
        
end );

##
InstallImmediateMethod( NonZeroColumns,
        IsHomalgMatrix and IsZero, 0,
        
  function( M )
    
    return [ ];
        
end );

##
InstallImmediateMethod( PositionOfFirstNonZeroEntryPerRow,
        IsHomalgMatrix and IsOne and HasNumberRows, 0,
        
  function( M )
    
    if not ( HasIsZero( M ) and IsZero( M ) ) then
        return [ 1 .. NumberRows( M ) ];
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( PositionOfFirstNonZeroEntryPerRow,
        IsHomalgMatrix and IsZero and HasNumberRows, 0,
        
  function( M )
    
    return ListWithIdenticalEntries( NumberRows( M ), 0 );
    
end );

##
InstallImmediateMethod( PositionOfFirstNonZeroEntryPerColumn,
        IsHomalgMatrix and IsOne and HasNumberColumns, 0,
        
  function( M )
    
    if not ( HasIsZero( M ) and IsZero( M ) ) then
        return [ 1 .. NumberColumns( M ) ];
    fi;
    
    TryNextMethod( );
    
end );

##
InstallImmediateMethod( PositionOfFirstNonZeroEntryPerColumn,
        IsHomalgMatrix and IsZero and HasNumberColumns, 0,
        
  function( M )
    
    return ListWithIdenticalEntries( NumberColumns( M ), 0 );
    
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
        
    elif IsBound( RP!.RowEchelonForm ) then
        
        B := RP!.RowEchelonForm( M );
        
        if HasRowRankOfMatrix( B ) then
            return RowRankOfMatrix( B );
        fi;
        
    elif IsBound( RP!.ReducedRowEchelonForm ) then
        
        B := RP!.ReducedRowEchelonForm( M );
        
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
        
        return RP!.RowRankOfMatrix( Involution( M ) ); ## in most cases Involution is obsolete
        
    elif IsBound( RP!.ColumnEchelonForm ) then
        
        B := RP!.ColumnEchelonForm( M );
        
        if HasColumnRankOfMatrix( B ) then
            return ColumnRankOfMatrix( B );
        fi;
        
    elif IsBound( RP!.ReducedColumnEchelonForm ) then
        
        B := RP!.ReducedColumnEchelonForm( M );
        
        if HasColumnRankOfMatrix( B ) then
            return ColumnRankOfMatrix( B );
        fi;
        
    elif IsBound( RP!.ReducedRowEchelonForm ) then
        
        N := Involution( M );
        
        B := RP!.ReducedRowEchelonForm( N );
        
        if HasRowRankOfMatrix( B ) then
            return RowRankOfMatrix( B );
        fi;
        
    elif IsBound( RP!.RowEchelonForm ) then
        
        N := Involution( M );
        
        B := RP!.RowEchelonForm( N );
        
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

##
InstallMethod( IndicatorMatrixOfNonZeroEntries,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero ],
        
  function( mat )
    local result;
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IndicatorMatrixOfNonZeroEntries(IsZero(Matrix))", "\033[0m" );
    
    result := ListWithIdenticalEntries( NumberColumns( mat ), 0 );
    result := List( [ 1 .. NumberRows( mat ) ], a -> ShallowCopy( result ) );
    
    return result;
    
end );

##
InstallMethod( IndicatorMatrixOfNonZeroEntries,
        "LIMAT: for homalg matrices (IsOne)",
        [ IsHomalgMatrix and IsOne ],
        
  function( mat )
    local result, i;
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IndicatorMatrixOfNonZeroEntries(IsOne(Matrix))", "\033[0m" );
    
    result := ListWithIdenticalEntries( NumberColumns( mat ), 0 );
    result := List( [ 1 .. NumberRows( mat ) ], a -> ShallowCopy( result ) );
    
    for i in [ 1 .. NumberRows( mat ) ] do
        result[i][i] := 1;
    od;
    
    return result;
    
end );

####################################
#
# methods for properties:
#
####################################
    
##
InstallMethod( IsEmptyMatrix,
        "LIMAT: for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    
    return NumberRows( M ) = 0 or NumberColumns( M ) = 0;
    
end );

##
InstallMethod( IsRightRegular,
        "LIMAT: for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    
    return NumberColumns( SyzygiesGeneratorsOfColumns( M ) ) = 0;
    
end );

##
InstallMethod( IsLeftRegular,
        "LIMAT: for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    
    return NumberRows( SyzygiesGeneratorsOfRows( M ) ) = 0;
    
end );

##
InstallMethod( IsSpecialSubidentityMatrix,
        "LIMAT: for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local r, c, nz, l;
    
    r := NumberRows( M );
    c := NumberColumns( M );
    
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

##
InstallMethod( IsUnitFree,
        "LIMAT: for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    
    return GetUnitPosition( M ) = fail;
    
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
    
    return HomalgZeroMatrix( NumberColumns( M ), NumberRows( M ), HomalgRing( M ) );
    
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
# TransposedMatrix
#-----------------------------------

##
InstallMethod( TransposedMatrix,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "TransposedMatrix( IsZero(Matrix) )", "\033[0m" );
    
    return HomalgZeroMatrix( NumberColumns( M ), NumberRows( M ), HomalgRing( M ) );
    
end );

##
InstallMethod( TransposedMatrix,
        "LIMAT: for homalg matrices (IsOne)",
        [ IsHomalgMatrix and IsOne ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "TransposedMatrix( IsOne(Matrix) )", "\033[0m" );
    
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
    
    if not IsSubset( [ 1 .. NumberRows( M ) ], plist ) then
        Error( "the list of row positions ", plist, " must be in the range [ 1 .. ", NumberRows( M ), " ]\n" );
    fi;
    
    if NumberRows( M ) = 0 or plist = [ 1 .. NumberRows( M ) ] then
        return M;
    elif plist = [ ] then
        return HomalgZeroMatrix( 0, NumberColumns( M ), HomalgRing( M ) );
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
    
    if not IsSubset( [ 1 .. NumberColumns( M ) ], plist ) then
        Error( "the list of column positions ", plist, " must be in the range [ 1 .. ", NumberColumns( M ), " ]\n" );
    fi;
    
    if NumberColumns( M ) = 0 or plist = [ 1 .. NumberColumns( M ) ] then
        return M;
    elif plist = [ ] then
        return HomalgZeroMatrix( NumberRows( M ), 0, HomalgRing( M ) );
    fi;
    
    TryNextMethod( );
    
end );

#-----------------------------------
# UnionOfRows
#-----------------------------------

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

#-----------------------------------
# UnionOfColumns
#-----------------------------------

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

#-----------------------------------
# DiagMat
#-----------------------------------

##
InstallMethod( DiagMat,
        "LIMAT: of a homalg ring and a list of homalg matrices (check input)",
        [ IsHomalgRing, IsHomogeneousList ], 10001,
        
  function( R, l )
    
    if not ForAll( l, IsHomalgMatrix ) then
        Error( "at least one of the matrices in the list is not a homalg matrix\n" );
    fi;
    
    if Length( l ) = 1 then
        return l[1];
    fi;
    
    if not ForAll( l, a -> IsIdenticalObj( HomalgRing( a ), R ) ) then
        Error( "the matrices are not defined over identically the same ring\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( DiagMat,
        "LIMAT: of a homalg ring and a list of homalg matrices",
        [ IsHomalgRing, IsHomogeneousList ], 2,
        
  function( R, l )
    
    if ForAll( l, HasIsOne and IsOne ) then
        
        Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DiagMat( [ identity matrices ] )", "\033[0m" );
        
        return HomalgIdentityMatrix( Sum( List( l, NumberRows ) ), Sum( List( l, NumberColumns ) ), R );
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( DiagMat,
        "LIMAT: of a homalg ring and a list of homalg matrices",
        [ IsHomalgRing, IsHomogeneousList ], 2,
        
  function( R, l )
    
    if ForAll( l, HasIsZero and IsZero ) then
        
        Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DiagMat( [ zero matrices ] )", "\033[0m" );
        
        return HomalgZeroMatrix( Sum( List( l, NumberRows ) ), Sum( List( l, NumberColumns ) ), R );
        
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
    
    return DiagMat( HomalgRing( A ), ListWithIdenticalEntries( NumberRows( A ), B ) );
    
end );

##
InstallMethod( KroneckerMat,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero, IsHomalgMatrix ], 1001, ## FIXME: this must be ranked higher than the "KroneckerMat( IsOne, IsHomalgMatrix )", why?
        
  function( A, B )
    local R;
    
    R := HomalgRing( A );
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "KroneckerMat( IsZero(Matrix), IsHomalgMatrix )", "\033[0m" );
    
    return HomalgZeroMatrix( NumberRows( A ) * NumberRows( B ), NumberColumns( A ) * NumberColumns( B ), R );
    
end );

##
InstallMethod( KroneckerMat,
        "LIMAT: for homalg matrices (IsOne)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsOne ],
        
  function( A, B )
    local R;
    
    R := HomalgRing( A );
    
    if ( HasNumberRows( B ) and NumberRows( B ) = 1 )
       or ( HasNumberColumns( B ) and NumberColumns( B ) = 1 ) then
        
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
    
    return HomalgZeroMatrix( NumberRows( A ) * NumberRows( B ), NumberColumns( A ) * NumberColumns( B ), R );
    
end );

#-----------------------------------
# DualKroneckerMat
#-----------------------------------

##
InstallMethod( DualKroneckerMat,
        "LIMAT: for homalg matrices (check input)",
        [ IsHomalgMatrix, IsHomalgMatrix ], 10001,
        
  function( A, B )
    
    if not IsIdenticalObj( HomalgRing( A ), HomalgRing( B ) ) then
        Error( "the two matrices are not defined over identically the same ring\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( DualKroneckerMat,
        "LIMAT: for homalg matrices (IsOne)",
        [ IsHomalgMatrix and IsOne, IsHomalgMatrix ],
        
  function( A, B )
    local R;
    
    R := HomalgRing( A );
    
    if ( HasNumberRows( A ) and NumberRows( A ) = 1 )
       or ( HasNumberColumns( A ) and NumberColumns( A ) = 1 ) then
        
        Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DualKroneckerMat( (1), IsHomalgMatrix )", "\033[0m" );
        
        return B;
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( DualKroneckerMat,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero, IsHomalgMatrix ], 1001, ## FIXME: this must be ranked higher than the "DualKroneckerMat( IsOne, IsHomalgMatrix )", why?
        
  function( A, B )
    local R;
    
    R := HomalgRing( A );
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DualKroneckerMat( IsZero(Matrix), IsHomalgMatrix )", "\033[0m" );
    
    return HomalgZeroMatrix( NumberRows( A ) * NumberRows( B ), NumberColumns( A ) * NumberColumns( B ), R );
    
end );

##
InstallMethod( DualKroneckerMat,
        "LIMAT: for homalg matrices (IsOne)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsOne ],
        
  function( A, B )
    local R;
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DualKroneckerMat( IsHomalgMatrix, IsOne(Matrix) )", "\033[0m" );
    
    return DiagMat( HomalgRing( A ), ListWithIdenticalEntries( NumberRows( B ), A ) );
    
end );

##
InstallMethod( DualKroneckerMat,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsZero ],
        
  function( A, B )
    local R;
    
    R := HomalgRing( A );
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DualKroneckerMat( IsHomalgMatrix, IsZero(Matrix) )", "\033[0m" );
    
    return HomalgZeroMatrix( NumberRows( A ) * NumberRows( B ), NumberColumns( A ) * NumberColumns( B ), R );
    
end );

#-----------------------------------
# MulMatRight
#-----------------------------------

##
InstallMethod( \*,
        "LIMAT: for a homalg matrix and a ring element (check input)",
        [ IsHomalgMatrix, IsHomalgRingElement ], 12001,
        
  function( A, a )
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
        [ IsHomalgMatrix, IsRingElement and IsZero ], 10001,
        
  function( A, a )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsHomalgMatrix * IsZero", "\033[0m" );
    
    return HomalgZeroMatrix( NumberRows( A ), NumberColumns( A ), HomalgRing( A ) );
    
end );

##
InstallMethod( \*,
        "LIMAT: for homalg matrices with ring elements",
        [ IsHomalgMatrix, IsRingElement and IsOne ], 10001,
        
  function( A, a )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsHomalgMatrix * IsOne(Matrix)", "\033[0m" );
    
    return A;
    
end );

##
InstallMethod( \*,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero, IsRingElement ], 10001,
        
  function( A, a )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsZero(Matrix) * IsRingElement", "\033[0m" );
    
    return A;
    
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
    
    return HomalgZeroMatrix( NumberRows( A ), NumberColumns( A ), HomalgRing( A ) );
    
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
    
    if NumberRows( A ) <> NumberRows( B ) then
        Error( "the two matrices are not summable, since the first one has ", NumberRows( A ), " row(s), while the second ", NumberRows( B ), "\n" );
    fi;
    
    if NumberColumns( A ) <> NumberColumns( B ) then
        Error( "the two matrices are not summable, since the first one has ", NumberColumns( A ), " column(s), while the second ", NumberColumns( B ), "\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \+,
        "LIMAT: for two homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero, IsHomalgMatrix ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsZero(Matrix) + IsHomalgMatrix", "\033[0m", "    ", NumberRows( A ), " x ", NumberColumns( A ) );
    
    return B;
    
end );

##
InstallMethod( \+,
        "LIMAT: for two homalg matrices (IsZero)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsZero ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsHomalgMatrix + IsZero(Matrix)", "\033[0m", "    ", NumberRows( A ), " x ", NumberColumns( A ) );
    
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
    
    if NumberRows( A ) <> NumberRows( B ) then
        Error( "the two matrices are not subtractable, since the first one has ", NumberRows( A ), " row(s), while the second ", NumberRows( B ), "\n" );
    fi;
    
    if NumberColumns( A ) <> NumberColumns( B ) then
        Error( "the two matrices are not subtractable, since the first one has ", NumberColumns( A ), " column(s), while the second ", NumberColumns( B ), "\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \-,
        "LIMAT: for two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ], 1000,
        
  function( A, B )
    
    if IsIdenticalObj( A, B ) then
        
        Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "M - M", "\033[0m", "    ", NumberRows( A ), " x ", NumberColumns( A ) );
        
        return 0 * A;
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \-,
        "LIMAT: for two homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero, IsHomalgMatrix ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsZero(Matrix) - IsHomalgMatrix", "\033[0m", "    ", NumberRows( A ), " x ", NumberColumns( A ) );
    
    return -B;
    
end );

##
InstallMethod( \-,
        "LIMAT: for two homalg matrices (IsZero)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsZero ],
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsHomalgMatrix - IsZero(Matrix)", "\033[0m", "    ", NumberRows( A ), " x ", NumberColumns( A ) );
    
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
    
    if NumberColumns( A ) <> NumberRows( B ) then
        Error( "the two matrices are not composable, since the first one has ", NumberColumns( A ), " column(s), while the second ", NumberRows( B ), " row(s)\n" );
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( \*,
        "LIMAT: for two homalg matrices (IsSubidentityMatrix)",
        [ IsHomalgMatrix and IsSubidentityMatrix and HasEvalCertainRows and IsRightInvertibleMatrix, IsHomalgMatrix ], 16001,
        
  function( A, B )
    local id;
    
    id := EvalCertainRows( A )[1];
    
    if not ( HasIsOne( id ) and IsOne( id ) ) then
        TryNextMethod( );
    fi;
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "CertainRows(IsOne(Matrix)) * IsHomalgMatrix", "\033[0m", "    ", NumberRows( A ), " x ", NumberColumns( A ), " x ", NumberColumns( B ) );
    
    return CertainRows( B, EvalCertainRows( A )[2] );
    
end );

##
InstallMethod( \*,
        "LIMAT: for two homalg matrices (IsSubidentityMatrix)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsSubidentityMatrix and HasEvalCertainColumns and IsLeftInvertibleMatrix ], 16001,
        
  function( A, B )
    local id;
    
    id := EvalCertainColumns( B )[1];
    
    if not ( HasIsOne( id ) and IsOne( id ) ) then
        TryNextMethod( );
    fi;
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsHomalgMatrix * CertainColumns(IsOne(Matrix))", "\033[0m", "    ", NumberRows( A ), " x ", NumberColumns( A ), " x ", NumberColumns( B ) );
    
    return CertainColumns( A, EvalCertainColumns( B )[2] );
    
end );

##
InstallMethod( \*,
        "LIMAT: for two homalg matrices (IsOne)",
        [ IsHomalgMatrix and IsOne, IsHomalgMatrix ], 17001,
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsOne(Matrix) * IsHomalgMatrix", "\033[0m", "    ", NumberRows( A ), " x ", NumberColumns( A ), " x ", NumberColumns( B ) );
    
    return B;
    
end );

##
InstallMethod( \*,
        "LIMAT: for two homalg matrices (IsOne)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsOne ], 17001,
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsHomalgMatrix * IsOne(Matrix)", "\033[0m", "    ", NumberRows( A ), " x ", NumberColumns( A ), " x ", NumberColumns( B ) );
    
    return A;
    
end );

##
InstallMethod( \*,
        "LIMAT: for two homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero, IsHomalgMatrix ], 17001,
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsZero(Matrix) * IsHomalgMatrix", "\033[0m", "    ", NumberRows( A ), " x ", NumberColumns( A ), " x ", NumberColumns( B ) );
    
    if NumberRows( B ) = NumberColumns( B ) then
        return A;
    else
        return HomalgZeroMatrix( NumberRows( A ), NumberColumns( B ), HomalgRing( A ) );
    fi;
    
end );

##
InstallMethod( \*,
        "LIMAT: for two homalg matrices (IsZero)",
        [ IsHomalgMatrix, IsHomalgMatrix and IsZero ], 17001,
        
  function( A, B )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "IsHomalgMatrix * IsZero(Matrix)", "\033[0m", "    ", NumberRows( A ), " x ", NumberColumns( A ), " x ", NumberColumns( B ) );
    
    if NumberRows( A ) = NumberColumns( A ) then
        return B;
    else
        return HomalgZeroMatrix( NumberRows( A ), NumberColumns( B ), HomalgRing( B ) );
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
    
    if NumberColumns( A ) <> NumberColumns( B ) then
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
        
        return HomalgIdentityMatrix( NumberRows( A ), HomalgRing( A ) );
        
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
    
    return HomalgZeroMatrix( NumberRows( B ), NumberRows( A ), HomalgRing( B ) );
    
end );

##
InstallMethod( RightDivide,
        "LIMAT: for homalg matrices (check input)",
        [ IsHomalgMatrix, IsHomalgMatrix, IsHomalgMatrix ], 10001,
        
  function( B, A, L )
    
    if NumberColumns( A ) <> NumberColumns( B ) then
        Error( "the first and the second matrix must have the same number of columns\n" );
    fi;
    
    if NumberColumns( A ) <> NumberColumns( L ) then
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
        
        return HomalgIdentityMatrix( NumberRows( A ), HomalgRing( A ) );
        
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
    
    return HomalgZeroMatrix( NumberRows( B ), NumberRows( A ), HomalgRing( B ) );
    
end );

#-----------------------------------
# LeftDivide
#-----------------------------------

##
InstallMethod( LeftDivide,
        "LIMAT: for homalg matrices (check input)",
        [ IsHomalgMatrix, IsHomalgMatrix ], 10001,
        
  function( A, B )
    
    if NumberRows( A ) <> NumberRows( B ) then
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
        
        return HomalgIdentityMatrix( NumberColumns( A ), HomalgRing( A ) );
        
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
    
    return HomalgZeroMatrix( NumberColumns( A ), NumberColumns( B ), HomalgRing( B ) );
    
end );

##
InstallMethod( LeftDivide,
        "LIMAT: for homalg matrices (check input)",
        [ IsHomalgMatrix, IsHomalgMatrix, IsHomalgMatrix ], 10001,
        
  function( A, B, L )
    
    if NumberRows( A ) <> NumberRows( B ) then
        Error( "the first and the second matrix must have the same number of rows\n" );
    fi;
    
    if NumberRows( A ) <> NumberRows( L ) then
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
        
        return HomalgIdentityMatrix( NumberColumns( A ), HomalgRing( A ) );
        
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
    
    return HomalgZeroMatrix( NumberColumns( A ), NumberColumns( B ), HomalgRing( B ) );
    
end );

#-----------------------------------
# LeftInverse
#-----------------------------------

##
InstallMethod( LeftInverse,
        "LIMAT: for homalg matrices (check input)",
        [ IsHomalgMatrix ], 10001,
        
  function( M )
    
    if NumberRows( M ) < NumberColumns( M ) then
        Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "LeftInverse( NumberRows < NumberColumns )", "\033[0m" );
        return false;
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
        [ IsHomalgMatrix and IsSubidentityMatrix and HasEvalCertainColumns ],
        
  function( M )
    local C;
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "LeftInverse( CertainColumns(IsOne(Matrix)) )", "\033[0m" );
    
    ## the consistency test is performed by a high rank method above
    C := EvalCertainColumns( M );
    
    C := CertainRows( Involution( C[1] ), C[2] ); ## Involution( Id ) = Id;
    
    SetRightInverse( M, C );
    
    return C;
    
end );

##
InstallMethod( LeftInverse,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero ],
        
  function( M )
    
    if NumberColumns( M ) = 0 then
        
        Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "LeftInverse( ? x 0 -- IsZero(Matrix) )", "\033[0m" );
        
        return HomalgZeroMatrix( 0, NumberRows( M ), HomalgRing( M ) );
        
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
    
    if NumberColumns( M ) < NumberRows( M ) then
        Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "RightInverse( NumberColumns < NumberRows )", "\033[0m" );
        return false;
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
        [ IsHomalgMatrix and IsSubidentityMatrix and HasEvalCertainRows ],
        
  function( M )
    local C;
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "RightInverse( CertainRows(IsOne(Matrix)) )", "\033[0m" );
    
    ## the consistency test is performed by a high rank method above
    C := EvalCertainRows( M );
    
    C := CertainColumns( Involution( C[1] ), C[2] ); ## Involution( Id ) = Id;
    
    SetLeftInverse( M, C );
    
    return C;
    
end );

##
InstallMethod( RightInverse,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero ],
        
  function( M )
    
    if NumberRows( M ) = 0 then
        
        Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "RightInverse( 0 x ? -- IsZero(Matrix) )", "\033[0m" );
        
        return HomalgZeroMatrix( NumberColumns( M ), 0, HomalgRing( M ) );
        
    else
        Error( "a zero matrix with positive number of rows has no left inverse!\n" );
    fi;
    
end );

#-----------------------------------
# RowRankOfMatrix
#-----------------------------------

##
InstallMethod( RowRankOfMatrix, ## FIXME: make an extra InstallImmediateMethod when NonZeroRows( M ) is set
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
InstallMethod( ColumnRankOfMatrix, ## FIXME: make an extra InstallImmediateMethod when NonZeroColumns( M ) is set
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
# RowEchelonForm
#-----------------------------------

##
InstallMethod( RowEchelonForm,
        "LIMAT: for homalg matrices (IsBasisOfRowsMatrix)",
        [ IsHomalgMatrix and IsBasisOfRowsMatrix ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "RowEchelonForm( IsBasisOfRowsMatrix )", "\033[0m" );
    
    return M;
    
end );

##
InstallMethod( RowEchelonForm,
        "LIMAT: for homalg matrices (IsOne)",
        [ IsHomalgMatrix and IsOne ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "RowEchelonForm( IsOne(Matrix) )", "\033[0m" );
    
    return M;
    
end );

##
InstallMethod( RowEchelonForm,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "RowEchelonForm( IsZero(Matrix) )", "\033[0m" );
    
    return M;
    
end );

#-----------------------------------
# ColumnEchelonForm
#-----------------------------------

##
InstallMethod( ColumnEchelonForm,
        "LIMAT: for homalg matrices (IsBasisOfColumnsMatrix)",
        [ IsHomalgMatrix and IsBasisOfColumnsMatrix ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "ColumnEchelonForm( IsBasisOfColumnsMatrix )", "\033[0m" );
    
    return M;
    
end );

##
InstallMethod( ColumnEchelonForm,
        "LIMAT: for homalg matrices (IsOne)",
        [ IsHomalgMatrix and IsOne ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "ColumnEchelonForm( IsOne(Matrix) )", "\033[0m" );
    
    return M;
    
end );

##
InstallMethod( ColumnEchelonForm,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "ColumnEchelonForm( IsZero(Matrix) )", "\033[0m" );
    
    return M;
    
end );

#-----------------------------------
# ReducedRowEchelonForm
#-----------------------------------

##
InstallMethod( ReducedRowEchelonForm,
        "LIMAT: for homalg matrices (IsReducedBasisOfRowsMatrix)",
        [ IsHomalgMatrix and IsReducedBasisOfRowsMatrix ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "ReducedRowEchelonForm( IsReducedBasisOfRowsMatrix )", "\033[0m" );
    
    return M;
    
end );

##
InstallMethod( ReducedRowEchelonForm,
        "LIMAT: for homalg matrices (IsOne)",
        [ IsHomalgMatrix and IsOne ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "ReducedRowEchelonForm( IsOne(Matrix) )", "\033[0m" );
    
    return M;
    
end );

##
InstallMethod( ReducedRowEchelonForm,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "ReducedRowEchelonForm( IsZero(Matrix) )", "\033[0m" );
    
    return M;
    
end );

#-----------------------------------
# ReducedColumnEchelonForm
#-----------------------------------

##
InstallMethod( ReducedColumnEchelonForm,
        "LIMAT: for homalg matrices (IsReducedBasisOfColumnsMatrix)",
        [ IsHomalgMatrix and IsReducedBasisOfColumnsMatrix ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "ReducedColumnEchelonForm( IsReducedBasisOfColumnsMatrix )", "\033[0m" );
    
    return M;
    
end );

##
InstallMethod( ReducedColumnEchelonForm,
        "LIMAT: for homalg matrices (IsOne)",
        [ IsHomalgMatrix and IsOne ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "ReducedColumnEchelonForm( IsOne(Matrix) )", "\033[0m" );
    
    return M;
    
end );

##
InstallMethod( ReducedColumnEchelonForm,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "ReducedColumnEchelonForm( IsZero(Matrix) )", "\033[0m" );
    
    return M;
    
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
    
    return HomalgZeroMatrix( 0, NumberColumns( M ), HomalgRing( M ) );
    
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
    
    return HomalgZeroMatrix( NumberRows( M ), 0, HomalgRing( M ) );
    
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
    
    return HomalgZeroMatrix( 0, NumberColumns( M ), HomalgRing( M ) );
    
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
    
    return HomalgZeroMatrix( NumberRows( M ), 0, HomalgRing( M ) );
    
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
    
    SetPreEval( T, HomalgIdentityMatrix( NumberRows( M ), R ) ); ResetFilterObj( T, IsVoidMatrix );
    
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
    
    SetPreEval( T, HomalgIdentityMatrix( NumberRows( M ), R ) ); ResetFilterObj( T, IsVoidMatrix );
    
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
    
    SetPreEval( T, HomalgZeroMatrix( 0, NumberRows( M ), R ) ); ResetFilterObj( T, IsVoidMatrix );
    
    return HomalgZeroMatrix( 0, NumberColumns( M ), R );
    
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
    
    SetPreEval( T, HomalgIdentityMatrix( NumberColumns( M ), R ) ); ResetFilterObj( T, IsVoidMatrix );
    
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
    
    SetPreEval( T, HomalgIdentityMatrix( NumberColumns( M ), R ) ); ResetFilterObj( T, IsVoidMatrix );
    
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
    
    SetPreEval( T, HomalgZeroMatrix( NumberColumns( M ), 0, R ) ); ResetFilterObj( T, IsVoidMatrix );
    
    return HomalgZeroMatrix( NumberRows( M ), 0, R );
    
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
    
    if NumberColumns( L ) <> NumberColumns( B ) then
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
    
    if NumberRows( L ) <> NumberRows( B ) then
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
    
    if NumberColumns( A ) <> NumberColumns( B ) then
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
        
        SetPreEval( T, -HomalgIdentityMatrix( NumberRows( A ), HomalgRing( A ) ) ); ResetFilterObj( T, IsVoidMatrix );
        
        return 0 * A;
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( DecideZeroRowsEffectively,
        "LIMAT: for homalg matrices (HasLeftInverse)",
        [ IsHomalgMatrix, IsHomalgMatrix and HasLeftInverse, IsVoidMatrix ],
        
  function( A, B, T )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DecideZeroRowsEffectively( IsHomalgMatrix, HasLeftInverse, T )", "\033[0m" );
    
    ## 0 = A + T * B
    SetPreEval( T, -A * LeftInverse( B ) ); ResetFilterObj( T, IsVoidMatrix );
    
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
        TryNextMethod( ); ## FIXME: this can be improved
    fi;
    
    nz := NonZeroColumns( B );
    
    l := Length( nz );
    
    if l = 0 then ## just to be on the safe side
        TryNextMethod( );
    fi;
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DecideZeroRowsEffectively( IsHomalgMatrix, IsSpecialSubidentityMatrix, T )", "\033[0m" );
    
    r := NumberRows( A );
    c := NumberColumns( A );
    
    ## M = A + T * B
    SetPreEval( T, -CertainColumns( A, nz ) ); ResetFilterObj( T, IsVoidMatrix );
    
    return UnionOfColumns( [
        CertainColumns( A, [ 1 .. nz[1] - 1 ] ),
        HomalgZeroMatrix( r, l, R ),
        CertainColumns( A, [ nz[l] + 1 .. c ] )
        ] );
    
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
    
    SetPreEval( T, HomalgZeroMatrix( NumberRows( A ), NumberRows( B ), HomalgRing( A ) ) ); ResetFilterObj( T, IsVoidMatrix );
    
    return A;
    
end );

##
InstallMethod( DecideZeroRowsEffectively,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero, IsHomalgMatrix, IsVoidMatrix ],
        
  function( A, B, T )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DecideZeroRowsEffectively( IsZero(Matrix), IsHomalgMatrix, T )", "\033[0m" );
    
    SetPreEval( T, HomalgZeroMatrix( NumberRows( A ), NumberRows( B ), HomalgRing( A ) ) ); ResetFilterObj( T, IsVoidMatrix );
    
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
    
    if NumberRows( A ) <> NumberRows( B ) then
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
        
        SetPreEval( T, -HomalgIdentityMatrix( NumberColumns( A ), HomalgRing( A ) ) ); ResetFilterObj( T, IsVoidMatrix );
        
        return 0 * A;
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( DecideZeroColumnsEffectively,
        "LIMAT: for homalg matrices (HasRightInverse)",
        [ IsHomalgMatrix, IsHomalgMatrix and HasRightInverse, IsVoidMatrix ],
        
  function( A, B, T )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DecideZeroColumnsEffectively( IsHomalgMatrix, HasRightInverse, T )", "\033[0m" );
    
    ## 0 = A + B * T
    SetPreEval( T, RightInverse( B ) * -A ); ResetFilterObj( T, IsVoidMatrix );
    
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
        TryNextMethod( ); ## FIXME: this can be improved
    fi;
    
    nz := NonZeroRows( B );
    
    l := Length( nz );
    
    if l = 0 then ## just to be on the safe side
        TryNextMethod( );
    fi;
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DecideZeroColumnsEffectively( IsHomalgMatrix, IsSpecialSubidentityMatrix, T )", "\033[0m" );
    
    c := NumberColumns( A );
    r := NumberRows( A );
    
    ## M = A + B * T
    SetPreEval( T, -CertainRows( A, nz ) ); ResetFilterObj( T, IsVoidMatrix );
    
    return UnionOfRows( [
        CertainRows( A, [ 1 .. nz[1] - 1 ] ),
        HomalgZeroMatrix( l, c, R ),
        CertainRows( A, [ nz[l] + 1 .. r ] )
        ] );
    
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
    
    SetPreEval( T, HomalgZeroMatrix( NumberColumns( B ), NumberColumns( A ), HomalgRing( A ) ) ); ResetFilterObj( T, IsVoidMatrix );
    
    return A;
    
end );

##
InstallMethod( DecideZeroColumnsEffectively,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero, IsHomalgMatrix, IsVoidMatrix ],
        
  function( A, B, T )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "DecideZeroColumnsEffectively( IsZero(Matrix), IsHomalgMatrix, T )", "\033[0m" );
    
    SetPreEval( T, HomalgZeroMatrix( NumberColumns( B ), NumberColumns( A ), HomalgRing( A ) ) ); ResetFilterObj( T, IsVoidMatrix );
    
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
    
    if NumberColumns( M1 ) <> NumberColumns( M2 ) then
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
        
        return HomalgIdentityMatrix( NumberRows( M1 ), HomalgRing( M1 ) );
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( SyzygiesGeneratorsOfRows,
        "LIMAT: for homalg matrices (IsLeftRegular)",
        [ IsHomalgMatrix and IsLeftRegular ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "SyzygiesGeneratorsOfRows( IsLeftRegular )", "\033[0m" );
    
    return HomalgZeroMatrix( 0, NumberRows( M ), HomalgRing( M ) );
    
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
    
    return HomalgIdentityMatrix( NumberRows( M ), HomalgRing( M ) );
    
end );

##
InstallMethod( SyzygiesGeneratorsOfRows,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero, IsHomalgMatrix ],
        
  function( M1, M2 )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "SyzygiesGeneratorsOfRows(IsZero(Matrix),IsHomalgMatrix)", "\033[0m" );
    
    return HomalgIdentityMatrix( NumberRows( M1 ), HomalgRing( M1 ) );
    
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
    
    if NumberRows( M1 ) <> NumberRows( M2 ) then
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
        
        return HomalgIdentityMatrix( NumberColumns( M1 ), HomalgRing( M1 ) );
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( SyzygiesGeneratorsOfColumns,
        "LIMAT: for homalg matrices (IsRightRegular)",
        [ IsHomalgMatrix and IsRightRegular ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "SyzygiesGeneratorsOfColumns( IsRightRegular )", "\033[0m" );
    
    return HomalgZeroMatrix( NumberColumns( M ), 0, HomalgRing( M ) );
    
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
    
    return HomalgIdentityMatrix( NumberColumns( M ), HomalgRing( M ) );
    
end );

##
InstallMethod( SyzygiesGeneratorsOfColumns,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero, IsHomalgMatrix ],
        
  function( M1, M2 )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "SyzygiesGeneratorsOfColumns(IsZero(Matrix),IsHomalgMatrix)", "\033[0m" );
    
    return HomalgIdentityMatrix( NumberColumns( M1 ), HomalgRing( M1 ) );
    
end );

#-----------------------------------
# ReducedSyzygiesGeneratorsOfRows
#-----------------------------------

##
InstallMethod( ReducedSyzygiesGeneratorsOfRows,
        "LIMAT: for homalg matrices (IsLeftRegular)",
        [ IsHomalgMatrix and IsLeftRegular ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "ReducedSyzygiesGeneratorsOfRows( IsLeftRegular )", "\033[0m" );
    
    return HomalgZeroMatrix( 0, NumberRows( M ), HomalgRing( M ) );
    
end );

##
InstallMethod( ReducedSyzygiesGeneratorsOfRows,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "ReducedSyzygiesGeneratorsOfRows( IsZero(Matrix) )", "\033[0m" );
    
    return HomalgIdentityMatrix( NumberRows( M ), HomalgRing( M ) );
    
end );

#-----------------------------------
# ReducedSyzygiesGeneratorsOfColumns
#-----------------------------------

##
InstallMethod( ReducedSyzygiesGeneratorsOfColumns,
        "LIMAT: for homalg matrices (IsRightRegular)",
        [ IsHomalgMatrix and IsRightRegular ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "ReducedSyzygiesGeneratorsOfColumns( IsRightRegular )", "\033[0m" );
    
    return HomalgZeroMatrix( NumberColumns( M ), 0, HomalgRing( M ) );
    
end );

##
InstallMethod( ReducedSyzygiesGeneratorsOfColumns,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "ReducedSyzygiesGeneratorsOfColumns( IsZero(Matrix) )", "\033[0m" );
    
    return HomalgIdentityMatrix( NumberColumns( M ), HomalgRing( M ) );
    
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

##
InstallMethod( GetUnitPosition,
        "LIMAT: for homalg matrices (IsZero)",
        [ IsHomalgMatrix and IsZero, IsHomogeneousList ],
        
  function( M, poslist )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "GetUnitPosition( IsZero(Matrix), poslist )", "\033[0m" );
    
    return fail;
    
end );

##
InstallMethod( GetUnitPosition,
        "LIMAT: for homalg matrices (IsUnitFree)",
        [ IsHomalgMatrix and IsUnitFree ],
        
  function( M )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "GetUnitPosition( IsUnitFree )", "\033[0m" );
    
    return fail;
    
end );

##
InstallMethod( GetUnitPosition,
        "LIMAT: for homalg matrices (IsUnitFree)",
        [ IsHomalgMatrix and IsUnitFree, IsHomogeneousList ],
        
  function( M, poslist )
    
    Info( InfoLIMAT, 2, LIMAT.color, "\033[01mLIMAT\033[0m ", LIMAT.color, "GetUnitPosition( IsUnitFree, poslist )", "\033[0m" );
    
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

