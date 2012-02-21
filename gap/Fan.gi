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

####################################
##
## Attributes
##
####################################

##
InstallMethod( Rays,
               " for external fans.",
               [ IsExternalFanRep ],
               
  function( fan )
    local rays;
    
    rays := EXT_RAYS_OF_FAN( fan );
    
    rays := List( rays, i -> Cone( [ i ] ) );
    
    List( rays, function( i ) SetContainingGrid( i, ContainingGrid( fan ) ); return 0; end );
    
    return rays;
    
end );

##
InstallMethod( RayGenerators,
               " for external fans.",
               [ IsExternalFanRep ],
               
  function( fan )
    
    return EXT_RAYS_OF_FAN( ExternalObject( fan ) );
    
end );

##
InstallMethod( RaysInMaximalCones,
               " for external fans.",
               [ IsExternalFanRep ],
               
  function( fan )
    
    return EXT_RAYS_IN_MAXCONES_OF_FAN( ExternalObject( fan ) );
    
end );

##
InstallMethod( MaximalCones,
               " for external fans.",
               [ IsExternalFanRep ],
               
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
               " for external fans. ",
               [ IsExternalFanRep ],
               
  function( fan )
    
    return EXT_DIM_OF_FAN( ExternalObject( fan ) );
    
end );

##
InstallMethod( AmbientSpaceDimension,
               " for external fans. ",
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
               " for external fans.",
               [ IsExternalFanRep ],
               
  function( fan )
    
    return EXT_IS_COMPLETE_FAN( ExternalObject( fan ) );
    
end );

##
InstallMethod( IsPointed,
               " for external fans.",
               [ IsExternalFanRep ],
               
  function( fan )
    
    return EXT_IS_POINTED_FAN( ExternalObject( fan ) );
    
end );

##
InstallMethod( IsSmooth,
               " for external fans.",
               [ IsExternalFanRep ],
               
  function( fan )
    
    return EXT_IS_SMOOTH_FAN( ExternalObject( fan ) );
    
end );

##
InstallMethod( IsRegularFan,
               " for external fans.",
               [ IsExternalFanRep ],
               
  function( fan )
    
    return EXT_IS_REGULAR_FAN( ExternalObject( fan ) );
    
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

##
InstallMethod( \*,
               "for homalg fans.",
               [ IsFan, IsFan ],
               
  function( fan1, fan2 )
    local cones1, cones2, n, m, newcones, i, k;
    
    cones1 := List( MaximalCones( fan1 ), RayGenerators );
    
    cones2 := List( MaximalCones( fan2 ), RayGenerators );
    
    cones1 := List( cones1, i -> Concatenation( i, [ List( [ 1 .. Length( i[ 1 ] ) ], i -> 0 ) ] ) );
    
    cones2 := List( cones2, i -> Concatenation( i, [ List( [ 1 .. Length( i[ 1 ] ) ], i -> 0 ) ] ) );
    
    newcones := [ 1 .. Length( cones1 ) * Length( cones2 ) ];
    
    for m in [ 1 .. Length( cones1 ) ] do
        
        for n in [ 1 .. Length( cones2 ) ] do
            
            newcones[ (m-1)*Length( cones2 ) + n ] := [ 1 .. Length( cones1[ m ] ) * Length( cones2[ n ] ) ];
            
            for i in [ 1 .. Length( cones1[ m ] ) ] do
                
                for k in [ 1 .. Length( cones2[ n ] ) ] do
                    
                    newcones[ (m-1)*Length( cones2 ) + n ][ (i-1)*Length( cones2[ n ] ) + k ] := Concatenation( cones1[ m ][ i ], cones2[ n ][ k ] );
                    
                od;
                
            od;
            
        od;
        
    od;
    
    newcones := Fan( newcones );
    
    SetContainingGrid( newcones, ContainingGrid( fan1 ) + ContainingGrid( fan2 ) );
    
    return newcones;
    
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
InstallMethod( Fan,
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
    
    point := rec( );
    
    ObjectifyWithAttributes(
        point, TheTypePolymakeFan,
        ExternalObject, EXT_FAN_BY_CONES( cones )
        );
    
    return point;
    
end );

InstallMethod( Fan,
               " for rays and cones.",
               [ IsList, IsList ],
               
  function( rays, cones )
    local point;
    
    if Length( cones ) = 0 or Length( rays ) = 0 then
        
        Error( " fan has to have the trivial cone." );
        
    fi;
    
    point := rec( );
    
    ObjectifyWithAttributes(
        point, TheTypePolymakeFan,
        ExternalObject, EXT_FAN_BY_RAYS_AND_CONES( rays, cones )
        );
    
    return point;
    
end );

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
    
    Print( " fan" );
    
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
    
    Print( " fan" );
    
    if HasRays( fan ) then
        
        Print( " with ", String( Length( Rays( fan ) ) )," rays" );
        
    fi;
    
    Print( ".\n" );
    
end );
