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
InstallGlobalFunction( ResolutionOfHomomorphism,	### defines: ResolutionOfHomomorphism (ResolutionOfSeq)
  function( arg )
    local nargs, phi, R, q, S, T, d_S, d_T, index_pair,
          j, d_S_j, d_T_j, phi_j, c;
    
    nargs := Length( arg );
    
    if nargs = 0 or not IsHomalgMap( arg[1] ) then
        Error( "the first argument must be a morphism\n" );
    fi;
    
    phi := arg[1];
    
    R := HomalgRing( phi );
    
    if nargs > 1 and IsInt( arg[2] ) then
        q := arg[2];
    elif IsBound( phi!.MaximumNumberOfResolutionSteps )
      and IsInt( phi!.MaximumNumberOfResolutionSteps ) then
        q := phi!.MaximumNumberOfResolutionSteps;
    elif IsBound( R!.MaximumNumberOfResolutionSteps )
      and IsInt( R!.MaximumNumberOfResolutionSteps ) then
        q := R!.MaximumNumberOfResolutionSteps;
    elif IsBound( HOMALG.MaximumNumberOfResolutionSteps )
      and IsInt( HOMALG.MaximumNumberOfResolutionSteps ) then
        q := HOMALG.MaximumNumberOfResolutionSteps;
    else
        q := infinity;
    fi;
    
    S := Source( phi );
    T := Range( phi );
    
    d_S := ResolutionOfModule( S, q );
    d_T := ResolutionOfModule( T, q );
    
    if q = infinity then
        q := Maximum( List( [ d_S, d_T ], HighestDegreeInComplex ) );
        d_S := ResolutionOfModule( Source( phi ), q );
        d_T := ResolutionOfModule( Range( phi ), q );
    fi;
    
    index_pair := PairOfPositionsOfTheDefaultSetOfRelations( phi );
    
    if IsBound( phi!.free_resolutions.(String( index_pair )) ) then
        c := phi!.free_resolutions.(String( index_pair ));
        j := HighestDegreeInChainMap( c );
        phi_j := HighestDegreeMorphismInChainMap( c );
    else
        j := 0;
        
        d_S_j := CokernelEpi( CertainMorphism( d_S, j + 1 ) );
        d_T_j := CokernelEpi( CertainMorphism( d_T, j + 1 ) );
        
        phi_j := CompleteImSq( d_S_j, phi, d_T_j );
        
        c := HomalgChainMap( phi_j, d_S, d_T );
        
        phi!.free_resolutions.(String( index_pair )) := c;
    fi;
    
    #=====# begin of the core procedure #=====#
    
    while j < q do
        
        j := j + 1;
        
        d_S_j := CertainMorphism( d_S, j );
        d_T_j := CertainMorphism( d_T, j );
        
        phi_j := CompleteImSq( d_S_j, phi_j, d_T_j );
        
        Add( c, phi_j );
        
    od;
    
    SetIsMorphism( c, true );
    
    return c;
    
end );
