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
               "for polytopes (fallback)",
               [ IsPolytope ],
               
  function( polytope )
    local vertices, ineqs, points, min_vec, lenght, max_vec, i, j, k;
    
    vertices := Vertices( polytope );
    
    ineqs := FacetInequalities( polytope );
    
    min_vec := List( TransposedMat( vertices ), k -> Minimum( k ) );
    
    max_vec := List( TransposedMat( vertices ), k -> Maximum( k ) );
    
    ## GAP has changed the behavior on list. Shit!
    i := ShallowCopy( min_vec );
    
    lenght := Length( min_vec );
    
    points := [ ];
    
    while i[ lenght ] <= max_vec[ lenght ] do
        
        if ForAll( ineqs, j -> Sum( [ 1 .. lenght ], k -> j[ k + 1 ] * i[ k ] ) >= - j[ 1 ] ) then
            
            Add( points, ShallowCopy( i ) );
            
        fi;
        
        k := 1;
        
        while k <= lenght and i[ k ] = max_vec[ k ] do
            
            k := k + 1;
            
        od;
        
        if k > lenght then
            
            break;
            
        fi;
        
        i[ k ] := i[ k ] + 1;
        
        for j in [ 1 .. k - 1 ] do
            
            i[ j ] := min_vec[ j ];
            
        od;
        
    od;
    
    return points;
    
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
InstallMethod( VerticesOfPolytope,
               "for internal polytopes",
               [ IsInternalPolytopeRep ],
               
  function( polytope )
    local inequalities, dimension, inequality_combinations, intersection_point, ineq, rhs, lhs, vertices;
    
    if IsBound( polytope!.input_points ) then
        
        return polytope!.input_points;
        
    fi;
    
    vertices := [ ];
    
    inequalities := FacetInequalities( polytope );
    
    dimension := AmbientSpaceDimension( polytope );
    
    inequality_combinations := Combinations( inequalities, dimension );
    
    for ineq in inequality_combinations do
        
        rhs := List( ineq, i -> - i[ 1 ] );
        
        lhs := List( ineq , i -> i{ [ 2 .. Length( i ) ] } );
        
        rhs := HomalgMatrix( rhs, 1, Length( rhs ), HOMALG_MATRICES.ZZ );
        
        lhs := HomalgMatrix( TransposedMat( lhs ), HOMALG_MATRICES.ZZ );
        
        ## RightDivide( B, A ) solves XA = B. -_-
        intersection_point := RightDivide( rhs, lhs );
        
        if intersection_point = fail then
            
            continue;
            
        fi;
        
        intersection_point := EntriesOfHomalgMatrix( intersection_point );
        
        if ForAll( Difference( inequalities, ineq ), i -> Sum( [ 2 .. Length( i ) ], j -> i[ j ] * intersection_point[ j - 1 ] ) >= - i[ 1 ] ) then
            
            Add( vertices, intersection_point );
            
        fi;
        
    od;
    
    return vertices;
    
end );

##
InstallMethod( VerticesOfPolytope,
               "for external polytopes",
               [ IsExternalPolytopeRep ],
               
  function( polytope )
    
    return EXT_VERTICES_OF_POLYTOPE( ExternalObject( polytope ) );
    
end );

##
InstallMethod( Vertices,
               "for compatibility",
               [ IsPolytope ],
               
  VerticesOfPolytope
  
);

##
InstallMethod( SetVertices,
               "for compatibility",
               [ IsPolytope, IsObject ],
               
  SetVerticesOfPolytope
  
);

##
InstallMethod( HasVertices,
               "for compatibility",
               [ IsPolytope ],
               
  HasVerticesOfPolytope
  
);

