#############################################################################
##
##  Fan.gi         ConvexForHomalg package         Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Fans for ConvexForHomalg.
##
#############################################################################

####################################
##
## Reps
##
####################################

DeclareRepresentation( "IsExternalFanRep",
                       IsFan and IsExternalConvexObjectRep,
                       [ ]
                      );

DeclareRepresentation( "IsPolymakeFanRep",
                       IsExternalFanRep,
                       [ ]
                      );

DeclareRepresentation( "IsInternalFanRep",
                       IsFan and IsInternalConvexObjectRep,
                       [ ]
                      );

####################################
##
## Types and Families
##
####################################


BindGlobal( "TheFamilyOfFans",
        NewFamily( "TheFamilyOfFans" , IsFan ) );

BindGlobal( "TheTypeExternalFan",
        NewType( TheFamilyOfFans,
                 IsFan and IsExternalFanRep ) );

BindGlobal( "TheTypePolymakeFan",
        NewType( TheFamilyOfFans,
                 IsPolymakeFanRep ) );

BindGlobal( "TheTypeInternalFan",
        NewType( TheFamilyOfFans,
                 IsInternalFanRep ) );


####################################
##
## Attributes
##
####################################

##
InstallMethod( ExternalObject,
               "for external fans",
               [ IsExternalFanRep ],
               
  function( fan )
    
    if IsBound( fan!.input_cone_list ) then
        
        return EXT_FAN_BY_CONES( fan!.input_cone_list );
        
    elif IsBound( fan!.input_rays ) and IsBound( fan!.input_cones ) then
        
        return EXT_FAN_BY_RAYS_AND_CONES( fan!.input_rays, fan!.input_cones );
        
    else
        
        Error( "something went wrong\n" );
        
    fi;
    
end );

##
InstallMethod( Rays,
               "for fans.",
               [ IsFan ],
               
  function( fan )
    local rays;
    
    rays := RayGenerators( fan );
    
    rays := List( rays, i -> Cone( [ i ] ) );
    
    List( rays, function( i ) SetContainingGrid( i, ContainingGrid( fan ) ); return 0; end );
    
    return rays;
    
end );

##
InstallMethod( RayGenerators,
               "for external fans.",
               [ IsInternalFanRep ],
               
  function( fan )
    
    if IsBound( fan!.input_rays ) then
        
        return fan!.input_rays;
        
    elif IsBound( fan!.input_cone_list ) then
        
        return List( Set( Union( fan!.input_cone_list ) ) );
        
    else
        
        Error( "Something went wrong." );
        
    fi;
    
end );

##
InstallMethod( RayGenerators,
               "for external fans.",
               [ IsExternalFanRep ],
               
  function( fan )
    
    return EXT_RAYS_OF_FAN( ExternalObject( fan ) );
    
end );

##
InstallMethod( RaysInMaximalCones,
               "for fans",
               [ IsInternalFanRep ],
               
  function( fan )
    local rays, cones, i, j;
    
    if IsBound( fan!.input_cones ) and IsBound( fan!.input_rays ) then
        
        rays := RayGenerators( fan );
        
        cones := List( [ 1 .. Length( fan!.input_cones ) ], i -> List( [ 1 .. Length( rays ) ], j -> 0 ) );
        
        for i in [ 1 .. Length( fan!.input_cones ) ] do
            
            for j in fan!.input_cones[ i ] do
                
                cones[ i ][ j ] := 1;
                
            od;
            
        od;
        
        return cones;
        
    fi;
    
    if IsBound( fan!.input_cone_list ) then
        
        rays := RayGenerators( fan );
        
        ## Dont use ListWithIdenticalEntries here since it has new sideeffects.
        cones := List( [ 1 .. Length( fan!.input_cone_list ) ], i -> List( [ 1 .. Length( rays ) ], j -> 0 ) );
        
        for i in [ 1 .. Length( fan!.input_cone_list ) ] do
            
            for j in [ 1 .. Length( rays ) ] do
                
                if rays[ j ] in fan!.input_cone_list[ i ] then
                    
                    cones[ i ][ j ] := 1;
                    
                fi;
                
            od;
            
        od;
        
        return cones;
        
    fi;
    
end );

##
InstallMethod( RaysInMaximalCones,
               "for external fans.",
               [ IsExternalFanRep ],
               
  function( fan )
    
    return EXT_RAYS_IN_MAXCONES_OF_FAN( ExternalObject( fan ) );
    
end );

