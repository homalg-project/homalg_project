#############################################################################
##
##  HomalgBicomplex.gi          Modules package              Mohamed Barakat
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##
##  Implementations for homalg bicomplexes.
##
#############################################################################

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( HomalgRing,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( B )
    
    return HomalgRing( UnderlyingComplex( B ) );
    
end );

##
InstallMethod( BasisOfModule,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( B )
    
    BasisOfModule( UnderlyingComplex( B ) );
    
    return B;
    
end );

##
InstallMethod( OnLessGenerators,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex ],
        
  function( B )
    
    OnLessGenerators( UnderlyingComplex( B ) );
    
    return B;
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallMethod( \*,
        "for homalg bicomplexes",
        [ IsHomalgRing, IsHomalgBicomplex ],
        
  function( R, B )
    
    return HomalgBicomplex( R * UnderlyingComplex( B ) );
    
end );

##
InstallMethod( \*,
        "for homalg bicomplexes",
        [ IsHomalgBicomplex, IsHomalgRing ],
        
  function( B, R )
    
    return R * B;
    
end );

