#############################################################################
##
##  Cone.gi         ConvexForHomalg package         Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Cones for ConvexForHomalg.
##
#############################################################################

####################################
##
## Reps
##
####################################

DeclareRepresentation( "IsExternalConeRep",
                       IsHomalgCone and IsExternalConvexObjectRep,
                       [ ]
                      );

DeclareRepresentation( "IsPolymakeConeRep",
                       IsExternalConeRep,
                       [ ]
                      );

####################################
##
## Types and Families
##
####################################


BindGlobal( "TheFamilyOfCones",
        NewFamily( "TheFamilyOfCones" , IsHomalgCone ) );

BindGlobal( "TheTypeExternalCone",
        NewType( TheFamilyOfCones,
                 IsHomalgCone and IsExternalConeRep ) );

BindGlobal( "TheTypePolymakeCone",
        NewType( TheFamilyOfCones,
                 IsPolymakeConeRep ) );

#####################################
##
## Property Computation
##
#####################################

##
InstallMethod( IsPointed,
               "for homalg cones.",
               [ IsExternalConeRep ],
               
  function( cone )
    
    return EXT_IS_POINTED_CONE(  cone  );
    
end );

##
InstallMethod( IsSmooth,
               "for external cones",
               [ IsExternalConeRep ],
               
  function( cone )
    
    return EXT_IS_SMOOTH_CONE( cone );
    
end );

##
InstallMethod( IsRegular,
               "for homalg cones.",
               [ IsHomalgCone ],
  function( cone )
    
    return IsSmooth( cone );
    
end );

##
InstallMethod( IsSimplicial,
               "for homalg cones.",
               [ IsExternalConeRep ],
  function( cone )
    
    return EXT_IS_SIMPLICIAL_CONE( cone );
    
end );

##
InstallMethod( IsFullDimensional,
               "for homalg cones.",
               [ IsExternalConeRep ],
  function( cone )
    
    return EXT_IS_FULL_DIMENSIONAL_CONE( cone );
    
end );

#####################################
##
## Attribute Computation
##
#####################################

##
InstallMethod( RayGenerators,
               "for external Cone",
               [ IsExternalConeRep ],
               
  function( cone )
    
    return EXT_GENERATING_RAYS_OF_CONE( cone );
    
end );

##
InstallMethod( DualCone,
               "for external cones",
               [ IsExternalConeRep ],
               
  function( cone )
    local dual;
    
    dual := EXT_CREATE_DUAL_CONE_OF_CONE( cone );
    
    dual := HomalgCone( dual );
    
    SetDualCone( dual, cone );
    
    SetContainingGrid( dual, ContainingGrid( cone ) );
    
    return dual;
    
end );

##
InstallMethod( AmbientSpaceDimension,
               "for external cones",
               [ IsExternalConeRep ],
               
  function( cone )
    
    return EXT_AMBIENT_DIM_OF_CONE( cone );
    
end );

##
InstallMethod( Dimension,
               "for external cones",
               [ IsExternalConeRep ],
               
  function( cone )
    
    return EXT_DIM_OF_CONE( cone );
    
end );

##
InstallMethod( HilbertBasis,
               "for external cones",
               [ IsExternalConeRep ],
               
  function( cone )
    
    return EXT_HILBERT_BASIS_OF_CONE( cone );
    
end );

##
InstallMethod( RaysInFacets,
               " for external cones",
               [ IsExternalConeRep ],
               
  function( cone )
    
    return EXT_RAYS_IN_FACETS( cone );
    
end );

