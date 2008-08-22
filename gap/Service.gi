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
# functions:
#
####################################

InstallGlobalFunction( ColoredInfoForService,
  function( arg )
    local nargs, l, color, s;
    
    nargs := Length( arg );
    
    l := arg[2];
    
    if l{[1]} = "T" then
        l := 4;
        color := HOMALG.color_BOT;
    elif l{[1]} = "B" then
        l := 3;
        color := HOMALG.color_BOB;
    elif l{[1]} = "D" then
        l := 2;
        color := HOMALG.color_BOD;
    elif l{[1]} = "S" then
        l := 2;
        color := HOMALG.color_BOH;
    fi;
    
    if arg[1] = "busy" then
        
        s := Concatenation( HOMALG.color_busy, "BUSY>\033[0m ", color );
        
        s := Concatenation( s, arg[2], "\033[0m \033[7m", color );
        
        Append( s, Concatenation( List( arg{[3..nargs]}, function( a ) if IsStringRep( a ) then return a; else return String( a ); fi; end ) ) );
        
        s := Concatenation( s, "\033[0m " );
        
        if l < 4 then
            Info( InfoHomalgBasicOperations, l , "" );
        fi;
        
        Info( InfoHomalgBasicOperations, l, s );
    
    else
        
        s := Concatenation( HOMALG.color_done, "<DONE\033[0m ", color );
        
        s := Concatenation( s, arg[2], "\033[0m \033[7m", color );
        
        Append( s, Concatenation( List( arg{[3..nargs]}, function( a ) if IsStringRep( a ) then return a; else return String( a ); fi; end ) ) );
        
        s := Concatenation( s, "\033[0m ", "	in ", homalgTotalRuntimes( arg[1] ) );
        
        Info( InfoHomalgBasicOperations, l, s );
    
        if l < 4 then
            Info( InfoHomalgBasicOperations, l , "" );
        fi;
        
    fi;
    
end );

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
    
    ColoredInfoForService( "busy", "TriangularBasisOfRows", NrRows( M ), " x ", NrColumns( M ) );
    
    t := homalgTotalRuntimes( );
    
    if IsBound(RP!.TriangularBasisOfRows) then
        
        B := RP!.TriangularBasisOfRows( M );
        
        ColoredInfoForService( t, "TriangularBasisOfRows", Length( NonZeroRows( B ) ) );
        
        return B;
        
    elif IsBound(RP!.TriangularBasisOfColumns) then
        
        B := Involution( RP!.TriangularBasisOfColumns( Involution( M ) ) );
        
        ColoredInfoForService( t, "TriangularBasisOfRows", Length( NonZeroRows( B ) ) );
        
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
    
    ColoredInfoForService( "busy", "TriangularBasisOfRows (M,T)", NrRows( M ), " x ", NrColumns( M ) );
    
    t := homalgTotalRuntimes( );
    
    if IsBound(RP!.TriangularBasisOfRows) then
        
        B := RP!.TriangularBasisOfRows( M, T );
        
        ColoredInfoForService( t, "TriangularBasisOfRows (M,T)", Length( NonZeroRows( B ) ) );
        
        return B;
        
    elif IsBound(RP!.TriangularBasisOfColumns) then
        
        TI := HomalgVoidMatrix( R );
        
        B := Involution( RP!.TriangularBasisOfColumns( Involution( M ), TI ) );
        
        ColoredInfoForService( t, "TriangularBasisOfRows (M,T)", Length( NonZeroRows( B ) ) );
        
        SetPreEval( T, Involution( TI ) ); ResetFilterObj( T, IsVoidMatrix );
        
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
        
        ColoredInfoForService( "busy", "TriangularBasisOfColumns", NrRows( M ), " x ", NrColumns( M ) );
        
        B := RP!.TriangularBasisOfColumns( M );
        
        ColoredInfoForService( t, "TriangularBasisOfColumns", Length( NonZeroColumns( B ) ) );
        
        return B;
        
    fi;
    
    B := Involution( TriangularBasisOfRows( Involution( M ) ) );
    
    return B;
    
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
        
        ColoredInfoForService( "busy", "TriangularBasisOfColumns (M,T)", NrRows( M ), " x ", NrColumns( M ) );
        
        B := RP!.TriangularBasisOfColumns( M, T );
        
        ColoredInfoForService( t, "TriangularBasisOfColumns (M,T)", Length( NonZeroColumns( B ) ) );
        
        return B;
        
    fi;
    
    TI := HomalgVoidMatrix( R );
    
    B := Involution( TriangularBasisOfRows( Involution( M ), TI ) );
    
    SetPreEval( T, Involution( TI ) ); ResetFilterObj( T, IsVoidMatrix );
    
    return B;
    
