#############################################################################
##
##  Service.gi                  homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations of homalg service procedures.
##
#############################################################################

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( TriangularBasisOfRows,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, t, B;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    t := homalgTotalRuntimes( );
    
    if IsBound(RP!.TriangularBasisOfRows) then
        
        Info( InfoHomalgBasicOperations, 4, HOMALG.color_start, "BUSY>\033[0m ", HOMALG.color_FOT, "TriangularBasisOfRows\033[0m ", HOMALG.color_FOT, NrRows( M ), " x ", NrColumns( M ), "\033[0m" );
        
        B := RP!.TriangularBasisOfRows( M );
        
        Info( InfoHomalgBasicOperations, 4, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOT, "TriangularBasisOfRows", "\033[0m", "	in ", homalgTotalRuntimes( t ) );
        
        return B;
        
    elif IsBound(RP!.TriangularBasisOfColumns) then
        
        Info( InfoHomalgBasicOperations, 4, HOMALG.color_start, "BUSY>\033[0m ", HOMALG.color_FOT, "TriangularBasisOfRows\033[0m ", HOMALG.color_FOT, NrRows( M ), " x ", NrColumns( M ), "\033[0m" );
        
        B := Involution( RP!.TriangularBasisOfColumns( Involution( M ) ) );
        
        Info( InfoHomalgBasicOperations, 4, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOT, "TriangularBasisOfRows", "\033[0m", "	in ", homalgTotalRuntimes( t ) );
        
        return B;
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( TriangularBasisOfRows,
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and IsVoidMatrix ],
        
  function( M, T )
    local R, RP, t, TI, B;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    t := homalgTotalRuntimes( );
    
    if IsBound(RP!.TriangularBasisOfRows) then
        
        Info( InfoHomalgBasicOperations, 4, HOMALG.color_start, "BUSY>\033[0m ", HOMALG.color_FOT, "TriangularBasisOfRows (M,T)\033[0m ", HOMALG.color_FOT, NrRows( M ), " x ", NrColumns( M ), "\033[0m" );
        
        B := RP!.TriangularBasisOfRows( M, T );
        
        Info( InfoHomalgBasicOperations, 4, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOT, "TriangularBasisOfRows (M,T)", "\033[0m", "	in ", homalgTotalRuntimes( t ) );
        
        return B;
        
    elif IsBound(RP!.TriangularBasisOfColumns) then
        
        Info( InfoHomalgBasicOperations, 4, HOMALG.color_start, "BUSY>\033[0m ", HOMALG.color_FOT, "TriangularBasisOfRows (M,T)\033[0m ", HOMALG.color_FOT, NrRows( M ), " x ", NrColumns( M ), "\033[0m" );
        
        TI := HomalgVoidMatrix( R );
        
        B := Involution( RP!.TriangularBasisOfColumns( Involution( M ), TI ) );
        
        SetPreEval( T, Involution( TI ) ); ResetFilterObj( T, IsVoidMatrix );
        
        Info( InfoHomalgBasicOperations, 4, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOT, "TriangularBasisOfRows (M,T)", "\033[0m", "	in ", homalgTotalRuntimes( t ) );
        
        return B;
        
    fi;
    
    TryNextMethod( );
    
end );

##
InstallMethod( TriangularBasisOfColumns,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, t, B;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.TriangularBasisOfColumns) then
        
        t := homalgTotalRuntimes( );
        
        Info( InfoHomalgBasicOperations, 4, HOMALG.color_start, "BUSY>\033[0m ", HOMALG.color_FOT, "TriangularBasisOfColumns\033[0m ", HOMALG.color_FOT, NrRows( M ), " x ", NrColumns( M ), "\033[0m" );
        
        B := RP!.TriangularBasisOfColumns( M );
        
        Info( InfoHomalgBasicOperations, 4, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOT, "TriangularBasisOfColumns", "\033[0m", "	in ", homalgTotalRuntimes( t ) );
        
        return B;
        
    fi;
    
    return Involution( TriangularBasisOfRows( Involution( M ) ) );
    
end );

##
InstallMethod( TriangularBasisOfColumns,
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix and IsVoidMatrix ],
        
  function( M, T )
    local R, RP, t, TI, B;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    if IsBound(RP!.TriangularBasisOfColumns) then
        
        t := homalgTotalRuntimes( );
        
        Info( InfoHomalgBasicOperations, 4, HOMALG.color_start, "BUSY>\033[0m ", HOMALG.color_FOT, "TriangularBasisOfColumns (M,T)\033[0m ", HOMALG.color_FOT, NrRows( M ), " x ", NrColumns( M ), "\033[0m" );
        
        B := RP!.TriangularBasisOfColumns( M, T );
        
        Info( InfoHomalgBasicOperations, 4, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOT, "TriangularBasisOfColumns (M,T)", "\033[0m", "	in ", homalgTotalRuntimes( t ) );
        
        return B;
        
    fi;
    
    TI := HomalgVoidMatrix( R );
    
    B := Involution( TriangularBasisOfRows( Involution( M ), TI ) );
    
    SetPreEval( T, Involution( TI ) ); ResetFilterObj( T, IsVoidMatrix );
    
    return B;
    