##
InstallMethod( Facets,
               " for external cones",
               [ IsExternalConeRep ],
               
  function( cone )
    local raylist, rays, conelist, i, lis, j;
    
    raylist := RaysInFacets( cone );
    
    rays := RayGenerators( cone );
    
    conelist := [ ];
    
    for i in [ 1..Length( raylist ) ] do
        
        lis := [ ];
        
        for j in [ 1 .. Length( raylist[ i ] ) ] do
            
            if raylist[ i ][ j ] = 1 then
                
                lis := Concatenation( lis, [ rays[ j ] ] );
                
            fi;
            
        od;
        
        conelist := Concatenation( conelist, [ lis ] );
        
    od;
    
    return List( conelist, HomalgCone );
    
end );

##
InstallMethod( GridGeneratedByCone,
               " for homalg cones.",
               [ IsHomalgCone ],
               
  function( cone )
    local rays, M, grid;
    
    rays := RayGenerators( cone );
    
    M := HomalgMatrix( rays, HOMALG_MATRICES.ZZ );
    
    M := HomalgMap( M, "free", ContainingGrid( cone ) );
    
    grid := ImageSubobject( M );
    
    SetFactorGrid( cone, FactorObject( grid ) );
    
    SetFactorGridMorphism( cone, CokernelEpi( M ) );
    
    return grid;
    
end );

##
InstallMethod( GridGeneratedByOrthogonalCone,
               " for homalg cones.",
               [ IsHomalgCone ],
               
  function( cone )
    local rays, M;
    
    rays := RayGenerators( cone );
    
    M := HomalgMatrix( rays, HOMALG_MATRICES.ZZ );
    
    M := Involution( M );
    
    M := HomalgMap( M, ContainingGrid( cone ), "free" );
    
    return Kernel( M );
    
end );

##
InstallMethod( FactorGrid,
               " for homalg cones.",
               [ IsHomalgCone ],
               
  function( cone )
    local rays, M, grid;
    
    rays := RayGenerators( cone );
    
    M := HomalgMatrix( rays, HOMALG_MATRICES.ZZ );
    
    M := HomalgMap( M, "free", ContainingGrid( cone ) );
    
    grid := ImageSubobject( M );
    
    SetGridGeneratedByCone( cone, grid );
    
    SetFactorGridMorphism( cone, CokernelEpi( M ) );
    
    return FactorObject( grid );
    
end );

##
InstallMethod( FactorGridMorphism,
               " for homalg cones.",
               [ IsHomalgCone ],
               
  function( cone )
    local rays, grid, M;
    
    rays := RayGenerators( cone );
    
    M := HomalgMatrix( rays, HOMALG_MATRICES.ZZ );
    
    M := HomalgMap( M, "free", ContainingGrid( cone ) );
    
    grid := ImageSubobject( M );
    
    SetGridGeneratedByCone( cone, grid );
    
    SetFactorGrid( cone, FactorObject( grid ) );
    
    return CokernelEpi( M );
    
end );

##
InstallMethod( DefiningInequalities,
               " for homalg cones.",
               [ IsExternalConeRep ],
               
  function( cone )
    
    return EXT_DEFINING_INEQUALITIES_OF_CONE( cone );
    
end );

####################################
##
## Methods
##
####################################

InstallMethod( Rays,
               " for homalg cones.",
               [ IsHomalgCone ],
               
  function( cone )
    
    return List( RayGenerators( cone ), HomalgCone );
    
end );

InstallMethod( \*,
               " cartesian product for cones.",
               [ IsHomalgCone, IsHomalgCone ],
               
  function( cone1, cone2 )
    local rays1, rays2, i, j, raysnew;
    
    rays1 := RayGenerators( cone1 );
    
    rays2 := RayGenerators( cone2 );
    
    rays1 := Concatenation( rays1, [ List( [ 1 .. Length( rays1[ 1 ] ) ], i -> 0 ) ] );
    
    rays2 := Concatenation( rays2, [ List( [ 1 .. Length( rays2[ 1 ] ) ], i -> 0 ) ] );
    
    raysnew := [ 1 .. Length( rays1 ) * Length( rays2 ) ];
    
    for i in [ 1 .. Length( rays1 ) ] do
        
        for j in [ 1 .. Length( rays2 ) ] do
            
            raysnew[ (i-1)*Length( rays2 ) + j ] := Concatenation( rays1[ i ], rays2[ j ] );
            
        od;
        
    od;
    
    raysnew := HomalgCone( raysnew );
    
    SetContainingGrid( raysnew, ContainingGrid( cone1 ) + ContainingGrid( cone2 ) );
    
    return raysnew;
    
end );