##
InstallMethod( FacetInequalities,
               "for internal polytopes",
               [ IsInternalPolytopeRep ],
               
  function( polytope )
    local vertices, vertices_collection, i, linear_subspace, kernel, inequality, j, k, testA, testB,
          sum_of_vert, new_ineqs;
    
    if IsBound( polytope!.input_ineqs ) then
        
        return polytope!.input_ineqs;
        
    fi;
    
    vertices := Vertices( polytope );
    
    vertices_collection := Combinations( vertices, AmbientSpaceDimension( polytope ) );
    
    new_ineqs := [ ];
    
    for i in vertices_collection do
        
        linear_subspace := List( [ 2 .. Length( i ) ], k -> i[ k ] - i[ 1 ] );
        
        linear_subspace := HomalgMatrix( linear_subspace, HOMALG_MATRICES.ZZ );
        
        kernel := KernelSubobject( HomalgMap( Involution( linear_subspace ), "free", "free" ) );
        
        kernel := GeneratingElements( kernel );
        
        if Length( kernel ) > 1 then
            
            Error( "Wrong kernel, this should not happen\n" );
            
        fi;
        
        if Length( kernel ) < 1 then
            
            continue;
            
        fi;
        
        kernel := UnderlyingListOfRingElements( kernel[ 1 ] );
        
        inequality := Sum( [ 1 .. Length( kernel ) ], k -> i[ 1 ][ k ] * kernel[ k ] );
        
        testA := true;
        
        testB := true;
        
        for k in Difference( vertices, i ) do
            
            sum_of_vert := Sum( [ 1 .. Length( k ) ], j -> k[ j ] * kernel[ j ] );
            
            testA := testA and sum_of_vert >= inequality;
            
            testB := testB and sum_of_vert <= inequality;
            
        od;
        
        ## Both can be fulfilled
        if testA then
            
            Add( new_ineqs, Concatenation( [ - inequality ], kernel ) );
            
        fi;
        
        if testB then
            
            Add( new_ineqs, Concatenation( [ inequality ], -kernel ) );
            
        fi;
        
    od;
    
    return new_ineqs;
    
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
               "for polytopes",
               [ IsPolytope ],
               
  function( polytope )
    local ineqs, vertices, dim, incidence_matrix, i, j;
    
    ineqs := FacetInequalities( polytope );
    
    vertices := Vertices( polytope );
    
    if Length( vertices ) = 0 then
        
        return ListWithIdenticalEntries( Length( ineqs ), [ ] );
        
    fi;
    
    dim := Length( vertices[ 1 ] );
    
    incidence_matrix := List( [ 1 .. Length( ineqs ) ], i -> ListWithIdenticalEntries( Length( vertices ), 0 ) );
    
    for i in [ 1 .. Length( incidence_matrix ) ] do
        
        for j in [ 1 .. Length( vertices ) ] do
            
            if Sum( [ 1 .. dim ], k -> ineqs[ i ][ k + 1 ] * vertices[ j ][ k ] ) = - ineqs[ i ][ 1 ] then
                
                incidence_matrix[ i ][ j ] := 1;
                
            fi;
            
        od;
        
    od;
    
    return incidence_matrix;
    
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
               "for polytopes",
               [ IsInternalPolytopeRep ],
               
  function( polytope )
    local lattice_points, ineqs, inner_points, i, j;
    
    lattice_points := LatticePoints( polytope );
    
    ineqs := FacetInequalities( polytope );
    
    inner_points := [ ];
    
    for i in lattice_points do
        
        if ForAll( ineqs, j -> Sum( [ 1 .. Length( i ) ], k -> j[ k + 1 ] * i[ k ] ) > - j[ 1 ] ) then
            
            Add( inner_points, i );
            
        fi;
        
    od;
    
    return inner_points;
    
end );

##
InstallMethod( RelativeInteriorLatticePoints,
               " for external polytopes",
               [ IsExternalPolytopeRep ],
               
  function( polytope )
    
    return EXT_INT_LATTICE_POINTS( ExternalObject( polytope ) );
    
end );

##
InstallMethod( EqualitiesOfPolytope,
               "for external polytopes",
               [ IsExternalPolytopeRep ],
               
  function( polytope )
    
    return EXT_EQUALITIES_OF_POLYTOPE( ExternalObject( polytope ) );
    
end );

##
InstallMethod( DefiningInequalities,
               "for polytope",
               [ IsPolytope ],
               
  function( polytope )
    
    return Concatenation( FacetInequalities( polytope ), EqualitiesOfPolytope( polytope ), - EqualitiesOfPolytope( polytope ) );
    
end );

##
InstallMethod( LatticePointsGenerators,
               "for polytopes",
               [ IsExternalPolytopeRep ],
               
  function( polytope )
    
    return EXT_LATTICE_POINTS_GENERATORS( ExternalObject( polytope ) );
    
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
               [ IsExternalPolytopeRep, IsExternalPolytopeRep ],
               
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

##
InstallMethod( \+,
               "for polytopes",
               [ IsPolytope, IsPolytope ],
               
  function( polytope1, polytope2 )
    local vertices1, vertices2, new_polytope;
    
    ##Maybe same grid, but this might be complicated
    if not Rank( ContainingGrid( polytope1 ) ) = Rank( ContainingGrid( polytope2 ) ) then
        
        Error( "polytopes are not of the same dimension" );
        
    fi;
    
    vertices1 := Vertices( polytope1 );
    
    vertices2 := Vertices( polytope2 );
    
    new_polytope := Concatenation( List( vertices1, i -> List( vertices2, j -> i + j ) ) );
    
    new_polytope := Polytope( new_polytope );
    
    SetContainingGrid( new_polytope, ContainingGrid( polytope1 ) );
    
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

if IsPackageMarkedForLoading( "PolymakeInterface", "2012.03.01" ) = true then
    
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