##
InstallMethod( MaximalCones,
               "for external fans.",
               [ IsFan ],
               
  function( fan )
    local raylist, rays, conelist, i, lis, j;
    
    raylist := RaysInMaximalCones( fan );
    
    rays := RayGenerators( fan );
    
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
    
    conelist := List( conelist, Cone );
    
    Perform( conelist, function( i ) SetContainingGrid( i, ContainingGrid( fan ) ); return 0; end );
    
    Perform( conelist, function( i ) SetIsContainedInFan( i, fan ); return 0; end );
    
    return conelist;
    
end );

##
InstallMethod( Dimension,
               "for fans",
               [ IsFan ],
               
  function( fan )
    
    return RankMat( RayGenerators( fan ) );
    
end );

##
InstallMethod( Dimension,
               "for external fans.",
               [ IsExternalFanRep ],
               
  function( fan )
    
    return EXT_DIM_OF_FAN( ExternalObject( fan ) );
    
end );

##
InstallMethod( AmbientSpaceDimension,
               "for fans",
               [ IsFan ],
               
  function( fan )
    
    return Length( RayGenerators( fan ) )[ 1 ];
    
end );

##
InstallMethod( AmbientSpaceDimension,
               "for external fans.",
               [ IsExternalFanRep ],
               
  function( fan )
    
    return EXT_AMBIENT_DIM_OF_FAN( ExternalObject( fan ) );
    
end );

####################################
##
## Properties
##
####################################

##
InstallMethod( IsComplete,
               "for external fans.",
               [ IsExternalFanRep ],
               
  function( fan )
    
    return EXT_IS_COMPLETE_FAN( ExternalObject( fan ) );
    
end );

##
InstallMethod( IsPointed,
               "for fans",
               [ IsFan ],
               
  function( fan )
    
    return ForAll( MaximalCones( fan ), IsPointed );
    
end );

##
InstallMethod( IsPointed,
               "for external fans.",
               [ IsExternalFanRep ],
               
  function( fan )
    
    return EXT_IS_POINTED_FAN( ExternalObject( fan ) );
    
end );

##
InstallMethod( IsSmooth,
               "for fans",
               [ IsFan ],
               
  function( fan )
    
    return ForAll( MaximalCones( fan ), IsSmooth );
    
end );

##
InstallMethod( IsSmooth,
               "for external fans.",
               [ IsExternalFanRep ],
               
  function( fan )
    
    return EXT_IS_SMOOTH_FAN( ExternalObject( fan ) );
    
end );

##
InstallMethod( IsRegularFan,
               "whether a fan is a normalfan or not",
               [ IsFan ],
               
  function( fan )
    local max_cones, ambient_dim, rays, max_cones_ineqs, embed, nr_rays, nd, equations, inequations, r, L1, L0, i,
          hyper_surface, cone, index_rays;
    
    if not IsComplete( fan ) then
        
        return false;
        
    fi;
    
    if AmbientSpaceDimension( fan ) <= 2 then
        
        return true;
        
    fi;
    
    ## Algorithm is taken from the Maple Convex package.
    rays := RayGenerators( fan );
    
    ambient_dim := AmbientSpaceDimension( fan );
    
    max_cones := MaximalCones( fan );
    
    max_cones_ineqs := List( max_cones, DefiningInequalities );
    
    nr_rays := Length( rays );
    
    nd := ambient_dim * Length( max_cones );
    
    embed := function( a, b, c, d, e )
                 local return_list, e1, d1;
                 if e < c then  
                    e1 := e;
                    e := c;
                    c := e1;
                    d1 := d;
                    d := b;
                    b := d1;
                 fi;
                 return_list := ListWithIdenticalEntries( c, 0 );
                 return_list := Concatenation( return_list, b );
                 return_list := Concatenation( return_list, ListWithIdenticalEntries( e - Length( b ) - c, 0 ) );
                 return_list := Concatenation( return_list, d );
                 return Concatenation( return_list, ListWithIdenticalEntries( a - Length( return_list ), 0 ) );
             end;
    
    ## FIXME: Our convention is to handle only pointed fans. convex handles fans with lineality spaces, so the lines differ.
    equations := List( [ 1 .. Length( max_cones ) ],
                       i -> List( EqualitiesOfCone( max_cones[ i ] ), 
                                  r -> embed( nd, r, ambient_dim * ( i - 1 ), [ ], 0 ) ) );
    
    equations := Concatenation( equations );
    
    inequations := [];
    
    index_rays := [ 1 .. nr_rays ];
    
    for r in [ 1 .. nr_rays ] do
        
        L0 := [];
        
        L1 := [];
        
        for i in [ 1 .. Length( max_cones ) ] do
            
            if RayGeneratorContainedInCone( rays[ r ], max_cones[ i ] ) then
                
                Add( L1, i );
                
            else
                
                Add( L0, i );
                
            fi;
            
        od;
        
        i := ambient_dim * ( L1[ 1 ] - 1 );
        
        index_rays[ r ] := i;
        
        Remove( L1, L1[ 1 ] );
        
        equations := Concatenation( equations,
                                    List( L1, j -> embed( nd, rays[ r ], i, - rays[ r ], ambient_dim * ( j - 1 ) ) ) );
        
        inequations := Concatenation( inequations,
                                    List( L0, j -> embed( nd, rays[ r ], i, - rays[ r ], ambient_dim * ( j - 1 ) ) ) );
        
    od;
    
    hyper_surface := ConeByEqualitiesAndInequalities( equations, [ ] );
    
    i := AmbientSpaceDimension( hyper_surface ) - Dimension( hyper_surface );
    
    cone := ConeByEqualitiesAndInequalities( equations, inequations );
    
    r := AmbientSpaceDimension( cone ) - Dimension( cone );
    
    return i = r;
    
end );