end );

#### could become lazy

##
InstallMethod( BasisOfRowModule,		### defines: BasisOfRowModule (BasisOfModule (low-level))
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, t, B, nz;
    
    if IsBound(M!.BasisOfRowModule) then
        return M!.BasisOfRowModule;
    fi;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    t := homalgTotalRuntimes( );
    
    ColoredInfoForService( "busy", "BasisOfRowModule", NrRows( M ), " x ", NrColumns( M ) );
    
    if IsBound(RP!.BasisOfRowModule) then
        
        B := RP!.BasisOfRowModule( M );
        
        if HasRowRankOfMatrix( B ) then
            SetRowRankOfMatrix( M, RowRankOfMatrix( B ) );
        fi;
        
        SetIsBasisOfRowsMatrix( B, true );
        
        ColoredInfoForService( t, "BasisOfRowModule", NrRows( B ) );
        
        IncreaseRingStatistics( R, "BasisOfRowModule" );
        
        M!.BasisOfRowModule := B;
	
        return B;
        
    elif IsBound(RP!.BasisOfColumnModule) then
        
        B := RP!.BasisOfColumnModule( Involution( M ) );
        
        if HasColumnRankOfMatrix( B ) then
            SetRowRankOfMatrix( M, ColumnRankOfMatrix( B ) );
        fi;
        
        B := Involution( B );
        
        SetIsBasisOfRowsMatrix( B, true );
        
        ColoredInfoForService( t, "BasisOfRowModule", NrRows( B ) );
        
        IncreaseRingStatistics( R, "BasisOfColumnModule" );
        
        M!.BasisOfRowModule := B;
        
        return B;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    B := TriangularBasisOfRows( M );
    
    nz := Length( NonZeroRows( B ) );
    
    if nz = 0 then
        B := HomalgZeroMatrix( 0, NrColumns( B ), R );
    else
        B := CertainRows( B, [ 1 .. nz ] );
    fi;
    
    SetIsBasisOfRowsMatrix( B, true );
        
    ColoredInfoForService( t, "BasisOfRowModule", NrRows( B ) );
    
    IncreaseRingStatistics( R, "BasisOfRowModule" );
    
    M!.BasisOfRowModule := B;
    
    return B;
    
end );

