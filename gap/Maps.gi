#############################################################################
##
##  Maps.gi                     homalg package               Mohamed Barakat
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementations of homalg procedures for maps ( = module homomorphisms ).
##
#############################################################################

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( Resolution,	### defines: Resolution (ResolutionOfSeq for a single map)
        "for homalg maps",
        [ IsInt, IsMapOfFinitelyGeneratedModulesRep ],
        
  function( _q, phi  )
    local q, S, T, d_S, d_T, index_pair, j, d_S_j, d_T_j, phi_j, cm;
    
    q := _q;
    
    S := Source( phi );
    T := Range( phi );
    
    d_S := Resolution( q, S );
    d_T := Resolution( q, T );
    
    if q < 0 then
        q := Maximum( List( [ S, T ], LengthOfResolution ) );
        d_S := Resolution( q, S );
        d_T := Resolution( q, T );
    fi;
    
    index_pair := PairOfPositionsOfTheDefaultSetOfRelations( phi );
    
    if IsBound( phi!.free_resolutions.(String( index_pair )) ) then
        cm := phi!.free_resolutions.(String( index_pair ));
        j := HighestDegreeInChainMap( cm );
        phi_j := HighestDegreeMorphismInChainMap( cm );
    else
        j := 0;
        
        d_S_j := FreeHullEpi( S );
        d_T_j := FreeHullEpi( T );
        
        phi_j := CompleteImageSquare( d_S_j, phi, d_T_j );
        
        cm := HomalgChainMap( phi_j, d_S, d_T );
        
        phi!.free_resolutions.(String( index_pair )) := cm;
    fi;
    
    #=====# begin of the core procedure #=====#
    
    while j < q do
        
        j := j + 1;
        
        d_S_j := CertainMorphism( d_S, j );
        d_T_j := CertainMorphism( d_T, j );
        
        phi_j := CompleteImageSquare( d_S_j, phi_j, d_T_j );
        
        Add( cm, phi_j );
        
    od;
    
    SetIsMorphism( cm, true );
    
    return cm;
    
end );

InstallMethod( Resolution,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    
    return Resolution( -1, phi );
    
end );
