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
        "for a homalg matrix",
        [ IsMatrixForHomalg ],
        
  function( M )
    local R, RP;
    
    R := HomalgRing( M );
    
    RP := HomalgTable( R );
  
    if IsBound(RP!.TriangularBasisOfRows) then
        return RP!.TriangularBasisOfRows( M );
    fi;
    
    TryNextMethod( );
    
end ); 

##
InstallMethod( TriangularBasisOfRows,
        "for a homalg matrix",
        [ IsMatrixForHomalg, IsMatrixForHomalg ],
        
  function( M, U )
    local R, RP;
    
    R := HomalgRing( M );
    
    RP := HomalgTable( R );
    
    if IsBound(RP!.TriangularBasisOfRows) then
        return RP!.TriangularBasisOfRows( M, U );
    fi;
    
    TryNextMethod( );
    
end ); 

##
InstallMethod( TriangularBasisOfColumns,
        "for a homalg matrix",
        [ IsMatrixForHomalg ],
        
  function( M )
    local R, RP;
    
    R := HomalgRing( M );
    
    RP := HomalgTable( R );
    
    if IsBound(RP!.TriangularBasisOfColumns) then
        return RP!.TriangularBasisOfColumns( M );
    fi;
    
    return Involution( TriangularBasisOfRows( Involution( M ) ) );
    
end ); 

##
InstallMethod( TriangularBasisOfColumns,
        "for a homalg matrix",
	[ IsMatrixForHomalg, IsMatrixForHomalg ],
        
  function( M, V )
    local R, RP, T, U;
    
    R := HomalgRing( M );
    
    RP := HomalgTable( R );
    
    if IsBound(RP!.TriangularBasisOfColumns) then
        return RP!.TriangularBasisOfColumns( M, V );
    fi;
    
    if IsHomalgInternalMatrixRep( V ) then
        U := MatrixForHomalg( "internal", R );
    else
        U := MatrixForHomalg( "external", R );
    fi;
    
    T := Involution( TriangularBasisOfRows( Involution( M ), U ) );
    
    SetEvalInvolution( V, U );
    SetNrRows( V, NrColumns( U ) );
    SetNrColumns( V, NrRows( U ) );
    SetIsFullRowRankMatrix( V, true );
    SetIsFullColumnRankMatrix( V, true );
         
    return T;
    
end ); 

##
InstallMethod( TriangularBasisOfRows,
        "for a homalg matrix",
	[ IsMatrixForHomalg and IsZeroMatrix ],
        
  function( M )
    
    return( M );
    
end );
    
##
InstallMethod( TriangularBasisOfColumns,
        "for a homalg matrix",
	[ IsMatrixForHomalg and IsZeroMatrix ],
        
  function( M )
    
    return( M );
    
end );
    
##
InstallMethod( TriangularBasisOfRows,
        "for a homalg matrix",
	[ IsMatrixForHomalg and IsIdentityMatrix ],
        
  function( M )
    
    return( M );
    
end );
    
##
InstallMethod( TriangularBasisOfColumns,
        "for a homalg matrix",
	[ IsMatrixForHomalg and IsIdentityMatrix ],
        
  function( M )
    
    return( M );
    
end );
    
##
InstallMethod( BasisOfRows,
        "for a homalg matrix",
	[ IsMatrixForHomalg ],
        
  function( _M )
    local R, RP, ring_rel, M, U, B, rank, Ur, Uc;
    
    R := HomalgRing( _M );
    
    RP := HomalgTable( R );
  
    if IsBound(RP!.BasisOfRows) then
        return RP!.BasisOfRows( _M );
    fi;
    
    if HasRingRelations( R ) then
        ring_rel := RingRelations( R );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    M := _M;
    
    if HasRightHandSide( M ) then
        if IsHomalgInternalMatrixRep( M ) then
            U := MatrixForHomalg( "internal", R );
        else
            U := MatrixForHomalg( "external", R );
        fi;
        
        B := TriangularBasisOfRows( M, U );
    else
        B := TriangularBasisOfRows( M );
    fi;
    
    rank := RowRankOfMatrix( B );
    
    if rank = 0 then
        B := MatrixForHomalg( "zero", 0, NrColumns( B ), R);
    else
        B := CertainRows( B, [1..rank] );
        
        SetRowRankOfMatrix( B, rank );
	
        SetIsFullRowRankMatrix( B, true );
    fi;
    
    if HasRightHandSide( M ) then
        Ur := CertainRows( U, [ 1 .. rank ] );
        Uc := CertainRows( U, [ rank + 1 .. NrRows( M ) ] );
        
        SetRightHandSide( B, Ur * RightHandSide( M ) );
        
        SetCompCond( B, Uc * RightHandSide( M ) );
    fi;
    
    return B;
    
end );