##
InstallMethod( BasisOfColumnModule,		### defines: BasisOfColumnModule (BasisOfModule (low-level))
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, t, B, nz;
    
    if IsBound(M!.BasisOfColumnModule) then
        return M!.BasisOfColumnModule;
    fi;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    t := homalgTotalRuntimes( );
    
    ColoredInfoForService( "busy", "BasisOfColumnModule", NrRows( M ), " x ", NrColumns( M ) );
    
    if IsBound(RP!.BasisOfColumnModule) then
        
        B := RP!.BasisOfColumnModule( M );
        
        if HasColumnRankOfMatrix( B ) then
            SetColumnRankOfMatrix( M, ColumnRankOfMatrix( B ) );
        fi;
        
        SetIsBasisOfColumnsMatrix( B, true );
        
        ColoredInfoForService( t, "BasisOfColumnModule", NrColumns( B ) );
        
        IncreaseRingStatistics( R, "BasisOfColumnModule" );
        
        M!.BasisOfColumnModule := B;
        
        return B;
        
    elif IsBound(RP!.BasisOfRowModule) then
        
        B := RP!.BasisOfRowModule( Involution( M ) );
        
        if HasRowRankOfMatrix( B ) then
            SetColumnRankOfMatrix( M, RowRankOfMatrix( B ) );
        fi;
        
        B := Involution( B );
        
        SetIsBasisOfColumnsMatrix( B, true );
        
        ColoredInfoForService( t, "BasisOfColumnModule", NrColumns( B ) );
        
        IncreaseRingStatistics( R, "BasisOfRowModule" );
        
        M!.BasisOfColumnModule := B;
        
        return B;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    B := TriangularBasisOfColumns( M );
    
    nz := Length( NonZeroColumns( B ) );
    
    if nz = 0 then
        B := HomalgZeroMatrix( NrRows( B ), 0, R );
    else
        B := CertainColumns( B, [ 1 .. nz ] );
    fi;
    
    SetIsBasisOfColumnsMatrix( B, true );
        
    ColoredInfoForService( t, "BasisOfColumnModule", NrColumns( B ) );
    
    IncreaseRingStatistics( R, "BasisOfColumnModule" );
    
    M!.BasisOfColumnModule := B;
    
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
    
    ColoredInfoForService( "busy", "DecideZeroRows", "( ", NrRows( A ), " + ", NrRows( B ), " ) x ", NrColumns( A ) );
    
    if IsBound(RP!.DecideZeroRows) then
        
        C := RP!.DecideZeroRows( A, B );
        
        ColoredInfoForService( t, "DecideZeroRows" );
        
        IncreaseRingStatistics( R, "DecideZeroRows" );
        
        return C;
        
    elif IsBound(RP!.DecideZeroColumns) then
        
        C := Involution( RP!.DecideZeroColumns( Involution( A ), Involution( B ) ) );
        
        ColoredInfoForService( t, "DecideZeroRows" );
        
        IncreaseRingStatistics( R, "DecideZeroColumns" );
        
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
    
    ColoredInfoForService( t, "DecideZeroRows" );
    
    IncreaseRingStatistics( R, "DecideZeroRows" );
    
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
    
    ColoredInfoForService( "busy", "DecideZeroColumns", NrRows( A ), " x ( ", NrColumns( A ), " + ", NrColumns( B ), " )" );
    
    if IsBound(RP!.DecideZeroColumns) then
        
        C := RP!.DecideZeroColumns( A, B );
        
        ColoredInfoForService( t, "DecideZeroColumns" );
        
        IncreaseRingStatistics( R, "DecideZeroColumns" );
        
        return C;
        
    elif IsBound(RP!.DecideZeroRows) then
        
        C := Involution( RP!.DecideZeroRows( Involution( A ), Involution( B ) ) );
        
        ColoredInfoForService( t, "DecideZeroColumns" );
        
        IncreaseRingStatistics( R, "DecideZeroRows" );
        
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
    
    ColoredInfoForService( t, "DecideZeroColumns" );
    
    IncreaseRingStatistics( R, "DecideZeroColumns" );
    
    return C;
    
end );

##
InstallMethod( SyzygiesGeneratorsOfRows,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, t, C, B, nz;
    
    if IsBound(M!.SyzygiesGeneratorsOfRows) then
        return M!.SyzygiesGeneratorsOfRows;
    fi;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    t := homalgTotalRuntimes( );
    
    ColoredInfoForService( "busy", "SyzygiesGeneratorsOfRows", NrRows( M ), " x ", NrColumns( M ) );
    
    if IsBound(RP!.SyzygiesGeneratorsOfRows) then
        
        C := RP!.SyzygiesGeneratorsOfRows( M );
        
        if IsZero( C ) then
            
            SetIsLeftRegularMatrix( M, true );
            
            C := HomalgZeroMatrix( 0, NrRows( M ), R );
            
        fi;
        
        ColoredInfoForService( t, "SyzygiesGeneratorsOfRows", NrRows( C ) );
        
        M!.SyzygiesGeneratorsOfRows := C;
        
        IncreaseRingStatistics( R, "SyzygiesGeneratorsOfRows" );
        
        return C;
        
    elif IsBound(RP!.SyzygiesGeneratorsOfColumns) then
        
        C := Involution( RP!.SyzygiesGeneratorsOfColumns( Involution( M ) ) );
        
        if IsZero( C ) then
            
            SetIsLeftRegularMatrix( M, true );
            
            C := HomalgZeroMatrix( 0, NrRows( M ), R );
            
        fi;
        
        ColoredInfoForService( t, "SyzygiesGeneratorsOfRows", NrRows( C ) );
        
        M!.SyzygiesGeneratorsOfRows := C;
        
        IncreaseRingStatistics( R, "SyzygiesGeneratorsOfColumns" );
        
        return C;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    C := HomalgVoidMatrix( R );
    
    B := TriangularBasisOfRows( M, C );
    
    nz := Length( NonZeroRows( B ) );
    
    C := CertainRows( C, [ nz + 1 .. NrRows( C ) ] );
    
    if IsZero( C ) then
        
        SetIsLeftRegularMatrix( M, true );
        
        C := HomalgZeroMatrix( 0, NrRows( M ), R );
        
    fi;
    
    ColoredInfoForService( t, "SyzygiesGeneratorsOfRows", NrRows( C ) );
    
    M!.SyzygiesGeneratorsOfRows := C;
    
    IncreaseRingStatistics( R, "SyzygiesGeneratorsOfRows" );
    
    return C;
    
end );

