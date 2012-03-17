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
                       IsCone and IsExternalFanRep,
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
        NewFamily( "TheFamilyOfCones" , IsCone ) );

BindGlobal( "TheTypeExternalCone",
        NewType( TheFamilyOfCones,
                 IsCone and IsExternalConeRep ) );

BindGlobal( "TheTypePolymakeCone",
        NewType( TheFamilyOfCones,
                 IsPolymakeConeRep ) );

#####################################
##
## Property Computation
##
#####################################

##
InstallImmediateMethod( IsComplete,
                        IsCone and IsPointed,
                        0,
                        
  function( i )
    
    return false;
    
end );

##
InstallMethod( IsComplete,
               " for cones",
               [ IsCone ],
               
  function( cone )
    
    if IsPointed( cone ) then
        
        return false;
        
    fi;
    
    TryNextMethod();
    
end );

##
InstallMethod( IsPointed,
               "for homalg cones.",
               [ IsExternalConeRep ],
               
  function( cone )
    
    return EXT_IS_POINTED_CONE( ExternalObject( cone ) );
    
end );

##
InstallMethod( IsSmooth,
               "for external cones",
               [ IsExternalConeRep ],
               
  function( cone )
    
    return EXT_IS_SMOOTH_CONE( ExternalObject( cone ) );
    
end );

##
InstallMethod( IsRegularCone,
               "for homalg cones.",
               [ IsCone ],
  function( cone )
    
    return IsSmooth( cone );
    
end );

##
InstallMethod( IsSimplicial,
               "for homalg cones.",
               [ IsExternalConeRep ],
  function( cone )
    
    return EXT_IS_SIMPLICIAL_CONE( ExternalObject( cone ) );
    
end );

##
InstallMethod( IsFullDimensional,
               "for homalg cones.",
               [ IsExternalConeRep ],
  function( cone )
    
    return EXT_IS_FULL_DIMENSIONAL_CONE( ExternalObject( cone ) );
    
end );

##
InstallTrueMethod( HasConvexSupport, IsCone );

#####################################
##
## Attribute Computation
##
#####################################

##
InstallMethod( ExternalObject,
               "for raylists",
               [ IsExternalConeRep ],
               
  function( cone )
    
    if not IsBound( cone!.input_rays ) then
        
        Error( "no rays set\n" );
        
    fi;
    
    return EXT_CREATE_CONE_BY_RAYS( cone!.input_rays );
    
end );

##
InstallMethod( RayGenerators,
               "for external Cone",
               [ IsExternalConeRep ],
               
  function( cone )
    
    return EXT_GENERATING_RAYS_OF_CONE( ExternalObject( cone ) );
    
end );

##
InstallMethod( Rays,
               " for homalg cones",
               [ IsCone ],
               
  function( cone )
    local rays;
    
    rays := RayGenerators( cone );
    
    rays := List( rays, Cone );
    
    List( rays, i -> SetContainingGrid( i, ContainingGrid( cone ) ) );
    
    return rays;
    
end );

##
InstallMethod( RaysInMaximalCones,
               " for homalg cones",
               [ IsCone ],
               10,
               
  function( cone )
    local rays;
    
    rays := RayGenerators( cone );
    
    return [ List( rays, i -> 1 ) ];
    
end );

##
InstallMethod( MaximalCones,
               " for homalg cones",
               [ IsCone ],
               
  function( cone )
    
    return [ cone ];
    
end );

##
InstallMethod( DualCone,
               "for external cones",
               [ IsExternalConeRep ],
               
  function( cone )
    local dual;
    
    dual := EXT_CREATE_DUAL_CONE_OF_CONE( ExternalObject( cone ) );
    
    dual := Cone( dual );
    
    SetDualCone( dual, cone );
    
    SetContainingGrid( dual, ContainingGrid( cone ) );
    
    return dual;
    
end );

##
InstallMethod( AmbientSpaceDimension,
               "for external cones",
               [ IsExternalConeRep ],
               
  function( cone )
    
    return EXT_AMBIENT_DIM_OF_CONE( ExternalObject( cone ) );
    
end );

##
InstallMethod( Dimension,
               "for external cones",
               [ IsExternalConeRep ],
               
  function( cone )
    
    return EXT_DIM_OF_CONE( ExternalObject( cone ) );
    
end );

##
InstallMethod( HilbertBasis,
               "for external cones",
               [ IsExternalConeRep ],
               
  function( cone )
    
    return EXT_HILBERT_BASIS_OF_CONE( ExternalObject( cone ) );
    
end );

