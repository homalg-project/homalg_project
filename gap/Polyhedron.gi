#############################################################################
##
##  Polyhedron.gi         Convex package         Sebastian Gutsche
##
##  Copyright 2011 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Polyhedrons for Convex.
##
#############################################################################

DeclareRepresentation( "IsExternalPolyhedronRep",
                       IsPolyhedron and IsExternalConvexObjectRep,
                       [ ]
                      );

####################################
##
## Types and Families
##
####################################


BindGlobal( "TheFamilyOfPolyhedrons",
        NewFamily( "TheFamilyOfPolyhedrons" , IsPolyhedron ) );

BindGlobal( "TheTypeExternalPolyhedron",
        NewType( TheFamilyOfPolyhedrons,
                 IsPolyhedron and IsExternalPolyhedronRep ) );

#####################################
##
## Structural Elements
##
#####################################

##
InstallMethod( ExternalObject,
               "for polyhedrons",
               [ IsPolyhedron and HasMainPolytope and HasTailCone ],
               
  function( polyhedron )
    local verts, rays;
    
    verts := Vertices( MainPolytope( polyhedron ) );
    
    verts := List( verts, i -> Concatenation( [ 1 ], i ) );
    
    rays := RayGenerators( TailCone( polyhedron ) );
    
    rays := List( rays, i -> Concatenation( [ 0 ], i ) );
    
    polyhedron := Concatenation( rays, verts );
    
    polyhedron := EXT_CREATE_POLYTOPE_BY_HOMOGENEOUS_POINTS( polyhedron );
    
    return polyhedron;
    
end );

##
InstallMethod( ExternalObject,
               "for polyhedrons",
               [ IsPolyhedron and HasHomogeneousPointsOfPolyhedron ],
               
  function( polyhedron )
    
    return EXT_CREATE_POLYTOPE_BY_HOMOGENEOUS_POINTS( HomogeneousPointsOfPolyhedron( polyhedron ) );
    
end );

##
InstallMethod( ExternalObject,
               "for polyhedrons with inequalities",
               [ IsPolyhedron ],
               
  function( polyhedron )
    
    if IsBound( polyhedron!.inequalities ) then
        
        return EXT_CREATE_POLYTOPE_BY_INEQUALITIES( polyhedron!.inequalities );
        
    fi;
    
    TryNextMethod();
    
end );

##
InstallMethod( MainPolytope,
               "for polyhedrons",
               [ IsPolyhedron and HasExternalObject ],
               
  function( polyhedron )
    local polytope;
    
    return Polytope( EXT_VERTICES_OF_POLYTOPE( ExternalObject( polyhedron ) ) );
    
    SetContainingGrid( polytope, ContainingGrid( polyhedron ) );
    
    return polytope;
    
end );

##
InstallMethod( MainPolytope,
               "for polyhedrons",
               [ IsPolyhedron and HasVerticesOfMainPolytope ],
               
  function( polyhedron )
    local polytope;
    
    polytope := Polytope( VerticesOfMainPolytope( polyhedron ) );
    
    SetContainingGrid( polytope, ContainingGrid( polyhedron ) );
    
    return polytope;
    
end );

##
InstallMethod( VerticesOfMainPolytope,
               "for polyhedrons",
               [ IsPolyhedron ],
               
  function( polyhedron )
    
    return Vertices( MainPolytope( polyhedron ) );
    
end );

##
InstallMethod( TailCone,
               "for polyhedrons",
               [ IsPolyhedron and HasExternalObject ],
               
  function( polyhedron )
    local rays;
    
    rays := EXT_TAIL_CONE_OF_POLYTOPE( ExternalObject( polyhedron ) );
    
    if rays = [] then
        
        rays := [ List( [ 1 .. Dimension( polyhedron ) ], i -> 0 ) ];
        
    fi;
    
    return Cone( rays );
    
end );

##
InstallMethod( TailCone,
               "for polyhedrons",
               [ IsPolyhedron and HasRayGeneratorsOfTailCone ],
               
  function( polyhedron )
    local tail;
    
    tail := Cone( RayGeneratorsOfTailCone( polyhedron ) );
    
    SetContainingGrid( tail, ContainingGrid( polyhedron ) );
    
    return tail;
    
end );

##
InstallMethod( RayGeneratorsOfTailCone,
               "for polyhedrons",
               [ IsPolyhedron ],
               
  function( polyhedron )
    
    return RayGenerators( TailCone( polyhedron ) );
    
end );

##
InstallMethod( HomogeneousPointsOfPolyhedron,
               "for polyhedrons",
               [ IsPolyhedron and HasExternalObject ],
               
  function( polyhedron )
    
    return EXT_HOMOGENEOUS_POINTS_OF_POLYTOPE( ExternalObject( polyhedron ) );
    
end );

