#############################################################################
##
##  SimplicialSet.gi             SCO package                  Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  The Simplicial Set data type and constructor.
##
#############################################################################

##
DeclareRepresentation( "IsSimplicialSetRep",
        IsSimplicialSet, [ "simplicial_set", "orbifold_triangulation", "regular", "singular", "connectivity", "dimension"  ] );

##
BindGlobal( "SimplicialSetFamily",
        NewFamily( "SimplicialSetFamily" ) );

##
BindGlobal( "SimplicialSetType",
        NewType( SimplicialSetFamily, IsSimplicialSetRep ) );

##
InstallMethod( SimplicialSet, "constructor",
        [ IsOrbifoldTriangulation ],
  function( ot )
    local ss, a;
    ss := rec( );
    ss.orbifold_triangulation := ot;
    ss.dimension := 0;
    ss.0 := Set( ot!.max_simplices, x->[x] );
    ss.simplicial_set := [];
    ss.simplicial_set[1] := ss!.0;
    ss.regular := [];
    ss.singular := [];
    ss.connectivity := [];
    ss.last_faces := [];
    for a in ot!.vertices do
        ss.connectivity[a] := Filtered( ot!.max_simplices, x -> a in x );
        ss.last_faces[a] := List( ss.connectivity[a], x -> [ x ] );
        if not IsBound( ot!.isotropy.( a ) ) or Order( ot!.isotropy.( a ) ) = 1 then
            Add( ss.regular, a );
        else
            Add( ss.singular, a );
        fi;
    od;
    return Objectify( SimplicialSetType, ss );
  end
);

##
InstallMethod( SimplicialSet, "creation and accessment of the simplicial set up to the neccessary index",
        [ IsSimplicialSet, IsInt ],
  function( ss, n );
    if ss!.dimension < n then
        Extend( ss, n );
    fi;
    return ss!.simplicial_set[ n + 1 ];
  end
);

##
InstallMethod( ComputeNextDimension,
        [ IsSimplicialSet ],
  function( ss )
    local dim, last, conn, P, u, a, x, y, z, g;
    last := ss!.last_faces;
    conn := ss!.connectivity;
    P := [];
    u := [];
    for a in ss!.regular do
        P[a] := Concatenation( List( last[a], x->List( Filtered( conn[a], y->y>x[1] ), z->Concatenation( [ z, () ], x ) ) ) );
        last[a] := P[a];
        u := Union( u, P[a] );
    od;
    for a in ss!.singular do
        P[a] := [];
        for x in last[a] do
            for g in Elements( ss!.orbifold_triangulation!.isotropy.( a ) ) do
                for y in conn[a] do
                    if not ( x[1] = y and Order(g) = 1 ) then
                        Append( P[a], [ Concatenation( [ y, g ], x ) ]);
                    fi;
                od;
            od;
        od;
        last[a] := P[a];
        u := Union( u, P[a] );
    od;
    ss!.dimension := ss!.dimension + 1;
    dim := ss!.dimension;
    ss!.( EvalString( String( dim ) ) ) := Set( u );
    ss!.simplicial_set[ dim + 1 ] := ss!.( EvalString( String( dim ) ) );
    return ss;
  end
);

##
InstallMethod( Extend,
        [ IsSimplicialSet, IsInt ],
  function( ss, n )
    while ss!.dimension < n do
        ComputeNextDimension( ss );
    od;
    return ss;
  end
);

##
InstallMethod( ViewObj,
        [ IsSimplicialSet ],
  function( ss )
    local info, str;
    info := ss!.orbifold_triangulation!.info;
    if info <> "" then
        str := Concatenation( "The simplicial set of the orbifold triangulation \"", info, "\"," );
    else
        str := Concatenation( "A simplicial set" );
    fi;
    str := Concatenation( str, " computed up to dimension ", String( ss!.dimension ), " with Length vector ", String( List( ss!.simplicial_set, Length ) ) );
    Print( str );
  end
);

##
InstallMethod( PrintObj,
        [ IsSimplicialSet ],
  function( ss )
    Print( "Extend( SimplicialSet( ", ss!.orbifold_triangulation, " ), ", ss!.dimension, " )\n" );
  end
);

##
InstallMethod( Display,
        [ IsSimplicialSet ],
  function( ss )
    local s;
    Display( List( ss!.simplicial_set, function( s ) if Length( s ) < 1000 then return s; else return [ "..." ]; fi; end ) );
  end
);