end );

##
InstallMethod( BasisOfRowModule,		### defines: BasisOfRowModule (BasisOfModule (low-level))
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, t, B, rank;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    t := homalgTotalRuntimes( );
    
    Info( InfoHomalgBasicOperations, 3, "" );
    Info( InfoHomalgBasicOperations, 3, HOMALG.color_start, "BUSY>\033[0m ", HOMALG.color_FOB, "BasisOfRowModule\033[0m ", HOMALG.color_FOB, NrRows( M ), " x ", NrColumns( M ), "\033[0m" );
    
    if IsBound(RP!.BasisOfRowModule) then
        
        B := RP!.BasisOfRowModule( M );
        
        Info( InfoHomalgBasicOperations, 3, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOB, "BasisOfRowModule\033[0m ", HOMALG.color_FOB, NrRows( B ), "\033[0m", "	in ", homalgTotalRuntimes( t ) );
        Info( InfoHomalgBasicOperations, 3, "" );
        
        return B;
        
    elif IsBound(RP!.BasisOfColumnModule) then
        
        B := Involution( RP!.BasisOfColumnModule( Involution( M ) ) );
        
        Info( InfoHomalgBasicOperations, 3, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOB, "BasisOfRowModule\033[0m ", HOMALG.color_FOB, NrRows( B ), "\033[0m", "	in ", homalgTotalRuntimes( t ) );
        Info( InfoHomalgBasicOperations, 3, "" );
        
        return B;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    B := TriangularBasisOfRows( M );
    
    rank := RowRankOfMatrix( B );
    
    if rank = 0 then
        B := HomalgZeroMatrix( 0, NrColumns( B ), R );
    else
        B := CertainRows( B, [ 1 .. rank ] );
        
        SetIsFullRowRankMatrix( B, true );
    fi;
    
    Info( InfoHomalgBasicOperations, 3, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOB, "BasisOfRowModule\033[0m ", HOMALG.color_FOB, NrRows( B ), "\033[0m", "	in ", homalgTotalRuntimes( t ) );
    Info( InfoHomalgBasicOperations, 3, "" );
    
    return B;
    
end );

##
InstallMethod( BasisOfColumnModule,		### defines: BasisOfColumnModule (BasisOfModule (low-level))
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, t, B, rank;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    t := homalgTotalRuntimes( );
    
    Info( InfoHomalgBasicOperations, 3, "" );
    Info( InfoHomalgBasicOperations, 3, HOMALG.color_start, "BUSY>\033[0m ", HOMALG.color_FOB, "BasisOfColumnModule\033[0m ", HOMALG.color_FOB, NrRows( M ), " x ", NrColumns( M ), "\033[0m" );
    
    if IsBound(RP!.BasisOfColumnModule) then
        
        B := RP!.BasisOfColumnModule( M );
        
        Info( InfoHomalgBasicOperations, 3, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOB, "BasisOfColumnModule\033[0m ", HOMALG.color_FOB, NrColumns( B ), "\033[0m", "	in ", homalgTotalRuntimes( t ) );
        Info( InfoHomalgBasicOperations, 3, "" );
        
        return B;
        
    elif IsBound(RP!.BasisOfRowModule) then
        
        B := Involution( RP!.BasisOfRowModule( Involution( M ) ) );
        
        Info( InfoHomalgBasicOperations, 3, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOB, "BasisOfColumnModule\033[0m ", HOMALG.color_FOB, NrColumns( B ), "\033[0m", "	in ", homalgTotalRuntimes( t ) );
        Info( InfoHomalgBasicOperations, 3, "" );
        
        return B;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    B := TriangularBasisOfColumns( M );
    
    rank := ColumnRankOfMatrix( B );
    
    if rank = 0 then
        B := HomalgZeroMatrix( NrRows( B ), 0, R );
    else
        B := CertainColumns( B, [ 1 .. rank ] );
        
        SetIsFullColumnRankMatrix( B, true );
    fi;
    
    Info( InfoHomalgBasicOperations, 3, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOB, "BasisOfColumnModule\033[0m ", HOMALG.color_FOB, NrColumns( B ), "\033[0m", "	in ", homalgTotalRuntimes( t ) );
    Info( InfoHomalgBasicOperations, 3, "" );
    
    return B;
    
end );

