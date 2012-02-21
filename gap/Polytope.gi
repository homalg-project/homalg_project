#############################################################################
##
##  Polytope.gi         ConvexForHomalg package         Sebastian Gutsche
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

DeclareRepresentation( "IsExternalPolytopeRep",
                       IsPolytope and IsExternalConvexObjectRep,
                       [ ]
                      );

DeclareRepresentation( "IsPolymakePolytopeRep",
                       IsExternalPolytopeRep,
                       [ ]
                      );

####################################
##
## Types and Families
##
####################################


BindGlobal( "TheFamilyOfPolytopes",
        NewFamily( "TheFamilyOfPolytopes" , IsPolytope ) );

BindGlobal( "TheTypeExternalPolytope",
        NewType( TheFamilyOfPolytopes,
                 IsPolytope and IsExternalPolytopeRep ) );

BindGlobal( "TheTypePolymakePolytope",
        NewType( TheFamilyOfPolytopes,
                 IsPolymakePolytopeRep ) );

####################################
##
## Properties
##
####################################

##
InstallMethod( IsNotEmpty,
               " for external polytopes.",
               [ IsExternalPolytopeRep ],
               
  function( polytope )
    
    return EXT_IS_NOT_EMPTY_POLYTOPE( polytope );
    
end );

##
InstallMethod( IsVeryAmple,
               " for external polytopes.",
               [ IsExternalPolytopeRep ],
               
  function( polytope )
    
    return EXT_IS_VERY_AMPLE_POLYTOPE( polytope );
    
end );

##
InstallMethod( IsNormalPolytope,
               " for external polytopes.",
               [ IsExternalPolytopeRep ],
               
  function( polytope )
    
    return EXT_IS_NORMAL_POLYTOPE( polytope );
    
end );

##
InstallMethod( IsSimplicial,
               " for external polytopes.",
               [ IsExternalPolytopeRep ],
               
  function( polytope )
    
    return EXT_IS_SIMPLICIAL_POLYTOPE( polytope );
    
end );

##
InstallMethod( IsSimplePolytope,
               " for external polytopes.",
               [ IsExternalPolytopeRep ],
               
  function( polytope )
    
    return EXT_IS_SIMPLE_POLYTOPE( polytope );
    
end );

##
InstallMethod( IsLatticePolytope,
               " for external polytopes.",
               [ IsExternalPolytopeRep ],
               
  function( polytope )
    
    return EXT_IS_LATTICE_POLYTOPE( polytope );
    
end );

##
InstallMethod( IsBounded,
               " for external polytopes.",
               [ IsExternalPolytopeRep ],
               
  function( polytope )
    
    return EXT_IS_BOUNDED_POLYTOPE( polytope );
    
end );

####################################
##
## Attribute
##
####################################

##
InstallMethod( LatticePoints,
               "for external polytopes",
               [ IsExternalPolytopeRep ],
               
  function( polytope )
    
    if not IsBounded( polytope ) then
        
        Error( "calculating lattice points for unbounded polyhedron, output is useless and false\n" );
        
    fi;
    
    return EXT_LATTICE_POINTS_OF_POLYTOPE( polytope );
    
end );

##
InstallMethod( Vertices,
               "for external polytopes",
               [ IsExternalPolytopeRep ],
               
  function( polytope )
    
    return EXT_VERTICES_OF_POLYTOPE( polytope );
    
end );

##
InstallMethod( FacetInequalities,
               " for external polytopes",
               [ IsExternalPolytopeRep ],
               
  function( polytope )
    
    return EXT_FACET_INEQUALITIES_OF_POLYTOPE( polytope );
    
end );

##
InstallMethod( VerticesInFacets,
               " for external polytopes",
               [ IsExternalPolytopeRep ],
               
  function( polytope )
    
    return EXT_VERTICES_IN_FACETS( polytope );
    
end );

##
InstallMethod( NormalFan,
               " for external polytopes",
               [ IsPolytope ],
               
  function( polytope )
    local ineqs, vertsinfacs, fan, i, aktcone, j;
    
    ineqs := FacetInequalities( polytope );
    
    ineqs := List( ineqs, i -> i{ [ 2 .. Length( i ) ] } );
    
    vertsinfacs := VerticesInFacets( polytope );
    
    fan := [ ];
    
    for i in vertsinfacs do
        
        aktcone := [ ];
        
        for j in [ 1 .. Length( i ) ] do
            
            if i[ j ] = 1 then
                
                Add( aktcone, ineqs[ j ] );
                
            fi;
            
        od;
        
        Add( fan, aktcone );
        
    od;
    
    fan := Fan( fan );
    
    SetIsRegularFan( fan, true );
    
    SetIsComplete( fan, true );
    
    return fan;
    
end );

##
InstallMethod( AffineCone,
               " for homalg polytopes",
               [ IsPolytope ],
               
  function( polytope )
    local cone, newcone, i, j;
    
    cone := LatticePoints( polytope );
    
    newcone := [ ];
    
    for i in cone do
        
        j := ShallowCopy( i );
        
        Add( j, 1 );
        
        Add( newcone, j );
        
    od;
    
    return Cone( newcone );
    
end );