##
InstallMethod( SyzygiesGeneratorsOfRows,	### defines: SyzygiesGeneratorsOfRows (SyzygiesGenerators)
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( M1, M2 )
    local R, RP, t, M, C, nz;
    
    R := HomalgRing( M1 );
    
    RP := homalgTable( R );
    
    t := homalgTotalRuntimes( );
    
    ColoredInfoForService( "busy", "SyzygiesGeneratorsOfRows", "( ", NrRows( M1 ), " + ", NrRows( M2 ), " ) x ", NrColumns( M1 ) );
    
    if IsBound(RP!.SyzygiesGeneratorsOfRows) then
        
        C := RP!.SyzygiesGeneratorsOfRows( M1, M2 );
        
        if IsZero( C ) then
            
            C := HomalgZeroMatrix( 0, NrRows( M1 ), R );
            
        fi;
        
        ColoredInfoForService( t, "SyzygiesGeneratorsOfRows", NrRows( C ) );
        
        IncreaseRingStatistics( R, "SyzygiesGeneratorsOfRows" );
        
        return C;
        
    elif IsBound(RP!.SyzygiesGeneratorsOfColumns) then
        
        C := Involution( RP!.SyzygiesGeneratorsOfColumns( Involution( M1 ), Involution( M2 ) ) );
        
        if IsZero( C ) then
            
            C := HomalgZeroMatrix( 0, NrRows( M1 ), R );
            
        fi;
        
        ColoredInfoForService( t, "SyzygiesGeneratorsOfRows", NrRows( C ) );
        
        IncreaseRingStatistics( R, "SyzygiesGeneratorsOfColumns" );
        
        return C;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    M := UnionOfRows( M1, M2 );
    
    C := HomalgVoidMatrix( R );
    
    M := TriangularBasisOfRows( M, C );
    
    nz := Length( NonZeroRows( M ) );
    
    C := CertainColumns( CertainRows( C, [ nz + 1 .. NrRows( C ) ] ), [ 1 .. NrRows( M1 ) ] );
    
    if IsZero( C ) then
        
        C := HomalgZeroMatrix( 0, NrRows( M1 ), R );
        
    fi;
    
    ColoredInfoForService( t, "SyzygiesGeneratorsOfRows", NrRows( C ) );
    
    IncreaseRingStatistics( R, "SyzygiesGeneratorsOfRows" );
    
    return C;
    
end );

