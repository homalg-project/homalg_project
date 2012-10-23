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

DeclareRepresentation( "IsInternalConeRep",
                       IsCone and IsInternalFanRep,
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

BindGlobal( "TheTypeInternalCone",
        NewType( TheFamilyOfCones,
                 IsInternalConeRep ) );

#####################################
##
## Property Computation
##
#####################################

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
InstallMethod( IsSmooth,
               "for internal cones",
               [ IsCone ],
               
  function( cone )
    local rays, smith;
    
    rays := RayGenerators( cone );
    
    if RankMat( rays ) <> Length( rays ) then
        
        return false;
        
    fi;
    
    smith := SmithNormalFormIntegerMat(rays);
    
    smith := List( Flat( smith ), i -> AbsInt( i ) );
    
    if Maximum( smith ) <> 1 then
        
        return false;
        
    fi;
    
    return true;
    
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
InstallMethod( IsSimplicial,
               "for cones.",
               [ IsCone ],
  function( cone )
    local rays;
    
    rays := RayGenerators( cone );
    
    return Length( rays ) = RankMat( rays );
    
end );

##
InstallMethod( IsFullDimensional,
               "for homalg cones.",
               [ IsExternalConeRep ],
  function( cone )
    
    return EXT_IS_FULL_DIMENSIONAL_CONE( ExternalObject( cone ) );
    
end );

##
InstallMethod( IsFullDimensional,
               "for homalg cones.",
               [ IsCone ],
  function( cone )
    
    return RankMat( RayGenerators( cone ) ) = AmbientSpaceDimension( cone );
    
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
    
    if IsBound( cone!.input_rays ) then
        
        return EXT_CREATE_CONE_BY_RAYS( cone!.input_rays );
        
    elif IsBound( cone!.input_equalities ) and IsBound( cone!.input_inequalities ) then
        
        return EXT_CREATE_CONE_BY_EQUALITIES_AND_INEQUALITIES( cone!.input_equalities, cone!.input_inequalities );
        
    elif IsBound( cone!.input_inequalities ) then
        
        return EXT_CREATE_CONE_BY_INEQUALITIES( cone!.input_inequalities );
        
    else
        
        Error( "no rays or inequalities set\n" );
        
    fi;
    
end );

##
InstallMethod( RayGenerators,
               "for Cone",
               [ IsCone ],
               
  function( cone )
    
    return cone!.input_rays;
    
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
               1,
               
  function( cone )
    local rays;
    
    rays := RayGenerators( cone );
    
    rays := List( rays, i -> Cone( [ i ] ) );
    
    List( rays, function( i )
                    SetContainingGrid( i, ContainingGrid( cone ) );
                    return 0;
                 end );
    
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
               "for cones",
               [ IsCone ],
               
  function( cone )
    
    return Length( RayGenerators( cone )[ 1 ] );
    
end );

##
InstallMethod( AmbientSpaceDimension,
               "for external cones",
               [ IsExternalConeRep ],
               
  function( cone )
    
    return EXT_AMBIENT_DIM_OF_CONE( ExternalObject( cone ) );
    
end );

InstallMethod( Dimension,
               "for cones",
               [ IsCone ],
               
  function( cone )
    
    return RankMat( RayGenerators( cone ) );
    
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
    
    if not IsPointed( cone ) then
        
        Error( "not yet implemented" );
        
    fi;
    
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

##
InstallMethod( LinearSubspaceGenerators,
               "for external cones",
               [ IsExternalConeRep ],
               
  function( cone )
    
    return EXT_LINEAR_SUBSPACE( ExternalObject( cone ) );
    
end );

##
InstallMethod( APointedFactor,
               "for cones",
               [ IsCone ],
               
  function( cone )
    local ray_generators, grid, subgrid, factor_grid, 
          factor_grid_morphism, lin_space, new_cone;
    
    if IsPointed( cone ) then
        
        return cone;
        
    fi;
    
    ray_generators := RayGenerators( cone );
    
    grid := ContainingGrid( cone );
    
    ray_generators := List( ray_generators, i -> HomalgModuleElement( i, grid ) );
    
    lin_space := LinearSubspaceGenerators( cone );
    
    subgrid := HomalgMatrix( lin_space, HOMALG_MATRICES.ZZ );
    
    subgrid := HomalgMap( subgrid, "free", grid );
    
    factor_grid := Cokernel( subgrid );
    
    ByASmallerPresentation( factor_grid );
    
    factor_grid_morphism := CokernelEpi( subgrid );
    
    ray_generators := List( ray_generators, i -> ApplyMorphismToElement( factor_grid_morphism, i ) );
    
    ray_generators := List( ray_generators, UnderlyingListOfRingElementsInCurrentPresentation );
    
    new_cone := Cone( ray_generators );
    
    SetContainingGrid( new_cone, factor_grid );
    
    SetFactorConeEmbedding( new_cone, factor_grid_morphism );
    
    return new_cone;
    
end );

##
InstallMethod( FactorConeEmbedding,
               "for cones",
               [ IsCone ],
               
  function( cone )
    
    return TheIdentityMorphism( ContainingGrid( cone ) );
    
end );

##
InstallMethod( EqualitiesOfCone,
               "for external Cone",
               [ IsExternalConeRep ],
               
  function( cone )
    
    return EXT_EQUALITIES_OF_CONE( ExternalObject( cone ) );
    
end );

##
InstallMethod( RelativeInteriorRayGenerator,
               "for a cone",
               [ IsCone ],
               
  function( cone )
    local rays, rand_mat;
    
    rays := RayGenerators( cone );
    
    rand_mat := RandomMat( Length( rays ), 1 );
    
    rand_mat := Concatenation( rand_mat );
    
    rand_mat := List( rand_mat, i -> AbsInt( i ) + 1 );
    
    return Sum( [ 1 .. Length( rays ) ], i -> rays[ i ] + rand_mat[ i ] );
    
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
    
    rays1 := HilbertBasis( cone1 );
    
    rays2 := HilbertBasis( cone2 );
    
    cone := Intersection( rays1, rays2 );
    
    if cone = [] then
        
        if Length( rays1 ) > 0 then
            
            cone := [ List( [ 1 .. Length( rays1[ 1 ] ) ], i -> 0 ) ];
            
        elif Length( rays2 ) > 0 then
            
            cone := [ List( [ 1 .. Length( rays2[ 1 ] ) ], i -> 0 ) ];
            
        else
            
            Error( "no dimension given\n" );
            
        fi;
        
    fi;
    
    cone := Cone( Intersection( rays1, rays2 ) );
    
    SetContainingGrid( cone, ContainingGrid( cone1 ) );
    
    return cone;
    
end );

##
InstallMethod( IntersectionOfCones,
               "for homalg cones",
               [ IsExternalConeRep, IsExternalConeRep ],
               
  function( cone1, cone2 )
    local cone, ext_cone;
    
    if not IsIdenticalObj( ContainingGrid( cone1 ), ContainingGrid( cone2 ) ) then
        
        Error( "cones are not from the same grid" );
        
    fi;
    
    ext_cone := EXT_INTERSECTION_OF_CONES( ExternalObject( cone1 ), ExternalObject( cone2 ) );
    
    cone := Cone( ext_cone );
    
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
InstallMethod( ContainedInRelativeInterior,
               "for cones",
               [ IsList, IsCone ],
               
  function( raygen, cone )
    local ineq;
    
    ineq := DefiningInequalities( cone );
    
    ineq := List( ineq, i -> i * raygen );
    
    return ForAll( ineq, i -> i > 0 );
    
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

##
InstallMethod( StellarSubdivision,
               "for a ray and a cone",
               [ IsExternalConeRep and IsRay, IsExternalFanRep ],
               
  function( ray, fan )
    
    return EXT_STELLAR_SUBDIVISION( ExternalObject( ray ), ExternalObject( fan ) );
    
end );

##
InstallMethod( \*,
               "for a matrix and a cone",
               [ IsHomalgMatrix, IsCone ],
               
  function( matrix, cone )
    local ray_list, multiplied_rays, ring, new_cone;
    
    ring := HomalgRing( matrix );
    
    ray_list := RayGenerators( cone );
    
    ray_list := List( ray_list, i -> HomalgMatrix( i, ring ) );
    
    multiplied_rays := List( ray_list, i -> matrix * i );
    
    multiplied_rays := List( multiplied_rays, i -> EntriesOfHomalgMatrix( i ) );
    
    new_cone := Cone( multiplied_rays );
    
    SetContainingGrid( new_cone, ContainingGrid( cone ) );
    
    return new_cone;
    
end );

##
InstallMethod( \=,
               "for two cones",
               [ IsCone, IsCone ],
               
  function( cone1, cone2 )
    
    return Contains( cone1, cone2 ) and Contains( cone2, cone1 );
    
end );

##
InstallMethod( DrawObject,
               "for a cone",
               [ IsCone ],
               
  function( cone )
    
    return DrawObject( Fan( [ cone ] ) );
    
end );

###################################
##
## Constructors
##
###################################

##
InstallMethod( ConeByInequalities,
               "constructor for Cones by inequalities",
               [ IsList ],
               
  function( raylist )
    local cone, newgens, i, vals;
    
    if Length( raylist ) = 0 then
        
        Error( "someone must set a dimension\n" );
        
    fi;
    
    cone := rec( input_inequalities := raylist );
    
    ObjectifyWithAttributes( 
        cone, TheTypePolymakeCone
     );
    
    SetAmbientSpaceDimension( cone, Length( raylist[ 1 ] ) );
    
    return cone;
    
end );

##
InstallMethod( ConeByEqualitiesAndInequalities,
               "constructor for cones by equalities and inequalities",
               [ IsList, IsList ],
               
  function( equalities, inequalities )
    local cone, newgens, i, vals;
    
    if Length( equalities ) = 0 and Length( inequalities ) = 0 then
        
        Error( "someone must set a dimension\n" );
        
    fi;
    
    cone := rec( input_inequalities := inequalities, input_equalities := equalities );
    
    ObjectifyWithAttributes( 
        cone, TheTypePolymakeCone
     );
    
    if Length( equalities ) > 0 then
        
        SetAmbientSpaceDimension( cone, Length( equalities[ 1 ] ) );
        
    else
        
        SetAmbientSpaceDimension( cone, Length( inequalities[ 1 ] ) );
        
    fi;
    
    return cone;
    
end );

##
InstallMethod( PolymakeCone,
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
InstallMethod( InternalCone,
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
        cone, TheTypeInternalCone,
        IsPointed, true
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

if IsPackageMarkedForLoading( "PolymakeInterface", "2012.03.01" ) = true then
    
    ##
    InstallMethod( Cone,
                  "a switch",
                  [ IsList ],
                  
      PolymakeCone

    );
    
else
    
    ##
    InstallMethod( Cone,
                  "a switch",
                  [ IsList ],
                  
      InternalCone

    );
    
fi;

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
InstallMethod( PolymakeFan,
               " for homalg cones",
               [ IsList ],
               
  function( cones )
    local newgens, i, point, extobj, type;
    
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
        point, TheTypePolymakeFan
        );
    
    return point;
    
end );

##
InstallMethod( InternalFan,
               " for cones",
               [ IsList ],
               
  function( cones )
    local newgens, i, point, extobj, type;
    
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
        point, TheTypeInternalFan
        );
    
    SetAmbientSpaceDimension( point, Length( newgens[ 1 ][ 1 ] ) );
    
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