##
InstallMethod( BasisOfColumns,
        "for a homalg matrix",
	[ IsMatrixForHomalg ],
        
  function( _M )
    local R, RP, ring_rel, M, U, B, rank, Ur, Uc;
    
    R := HomalgRing( _M );
    
    RP := HomalgTable( R );
  
    if IsBound(RP!.BasisOfColumns) then
        return RP!.BasisOfColumns( _M );
    fi;
    
    if HasRingRelations( R ) then
        ring_rel := RingRelations( R );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    M := _M;
    
    if HasBottomSide( M ) then
        if IsHomalgInternalMatrixRep( M ) then
            U := MatrixForHomalg( "internal", R );
        else
            U := MatrixForHomalg( "external", R );
        fi;
        
        B := TriangularBasisOfColumns( M, U );
    else
        B := TriangularBasisOfColumns( M );
    fi;
    
    rank := ColumnRankOfMatrix( B );
    
    if rank = 0 then
        B := MatrixForHomalg( "zero", NrRows( B ), 0, R);
    else
        B := CertainColumns( B, [1..rank] );
        
        SetColumnRankOfMatrix( B, rank );
	
        SetIsFullColumnRankMatrix( B, true );
    fi;
    
    if HasBottomSide( M ) then
        Ur := CertainColumns( U, [ 1 .. rank ] );
        Uc := CertainColumns( U, [ rank + 1 .. NrColumns( M ) ] );
        
        SetBottomSide( B, BottomSide( M ) * Ur );
        
        SetCompCond( B, BottomSide( M ) * Uc );
    fi;
    
    return B;
    
end );

##
InstallMethod( DecideZeroRows,
        "for a homalg matrix",
	[ IsMatrixForHomalg, IsMatrixForHomalg ],
        
  function( L, B )
    local R, RP, l, m, n, id, zz, M, U, C, Ul, T;
    
    R := HomalgRing( B );
    
    RP := HomalgTable( R );
  
    if IsBound(RP!.DecideZeroRows) then
        return RP!.DecideZeroRows( L, B );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    l := NrRows( L );
    m := NrColumns( L );
    
    n := NrRows( B );
    
    id := MatrixForHomalg( "identity", l, R );
    
    zz := MatrixForHomalg( "zero", n, l, R );
    
    M := UnionOfRows( UnionOfColumns( id, L ), UnionOfColumns( zz, B ) );
    
    if HasRightHandSide( B ) then
        if IsHomalgInternalMatrixRep( M ) then
            U := MatrixForHomalg( "internal", R );
        else
            U := MatrixForHomalg( "external", R );
        fi;
        
        M := TriangularBasisOfRows( M, U );
    else
        M := TriangularBasisOfRows( M );
    fi;
    
    C := CertainRows( CertainColumns( M, [ l + 1 .. l + m ] ), [ 1 .. l ] );
    
    if HasRightHandSide( B ) then
        
        Ul := CertainRows( U, [ 1 .. l ] );
        
        if HasRightHandSide( L ) then
            T := Ul * UnionOfRows( RightHandSide( L ), RightHandSide( B ) );
        else
            T := CertainColumns( Ul, [ l + 1 .. l + n ] ) * RightHandSide( B );
        fi;
        
        SetRightHandSide( C, T );
    fi;
    
    return C;
    
end );

##
InstallMethod( DecideZeroColumns,
        "for a homalg matrix",
	[ IsMatrixForHomalg, IsMatrixForHomalg ],
        
  function( L, B )
    local R, RP, l, m, n, id, zz, M, U, C, Ul, T;
    
    R := HomalgRing( B );
    
    RP := HomalgTable( R );
  
    if IsBound(RP!.DecideZeroColumns) then
        return RP!.DecideZeroColumns( L, B );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    l := NrColumns( L );
    m := NrRows( L );
    
    n := NrColumns( B );
    
    id := MatrixForHomalg( "identity", l, R );
    
    zz := MatrixForHomalg( "zero", l, n, R );
    
    M := UnionOfColumns( UnionOfRows( id, L ), UnionOfRows( zz, B ) );
    
    if HasBottomSide( B ) then
        if IsHomalgInternalMatrixRep( M ) then
            U := MatrixForHomalg( "internal", R );
        else
            U := MatrixForHomalg( "external", R );
        fi;
        
        M := TriangularBasisOfColumns( M, U );
    else
        M := TriangularBasisOfColumns( M );
    fi;
    
    C := CertainColumns( CertainRows( M, [ l + 1 .. l + m ] ), [ 1 .. l ] );
    
    if HasBottomSide( B ) then
        
        Ul := CertainColumns( U, [ 1 .. l ] );
        
        if HasBottomSide( L ) then
            T := UnionOfColumns( BottomSide( L ), BottomSide( B ) ) * Ul;
        else
            T := BottomSide( B ) * CertainRows( Ul, [ l + 1 .. l + n ] );
        fi;
        
        SetBottomSide( C, T );
    fi;
    
    return C;
    
end );