##
InstallMethod( SyzygiesGeneratorsOfColumns,
        "for homalg matrices",
        [ IsHomalgMatrix ],
        
  function( M )
    local R, RP, t, C, B, nz;
    
    if IsBound(M!.SyzygiesGeneratorsOfColumns) then
        return M!.SyzygiesGeneratorsOfColumns;
    fi;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    t := homalgTotalRuntimes( );
    
    ColoredInfoForService( "busy", "SyzygiesGeneratorsOfColumns", NrRows( M ), " x ", NrColumns( M ) );
    
    if IsBound(RP!.SyzygiesGeneratorsOfColumns) then
        
        C := RP!.SyzygiesGeneratorsOfColumns( M );
        
        if IsZero( C ) then
            
            SetIsRightRegularMatrix( M, true );
            
            C := HomalgZeroMatrix( NrColumns( M ), 0, R );
            
        fi;
        
        ColoredInfoForService( t, "SyzygiesGeneratorsOfColumns", NrColumns( C ) );
        
        M!.SyzygiesGeneratorsOfColumns := C;
        
        IncreaseRingStatistics( R, "SyzygiesGeneratorsOfColumns" );
        
        return C;
        
    elif IsBound(RP!.SyzygiesGeneratorsOfRows) then
        
        C := Involution( RP!.SyzygiesGeneratorsOfRows( Involution( M ) ) );
        
        if IsZero( C ) then
            
            SetIsRightRegularMatrix( M, true );
            
            C := HomalgZeroMatrix( NrColumns( M ), 0, R );
            
        fi;
        
        ColoredInfoForService( t, "SyzygiesGeneratorsOfColumns", NrColumns( C ) );
        
        M!.SyzygiesGeneratorsOfColumns := C;
        
        IncreaseRingStatistics( R, "SyzygiesGeneratorsOfRows" );
        
        return C;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    C := HomalgVoidMatrix( R );
    
    B := TriangularBasisOfColumns( M, C );
    
    nz := Length( NonZeroColumns( B ) );
    
    C := CertainColumns( C, [ nz + 1 .. NrColumns( C ) ] );
    
    if IsZero( C ) then
        
        SetIsRightRegularMatrix( M, true );
        
        C := HomalgZeroMatrix( NrColumns( M ), 0, R );
        
    fi;
    
    ColoredInfoForService( t, "SyzygiesGeneratorsOfColumns", NrColumns( C ) );
    
    M!.SyzygiesGeneratorsOfColumns := C;
    
    IncreaseRingStatistics( R, "SyzygiesGeneratorsOfColumns" );
    
    return C;
    
end );

##
InstallMethod( SyzygiesGeneratorsOfColumns,	### defines: SyzygiesGeneratorsOfColumns (SyzygiesGenerators)
        "for homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( M1, M2 )
    local R, RP, t, M, C, nz;
    
    R := HomalgRing( M1 );
    
    RP := homalgTable( R );
    
    t := homalgTotalRuntimes( );
    
    ColoredInfoForService( "busy", "SyzygiesGeneratorsOfColumns", NrRows( M1 ), " x ( ", NrColumns( M1 ), " + ", NrColumns( M2 ), " )" );
    
    if IsBound(RP!.SyzygiesGeneratorsOfColumns) then
        
        C := RP!.SyzygiesGeneratorsOfColumns( M1, M2 );
        
        if IsZero( C ) then
            
            C := HomalgZeroMatrix( NrColumns( M1 ), 0, R );
            
        fi;
        
        ColoredInfoForService( t, "SyzygiesGeneratorsOfColumns", NrColumns( C ) );
        
        IncreaseRingStatistics( R, "SyzygiesGeneratorsOfColumns" );
        
        return C;
        
    elif IsBound(RP!.SyzygiesGeneratorsOfRows) then
        
        C := Involution( RP!.SyzygiesGeneratorsOfRows( Involution( M1 ), Involution( M2 ) ) );
        
        if IsZero( C ) then
            
            C := HomalgZeroMatrix( NrColumns( M1 ), 0, R );
            
        fi;
        
        ColoredInfoForService( t, "SyzygiesGeneratorsOfColumns", NrColumns( C ) );
        
        IncreaseRingStatistics( R, "SyzygiesGeneratorsOfRows" );
        
        return C;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    M := UnionOfColumns( M1, M2 );
    
    C := HomalgVoidMatrix( R );
    
    M := TriangularBasisOfColumns( M, C );
    
    nz := Length( NonZeroColumns( M ) );
    
    C := CertainRows( CertainColumns( C, [ nz + 1 .. NrColumns( C ) ] ), [ 1 .. NrColumns( M1 ) ] );
    
    if IsZero( C ) then
        
        C := HomalgZeroMatrix( NrColumns( M1 ), 0, R );
        
    fi;
    
    ColoredInfoForService( t, "SyzygiesGeneratorsOfColumns", NrColumns( C ) );
    
    IncreaseRingStatistics( R, "SyzygiesGeneratorsOfColumns" );
    
    return C;
    
end );

#### Effectively:

