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

DeclareRepresentation( "IsInternalPolytopeRep",
                       IsPolytope and IsInternalConvexObjectRep,
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

BindGlobal( "TheTypeInternalPolytope",
        NewType( TheFamilyOfPolytopes,
                 IsInternalPolytopeRep ) );

####################################
##
## Properties
##
####################################

##
InstallMethod( IsNotEmpty,
               "for polytopes",
               [ IsPolytope ],
               
  function( polytope )
    
    if IsBound( polytope!.input_points ) and Length( polytope!.input_points ) > 0 then
        
        return true;
        
    fi;
    
    TryNextMethod();
    
end );

##
InstallMethod( IsNotEmpty,
               " for external polytopes.",
               [ IsExternalPolytopeRep ],
               
  function( polytope )
    
    return EXT_IS_NOT_EMPTY_POLYTOPE( ExternalObject( polytope ) );
    
end );

##
InstallMethod( IsVeryAmple,
               " for external polytopes.",
               [ IsExternalPolytopeRep ],
               
  function( polytope )
    
    return EXT_IS_VERY_AMPLE_POLYTOPE( ExternalObject( polytope ) );
    
end );

##
InstallMethod( IsNormalPolytope,
               " for external polytopes.",
               [ IsExternalPolytopeRep ],
               
  function( polytope )
    
    return EXT_IS_NORMAL_POLYTOPE( ExternalObject( polytope ) );
    
end );

##
InstallMethod( IsSimplicial,
               " for external polytopes.",
               [ IsExternalPolytopeRep ],
               
  function( polytope )
    
    return EXT_IS_SIMPLICIAL_POLYTOPE( ExternalObject( polytope ) );
    
end );

##
InstallMethod( IsSimplePolytope,
               " for external polytopes.",
               [ IsExternalPolytopeRep ],
               
  function( polytope )
    
    return EXT_IS_SIMPLE_POLYTOPE( ExternalObject( polytope ) );
    
end );

InstallMethod( IsLatticePolytope,
               "for polytopes",
               [ IsPolytope ],
               
  function( polytope )
    
    if IsBound( polytope!.input_points ) and ForAll( Flat( polytope!.input_points ), IsInt ) then
        
        return true;
        
    fi;
    
end );

##
InstallMethod( IsLatticePolytope,
               " for external polytopes.",
               [ IsExternalPolytopeRep ],
               
  function( polytope )
    
    return EXT_IS_LATTICE_POLYTOPE( ExternalObject( polytope ) );
    
end );

##
InstallMethod( IsBounded,
               " for external polytopes.",
               [ IsExternalPolytopeRep ],
               
  function( polytope )
    
    return EXT_IS_BOUNDED_POLYTOPE( ExternalObject( polytope ) );
    
end );

####################################
##
## Attribute
##
####################################

##
InstallMethod( ExternalObject,
               "for external polytopes",
               [ IsExternalPolytopeRep ],
               
  function( polytope )
    
    if IsBound( polytope!.input_points ) and IsBound( polytope!.input_ineqs ) then
        
        Error( "points and inequalities at the same time are not supported\n" );
        
    fi;
    
    if IsBound( polytope!.input_points ) then
        
        return EXT_CREATE_POLYTOPE_BY_POINTS( polytope!.input_points );
        
    elif IsBound( polytope!.input_ineqs ) then
        
        return EXT_CREATE_POLYTOPE_BY_INEQUALITIES( polytope!.input_ineqs );
        
    else
        
        Error( "something went wrong\n" );
        
    fi;
    
end );

##
InstallMethod( LatticePoints,
               "for external polytopes",
               [ IsExternalPolytopeRep ],
               
  function( polytope )
    
    if not IsBounded( polytope ) then
        
        Error( "calculating lattice points for unbounded polyhedron, output is useless and false\n" );
        
    fi;
    
    return EXT_LATTICE_POINTS_OF_POLYTOPE( ExternalObject( polytope ) );
    
end );

##
InstallMethod( Vertices,
               "for external polytopes",
               [ IsExternalPolytopeRep ],
               
  function( polytope )
    
    return EXT_VERTICES_OF_POLYTOPE( ExternalObject( polytope ) );
    
end );

##
InstallMethod( FacetInequalities,
               " for external polytopes",
               [ IsExternalPolytopeRep ],
               
  function( polytope )
    
    return EXT_FACET_INEQUALITIES_OF_POLYTOPE( ExternalObject( polytope ) );
    
end );

##
InstallMethod( VerticesInFacets,
               " for external polytopes",
               [ IsExternalPolytopeRep ],
               
  function( polytope )
    
    return EXT_VERTICES_IN_FACETS( ExternalObject( polytope ) );
    
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
    
    vertsinfacs := TransposedMat( vertsinfacs );
    
    fan := [ ];
    
    for i in vertsinfacs do
        
        aktcone := [ ];
        
        for j in [ 1 .. Length( i ) ] do
            
            if i[ j ] = 1 then
                
                Add( aktcone,  j  );
                
            fi;
            
        od;
        
        Add( fan, aktcone );
        
    od;
    
    fan := Fan( ineqs, fan );
    
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
    
    cone := Vertices( polytope );
    
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
               
  function( polytope )
    
    return EXT_INT_LATTICE_POINTS( ExternalObject( polytope ) );
    
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

##
InstallMethod( \+,
               "for polytopes",
               [ IsPolytope, IsPolytope ],
               
  function( polytope1, polytope2 )
    local new_polytope, new_ext;
    
    ##Maybe same grid, but this might be complicated
    if not Rank( ContainingGrid( polytope1 ) ) = Rank( ContainingGrid( polytope2 ) ) then
        
        Error( "polytopes are not of the same dimension" );
        
    fi;
    
    new_polytope := rec();
    
    new_ext := EXT_MINKOWSKI_SUM( ExternalObject( polytope1 ), ExternalObject( polytope2 ) );
    
    ObjectifyWithAttributes( new_polytope, TheTypeExternalPolytope,
                             ExternalObject, new_ext );
    
    SetContainingGrid( new_polytope, ContainingGrid( polytope1 ) );
    
    SetAmbientSpaceDimension( new_polytope, AmbientSpaceDimension( polytope1 ) );
    
    return new_polytope;
    
end );

####################################
##
## Constructors
##
####################################

##
InstallMethod( PolymakePolytope,
               "creates a PolymakePolytope.",
               [ IsList ],
               
  function( pointlist )
    local polyt, extpoly;
    
    polyt := rec( input_points := pointlist );
    
     ObjectifyWithAttributes( 
        polyt, TheTypePolymakePolytope,
        IsBounded, true
     );
     
     if not pointlist = [ ] then
        
        SetAmbientSpaceDimension( polyt, Length( pointlist[ 1 ] ) );
        
     fi;
     
     return polyt;
     
end );


##
InstallMethod( PolymakePolytopeByInequalities,
               "creates a PolymakePolytope.",
               [ IsList ],
               
  function( pointlist )
    local extpoly, polyt;
    
    polyt := rec( input_ineqs := pointlist );
    
    ObjectifyWithAttributes( 
        polyt, TheTypePolymakePolytope
    );
    
    if not pointlist = [ ] then
        
        SetAmbientSpaceDimension( polyt, Length( pointlist[ 1 ] ) -1 );
        
    fi;
     
     return polyt;
     
end );

##
InstallMethod( InternalPolytope,
               "creates an internal polytope.",
               [ IsList ],
               
  function( pointlist )
    local polyt, extpoly;
    
    polyt := rec( input_points := pointlist );
    
     ObjectifyWithAttributes( 
        polyt, TheTypeInternalPolytope,
        IsBounded, true
     );
     
     if not pointlist = [ ] then
        
        SetAmbientSpaceDimension( polyt, Length( pointlist[ 1 ] ) );
        
     fi;
     
     return polyt;
     
end );


##
InstallMethod( InternalPolytopeByInequalities,
               "creates a internal polytope.",
               [ IsList ],
               
  function( pointlist )
    local extpoly, polyt;
    
    polyt := rec( input_ineqs := pointlist );
    
    ObjectifyWithAttributes( 
        polyt, TheTypeInternalPolytope
    );
    
    if not pointlist = [ ] then
        
        SetAmbientSpaceDimension( polyt, Length( pointlist[ 1 ] ) -1 );
        
    fi;
     
     return polyt;
     
end );

if LoadPackage( "PolymakeInterface" ) = true then
    
    ##
    InstallMethod( Polytope,
                  "creates polytope.",
                  [ IsList ],
                  
      PolymakePolytope
      
    );
    
    ##
    InstallMethod( PolytopeByInequalities,
                  "creates polytope.",
                  [ IsList ],
                  
      PolymakePolytopeByInequalities
      
    );
    
else
    
    ##
    InstallMethod( Polytope,
                  "creates polytope.",
                  [ IsList ],
                  
      InternalPolytope
      
    );
    
    ##
    InstallMethod( PolytopeByInequalities,
                  "creates polytope.",
                  [ IsList ],
                  
      InternalPolytopeByInequalities
      
    );
    
fi;

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
    
    Print( "polytope in |R^" );
    
    Print( String( AmbientSpaceDimension( polytope ) ) );
    
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
    
    Print( "polytope in |R^" );
    
    Print( String( AmbientSpaceDimension( polytope ) ) );
    
    if HasVertices( polytope ) then
        
        Print( " with ", String( Length( Vertices( polytope ) ) )," vertices" );
        
    fi;
    
    Print( ".\n" );
    
end );