##
InstallMethod( RelativeInteriorLatticePoints,
               " for external polytopes",
               [ IsExternalPolytopeRep ],
               
  function( poly )
    
    return EXT_INT_LATTICE_POINTS( poly );
    
end );

####################################
##
## Methods
##
####################################

##
InstallMethod( \*,
               "for polytopes",
               [ IsPolytope, IsPolytope ],
               
  function( polytope1, polytope2 )
    local vertices1, vertices2, new_vertices, i, j;
    
    vertices1 := Vertices( polytope1 );
    
    vertices2 := Vertices( polytope2 );
    
    new_vertices := [ ];
    
    for i in vertices1 do
        
        for j in vertices2 do
            
            Add( new_vertices, Concatenation( i, j ) );
            
        od;
        
    od;
    
    return Polytope( new_vertices );
    
end );

####################################
##
## Constructors
##
####################################

##
InstallMethod( Polytope,
               "creates a PolymakePolytope.",
               [ IsList ],
               
  function( pointlist )
    local polyt, extpoly;
    
    extpoly := EXT_CREATE_POLYTOPE_BY_POINTS( pointlist );
    
    polyt := rec( );
    
     ObjectifyWithAttributes( 
        polyt, TheTypePolymakePolytope,
        IsBounded, true,
        ExternalObject, extpoly
     );
     
     return polyt;
     
end );


##
InstallMethod( PolytopeByInequalities,
               "creates a PolymakePolytope.",
               [ IsList ],
               
  function( pointlist )
    local extpoly, polyt;
    
    extpoly := EXT_CREATE_POLYTOPE_BY_INEQUALITIES( pointlist );
    
    polyt := rec(  );
    
     ObjectifyWithAttributes( 
        polyt, TheTypePolymakePolytope,
        ExternalObject, extpoly
     );
     
     return polyt;
     
end );

####################################
##
## Display Methods
##
####################################

##
InstallMethod( ViewObj,
               "for homalg polytopes",
               [ IsPolytope ],
               
  function( polytope )
    local str;
    
    Print( "<A" );
    
    if HasIsNotEmpty( polytope ) then
        
        if IsNotEmpty( polytope ) then
            
            Print( " not empty" );
            
        fi;
    
    fi;
    
    if HasIsNormalPolytope( polytope ) then
        
        if IsNormalPolytope( polytope ) then
            
            Print( " normal" );
            
        fi;
    
    fi;
    
    if HasIsSimplicial( polytope ) then
        
        if IsSimplicial( polytope ) then
            
            Print( " simplicial" );
            
        fi;
    
    fi;
    
    if HasIsSimplePolytope( polytope ) then
        
        if IsSimplePolytope( polytope ) then
            
            Print( " simple" );
            
        fi;
    
    fi;
    
    if HasIsVeryAmple( polytope ) then
        
        if IsVeryAmple( polytope ) then
            
            Print( " very ample" );
            
        fi;
    
    fi;
    
    Print( " " );
    
    if HasIsLatticePolytope( polytope) then
        
        if IsLatticePolytope( polytope ) then
            
            Print( "lattice" );
            
        fi;
        
    fi;
    
    Print( "polytope" );
    
    if HasVertices( polytope ) then
        
        Print( " with ", String( Length( Vertices( polytope ) ) )," vertices" );
        
    fi;
    
    Print( ">" );
    
end );

##
InstallMethod( Display,
               "for homalg polytopes",
               [ IsPolytope ],
               
  function( polytope )
    local str;
    
    Print( "A" );
    
    if HasIsNotEmpty( polytope ) then
        
        if IsNotEmpty( polytope ) then
            
            Print( " not empty" );
            
        fi;
    
    fi;
    
    if HasIsNormalPolytope( polytope ) then
        
        if IsNormalPolytope( polytope ) then
            
            Print( " normal" );
            
        fi;
    
    fi;
    
    if HasIsSimplicial( polytope ) then
        
        if IsSimplicial( polytope ) then
            
            Print( " simplicial" );
            
        fi;
    
    fi;
    
    if HasIsSimplePolytope( polytope ) then
        
        if IsSimplePolytope( polytope ) then
            
            Print( " simple" );
            
        fi;
    
    fi;
    
    if HasIsVeryAmple( polytope ) then
        
        if IsVeryAmple( polytope ) then
            
            Print( " very ample" );
            
        fi;
    
    fi;
    
    Print( " " );
    
    if HasIsLatticePolytope( polytope) then
        
        if IsLatticePolytope( polytope ) then
            
            Print( "lattice" );
            
        fi;
        
    fi;
    
    Print( "polytope" );
    
    if HasVertices( polytope ) then
        
        Print( " with ", String( Length( Vertices( polytope ) ) )," vertices" );
        
    fi;
    
    Print( ".\n" );
    
end );