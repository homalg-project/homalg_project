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

##  <#GAPDoc Label="SimplicialSet">
##  <ManSection>
##  <Meth Arg="ot" Name="SimplicialSet" Label="constructor"/>
##  <Returns>the simplicial set based on the orbifold triangulation <A>ot</A>.</Returns>
##  <Description>
##  The constructor for simplicial sets. This just sets up the object
##  without any computations. These can be triggered later explicitly
##  or by <Ref Meth="SimplicialSet" Label="data access"/>.
##  <Example><![CDATA[
##  no example yet
##  ]]></Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
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

##  <#GAPDoc Label="SimplicialSet2">
##  <ManSection>
##  <Meth Arg="S, i" Name="SimplicialSet" Label="data access"/>
##  <Returns>The components of dimension <A>i</a> of the simplicial set <A>S</A></Returns>
##  <Description>
##  This should be used to access existing data instead of using
##  <C>S!.simplicial_set[ i + 1 ]</C>, as it has the added side
##  effect of computing <A>S</A> up to dimension <A>i</A>, thus
##  always returning the desired result.
##  <Example><![CDATA[
##  no example yet
##  ]]></Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
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

##  <#GAPDoc Label="ComputeNextDimension">
##  <ManSection>
##  <Meth Arg="S" Name="ComputeNextDimension"/>
##  <Returns><A>S</A></Returns>
##  <Description>
##  This computes the component of the next dimension of
##  the simplicial set <A>S</A>. <A>S</A> is extended
##  as a side effect.
##  <Example><![CDATA[
##  no example yet
##  ]]></Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
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
                    if y > x[1] or ( x[1] = y and Order( g ) <> 1 ) then #this is the key to reducing simplicial set length
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
    ss!.(String( dim )) := Set( u );
    ss!.simplicial_set[ dim + 1 ] := ss!.(String( dim ));
    return ss;
  end
);

##  <#GAPDoc Label="Extend">
##  <ManSection>
##  <Meth Arg="S, i" Name="Extend"/>
##  <Returns><A>S</A></Returns>
##  <Description>
##  This computes the components of the simplicial set <A>S</A>
##  up to dimension <A>i</A>. <A>S</A> is extended as a side effect.
##  This method is equivalent to calling <Ref Meth="ComputeNextDimension"/>
##  the appropriate number of times.
##  <Example><![CDATA[
##  no example yet
##  ]]></Example>
##  </Description>
##  </ManSection>
##  <#/GAPDoc>
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
        str := "A simplicial set";
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