##
InstallMethod( BasisOfRowsCoeff,		### defines: BasisOfRowsCoeff (BasisCoeff)
        "for a homalg matrix",
	[ IsHomalgMatrix, IsHomalgMatrix and IsVoidMatrix ],
        
  function( M, T )
    local R, RP, t, TI, B, TT, rank;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    t := homalgTotalRuntimes( );
        
    Info( InfoHomalgBasicOperations, 3, "" );
    Info( InfoHomalgBasicOperations, 3, HOMALG.color_start, "BUSY>\033[0m ", HOMALG.color_FOB, "BasisOfRowsCoeff\033[0m ", HOMALG.color_FOB, NrRows( M ), " x ", NrColumns( M ), "\033[0m" );
    
    if IsBound(RP!.BasisOfRowsCoeff) then
        
        B := RP!.BasisOfRowsCoeff( M, T );
        
        Info( InfoHomalgBasicOperations, 3, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOB, "BasisOfRowsCoeff\033[0m ", HOMALG.color_FOB, NrRows( B ), "\033[0m", "	in ", homalgTotalRuntimes( t ) );
        Info( InfoHomalgBasicOperations, 3, "" );
        
        return B;
        
    elif IsBound(RP!.BasisOfColumnsCoeff) then
        
        TI := HomalgVoidMatrix( R );
        
        B := Involution( RP!.BasisOfColumnsCoeff( Involution( M ), TI ) );
        
        SetEvalInvolution( T, TI ); ResetFilterObj( T, IsVoidMatrix );
        
        Info( InfoHomalgBasicOperations, 3, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOB, "BasisOfRowsCoeff\033[0m ", HOMALG.color_FOB, NrRows( B ), "\033[0m", "	in ", homalgTotalRuntimes( t ) );
        Info( InfoHomalgBasicOperations, 3, "" );
        
        return B;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    TT := HomalgVoidMatrix( R );
    
    B := TriangularBasisOfRows( M, TT );
    
    rank := RowRankOfMatrix( B );
    
    if rank = 0 then
        B := HomalgZeroMatrix( 0, NrColumns( B ), R);
    else
        B := CertainRows( B, [ 1 .. rank ] );
        
        SetRowRankOfMatrix( B, rank );
        
        SetIsFullRowRankMatrix( B, true );
    fi;
    
    SetPreEval( T, CertainRows( TT, [ 1 .. rank ] ) ); ResetFilterObj( T, IsVoidMatrix );
    
    Info( InfoHomalgBasicOperations, 3, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOB, "BasisOfRowsCoeff\033[0m ", HOMALG.color_FOB, NrRows( B ), "\033[0m", "	in ", homalgTotalRuntimes( t ) );
    Info( InfoHomalgBasicOperations, 3, "" );
    
    return B;
    
end );

##
InstallMethod( BasisOfColumnsCoeff,		### defines: BasisOfColumnsCoeff (BasisCoeff)
        "for a homalg matrix",
	[ IsHomalgMatrix, IsHomalgMatrix and IsVoidMatrix ],
        
  function( M, T )
    local R, RP, t, TI, B, TT, rank;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    t := homalgTotalRuntimes( );
        
    Info( InfoHomalgBasicOperations, 3, "" );
    Info( InfoHomalgBasicOperations, 3, HOMALG.color_start, "BUSY>\033[0m ", HOMALG.color_FOB, "BasisOfColumnsCoeff\033[0m ", HOMALG.color_FOB, NrRows( M ), " x ", NrColumns( M ), "\033[0m" );
    
    if IsBound(RP!.BasisOfColumnsCoeff) then
        
        B := RP!.BasisOfColumnsCoeff( M, T );
        
        Info( InfoHomalgBasicOperations, 3, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOB, "BasisOfColumnsCoeff\033[0m ", HOMALG.color_FOB, NrColumns( B ), "\033[0m", "	in ", homalgTotalRuntimes( t ) );
        Info( InfoHomalgBasicOperations, 3, "" );
        
        return B;
        
    elif IsBound(RP!.BasisOfRowsCoeff) then
        
        TI := HomalgVoidMatrix( R );
        
        B := Involution( RP!.BasisOfRowsCoeff( Involution( M ), TI ) );
        
        SetEvalInvolution( T, TI ); ResetFilterObj( T, IsVoidMatrix );
        
        Info( InfoHomalgBasicOperations, 3, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOB, "BasisOfColumnsCoeff\033[0m ", HOMALG.color_FOB, NrColumns( B ), "\033[0m", "	in ", homalgTotalRuntimes( t ) );
        Info( InfoHomalgBasicOperations, 3, "" );
        
        return B;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    TT := HomalgVoidMatrix( R );
    
    B := TriangularBasisOfColumns( M, TT );
    
    rank := ColumnRankOfMatrix( B );
    
    if rank = 0 then
        B := HomalgZeroMatrix( NrRows( B ), 0, R);
    else
        B := CertainColumns( B, [ 1 .. rank ] );
        
        SetColumnRankOfMatrix( B, rank );
        
        SetIsFullColumnRankMatrix( B, true );
    fi;
    
    SetPreEval( T, CertainColumns( TT, [ 1 .. rank ] ) ); ResetFilterObj( T, IsVoidMatrix );
    
    Info( InfoHomalgBasicOperations, 3, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOB, "BasisOfColumnsCoeff\033[0m ", HOMALG.color_FOB, NrColumns( B ), "\033[0m", "	in ", homalgTotalRuntimes( t ) );
    Info( InfoHomalgBasicOperations, 3, "" );
    
    return B;
    
end );