##
InstallMethod( IsFullDimensional,
               "for fans",
               [ IsFan ],
               
  function( fan )
    
    return ForAny( MaximalCones( fan ), i -> Dimension( i ) = AmbientSpaceDimension( i ) );
    
end );

##
InstallMethod( IsFullDimensional,
               "for homalg cones.",
               [ IsExternalFanRep ],
  function( fan )
    
    return EXT_IS_FULL_DIMENSIONAL_FAN( ExternalObject( fan ) );
    
end );

##
InstallMethod( IsSimplicial,
               " for homalg fans",
               [ IsFan ],
               
  function( fan )
    
    fan := MaximalCones( fan );
    
    return ForAll( fan, IsSimplicial );
    
end );

##
InstallTrueMethod( HasConvexSupport, IsComplete );

####################################
##
## Methods
##
####################################

# ##
# InstallMethod( \*,
#                "for homalg fans.",
#                [ IsFan, IsFan ],
#                
#   function( fan1, fan2 )
#     local cones1, cones2, n, m, newcones, i, k;
#     
#     cones1 := List( MaximalCones( fan1 ), RayGenerators );
#     
#     cones2 := List( MaximalCones( fan2 ), RayGenerators );
#     
#     cones1 := List( cones1, i -> Concatenation( i, [ List( [ 1 .. Length( i[ 1 ] ) ], i -> 0 ) ] ) );
#     
#     cones2 := List( cones2, i -> Concatenation( i, [ List( [ 1 .. Length( i[ 1 ] ) ], i -> 0 ) ] ) );
#     
#     newcones := [ 1 .. Length( cones1 ) * Length( cones2 ) ];
#     
#     for m in [ 1 .. Length( cones1 ) ] do
#         
#         for n in [ 1 .. Length( cones2 ) ] do
#             
#             newcones[ (m-1)*Length( cones2 ) + n ] := [ 1 .. Length( cones1[ m ] ) * Length( cones2[ n ] ) ];
#             
#             for i in [ 1 .. Length( cones1[ m ] ) ] do
#                 
#                 for k in [ 1 .. Length( cones2[ n ] ) ] do
#                     
#                     newcones[ (m-1)*Length( cones2 ) + n ][ (i-1)*Length( cones2[ n ] ) + k ] := Concatenation( cones1[ m ][ i ], cones2[ n ][ k ] );
#                     
#                 od;
#                 
#             od;
#             
#         od;
#         
#     od;
#     
#     newcones := Fan( newcones );
#     
#     SetContainingGrid( newcones, ContainingGrid( fan1 ) + ContainingGrid( fan2 ) );
#     
#     return newcones;
#     
# end );

