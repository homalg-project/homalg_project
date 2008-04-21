#############################################################################
##
##  SCO.gi                   SCO package                      Simon Goertzen
##
##  Copyright 2007-2008 Lehrstuhl B für Mathematik, RWTH Aachen
##
##  Implementation stuff for SCO.
##
#############################################################################

##
DeclareRepresentation( "IsOrbifoldTriangulationRep",
        IsOrbifoldTriangulation, [ "vertices", "max_simplices", "isotropy", "mu" ] );

##
BindGlobal( "TheFamilyOfOrbifoldTriangulations",
        NewFamily( "TheFamilyOfOrbifoldTriangulations" ) );

##
BindGlobal( "TheTypeOrbifoldTriangulation",
        NewType( TheFamilyOfOrbifoldTriangulations, IsOrbifoldTriangulationRep ) );

##
DeclareRepresentation( "IsSimplicialSetRep",
        IsSimplicialSet, [ "simplicial_set" ] );

##
BindGlobal( "SimplicialSetFamily",
        NewFamily( "SimplicialSetFamily" ) );

##
BindGlobal( "SimplicialSetType",
        NewType( SimplicialSetFamily, IsSimplicialSetRep ) );

##
##
InstallMethod( OrbifoldTriangulation, "constructor",
        [ IsList, IsRecord, IsList ],
  function( s , i , m)
    local v, mm, ind, triangulation;
    v := Union( s );
    mm := function( x )
        for ind in m do
            if ind{[1..4]} = x then return ind[5]; fi;
        od;
        return x->x;
    end;
    triangulation := rec( vertices := v, max_simplices := s, isotropy := i, mu := mm );
    return Objectify( TheTypeOrbifoldTriangulation, triangulation );
end );

##
InstallMethod( SimplicialSet, "constructor",
        [ IsOrbifoldTriangulation, IsInt ],
  function( ot, n )
    local a, L, P, dim, x, y, g, S, u;
    L := [];
    P := [];
    for a in ot!.vertices do
        L[a] := Filtered( ot!.max_simplices, x->a in x );
        P[a] := [];
        P[a][1] := List( L[a], x->[x] );
        if not IsBound( ot!.isotropy.( a ) ) or Order( ot!.isotropy.( a ) ) = 1 then
            for dim in [2..n+1] do
                P[a][dim] := Concatenation( List( P[a][dim-1], x->List( Filtered( L[a], y->y>x[1] ), z->Concatenation( [ z, () ], x ) ) ) );
            od;
        else
            for dim in [2..n+1] do
                P[a][dim] := [];
                for x in P[a][dim-1] do
                    for g in Elements( ot!.isotropy.( a ) ) do
                        for y in L[a] do
                            if not ( x[1] = y and Order(g) = 1 ) then
                                Append( P[a][dim], [ Concatenation( [ y, g ], x ) ]);
                            fi;
                        od;
                    od;
                od;
            od;
        fi; 
    od;
    
    S := [];
    S[1] := Set( ot!.max_simplices, x->[x] );
    
    for dim in [2..n+1] do
        u := [];
        for a in ot!.vertices do
            u := Union( u, P[a][dim]);
        od;
        S[dim] := Set(u);
    od;
    
    return Objectify( SimplicialSetType, rec( simplicial_set := S ) );
    
end );

##
InstallMethod( Dimension, "for Simplicial Sets",
        [ IsSimplicialSetRep ],
  function( s )
    return Length( s!.simplicial_set );
end );

##
InstallMethod( BoundaryOperator, "calculate i-th boundary",
        [ IsInt, IsList, IsFunction ],
  function( i, L, mu)
    local n, tau, rho, j, rand;
    rand := ShallowCopy( L );
    n := ( Length( L ) - 1 ) / 2;
    tau := Intersection( Filtered( L, x->IsList( x ) ) );
    if i = 0 then
        rand := L{[3..Length( L )]};
        rho := Intersection( Filtered( rand, x->IsList( x ) ) );
    elif i = n then
        rand := L{[1..Length( L ) - 2]};
        rho := Intersection( Filtered( rand, x->IsList( x ) ) );
    fi;
    if i = 0 or i = n then
        for j in [2,4..Length( rand ) - 1] do
            rand[j] := mu( [ tau, rho, rand[j-1], rand[j+1] ] )( rand[j] );
        od;
        return rand;
    fi;
    rand := rand{Difference( [1..Length( rand )],[2*i+1,2*i+2] )};
    rho := Intersection( Filtered( rand, x->IsList( x ) ) );
    for j in [2,4..Length( rand ) - 1] do
        if j = 2*i then
            rand[j] := mu( [ tau, rho, L[j-1], L[j+1] ] )( L[j] ) * mu( [ tau, rho, L[j+1], L[j+3] ] )( L[j+2] );
        else
            rand[j] := mu( [ tau, rho, rand[j-1], rand[j+1] ] )( rand[j] );
        fi;
    od;
    return rand;
end );

##
##
InstallMethod( CreateCohomologyMatrix, "for an internal ring",
        [ IsOrbifoldTriangulation, IsSimplicialSet, IsHomalgInternalRingRep ],
  function( ot, s, R )
    local d, S, matrices, k, m, p, i, ind;
    d := Dimension( s );
    S := s!.simplicial_set;
    matrices := [];
    matrices[1] := NullMat( 1, Length( S[1] ) );
    for k in [2..Dimension( s )] do
        if Length( S[k] ) = 0 then
            matrices[k] := NullMat( Length( S[k-1] ), 1 );
        else
            matrices[k] := NullMat( Length( S[k-1] ), Length( S[k] ) );
            for p in [1..Length( S[k] )] do
                for i in [0..k] do
                    ind := PositionSet( S[k-1], BoundaryOperator( i, S[k][p], ot!.mu ) );
                    if not ind = fail then
                        matrices[k][ind][p] := matrices[k][ind][p] + MinusOne( R )^i;
                    fi;
                od;
            od;
        fi;
    od;
    return List( matrices, m->HomalgMatrix( m, R ) );
end );

##
InstallMethod( CreateHomologyMatrix, "for any ring",
        [ IsOrbifoldTriangulation, IsSimplicialSet, IsHomalgRing ],
  function( ot, s, R )
    return List( CreateCohomologyMatrix( ot, s, R ), m->Involution( m ) );    
end);

##
InstallMethod( CreateCohomologyMatrix, "for an external ring",
        [ IsOrbifoldTriangulation, IsSimplicialSet, IsHomalgExternalRingRep ],
  function( ot, s, R )
    local internal_ring;
    internal_ring := HomalgRingOfIntegers();    # FIXME ?
    return List( CreateCohomologyMatrix( ot, s, internal_ring ), function(m) SetExtractHomalgMatrixToFile( m, true ); return HomalgMatrix( m, R ); end );    
end );
