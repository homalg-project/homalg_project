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
InstallGlobalFunction( ResolutionOfHomomorphism,	### defines: ResolutionOfHomomorphism
  function( arg )
    local nargs, phi, R, q, d_S, d_T, c, j, d_S_j, d_T_j, phi_j;
    
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
    
    d_S := ResolutionOfModule( Source( phi ), q );
    d_T := ResolutionOfModule( Target( phi ), q );
    
    q := Maximum( List( [ d_S, d_T ], HighestDegreeInComplex ) );
    
    d_S := ResolutionOfModule( Source( phi ), q );
    d_T := ResolutionOfModule( Target( phi ), q );
    
    j := 0;
    
    d_S_j := CokernelEpi( CertainMorphism( d_S, j + 1 ) );
    d_T_j := CokernelEpi( CertainMorphism( d_T, j + 1 ) );
    
    phi_j := CompleteImSq( d_S_j, phi, d_T_j );
    
    c := HomalgChainMap( phi_j, d_S, d_T );
    
    while j < q do
        
        j := j + 1;
        
        d_S_j := CertainMorphism( d_S, j );
        d_T_j := CertainMorphism( d_T, j );
        
        phi_j := CompleteImSq( d_S_j, phi_j, d_T_j );
        
        Add( c, phi_j );
        
    od;
    
    return c;
    
end );
