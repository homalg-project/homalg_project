#############################################################################
##
##  HomalgFiltration.gi         Modules package              Mohamed Barakat
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##
##  Implementation stuff for a filtration.
##
#############################################################################

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( MatrixOfFiltration,
        "for filtrations of homalg modules",
        [ IsFiltrationOfFinitelyPresentedObjectRep, IsInt ],
        
  function( filt, p_min )
    local stack;
    
    stack := List( Filtered( DegreesOfFiltration( filt ), p -> p >= p_min ) , d -> CertainMorphism( filt, d ) );
    
    stack := Iterated( stack, CoproductMorphism );
    
    return MatrixOfMap( stack );
    
end );

##
InstallMethod( MatrixOfFiltration,
        "for filtrations of homalg modules",
        [ IsFiltrationOfFinitelyPresentedObjectRep ],
        
  function( filt )
    
    return MatrixOfFiltration( filt, LowestDegree( filt ) );
    
end );

##
InstallMethod( BasisOfModule,
        "for homalg filtrations",
        [ IsHomalgFiltration ],
        
  function( filt )
    
    List( ObjectsOfFiltration( filt ), BasisOfModule );
    
    BasisOfModule( UnderlyingObject( filt ) );
    
    return filt;
    
end );

##
InstallMethod( DecideZero,
        "for homalg filtrations",
        [ IsHomalgFiltration ],
        
  function( filt )
    
    List( MorphismsOfFiltration( filt ), DecideZero );
    
    return filt;
    
end );

##
InstallMethod( OnLessGenerators,
        "for homalg filtrations",
        [ IsHomalgFiltration ],
        
  function( filt )
    
    List( ObjectsOfFiltration( filt ), OnLessGenerators );
    
    OnLessGenerators( UnderlyingObject( filt ) );
    
    return filt;
    
end );

##
InstallMethod( ByASmallerPresentation,
        "for homalg filtrations",
        [ IsHomalgFiltration ],
        
  function( filt )
    
    List( ObjectsOfFiltration( filt ), ByASmallerPresentation );
    
    ByASmallerPresentation( UnderlyingObject( filt ) );
    
    DecideZero( filt );
    
    return filt;
    
end );