##
InstallMethod( DecideZero,
        "for a homalg matrix",
	[ IsMatrixForHomalg ],
        
  function( M )
    local R, RP, ring_rel, rel;
    
    R := HomalgRing( M );
    
    RP := HomalgTable( R );
  
    if IsBound(RP!.DecideZero) then
        return RP!.DecideZero( M );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    ring_rel := RingRelations( R );
    
    rel := MatrixOfRelations( ring_rel );
    
    if IsLeftRelationsForHomalgRep( ring_rel ) then
        rel := DiagMat( ListWithIdenticalEntries( NrColumns( M ), rel ) );
        return DecideZeroRows( M, rel );
    else
        rel := DiagMat( ListWithIdenticalEntries( NrRows( M ), rel ) );
        return DecideZeroColumns( M, rel );
    fi;
    
end );

##
InstallMethod( SyzygiesGeneratorsOfRows,
        "for a homalg matrix",
	[ IsMatrixForHomalg, IsMatrixForHomalg ],
        
  function( M1, M2 )
    local R, RP, id, zz, L;
    
    R := HomalgRing( M1 );
    
    RP := HomalgTable( R );
  
    if IsBound(RP!.SyzygiesGeneratorsOfRows) then
        return RP!.SyzygiesGeneratorsOfRows( M1, M2 );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    id := MatrixForHomalg( "identity", NrRows( M1 ), R );
    
    zz := MatrixForHomalg( "zero", NrRows( M2 ), NrRows( M1 ), R );
    
    L := UnionOfRows( M1, M2 );
    
    SetRightHandSide( L, UnionOfRows( id, zz ) );
    
    L := BasisOfRows( L );
    
    return CompatibilityConditions( L );
    
end );

##
InstallMethod( SyzygiesGeneratorsOfRows,
        "for a homalg matrix",
	[ IsMatrixForHomalg, IsList and IsEmpty ],
        
  function( M1, M2 )
    local R, RP, L;
    
    R := HomalgRing( M1 );
    
    RP := HomalgTable( R );
  
    if IsBound(RP!.SyzygiesGeneratorsOfRows) then
        return RP!.SyzygiesGeneratorsOfRows( M1, M2 );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    L := AddRhs( M1 );
    
    L := BasisOfRows( L );
    
    return CompatibilityConditions( L );
    
end );

##
InstallMethod( SyzygiesGeneratorsOfColumns,
        "for a homalg matrix",
	[ IsMatrixForHomalg, IsMatrixForHomalg ],
        
  function( M1, M2 )
    local R, RP, id, zz, L;
    
    R := HomalgRing( M1 );
    
    RP := HomalgTable( R );
  
    if IsBound(RP!.SyzygiesGeneratorsOfColumns) then
        return RP!.SyzygiesGeneratorsOfColumns( M1, M2 );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    id := MatrixForHomalg( "identity", NrColumns( M1 ), R );
    
    zz := MatrixForHomalg( "zero", NrColumns( M1 ), NrColumns( M2 ), R );
    
    L := UnionOfColumns( M1, M2 );
    
    SetBottomSide( L, UnionOfColumns( id, zz ) );
    
    L := BasisOfColumns( L );
    
    return CompatibilityConditions( L );
    
end );

##
InstallMethod( SyzygiesGeneratorsOfColumns,
        "for a homalg matrix",
	[ IsMatrixForHomalg, IsList and IsEmpty ],
        
  function( M1, M2 )
    local R, RP, L;
    
    R := HomalgRing( M1 );
    
    RP := HomalgTable( R );
  
    if IsBound(RP!.SyzygiesGeneratorsOfColumns) then
        return RP!.SyzygiesGeneratorsOfColumns( M1, M2 );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    L := AddBts( M1 );
    
    L := BasisOfColumns( L );
    
    return CompatibilityConditions( L );
    
end );

