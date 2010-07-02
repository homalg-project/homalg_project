#############################################################################
##
##  HomalgChainMap.gi           Modules package              Mohamed Barakat
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##
##  Implementations for homalg chain maps.
##
#############################################################################

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( HomalgRing,
        "for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( cm )
    
    return HomalgRing( Source( cm ) );
    
end );

##
InstallMethod( PositionOfTheDefaultSetOfRelations,	## provided to avoid branching in the code and always returns fail
        "for homalg maps",
        [ IsHomalgChainMap ],
        
  function( M )
    
    return fail;
    
end );

##
InstallMethod( Add,
        "for homalg chain maps",
        [ IsHomalgChainMap, IsHomalgMatrix ],
        
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
        "for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( phi )
    
    OnLessGenerators( Source( phi ) );
    OnLessGenerators( Range( phi ) );
    
    return phi;
    
end );

##
InstallMethod( BasisOfModule,
        "for homalg chain maps",
        [ IsHomalgChainMap ],
        
  function( phi )
    
    BasisOfModule( Source( phi ) );
    BasisOfModule( Range( phi ) );
    
    return phi;
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallMethod( \*,
        "for homalg chain maps",
        [ IsHomalgRing, IsHomalgChainMap ],
        
  function( R, cm )
    
    return BaseChange( R, cm );
    
end );

##
InstallMethod( \*,
        "for homalg chain maps",
        [ IsHomalgChainMap, IsHomalgRing ],
        
  function( cm, R )
    
    return R * cm;
    
end );

