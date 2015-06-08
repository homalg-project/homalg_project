#############################################################################
##
##  HomalgChainMap.gi           Modules package              Mohamed Barakat
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##
##  Implementations for homalg chain morphisms.
##
#############################################################################

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( HomalgRing,
        "for homalg chain morphisms",
        [ IsHomalgChainMorphism ],
        
  function( cm )
    
    return HomalgRing( Source( cm ) );
    
end );

##
InstallMethod( Add,
        "for homalg chain morphisms",
        [ IsHomalgChainMorphism, IsHomalgMatrix ],
        
  function( cm, mat )
    local i, degree, S, T, phi;
    
    i := HighestDegree( cm ) + 1;
    degree := DegreeOfMorphism( cm );
    
    S := Source( cm );
    T := Range( cm );
    
    phi := HomalgMap( mat, CertainObject( S, i ), CertainObject( T, i + degree ) );
    
    Add( cm, phi );
    
end );

##
InstallMethod( OnLessGenerators,
        "for homalg chain morphisms",
        [ IsHomalgChainMorphism ],
        
  function( phi )
    
    OnLessGenerators( Source( phi ) );
    OnLessGenerators( Range( phi ) );
    
    return phi;
    
end );

##
InstallMethod( BasisOfModule,
        "for homalg chain morphisms",
        [ IsHomalgChainMorphism ],
        
  function( phi )
    
    BasisOfModule( Source( phi ) );
    BasisOfModule( Range( phi ) );
    
    return phi;
    
end );