##
InstallMethod( \*,
               "for fans.",
               [ IsFan, IsFan ],
               
  function( fan1, fan2 )
    local rays1, rays2, m1, m2, new_m, new_rays, cones1, cones2, i, j, k, new_cones, akt_cone, new_fan;
    
    rays1 := RayGenerators( fan1 );
    
    rays2 := RayGenerators( fan2 );
    
    m1 := Rank( ContainingGrid( fan1 ) );
    
    m2 := Rank( ContainingGrid( fan2 ) );
    
    m1 := List( [ 1 .. m1 ], i -> 0 );
    
    m2 := List( [ 1 .. m2 ], i -> 0 );
    
    rays1 := List( rays1, i -> Concatenation( i, m2 ) );
    
    rays2 := List( rays2, i -> Concatenation( m1, i ) );
    
    new_rays := Concatenation( rays1, rays2 );
    
    cones1 := RaysInMaximalCones( fan1 );
    
    cones2 := RaysInMaximalCones( fan2 );
    
    new_cones := [ ];
    
    m1 := Length( rays1 );
    
    m2 := Length( rays2 );
    
    for i in cones1 do
        
        for j in cones2 do
            
            akt_cone := [ ];
            
            for k in [ 1 .. m1 ] do
                
                if i[ k ] = 1 then
                    
                    Add( akt_cone, k );
                    
                fi;
                
            od;
            
            for k in [ 1 .. m2 ] do
                
                if j[ k ] = 1 then
                    
                    Add( akt_cone, k + m1 );
                    
                fi;
                
            od;
            
            Add( new_cones, akt_cone );
            
        od;
        
    od;
    
    new_fan := FanWithFixedRays( new_rays, new_cones );
    
    SetContainingGrid( new_fan, ContainingGrid( fan1 ) + ContainingGrid( fan2 ) );
    
    return new_fan;
    
end );

##
InstallMethod( \*,
               "for homalg fans.",
               [ IsCone, IsFan ],
               
  function( cone, fan )
    
    return Fan( [ cone ] ) * fan;
    
end );

##
InstallMethod( \*,
               "for homalg fans.",
               [ IsFan, IsCone ],
               
  function( fan, cone )
    
    return fan * Fan( [ cone ] );
    
end );

####################################
##
## Constructors
##
####################################

##
InstallMethod( Fan,
               " for homalg fans",
               [ IsFan ],
               
  IdFunc
  
);

##
InstallMethod( Fan,
               " for homalg fans",
               [ IsExternalObject ],
               
  function( point )
    local point2;
    
    point2 := rec( );
    
    ObjectifyWithAttributes(
                             point2, TheTypePolymakeFan,
                             ExternalObject, point
                            );
    
    return point2;
    
end );

##
InstallMethod( PolymakeFan,
               " for lists of Cones",
               [ IsList ],
               
  function( cones )
    local point;
    
    if Length( cones ) = 0 then
        
        Error( "fan has to have the trivial cone\n" );
        
    fi;
    
    if not IsList( cones[ 1 ] ) then
        
        Error( "input must be a list of rays for a cone\n" );
        
    fi;
    
    point := rec( input_cone_list := cones );
    
    ObjectifyWithAttributes(
        point, TheTypePolymakeFan
        );
    
    if not cones[ 1 ] = [ ] and not cones[ 1 ][ 1 ] = [ ] then
        
        SetAmbientSpaceDimension( point, Length( cones[ 1 ][ 1 ] ) );
        
    fi;
    
    return point;
    
end );

InstallMethod( PolymakeFan,
               "for rays and cones.",
               [ IsList, IsList ],
               
  function( rays, cones )
    local point;
    
    if Length( cones ) = 0 or Length( rays ) = 0 then
        
        Error( "fan has to have the trivial cone.\n" );
        
    fi;
    
    point := rec( input_rays := rays, input_cones := cones );
    
    ObjectifyWithAttributes(
        point, TheTypePolymakeFan
        );
    
    SetAmbientSpaceDimension( point, Length( rays[ 1 ] ) );
    
    return point;
    
end );

InstallMethod( PolymakeFanWithFixedRays,
               "for rays and cones.",
               [ IsList, IsList ],
               
  function( rays, cones )
    local point;
    
    if Length( cones ) = 0 or Length( rays ) = 0 then
        
        Error( "fan has to have the trivial cone.\n" );
        
    fi;
    
    point := rec( );
    
    ObjectifyWithAttributes(
        point, TheTypePolymakeFan,
        ExternalObject, EXT_FAN_BY_RAYS_AND_CONES_UNSAVE( rays, cones )
        );
    
    SetAmbientSpaceDimension( point, Length( rays[ 1 ] ) );
    
    return point;
    
end );

