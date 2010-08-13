#############################################################################
##
##  HomalgComplex.gi            Modules package              Mohamed Barakat
##
##  Copyright 2007-2010, Mohamed Barakat, University of Kaiserslautern
##
##  Implementation stuff for homalg complexes.
##
#############################################################################

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( HomalgRing,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    
    return HomalgRing( LowestDegreeObject( C ) );
    
end );

##
InstallMethod( Add,
        "for homalg complexes",
        [ IsComplexOfFinitelyPresentedObjectsRep, IsHomalgMatrix ],
        
  function( C, mat )
    local T;
    
    T := HighestDegreeObject( C );
    
    Add( C, HomalgMap( mat, "free", T ) );
    
end );

##
InstallMethod( Add,
        "for homalg complexes",
        [ IsCocomplexOfFinitelyPresentedObjectsRep, IsHomalgMatrix ],
        
  function( C, mat )
    local S;
    
    S := HighestDegreeObject( C );
    
    Add( C, HomalgMap( mat, S, "free" ) );
    
end );

##
InstallMethod( BasisOfModule,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    
    List( ObjectsOfComplex( C ), BasisOfModule );
    
    return C;
    
end );

##
InstallMethod( OnLessGenerators,
        "for homalg complexes",
        [ IsHomalgComplex ],
        
  function( C )
    
    List( ObjectsOfComplex( C ), OnLessGenerators );
    
    return C;
    
end );

##
InstallMethod( SetAsStandardResolution,
        "for a homalg module and a homalg complex",
        [ IsHomalgModule, IsHomalgComplex ],
        
  function( M, P )
    local rel;
    
    rel := RelationsOfModule( M );
    
    if HasFreeResolution( rel ) then
        ResetFilterObj( rel, FreeResolution );
    fi;
    
    SetFreeResolution( rel, P );
    
end );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallMethod( \*,
        "for homalg complexes",
        [ IsHomalgRing, IsHomalgComplex ],
        
  function( R, C )
    
    return BaseChange( R, C );
    
end );

##
InstallMethod( \*,
        "for homalg complexes",
        [ IsHomalgComplex, IsHomalgRing ],
        
  function( C, R )
    
    return R * C;
    
end );

