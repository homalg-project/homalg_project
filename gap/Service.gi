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
InstallMethod( TriangularBasis,
        "for a homalg matrix",
	[ IsMatrixForHomalg ],
        
  function( M )
    local R, RP;
    
    R := M!.ring;
    
    RP := HomalgTable( R );
  
    if IsBound( RP!.TriangularBasis ) then
        return RP!.TriangularBasis( M );
    else
        TryNextMethod();
    fi;
    
end );    

##
InstallMethod( TriangularBasis,
        "for a homalg matrix",
	[ IsMatrixForHomalg and IsZeroMatrix ],
        
  function( M )
    
    return( M );
    
end );
    
##
InstallMethod( TriangularBasis,
        "for a homalg matrix",
	[ IsMatrixForHomalg and IsIdentityMatrix ],
        
  function( M )
    
    return( M );
    
end );
    
##
InstallMethod( BasisOfModule,
        "for a homalg matrix",
	[ IsMatrixForHomalg ],
        
  function( _M )
    local R, RP, ring_rel, M, B, rank;
    
    R := _M!.ring;
    
    RP := HomalgTable( R );
  
    if IsBound( RP!.BasisOfModule ) then
        return RP!.BasisOfModule( _M );
    fi;
    
    if HasRingRelations( R ) then
        ring_rel := RingRelations( R );
    fi;
    
    #=====# begin of the core procedure #=====#
    
    M := _M;
    
    B := TriangularBasis( M );
    
    rank := RankOfMatrix( B );
    
    if rank = 0 then
        B := MatrixForHomalg( "zero", 0, NrColumns( B ), R);
    else
        B := CertainRows( B, [1..rank] );
        
        SetRankOfMatrix( B, rank );
	
        SetIsFullRowRankMatrix( B, true );
    fi;
    
    return B;
    
end );