##
InstallMethod( RaysInFacets,
               " for external cones",
               [ IsExternalConeRep ],
               
  function( cone )
    
    return EXT_RAYS_IN_FACETS( ExternalObject( cone ) );
    
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
    
    return List( conelist, Cone );
    
end );

##
InstallMethod( GridGeneratedByCone,
               " for homalg cones.",
               [ IsCone ],
               
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
               [ IsCone ],
               
  function( cone )
    local rays, M;
    
    rays := RayGenerators( cone );
    
    M := HomalgMatrix( rays, HOMALG_MATRICES.ZZ );
    
    M := Involution( M );
    
    M := HomalgMap( M, ContainingGrid( cone ), "free" );
    
    return KernelSubobject( M );
    
end );

##
InstallMethod( FactorGrid,
               " for homalg cones.",
               [ IsCone ],
               
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
               [ IsCone ],
               
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
    
    return EXT_DEFINING_INEQUALITIES_OF_CONE( ExternalObject( cone ) );
    
end );

##
InstallMethod( IsRay,
               "for cones.",
               [ IsCone ],
               
  function( cone )
    
    return Dimension( cone ) = 1;
    
end );

####################################
##
## Methods
##
####################################

InstallMethod( \*,
               " cartesian product for cones.",
               [ IsCone, IsCone ],
               
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
    
    raysnew := Cone( raysnew );
    
    SetContainingGrid( raysnew, ContainingGrid( cone1 ) + ContainingGrid( cone2 ) );
    
    return raysnew;
    
end );

##
InstallMethod( IntersectionOfCones,
               "for homalg cones",
               [ IsCone, IsCone ],
               
  function( cone1, cone2 )
    local rays1, rays2, cone;
    
    if not IsIdenticalObj( ContainingGrid( cone1 ), ContainingGrid( cone2 ) ) then
        
        Error( "cones are not from the same grid" );
        
    fi;
    
    rays1 := RayGenerators( cone1 );
    
    rays2 := RayGenerators( cone2 );
    
    cone := Cone( Intersection( rays1, rays2 ) );
    
    SetContainingGrid( cone, ContainingGrid( cone1 ) );
    
    return cone;
    
end );

##
InstallMethod( Intersect2,
               "for convex cones",
               [ IsCone, IsCone ],
               
  IntersectionOfCones
  
);

##
InstallMethod( Contains,
               " for homalg cones",
               [ IsCone, IsCone ],
               
  function( ambcone, cone )
    local ineq;
    
    ineq := DefiningInequalities( ambcone );
    
    cone := RayGenerators( cone );
    
    ineq := List( cone, i -> ineq * i );
    
    ineq := Flat( ineq );
    
    return ForAll( ineq, i -> i >= 0 );
    
end );

##
InstallMethod( RayGeneratorContainedInCone,
               "for cones",
               [ IsList, IsCone ],
               
  function( raygen, cone )
    local ineq;
    
    ineq := DefiningInequalities( cone );
    
    ineq := List( ineq, i -> i * raygen );
    
    return ForAll( ineq, i -> i >= 0 );
    
end );

##
InstallMethod( StarFan,
               " for homalg cones in fans",
               [ IsCone and HasIsContainedInFan ],
               
  function( cone )
    
    return StarFan( cone, IsContainedInFan( cone ) );
    
end );

##
InstallMethod( StarFan,
               " for homalg cones",
               [ IsCone, IsFan ],
               
  function( cone, fan )
    local maxcones;
    
    maxcones := MaximalCones( fan );
    
    maxcones := Filtered( maxcones, i -> Contains( i, cone ) );
    
    maxcones := List( maxcones, HilbertBasis );
    
    ## FIXME: THIS IS BAD CODE! REPAIR IT!
    maxcones := List( maxcones, i -> List( i, j -> HomalgMap( HomalgMatrix( [ j ], HOMALG_MATRICES.ZZ ), 1 * HOMALG_MATRICES.ZZ, ContainingGrid( cone ) ) ) );
    
    maxcones := List( maxcones, i -> List( i, j -> UnderlyingListOfRingElementsInCurrentPresentation( ApplyMorphismToElement( ByASmallerPresentation( FactorGridMorphism( cone ) ), HomalgElement( j ) ) ) ) );
    
    maxcones := Fan( maxcones );
    
    return maxcones;
    
end );

