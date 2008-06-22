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
        [ IsMapOfFinitelyGeneratedModulesRep, IsInt ],
        
  function( phi, _q )
    local q, S, T, d_S, d_T, index_pair, j, d_S_j, d_T_j, phi_j, c;
    
    q := _q;
    
    S := Source( phi );
    T := Range( phi );
    
    d_S := Resolution( S, q );
    d_T := Resolution( T, q );
    
    if q < 1 then
        q := Maximum( List( [ d_S, d_T ], HighestDegreeInComplex ) );
        d_S := Resolution( S, q );
        d_T := Resolution( T, q );
    fi;
    
    index_pair := PairOfPositionsOfTheDefaultSetOfRelations( phi );
    
    if IsBound( phi!.free_resolutions.(String( index_pair )) ) then
        c := phi!.free_resolutions.(String( index_pair ));
        j := HighestDegreeInChainMap( c );
        phi_j := HighestDegreeMorphismInChainMap( c );
    else
        j := 0;
        
        d_S_j := FreeHullEpi( S );
        d_T_j := FreeHullEpi( T );
        
        phi_j := CompleteImageSquare( d_S_j, phi, d_T_j );
        
        c := HomalgChainMap( phi_j, d_S, d_T );
        
        phi!.free_resolutions.(String( index_pair )) := c;
    fi;
    
    #=====# begin of the core procedure #=====#
    
    while j < q do
        
        j := j + 1;
        
        d_S_j := CertainMorphism( d_S, j );
        d_T_j := CertainMorphism( d_T, j );
        
        phi_j := CompleteImageSquare( d_S_j, phi_j, d_T_j );
        
        Add( c, phi_j );
        
    od;
    
    SetIsMorphism( c, true );
    
    return c;
    
end );

InstallMethod( Resolution,
        "for homalg maps",
        [ IsMapOfFinitelyGeneratedModulesRep ],
        
  function( phi )
    local R, q;
    
    R := HomalgRing( phi );
    
    if IsBound( phi!.MaximumNumberOfResolutionSteps )
      and IsInt( phi!.MaximumNumberOfResolutionSteps ) then
        q := phi!.MaximumNumberOfResolutionSteps;
    elif IsBound( R!.MaximumNumberOfResolutionSteps )
      and IsInt( R!.MaximumNumberOfResolutionSteps ) then
        q := R!.MaximumNumberOfResolutionSteps;
    elif IsBound( HOMALG.MaximumNumberOfResolutionSteps )
      and IsInt( HOMALG.MaximumNumberOfResolutionSteps ) then
        q := HOMALG.MaximumNumberOfResolutionSteps;
    else
        q := 0;
    fi;
    
    return Resolution( phi, q );
    
end );
