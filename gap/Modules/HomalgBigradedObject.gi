#############################################################################
##
##  HomalgBigradedObject.gi     Modules package              Mohamed Barakat
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##
##  Implementations for homalg bigraded objects.
##
#############################################################################

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
InstallMethod( PositionOfTheDefaultSetOfRelations,	## provided to avoid branching in the code and always returns fail
        "for homalg bigraded objects",
        [ IsHomalgBigradedObject ],
        
  function( Er )
    
    return fail;
    
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

