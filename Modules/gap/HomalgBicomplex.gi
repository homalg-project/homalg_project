# SPDX-License-Identifier: GPL-2.0-or-later
# Modules: A homalg based package for the Abelian category of finitely presented modules over computable rings
#
# Implementations
#

##  Implementations for homalg bicomplexes.

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