##
InstallMethod( BasisOfRowsCoeff,		### defines: BasisOfRowsCoeff (BasisCoeff)
        "for a homalg matrix",
        [ IsHomalgMatrix, IsHomalgMatrix and IsVoidMatrix ],
        
  function( M, T )
    local R, RP, t, TI, B, TT, nz;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    t := homalgTotalRuntimes( );
    
    ColoredInfoForService( "busy", "BasisOfRowsCoeff", NrRows( M ), " x ", NrColumns( M ) );
    
    if IsBound(RP!.BasisOfRowsCoeff) then
        
        B := RP!.BasisOfRowsCoeff( M, T );
        
        if HasRowRankOfMatrix( B ) then
            SetRowRankOfMatrix( M, RowRankOfMatrix( B ) );
        fi;
        
        ColoredInfoForService( t, "BasisOfRowsCoeff", NrRows( B ) );
        
        IncreaseRingStatistics( R, "BasisOfRowsCoeff" );
        
        return B;
        
    elif IsBound(RP!.BasisOfColumnsCoeff) then
        
        TI := HomalgVoidMatrix( R );
        
        B := RP!.BasisOfColumnsCoeff( Involution( M ), TI );
        
        if HasColumnRankOfMatrix( B ) then
            SetRowRankOfMatrix( M, ColumnRankOfMatrix( B ) );
        fi;
        
        B := Involution( B );
        
        SetEvalInvolution( T, TI ); ResetFilterObj( T, IsVoidMatrix );
        
        ColoredInfoForService( t, "BasisOfRowsCoeff", NrRows( B ) );
        
        IncreaseRingStatistics( R, "BasisOfColumnsCoeff" );
        
        return B;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    TT := HomalgVoidMatrix( R );
    
    B := TriangularBasisOfRows( M, TT );
    
    nz := Length( NonZeroRows( B ) );
    
    if nz = 0 then
        B := HomalgZeroMatrix( 0, NrColumns( B ), R );
    else
        B := CertainRows( B, [ 1 .. nz ] );
    fi;
    
    ## B = T * M;
    SetPreEval( T, CertainRows( TT, [ 1 .. nz ] ) ); ResetFilterObj( T, IsVoidMatrix );
    
    ColoredInfoForService( t, "BasisOfRowsCoeff", NrRows( B ) );
    
    IncreaseRingStatistics( R, "BasisOfRowsCoeff" );
    
    return B;
    
end );

##
InstallMethod( BasisOfColumnsCoeff,		### defines: BasisOfColumnsCoeff (BasisCoeff)
        "for a homalg matrix",
        [ IsHomalgMatrix, IsHomalgMatrix and IsVoidMatrix ],
        
  function( M, T )
    local R, RP, t, TI, B, TT, nz;
    
    R := HomalgRing( M );
    
    RP := homalgTable( R );
    
    t := homalgTotalRuntimes( );
    
    ColoredInfoForService( "busy", "BasisOfColumnsCoeff", NrRows( M ), " x ", NrColumns( M ) );
    
    if IsBound(RP!.BasisOfColumnsCoeff) then
        
        B := RP!.BasisOfColumnsCoeff( M, T );
        
        if HasColumnRankOfMatrix( B ) then
            SetColumnRankOfMatrix( M, ColumnRankOfMatrix( B ) );
        fi;
        
        ColoredInfoForService( t, "BasisOfColumnsCoeff", NrColumns( B ) );
        
        IncreaseRingStatistics( R, "BasisOfColumnsCoeff" );
        
        return B;
        
    elif IsBound(RP!.BasisOfRowsCoeff) then
        
        TI := HomalgVoidMatrix( R );
        
        B := RP!.BasisOfRowsCoeff( Involution( M ), TI );
        
        if HasRowRankOfMatrix( B ) then
            SetColumnRankOfMatrix( M, RowRankOfMatrix( B ) );
        fi;
        
        B := Involution( B );
        
        SetEvalInvolution( T, TI ); ResetFilterObj( T, IsVoidMatrix );
        
        ColoredInfoForService( t, "BasisOfColumnsCoeff", NrColumns( B ) );
        
        IncreaseRingStatistics( R, "BasisOfRowsCoeff" );
        
        return B;
        
    fi;
    
    #=====# begin of the core procedure #=====#
    
    TT := HomalgVoidMatrix( R );
    
    B := TriangularBasisOfColumns( M, TT );
    
    nz := Length( NonZeroColumns( B ) );
    
    if nz = 0 then
        B := HomalgZeroMatrix( NrRows( B ), 0, R );
    else
        B := CertainColumns( B, [ 1 .. nz ] );
    fi;
    
    ## B = M * T;
    SetPreEval( T, CertainColumns( TT, [ 1 .. nz ] ) ); ResetFilterObj( T, IsVoidMatrix );
    
    ColoredInfoForService( t, "BasisOfColumnsCoeff", NrColumns( B ) );
    
    IncreaseRingStatistics( R, "BasisOfColumnsCoeff" );
    
    return B;
    
end );

