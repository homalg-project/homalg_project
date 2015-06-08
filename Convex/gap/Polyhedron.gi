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
InstallMethod( ContainingGrid,
               "for polyhedrons",
               [ IsPolyhedron ],
               
  function( polyhedron )
    
    if HasTailCone( polyhedron ) then
        
        return ContainingGrid( TailCone( polyhedron ) );
        
    elif HasMainPolytope( polyhedron ) then
        
        return ContainingGrid( MainPolytope( polyhedron ) );
        
    fi;
    
end );

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
               [ IsExternalPolyhedronRep ],
               
  function( polyhedron )
    
    if IsBound( polyhedron!.inequalities ) then
        
        if IsEmpty( polyhedron!.inequalities ) then
            
            polyhedron!.inequalities := [ [ 0 ] ];
            
        fi;
        
        return EXT_CREATE_POLYTOPE_BY_INEQUALITIES( polyhedron!.inequalities );
        
    fi;
    
    TryNextMethod();
    
end );

##
InstallMethod( MainPolytope,
               "for polyhedrons",
               [ IsExternalPolyhedronRep ],
               
  function( polyhedron )
    local polytope;
    
    polytope := LatticePointsGenerators( polyhedron )[ 1 ];
    
    return Polytope( polytope );
    
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
               [ IsPolyhedron ],
               
  function( polyhedron )
    local ineqs, i;
    
    if not IsBound( polyhedron!.inequalities ) or HasExternalObject( polyhedron ) then
        
        TryNextMethod();
        
    fi;
    
    ineqs := StructuralCopy( polyhedron!.inequalities );
    
    for i in [ 1 .. Length( ineqs ) ] do
        
        Remove( ineqs[ i ], 1 );
        
    od;
    
    ineqs := ConeByInequalities( ineqs );
    
    SetContainingGrid( ineqs, ContainingGrid( polyhedron ) );
    
    return ineqs;
    
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
               [ IsExternalPolyhedronRep ],
               
  function( polyhedron )
    local generators;
    
    generators := LatticePointsGenerators( polyhedron );
    
    generators := Concatenation( generators[ 2 ], generators[ 3 ], - generators[ 3 ] );
    
    return Cone( generators );
    
end );

##
## FIXME: DOES THIS EVEN MAKE SENSE?
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

##
InstallMethod( LatticePointsGenerators,
               "for polyhedrons",
               [ IsExternalPolyhedronRep ],
               
  function( polyhedron )
    
    return EXT_LATTICE_POINTS_GENERATORS( ExternalObject( polyhedron ) );
    
end );

##
InstallMethod( BasisOfLinealitySpace,
               "for ext polyhedrons",
               [ IsExternalPolyhedronRep ],
               
  function( polyhedron )
    
    return LatticePointsGenerators( polyhedron )[ 3 ];
    
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
    
    polyhedron := rec();
    
    ObjectifyWithAttributes( polyhedron, TheTypeExternalPolyhedron );
    
    polyhedron!.inequalities := inequalities;
    
    if not IsEmpty( inequalities ) then
        
        SetAmbientSpaceDimension( polyhedron, Length( inequalities[ 1 ] ) - 1 );
        
    else
        
        SetAmbientSpaceDimension( polyhedron, 0 );
    fi;
    
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
    
    polyhedron := rec();
    
    ObjectifyWithAttributes( polyhedron, TheTypeExternalPolyhedron,
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
    
    polyhedron := rec( );
    
    ObjectifyWithAttributes( polyhedron, TheTypeExternalPolyhedron,
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
    
    polyhedron := rec( );
    
    ObjectifyWithAttributes( polyhedron, TheTypeExternalPolyhedron,
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
    
    polyhedron := rec();
    
    ObjectifyWithAttributes( polyhedron, TheTypeExternalPolyhedron,
                                          MainPolytope, Polytope( polytope ),
                                          TailCone, Cone( cone ),
                                          AmbientSpaceDimension, Length( polytope[ 1 ] ) 
                                        );
    
    SetContainingGrid( TailCone( polyhedron ), ContainingGrid( MainPolytope( polyhedron ) ) );
    
    SetContainingGrid( polyhedron, ContainingGrid( MainPolytope( polyhedron ) ) );
    
    return polyhedron;
    
end );


##############################
##
## View & Display
##
##############################

##
InstallMethod( ViewObj,
               "for homalg polytopes",
               [ IsPolyhedron ],
               
  function( polytope )
    local str;
    
    Print( "<A" );
    
    if HasIsNotEmpty( polytope ) then
        
        if IsNotEmpty( polytope ) then
            
            Print( " not empty" );
            
        fi;
    
    fi;
    
    Print( " polyhedron in |R^" );
    
    Print( String( AmbientSpaceDimension( polytope ) ) );
    
    Print( ">" );
    
end );

##
InstallMethod( Display,
               "for homalg polytopes",
               [ IsPolyhedron ],
               
  function( polytope )
    local str;
    
    Print( "A" );
    
    if HasIsNotEmpty( polytope ) then
        
        if IsNotEmpty( polytope ) then
            
            Print( " not empty" );
            
        fi;
    
    fi;
    
    Print( " polyhedron in |R^" );
    
    Print( String( AmbientSpaceDimension( polytope ) ) );
    
    Print( ".\n" );
    
end );