##
InstallMethod( DecideZeroRows,			### defines: DecideZeroRows (Reduce)
        "for homalg matrices",
	[ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( A, B )
    local R, RP, t, l, m, n, id, zz, M, C;
    
    R := HomalgRing( B );
    
    RP := homalgTable( R );
    
    t := homalgTotalRuntimes( );
        
    Info( InfoHomalgBasicOperations, 2, "" );
    Info( InfoHomalgBasicOperations, 2, HOMALG.color_start, "BUSY>\033[0m ", HOMALG.color_FOP, "DecideZeroRows\033[0m ", HOMALG.color_FOP, "( ", NrRows( A ), " + ", NrRows( B ), " ) x ", NrColumns( A ), "\033[0m" );
    
    if IsBound(RP!.DecideZeroRows) then
        
        C := RP!.DecideZeroRows( A, B );
        
        Info( InfoHomalgBasicOperations, 2, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOP, "DecideZeroRows", "\033[0m", "	in ", homalgTotalRuntimes( t ) );
        Info( InfoHomalgBasicOperations, 2, "" );
        
        return C;
        
    elif IsBound(RP!.DecideZeroColumns) then
        
        C := Involution( RP!.DecideZeroColumns( Involution( A ), Involution( B ) ) );
        
        Info( InfoHomalgBasicOperations, 2, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOP, "DecideZeroRows", "\033[0m", "	in ", homalgTotalRuntimes( t ) );
        Info( InfoHomalgBasicOperations, 2, "" );
        
        return C;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    l := NrRows( A );
    m := NrColumns( A );
    
    n := NrRows( B );
    
    if HasIsIdentityMatrix( A ) and IsIdentityMatrix( A ) then ## save as much new definitions as possible
        id := A;
    else
        id := HomalgIdentityMatrix( l, R );
    fi;
    
    zz := HomalgZeroMatrix( n, l, R );
    
    M := UnionOfRows( UnionOfColumns( id, A ), UnionOfColumns( zz, B ) );
    
    M := TriangularBasisOfRows( M );
    
    C := CertainRows( CertainColumns( M, [ l + 1 .. l + m ] ), [ 1 .. l ] );
    
    Info( InfoHomalgBasicOperations, 2, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOP, "DecideZeroRows", "\033[0m", "	in ", homalgTotalRuntimes( t ) );
    Info( InfoHomalgBasicOperations, 2, "" );
    
    return C;
    
end );

##
InstallMethod( DecideZeroColumns,		### defines: DecideZeroColumns (Reduce)
        "for homalg matrices",
	[ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( A, B )
    local R, RP, t, l, m, n, id, zz, M, C;
    
    R := HomalgRing( B );
    
    RP := homalgTable( R );
    
    t := homalgTotalRuntimes( );
        
    Info( InfoHomalgBasicOperations, 2, "" );
    Info( InfoHomalgBasicOperations, 2, HOMALG.color_start, "BUSY>\033[0m ", HOMALG.color_FOP, "DecideZeroColumns\033[0m ", HOMALG.color_FOP, NrRows( A ), " x ( ", NrColumns( A ), " + ", NrColumns( B ), " )", "\033[0m" );
    
    if IsBound(RP!.DecideZeroColumns) then
        
        C := RP!.DecideZeroColumns( A, B );
        
        Info( InfoHomalgBasicOperations, 2, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOP, "DecideZeroColumns", "\033[0m", "	in ", homalgTotalRuntimes( t ) );
        Info( InfoHomalgBasicOperations, 2, "" );
        
        return C;
        
    elif IsBound(RP!.DecideZeroRows) then
        
        C := Involution( RP!.DecideZeroRows( Involution( A ), Involution( B ) ) );
        
        Info( InfoHomalgBasicOperations, 2, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOP, "DecideZeroColumns", "\033[0m", "	in ", homalgTotalRuntimes( t ) );
        Info( InfoHomalgBasicOperations, 2, "" );
        
        return C;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    l := NrColumns( A );
    m := NrRows( A );
    
    n := NrColumns( B );
    
    if HasIsIdentityMatrix( A ) and IsIdentityMatrix( A ) then ## save as much new definitions as possible
        id := A;
    else
        id := HomalgIdentityMatrix( l, R );
    fi;
    
    zz := HomalgZeroMatrix( l, n, R );
    
    M := UnionOfColumns( UnionOfRows( id, A ), UnionOfRows( zz, B ) );
    
    M := TriangularBasisOfColumns( M );
    
    C := CertainColumns( CertainRows( M, [ l + 1 .. l + m ] ), [ 1 .. l ] );
    
    Info( InfoHomalgBasicOperations, 2, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOP, "DecideZeroColumns", "\033[0m", "	in ", homalgTotalRuntimes( t ) );
    Info( InfoHomalgBasicOperations, 2, "" );
    
    return C;
    
end );

##
InstallMethod( DecideZeroRowsEffectively,	### defines: DecideZeroRowsEffectively (ReduceCoeff)
        "for a homalg matrix",
        [ IsHomalgMatrix, IsHomalgMatrix, IsHomalgMatrix and IsVoidMatrix ],
        
  function( A, B, T )
    local R, RP, t, TI, l, m, n, id, zz, M, TT;
    
    R := HomalgRing( B );
    
    RP := homalgTable( R );
    
    t := homalgTotalRuntimes( );
    
    Info( InfoHomalgBasicOperations, 2, "" );
    Info( InfoHomalgBasicOperations, 2, HOMALG.color_start, "BUSY>\033[0m ", HOMALG.color_FOP, "DecideZeroRowsEffectively\033[0m ",  HOMALG.color_FOP, "( ", NrRows( A ), " + ", NrRows( B ), " ) x ", NrColumns( A ), "\033[0m" );
    
    if IsBound(RP!.DecideZeroRowsEffectively) then
        
        M := RP!.DecideZeroRowsEffectively( A, B, T );
        
        Info( InfoHomalgBasicOperations, 2, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOP, "DecideZeroRowsEffectively", "\033[0m", "	in ", homalgTotalRuntimes( t ) );
        Info( InfoHomalgBasicOperations, 2, "" );
        
        return M;
        
    elif IsBound(RP!.DecideZeroColumnsEffectively) then
        
        TI := HomalgVoidMatrix( R );
        
        M := Involution( RP!.DecideZeroColumnsEffectively( Involution( A ), Involution( B ), TI ) );
        
        SetEvalInvolution( T, TI ); ResetFilterObj( T, IsVoidMatrix );
        
        Info( InfoHomalgBasicOperations, 2, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOP, "DecideZeroRowsEffectively", "\033[0m", "	in ", homalgTotalRuntimes( t ) );
        Info( InfoHomalgBasicOperations, 2, "" );
        
        return M;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    l := NrRows( A );
    m := NrColumns( A );
    
    n := NrRows( B );
    
    if HasIsIdentityMatrix( A ) and IsIdentityMatrix( A ) then ## save as much new definitions as possible
        id := A;
    else
        id := HomalgIdentityMatrix( l, R );
    fi;
    
    zz := HomalgZeroMatrix( n, l, R );
    
    M := UnionOfRows( UnionOfColumns( id, A ), UnionOfColumns( zz, B ) );
    
    TT := HomalgVoidMatrix( R );
    
    M := TriangularBasisOfRows( M, TT );
    
    M := CertainRows( CertainColumns( M, [ l + 1 .. l + m ] ), [ 1 .. l ] );
    
    TT := CertainColumns( CertainRows( TT, [ 1 .. l ] ), [ l + 1 .. l + n ] );
    
    SetPreEval( T, -TT ); ResetFilterObj( T, IsVoidMatrix );
    
    Info( InfoHomalgBasicOperations, 2, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOP, "DecideZeroRowsEffectively", "\033[0m", "	in ", homalgTotalRuntimes( t ) );
    Info( InfoHomalgBasicOperations, 2, "" );
    
    return M;
    
end );

##
InstallMethod( DecideZeroColumnsEffectively,	### defines: DecideZeroColumnsEffectively (ReduceCoeff)
        "for a homalg matrix",
        [ IsHomalgMatrix, IsHomalgMatrix, IsHomalgMatrix and IsVoidMatrix ],
        
  function( A, B, T )
    local R, RP, t, TI, l, m, n, id, zz, M, TT;
    
    R := HomalgRing( B );
    
    RP := homalgTable( R );
    
    t := homalgTotalRuntimes( );
    
    Info( InfoHomalgBasicOperations, 2, "" );
    Info( InfoHomalgBasicOperations, 2, HOMALG.color_start, "BUSY>\033[0m ", HOMALG.color_FOP, "DecideZeroColumnsEffectively\033[0m ", HOMALG.color_FOP, NrRows( A ), " x ( ", NrColumns( A ), " + ", NrColumns( B ), " )", "\033[0m" );
    
    if IsBound(RP!.DecideZeroColumnsEffectively) then
        
        M := RP!.DecideZeroColumnsEffectively( A, B, T );
        
        Info( InfoHomalgBasicOperations, 2, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOP, "DecideZeroColumnsEffectively", "\033[0m", "	in ", homalgTotalRuntimes( t ) );
        Info( InfoHomalgBasicOperations, 2, "" );
        
        return M;
        
    elif IsBound(RP!.DecideZeroRowsEffectively) then
        
        TI := HomalgVoidMatrix( R );
        
        M := Involution( RP!.DecideZeroRowsEffectively( Involution( A ), Involution( B ), TI ) );
        
        SetEvalInvolution( T, TI ); ResetFilterObj( T, IsVoidMatrix );
        
        Info( InfoHomalgBasicOperations, 2, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOP, "DecideZeroColumnsEffectively", "\033[0m", "	in ", homalgTotalRuntimes( t ) );
        Info( InfoHomalgBasicOperations, 2, "" );
        
        return M;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    l := NrColumns( A );
    m := NrRows( A );
    
    n := NrColumns( B );
    
    if HasIsIdentityMatrix( A ) and IsIdentityMatrix( A ) then ## save as much new definitions as possible
        id := A;
    else
        id := HomalgIdentityMatrix( l, R );
    fi;
    
    zz := HomalgZeroMatrix( l, n, R );
    
    M := UnionOfColumns( UnionOfRows( id, A ), UnionOfRows( zz, B ) );
    
    TT := HomalgVoidMatrix( R );
    
    M := TriangularBasisOfColumns( M, TT );
    
    M := CertainColumns( CertainRows( M, [ l + 1 .. l + m ] ), [ 1 .. l ] );
    
    TT := CertainRows( CertainColumns( TT, [ 1 .. l ] ), [ l + 1 .. l + n ] );
    
    SetPreEval( T, -TT ); ResetFilterObj( T, IsVoidMatrix );
    
    Info( InfoHomalgBasicOperations, 2, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOP, "DecideZeroColumnsEffectively", "\033[0m", "	in ", homalgTotalRuntimes( t ) );
    Info( InfoHomalgBasicOperations, 2, "" );
    
    return M;
    
end );

##
InstallMethod( SyzygiesGeneratorsOfRows,
        "for homalg matrices",
	[ IsHomalgMatrix ],
        
  function( M )
    local R, RP, t, C, B, rank;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    t := homalgTotalRuntimes( );
        
    Info( InfoHomalgBasicOperations, 2, "" );
    Info( InfoHomalgBasicOperations, 2, HOMALG.color_start, "BUSY>\033[0m ", HOMALG.color_FOH, "SyzygiesGeneratorsOfRows\033[0m ", HOMALG.color_FOH, NrRows( M ), " x ", NrColumns( M ), "\033[0m" );
    
    if IsBound(RP!.SyzygiesGeneratorsOfRows) then
        
        C := RP!.SyzygiesGeneratorsOfRows( M );
        
        if IsZeroMatrix( C ) then
            
            SetIsFullRowRankMatrix( M, true );
            
            C := HomalgZeroMatrix( 0, NrRows( M ), R );
            
        fi;
        
        Info( InfoHomalgBasicOperations, 2, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOH, "SyzygiesGeneratorsOfRows\033[0m ", HOMALG.color_FOH, NrRows( C ), "\033[0m", "	in ", homalgTotalRuntimes( t ) );
        Info( InfoHomalgBasicOperations, 2, "" );
        
        return C;
        
    elif IsBound(RP!.SyzygiesGeneratorsOfColumns) then
        
        C := Involution( RP!.SyzygiesGeneratorsOfColumns( Involution( M ) ) );
        
        if IsZeroMatrix( C ) then
            
            SetIsFullRowRankMatrix( M, true );
            
            C := HomalgZeroMatrix( 0, NrRows( M ), R );
            
        fi;
        
        Info( InfoHomalgBasicOperations, 2, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOH, "SyzygiesGeneratorsOfRows\033[0m ", HOMALG.color_FOH, NrRows( C ), "\033[0m", "	in ", homalgTotalRuntimes( t ) );
        Info( InfoHomalgBasicOperations, 2, "" );
        
        return C;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    C := HomalgVoidMatrix( R );
    
    B := TriangularBasisOfRows( M, C );
    
    rank := RowRankOfMatrix( B );
    
    C := CertainRows( C, [ rank + 1 .. NrRows( M ) ] );
    
    if IsZeroMatrix( C ) then
        
        SetIsFullRowRankMatrix( M, true );
        
        C := HomalgZeroMatrix( 0, NrRows( M ), R );
        
    fi;
    
    Info( InfoHomalgBasicOperations, 2, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOH, "SyzygiesGeneratorsOfRows\033[0m ", HOMALG.color_FOH, NrRows( C ), "\033[0m", "	in ", homalgTotalRuntimes( t ) );
    Info( InfoHomalgBasicOperations, 2, "" );
    
    return C;
    
end );

##
InstallMethod( SyzygiesGeneratorsOfColumns,
        "for homalg matrices",
	[ IsHomalgMatrix ],
        
  function( M )
    local R, RP, t, C, B, rank;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    t := homalgTotalRuntimes( );
        
    Info( InfoHomalgBasicOperations, 2, "" );
    Info( InfoHomalgBasicOperations, 2, HOMALG.color_start, "BUSY>\033[0m ", HOMALG.color_FOH, "SyzygiesGeneratorsOfColumns\033[0m ", HOMALG.color_FOH, NrRows( M ), " x ", NrColumns( M ), "\033[0m" );
    
    if IsBound(RP!.SyzygiesGeneratorsOfColumns) then
        
        C := RP!.SyzygiesGeneratorsOfColumns( M );
        
        if IsZeroMatrix( C ) then
            
            SetIsFullColumnRankMatrix( M, true );
            
            C := HomalgZeroMatrix( NrColumns( M ), 0, R );
            
        fi;
        
        Info( InfoHomalgBasicOperations, 2, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOH, "SyzygiesGeneratorsOfColumns\033[0m ", HOMALG.color_FOH, NrColumns( C ), "\033[0m", "	in ", homalgTotalRuntimes( t ) );
        Info( InfoHomalgBasicOperations, 2, "" );
        
        return C;
        
    elif IsBound(RP!.SyzygiesGeneratorsOfRows) then
        
        C := Involution( RP!.SyzygiesGeneratorsOfRows( Involution( M ) ) );
        
        if IsZeroMatrix( C ) then
            
            SetIsFullColumnRankMatrix( M, true );
            
            C := HomalgZeroMatrix( NrColumns( M ), 0, R );
            
        fi;
        
        Info( InfoHomalgBasicOperations, 2, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOH, "SyzygiesGeneratorsOfColumns\033[0m ", HOMALG.color_FOH, NrColumns( C ), "\033[0m", "	in ", homalgTotalRuntimes( t ) );
        Info( InfoHomalgBasicOperations, 2, "" );
        
        return C;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    C := HomalgVoidMatrix( R );
    
    B := TriangularBasisOfColumns( M, C );
    
    rank := ColumnRankOfMatrix( B );
    
    C := CertainColumns( C, [ rank + 1 .. NrColumns( M ) ] );
    
    if IsZeroMatrix( C ) then
        
        SetIsFullColumnRankMatrix( M, true );
        
        C := HomalgZeroMatrix( NrColumns( M ), 0, R );
        
    fi;
    
    Info( InfoHomalgBasicOperations, 2, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOH, "SyzygiesGeneratorsOfColumns\033[0m ", HOMALG.color_FOH, NrColumns( C ), "\033[0m", "	in ", homalgTotalRuntimes( t ) );
    Info( InfoHomalgBasicOperations, 2, "" );
    
    return C;
    
end );

##
InstallMethod( SyzygiesGeneratorsOfRows,	### defines: SyzygiesGeneratorsOfRows (SyzygiesGenerators)
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( M1, M2 )
    local R, RP, t, M, C, rank;
    
    R := HomalgRing( M1 );
    
    RP := homalgTable( R );
    
    t := homalgTotalRuntimes( );
    
    Info( InfoHomalgBasicOperations, 2, "" );
    Info( InfoHomalgBasicOperations, 2, HOMALG.color_start, "BUSY>\033[0m ", HOMALG.color_FOH, "SyzygiesGeneratorsOfRows\033[0m", HOMALG.color_FOH, "( ", NrRows( M1 ), " + ", NrRows( M2 ), " ) x ", NrColumns( M1 ), "\033[0m" );
    
    if IsBound(RP!.SyzygiesGeneratorsOfRows) then
        
        C := RP!.SyzygiesGeneratorsOfRows( M1, M2 );
        
        if IsZeroMatrix( C ) then
            
            C := HomalgZeroMatrix( 0, NrRows( M1 ), R );
            
        fi;
        
        Info( InfoHomalgBasicOperations, 2, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOH, "SyzygiesGeneratorsOfRows\033[0m ", HOMALG.color_FOH, NrRows( C ), "\033[0m", "	in ", homalgTotalRuntimes( t ) );
        Info( InfoHomalgBasicOperations, 2, "" );
        
        return C;
        
    elif IsBound(RP!.SyzygiesGeneratorsOfColumns) then
        
        C := Involution( RP!.SyzygiesGeneratorsOfColumns( Involution( M1 ), Involution( M2 ) ) );
        
        if IsZeroMatrix( C ) then
            
            C := HomalgZeroMatrix( 0, NrRows( M1 ), R );
            
        fi;
        
        Info( InfoHomalgBasicOperations, 2, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOH, "SyzygiesGeneratorsOfRows\033[0m ", HOMALG.color_FOH, NrRows( C ), "\033[0m", "	in ", homalgTotalRuntimes( t ) );
        Info( InfoHomalgBasicOperations, 2, "" );
        
        return C;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    M := UnionOfRows( M1, M2 );
    
    C := HomalgVoidMatrix( R );
    
    M := TriangularBasisOfRows( M, C );
    
    rank := RowRankOfMatrix( M );
    
    C := CertainColumns( CertainRows( C, [ rank + 1 .. NrRows( M ) ] ), [ 1 .. NrRows( M1 ) ] );
    
    if IsZeroMatrix( C ) then
        
        C := HomalgZeroMatrix( 0, NrRows( M1 ), R );
        
    fi;
    
    Info( InfoHomalgBasicOperations, 2, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOH, "SyzygiesGeneratorsOfRows\033[0m ", HOMALG.color_FOH, NrRows( C ), "\033[0m", "	in ", homalgTotalRuntimes( t ) );
    Info( InfoHomalgBasicOperations, 2, "" );
    
    return C;
    
end );

##
InstallMethod( SyzygiesGeneratorsOfColumns,	### defines: SyzygiesGeneratorsOfColumns (SyzygiesGenerators)
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( M1, M2 )
    local R, RP, t, M, C, rank;
    
    R := HomalgRing( M1 );
    
    RP := homalgTable( R );
    
    t := homalgTotalRuntimes( );
    
    Info( InfoHomalgBasicOperations, 2, "" );
    Info( InfoHomalgBasicOperations, 2, HOMALG.color_start, "BUSY>\033[0m ", HOMALG.color_FOH, "SyzygiesGeneratorsOfColumns\033[0m ", HOMALG.color_FOH, NrRows( M1 ), " x ( ", NrColumns( M1 ), " + ", NrColumns( M2 ), " )", "\033[0m" );
    
    if IsBound(RP!.SyzygiesGeneratorsOfColumns) then
        
        C := RP!.SyzygiesGeneratorsOfColumns( M1, M2 );
        
        if IsZeroMatrix( C ) then
            
            C := HomalgZeroMatrix( NrColumns( M1 ), 0, R );
            
        fi;
        
        Info( InfoHomalgBasicOperations, 2, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOH, "SyzygiesGeneratorsOfColumns\033[0m ", HOMALG.color_FOH, NrColumns( C ), "\033[0m", "	in ", homalgTotalRuntimes( t ) );
        Info( InfoHomalgBasicOperations, 2, "" );
        
        return C;
        
    elif IsBound(RP!.SyzygiesGeneratorsOfRows) then
        
        C := Involution( RP!.SyzygiesGeneratorsOfRows( Involution( M1 ), Involution( M2 ) ) );
        
        if IsZeroMatrix( C ) then
            
            C := HomalgZeroMatrix( NrColumns( M1 ), 0, R );
            
        fi;
        
        Info( InfoHomalgBasicOperations, 2, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOH, "SyzygiesGeneratorsOfColumns\033[0m ", HOMALG.color_FOH, NrColumns( C ), "\033[0m", "	in ", homalgTotalRuntimes( t ) );
        Info( InfoHomalgBasicOperations, 2, "" );
        
        return C;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    M := UnionOfColumns( M1, M2 );
    
    C := HomalgVoidMatrix( R );
    
    M := TriangularBasisOfColumns( M, C );
    
    rank := ColumnRankOfMatrix( M );
    
    C := CertainRows( CertainColumns( C, [ rank + 1 .. NrColumns( M ) ] ), [ 1 .. NrColumns( M1 ) ] );
    
    if IsZeroMatrix( C ) then
        
        C := HomalgZeroMatrix( NrColumns( M1 ), 0, R );
        
    fi;
    
    Info( InfoHomalgBasicOperations, 2, HOMALG.color_end, "<DONE\033[0m ", HOMALG.color_FOH, "SyzygiesGeneratorsOfColumns\033[0m ", HOMALG.color_FOH, NrColumns( C ), "\033[0m", "	in ", homalgTotalRuntimes( t ) );
    Info( InfoHomalgBasicOperations, 2, "" );
    
    return C;
    
end );