##
InstallMethod( DecideZeroRowsEffectively,	### defines: DecideZeroRowsEffectively (ReduceCoeff)
        "for a homalg matrix",
        [ IsHomalgMatrix, IsHomalgMatrix, IsHomalgMatrix and IsVoidMatrix ],
        
  function( A, B, T )
    local R, RP, t, TI, l, m, n, id, zz, M, TT, MM;
    
    R := HomalgRing( B );
    
    RP := homalgTable( R );
    
    t := homalgTotalRuntimes( );
    
    ColoredInfoForService( "busy", "DecideZeroRowsEffectively", "( ", NrRows( A ), " + ", NrRows( B ), " ) x ", NrColumns( A ) );
    
    if IsBound(RP!.DecideZeroRowsEffectively) then
        
        M := RP!.DecideZeroRowsEffectively( A, B, T );
        
        ColoredInfoForService( t, "DecideZeroRowsEffectively" );
        
        IncreaseRingStatistics( R, "DecideZeroRowsEffectively" );
        
        return M;
        
    elif IsBound(RP!.DecideZeroColumnsEffectively) then
        
        TI := HomalgVoidMatrix( R );
        
        M := Involution( RP!.DecideZeroColumnsEffectively( Involution( A ), Involution( B ), TI ) );
        
        SetEvalInvolution( T, TI ); ResetFilterObj( T, IsVoidMatrix );
        
        ColoredInfoForService( t, "DecideZeroRowsEffectively" );
        
        IncreaseRingStatistics( R, "DecideZeroColumnsEffectively" );
        
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
    
    ## M = A + T * B;
    SetPreEval( T, TT ); ResetFilterObj( T, IsVoidMatrix );
    
    ## check assertion
    Assert( 4, M = A + T * B );
    
    ColoredInfoForService( t, "DecideZeroRowsEffectively" );
    
    IncreaseRingStatistics( R, "DecideZeroRowsEffectively" );
    
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
    
    ColoredInfoForService( "busy", "DecideZeroColumnsEffectively", NrRows( A ), " x ( ", NrColumns( A ), " + ", NrColumns( B ), " )" );
    
    if IsBound(RP!.DecideZeroColumnsEffectively) then
        
        M := RP!.DecideZeroColumnsEffectively( A, B, T );
        
        ColoredInfoForService( t, "DecideZeroColumnsEffectively" );
        
        IncreaseRingStatistics( R, "DecideZeroColumnsEffectively" );
        
        return M;
        
    elif IsBound(RP!.DecideZeroRowsEffectively) then
        
        TI := HomalgVoidMatrix( R );
        
        M := Involution( RP!.DecideZeroRowsEffectively( Involution( A ), Involution( B ), TI ) );
        
        SetEvalInvolution( T, TI ); ResetFilterObj( T, IsVoidMatrix );
        
        ColoredInfoForService( t, "DecideZeroColumnsEffectively" );
        
        IncreaseRingStatistics( R, "DecideZeroRowsEffectively" );
        
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
    
    ## M = A + B * T;
    SetPreEval( T, TT ); ResetFilterObj( T, IsVoidMatrix );
    
    ## check assertion
    Assert( 4, M = A + B * T );
    
    ColoredInfoForService( t, "DecideZeroColumnsEffectively" );
    
    IncreaseRingStatistics( R, "DecideZeroColumnsEffectively" );
    
    return M;
    
end );

