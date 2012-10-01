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
##  <Returns>SimplicialSet</Returns>
##  <Description>
##  The constructor for simplicial sets based on an orbifold triangulation <A>ot</A>.
##  This just sets up the object without any computations.
##  These can be triggered later, either explicitly or by <Ref Meth="SimplicialSet" Label="data access"/>.
##  <Example><![CDATA[
##  gap> Teardrop;
##  <OrbifoldTriangulation "Teardrop" of dimension 2. 4 simplices on 4 vertices wi\
##  th Isotropy on 1 vertex and nontrivial mu-maps>
##  gap> S := SimplicialSet( Teardrop );
##  <The simplicial set of the orbifold triangulation "Teardrop", computed up to d\
##  imension 0 with Length vector [ 4 ]>
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
##  <Returns>List <A>S</A>_<A>i</A></Returns>
##  <Description>
##  This returns the components of dimension <A>i</A> of the simplicial set <A>S</A>.
##  Should be used to access existing data instead of using <C>S!.simplicial_set[ i + 1 ]</C>,
##  as it has the additional side effect of computing <A>S</A> up to dimension <A>i</A>, thus
##  always returning the desired result.
##  <Example><![CDATA[
##  gap> S := SimplicialSet( Teardrop );
##  <The simplicial set of the orbifold triangulation "Teardrop", computed up to d\
##  imension 0 with Length vector [ 4 ]>
##  gap> S!.simplicial_set[1];
##  [ [ [ 1, 2, 3 ] ], [ [ 1, 2, 4 ] ], [ [ 1, 3, 4 ] ], [ [ 2, 3, 4 ] ] ]
##  gap> S!.simplicial_set[2];;
##  Error, List Element: <list>[2] must have an assigned value
##  gap> SimplicialSet( S, 0 );
##  [ [ [ 1, 2, 3 ] ], [ [ 1, 2, 4 ] ], [ [ 1, 3, 4 ] ], [ [ 2, 3, 4 ] ] ]
##  gap> SimplicialSet( S, 1 );;
##  gap> S;
##  <The simplicial set of the orbifold triangulation "Teardrop", computed up to d\
##  imension 1 with Length vector [ 4, 12 ]>
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
##  gap> S;
##  <The simplicial set of the orbifold triangulation "Teardrop", computed up to d\
##  imension 1 with Length vector [ 4, 12 ]>
##  gap> ComputeNextDimension( S );
##  <The simplicial set of the orbifold triangulation "Teardrop", computed up to d\
##  imension 2 with Length vector [ 4, 12, 22 ]>
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
##  gap> S;
##  <The simplicial set of the orbifold triangulation "Teardrop", computed up to d\
##  imension 2 with Length vector [ 4, 12, 22 ]>
##  gap> Extend( S, 5 );
##  <The simplicial set of the orbifold triangulation "Teardrop", computed up to d\
##  imension 5 with Length vector [ 4, 12, 22, 33, 51, 73 ]>
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
    str := Concatenation( "<", str, " computed up to dimension ", String( ss!.dimension ), " with Length vector ", String( List( ss!.simplicial_set, Length ) ), ">" );
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