##
InstallMethod( InternalFan,
               " for lists of Cones",
               [ IsList ],
               
  function( cones )
    local point;
    
    if Length( cones ) = 0 then
        
        Error( "fan has to have the trivial cone\n" );
        
    fi;
    
    if not IsList( cones[ 1 ] ) then
        
        Error( "input must be a list of rays for a cone\n" );
        
    fi;
    
    point := rec( input_cone_list := cones );
    
    ObjectifyWithAttributes(
        point, TheTypeInternalFan
        );
    
    if not cones[ 1 ] = [ ] and not cones[ 1 ][ 1 ] = [ ] then
        
        SetAmbientSpaceDimension( point, Length( cones[ 1 ][ 1 ] ) );
        
    fi;
    
    return point;
    
end );

InstallMethod( InternalFan,
               "for rays and cones.",
               [ IsList, IsList ],
               
  function( rays, cones )
    local point;
    
    if Length( cones ) = 0 or Length( rays ) = 0 then
        
        Error( "fan has to have the trivial cone.\n" );
        
    fi;
    
    point := rec( input_rays := rays, input_cones := cones );
    
    ObjectifyWithAttributes(
        point, TheTypeInternalFan
        );
    
    SetAmbientSpaceDimension( point, Length( rays[ 1 ] ) );
    
    return point;
    
end );

InstallMethod( InternalFanWithFixedRays,
               "for rays and cones.",
               [ IsList, IsList ],
               
  InternalFan
  
);

if IsPackageMarkedForLoading( "PolymakeInterface", "2012.03.01" ) = true then
    
    ##
    InstallMethod( Fan,
                  " for lists of Cones",
                  [ IsList ],
                  
      PolymakeFan
      
    );
    
    ##
    InstallMethod( Fan,
                  " for rays and cones",
                  [ IsList, IsList ],
                  
      PolymakeFan
      
    );
    
    ##
    InstallMethod( FanWithFixedRays,
                  " for rays and cones",
                  [ IsList, IsList ],
                  
      PolymakeFanWithFixedRays
      
    );
    
else
    
    ##
    InstallMethod( Fan,
                  " for lists of Cones",
                  [ IsList ],
                  
      InternalFan
      
    );
    
    ##
    InstallMethod( Fan,
                  " for rays and cones",
                  [ IsList, IsList ],
                  
      InternalFan
      
    );
    
    ##
    InstallMethod( FanWithFixedRays,
                  " for rays and cones",
                  [ IsList, IsList ],
                  
      InternalFanWithFixedRays
      
    );
    
fi;



####################################
##
## Display Methods
##
####################################

##
InstallMethod( ViewObj,
               "for homalg fans",
               [ IsFan ],
               
  function( fan )
    local str;
    
    Print( "<A" );
    
    if HasIsComplete( fan ) then
        
        if IsComplete( fan ) then
            
            Print( " complete" );
            
        fi;
    
    fi;
    
    if HasIsPointed( fan ) then
        
        if IsPointed( fan ) then
            
            Print( " pointed" );
            
        fi;
    
    fi;
      
    if HasIsSmooth( fan ) then
        
        if IsSmooth( fan ) then
            
            Print( " smooth" );
            
        fi;
    
    fi;
    
    Print( " fan in |R^" );
    
    Print( String( AmbientSpaceDimension( fan ) ) );
    
    if HasRays( fan ) then
        
        Print( " with ", String( Length( Rays( fan ) ) )," rays" );
        
    fi;
    
    Print( ">" );
    
end );

##
InstallMethod( Display,
               "for homalg polytopes",
               [ IsFan ],
               
  function( fan )
    local str;
    
    Print( "A" );
    
    if HasIsComplete( fan ) then
        
        if IsComplete( fan ) then
            
            Print( " complete" );
            
        fi;
    
    fi;
    
    Print( " fan in |R^" );
    
    Print( String( AmbientSpaceDimension( fan ) ) );
    
    if HasRays( fan ) then
        
        Print( " with ", String( Length( Rays( fan ) ) )," rays" );
        
    fi;
    
    Print( ".\n" );
    
end );