##
InstallMethod( HomogeneousPointsOfPolyhedron,
               "for polyhedrons",
               [ IsPolyhedron and HasMainPolytope and HasTailCone ],
               
  function( polyhedron )
    local verts, rays;
    
    verts := Vertices( MainPolytope( polyhedron ) );
    
    verts := List( verts, i -> Concatenation( [ 1 ], i ) );
    
    rays := RayGenerators( TailCone( polyhedron ) );
    
    rays := List( rays, i -> Concatenation( [ 0 ], i ) );
    
    polyhedron := Concatenation( rays, verts );
    
    return polyhedron;
    
end );


#####################################
##
## Constructors
##
#####################################

##
InstallMethod( PolyhedronByInequalities,
               "for list of inequalities",
               [ IsList ],
               
  function( inequalities )
    local polyhedron;
    
    polyhedron := ObjectifyWithAttributes( rec(), TheTypeExternalPolyhedron );
    
    polyhedron!.inequalities := inequalities;
    
    return polyhedron;
    
end );

##
InstallMethod( Polyhedron,
               "for a polytope and a cone",
               [ IsPolytope, IsCone ],
               
  function( polytope, cone )
    local polyhedron;
    
    if not IsIdenticalObj( ContainingGrid( polytope ), ContainingGrid( cone ) ) then
        
        Error( "Two objects are not comparable" );
        
    fi;
    
    polyhedron := ObjectifyWithAttributes( rec(), TheTypeExternalPolyhedron,
                                          MainPolytope, polytope,
                                          TailCone, cone,
                                          ContainingGrid, ContainingGrid( polytope ),
                                          AmbientSpaceDimension, AmbientSpaceDimension( polytope )
                                        );
    
    return polyhedron;
    
end );

##
InstallMethod( Polyhedron,
               "for a polytope and a list",
               [ IsPolytope, IsList ],
               
  function( polytope, cone )
    local polyhedron;
    
    if Length( cone ) > 0 and Length( cone[ 1 ] ) <> AmbientSpaceDimension( polytope ) then
        
        Error( "the two objects are not comparable" );
        
    fi;
    
    polyhedron := ObjectifyWithAttributes( rec(), TheTypeExternalPolyhedron,
                                          MainPolytope, polytope,
                                          RayGeneratorsOfTailCone, cone,
                                          ContainingGrid, ContainingGrid( polytope ),
                                          AmbientSpaceDimension, AmbientSpaceDimension( polytope )
                                        );
    
    return polyhedron;
    
end );


##
InstallMethod( Polyhedron,
               "for a polytope and a cone",
               [ IsList, IsCone ],
               
  function( polytope, cone )
    local polyhedron;
    
    if Length( polytope ) > 0 and Length( polytope[ 1 ] ) <> AmbientSpaceDimension( cone ) then
        
        Error( "the two objects are not comparable" );
        
    fi;
    
    polytope := Polytope( polytope );
    
    SetContainingGrid( polytope, ContainingGrid( cone ) );
    
    polyhedron := ObjectifyWithAttributes( rec(), TheTypeExternalPolyhedron,
                                          MainPolytope, polytope,
                                          TailCone, cone,
                                          ContainingGrid, ContainingGrid( cone ),
                                          AmbientSpaceDimension, AmbientSpaceDimension( cone )
                                        );
    
    return polyhedron;
    
end );

##
InstallMethod( Polyhedron,
               "for a polytope and a cone",
               [ IsList, IsList ],
               
  function( polytope, cone )
    local polyhedron;
    
    if Length( polytope ) > 0 and Length( cone ) > 0 and Length( cone[ 1 ] ) <> Length( polytope[ 1 ] ) then
        
        Error( "two objects are not comparable\n" );
        
    fi;
    
    if Length( polytope ) = 0 then
        
        Error( "no empty polytope" );
        
    fi;
    
    if Length( cone ) = 0 then
        
        cone := [ List( [ 1 .. Length( polytope[ 1 ] ) ], i -> 0 ) ];
        
    fi;
    
    polyhedron := ObjectifyWithAttributes( rec(), TheTypeExternalPolyhedron,
                                          MainPolytope, Polytope( polytope ),
                                          TailCone, Cone( cone ),
                                          AmbientSpaceDimension, Length( polytope[ 1 ] ) 
                                        );
    
    SetContainingGrid( TailCone( polyhedron ), ContainingGrid( polytope ) );
    
    SetContainingGrid( polyhedron, ContainingGrid( polytope ) );
    
    return polyhedron;
    
end );

