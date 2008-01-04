##
InstallMethod( BasisOfModule,
        "for a homalg matrix",
	[ IsMatrixForHomalg, IsRingForHomalg ],
        
  function( _M, R )
    local RP, ring_rel, M, B, rank;
    
    RP := HomalgTable(R);
  
    if IsBound(RP!.BasisOfModule) then
        return RP!.BasisOfModule(_M, R); ## the ring contains possible ring relations
    fi;
    
    if HasRingRelations(R) then
        ring_rel := RingRelations(R);
    fi;
    
    #=====# begin of the core procedure #=====#
    
    M := _M;
    
    B := RP!.TriangularBasis(M, R);
    
    rank := RankOfGauss(B);
    
    B := CertainRows(B,[1..rank]);
    
    return B;
    
end );