##
InstallMethod( IntersectionOfCones,
               "for homalg cones",
               [ IsHomalgCone, IsHomalgCone ],
               
  function( cone1, cone2 )
    local rays1, rays2, cone;
    
    if not IsIdenticalObj( ContainingGrid( cone1 ), ContainingGrid( cone2 ) ) then
        
        Error( "cones are not from the same grid" );
        
    fi;
    
    rays1 := RayGenerators( cone1 );
    
    rays2 := RayGenerators( cone2 );
    
    cone := HomalgCone( Intersection( rays1, rays2 ) );
    
    SetContainingGrid( cone, ContainingGrid( cone1 ) );
    
    return cone;
    
end );

###################################
##
## Constructors
##
###################################

##
InstallMethod( HomalgCone,
               "constructor for Cones by List",
               [ IsList ],
               
  function( raylist )
    local cone, vals;
    
    if Length( raylist ) = 0 then
        
        Error( "a cone must contain the zero point" );
        
    fi;
    
    vals := EXT_CREATE_CONE_BY_RAYS( raylist );
    
    cone := rec( WeakPointerToExternalObject := vals );
    
    ObjectifyWithAttributes( 
        cone, TheTypePolymakeCone
     );
    
    return cone;
    
end );

##
InstallMethod( HomalgCone,
               "constructor for given Pointers",
               [ IsInt ],
               
  function( conepointer )
    local cone;
    
    cone := rec( WeakPointerToExternalObject := conepointer );
    
    ObjectifyWithAttributes(
      cone, TheTypePolymakeCone
    );
    
    return cone;
    
end );


################################
##
## Displays and Views
##
################################

##
InstallMethod( ViewObj,
               "for homalg cones",
               [ IsHomalgCone ],
               
  function( cone )
    local str;
    
    Print( "<A" );
    
    if HasIsSmooth( cone ) then
        
        if IsSmooth( cone ) then
            
            Print( " smooth" );
            
        fi;
        
    fi;
    
    if HasIsPointed( cone ) then
        
        if IsPointed( cone ) then
            
            Print( " pointed" );
            
        fi;
        
    fi;
    
    if HasIsSimplicial( cone ) then
        
        if IsSimplicial( cone ) then
            
            Print( " simplicial" );
            
        fi;
        
    fi;
    
    Print( " cone" );
    
    if HasDimension( cone ) then
        
        Print( " of dimension ", String( Dimension( cone ) ) );
        
    fi;
    
    if HasRayGenerators( cone ) then
        
        Print( " with ", String( Length( RayGenerators( cone ) ) )," ray generators" );
        
    fi;
    
    Print( ">" );
    
end );

##
InstallMethod( Display,
               "for homalg cones",
               [ IsHomalgCone ],
               
  function( cone )
    local str;
    
    Print( "A" );
    
    if HasIsSmooth( cone ) then
        
        if IsSmooth( cone ) then
            
            Print( " smooth" );
            
        fi;
        
    fi;
    
    if HasIsPointed( cone ) then
        
        if IsPointed( cone ) then
            
            Print( " pointed" );
            
        fi;
        
    fi;
    
    Print( " cone" );
    
    if HasDimension( cone ) then
        
        Print( " of dimension ", String( Dimension( cone ) ) );
        
    fi;
    
    if HasRayGenerators( cone ) then
        
        Print( " with ray generators ", String( RayGenerators( cone ) ) );
        
    fi;
    
    Print( ".\n" );
    
end );