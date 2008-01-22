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
    
    R := M!.ring;
    
    RP := HomalgTable( R );
  
    if IsBound(RP!.TriangularBasisOfRows) then
        return RP!.TriangularBasisOfRows( M );
    else
        TryNextMethod( );
    fi;
    
end ); 

##
InstallMethod( TriangularBasisOfRows,
        "for a homalg matrix",
	[ IsMatrixForHomalg, IsMatrixForHomalg ],
        
  function( M, U )
    local R, RP;
    
    R := M!.ring;
    
    RP := HomalgTable( R );
  
    if IsBound(RP!.TriangularBasisOfRows) then
        return RP!.TriangularBasisOfRows( M, U );
    else
        TryNextMethod( );
    fi;
    
end ); 

##
InstallMethod( TriangularBasisOfColumns,
        "for a homalg matrix",
	[ IsMatrixForHomalg ],
        
  function( M )
    local R, RP;
    
    R := M!.ring;
    
    RP := HomalgTable( R );
  
    if IsBound(RP!.TriangularBasisOfColumns) then
        return RP!.TriangularBasisOfColumns( M );
    else
        TryNextMethod( );
    fi;
    
end ); 

##
InstallMethod( TriangularBasisOfColumns,
        "for a homalg matrix",
	[ IsMatrixForHomalg, IsMatrixForHomalg ],
        
  function( M, U )
    local R, RP;
    
    R := M!.ring;
    
    RP := HomalgTable( R );
  
    if IsBound(RP!.TriangularBasisOfColumns) then
        return RP!.TriangularBasisOfColumns( M, U );
    else
        TryNextMethod( );
    fi;
    
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
    
    R := _M!.ring;
    
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
        
        AddRhs( B, Ur * RightHandSide( M ) );
        
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
    
    R := _M!.ring;
    
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
        
        AddBts( B, BottomSide( M ) * Ur );
        
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
    
    R := B!.ring;
    
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
        
        AddRhs( C, T );
    fi;
    
    return C;
    
end );