##
InstallMethod( StarSubdivisionOfIthMaximalCone,
               " for homalg cones and fans",
               [ IsFan, IsInt ],
               
  function( fan, noofcone )
    local maxcones, cone, ray, cone2;
    
    maxcones := MaximalCones( fan );
    
    maxcones := List( maxcones, RayGenerators );
    
    if Length( maxcones ) < noofcone then
        
        Error( " not enough maximal cones" );
        
    fi;
    
    cone := maxcones[ noofcone ];
    
    ray := Sum( cone );
    
    cone2 := Concatenation( cone, [ ray ] );
    
    cone2 := UnorderedTuples( cone2, Length( cone2 ) - 1 );
    
    Apply( cone2, Set );
    
    Apply( maxcones, Set );
    
    maxcones := Concatenation( maxcones, cone2 );
    
    maxcones := Difference( maxcones, [ Set( cone ) ] );
    
    maxcones := Fan( maxcones );
    
    SetContainingGrid( maxcones, ContainingGrid( fan ) );
    
    return maxcones;
    
end );

###################################
##
## Constructors
##
###################################

##
InstallMethod( Cone,
               "constructor for Cones by List",
               [ IsList ],
               
  function( raylist )
    local cone, newgens, i, vals;
    
    if Length( raylist ) = 0 then
        
        Error( "a cone must contain the zero point" );
        
    fi;
    
    newgens := [ ];
    
    for i in raylist do
        
        if IsList( i ) then
            
            Add( newgens, i );
            
        elif IsCone( i ) then
            
            Append( newgens, RayGenerators( i ) );
            
        else
            
            Error( " wrong rays" );
            
        fi;
        
    od;
    
    cone := rec( input_rays := newgens );
    
    ObjectifyWithAttributes( 
        cone, TheTypePolymakeCone
     );
    
        
    newgens := Set( newgens );
    
    SetAmbientSpaceDimension( cone, Length( newgens[ 1 ] ) );
    
    if Length( newgens ) = 1 and not Set( newgens[ 1 ] ) = [ 0 ] then
        
        SetIsRay( cone, true );
        
    else
        
        SetIsRay( cone, false );
        
    fi;
    
    return cone;
    
end );

##
InstallMethod( Cone,
               "constructor for given Pointers",
               [ IsExternalPolymakeCone ],
               
  function( conepointer )
    local cone;
    
    cone := rec( );
    
    ObjectifyWithAttributes(
      cone, TheTypePolymakeCone,
      ExternalObject, conepointer
    );
    
    return cone;
    
end );

##
InstallMethod( Fan,
               " for homalg cones",
               [ IsList ],
               
  function( cones )
    local newgens, i, point, extobj;
    
    if Length( cones ) = 0 then
        
        Error( " no empty fans allowed." );
        
    fi;
    
    newgens := [ ];
    
    for i in cones do
        
        if IsCone( i ) then
            
            if IsBound( i!.input_rays ) then
                
                Add( newgens, i!.input_rays );
                
            else
                
                Add( newgens, RayGenerators( i ) );
                
            fi;
            
        elif IsList( i ) then
            
            Add( newgens, i );
            
        else
            
            Error( " wrong cones inserted" );
            
        fi;
        
    od;
    
    
    point := rec( input_cone_list := newgens );
    
    ObjectifyWithAttributes(
        point, TheTypePolymakeFan,
        );
    
    return point;
    
end );

################################
##
## Displays and Views
##
################################

##
InstallMethod( ViewObj,
               "for homalg cones",
               [ IsCone ],
               
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
    
    if HasIsRay( cone ) and IsRay( cone ) then
        
        Print( " ray" );
        
    else
        
        Print( " cone" );
        
    fi;
    
    Print( " in |R^" );
    
    Print( String( AmbientSpaceDimension( cone ) ) );
    
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
               [ IsCone ],
               
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
    
    if IsRay( cone ) then
        
        Print( " ray" );
        
    else
        
        Print( " cone" );
        
    fi;
    
    Print( " in |R^" );
    
    Print( String( AmbientSpaceDimension( cone ) ) );
    
    if HasDimension( cone ) then
        
        Print( " of dimension ", String( Dimension( cone ) ) );
        
    fi;
    
    if HasRayGenerators( cone ) then
        
        Print( " with ray generators ", String( RayGenerators( cone ) ) );
        
    fi;
    
    Print( ".\n" );
    
end );