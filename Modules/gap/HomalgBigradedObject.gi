# SPDX-License-Identifier: GPL-2.0-or-later
# Modules: A homalg based package for the Abelian category of finitely presented modules over computable rings
#
# Implementations
#

##  Implementations for homalg bigraded objects.

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( HomalgRing,
        "for homalg bigraded objects",
        [ IsHomalgBigradedObject ],
        
  function( Er )
    
    return HomalgRing( LowestBidegreeObjectInBigradedObject( Er ) );
    
end );

##
InstallMethod( BasisOfModule,
        "for homalg bigraded objects",
        [ IsHomalgBigradedObject ],
        
  function( Er )
    
    List( Flat( ObjectsOfBigradedObject( Er ) ), BasisOfModule );
    
    return Er;
    
end );

##
InstallMethod( OnLessGenerators,
        "for homalg bigraded objects",
        [ IsHomalgBigradedObject ],
        
  function( Er )
    
    List( Flat( ObjectsOfBigradedObject( Er ) ), OnLessGenerators );
    
    return Er;
    
end );

