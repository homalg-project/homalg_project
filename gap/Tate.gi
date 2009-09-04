#############################################################################
##
##  Sheaves.gi                  Sheaves package              Mohamed Barakat
##
##  Copyright 2008-2009, Mohamed Barakat, Universität des Saarlandes
##
##  Implementations of procedures for the pair of adjoint Tate functors.
##
#############################################################################

####################################
#
# global variables:
#
####################################

HOMALG_IO.Pictograms.MonomialMatrix := "mon";	## create the i-th monomial matrix

####################################
#
# methods for operations:
#
####################################

##  <#GAPDoc Label="TateResolution">
##  <ManSection>
##    <Oper Arg="M, degree_lowest, degree_highest" Name="TateResolution"/>
##    <Returns>a &homalg; cocomplex</Returns>
##    <Description>
##      Compute the Tate resolution of the sheaf <A>M</A>.
##      <Example><![CDATA[
##  gap> S := HomalgFieldOfRationalsInDefaultCAS( ) * "x0,x1,x2,x3";;
##  gap> A := KoszulDualRing( S, "e0,e1,e2,e3" );;
##  ]]></Example>
##  In the following we construct the different exterior powers of the cotangent bundle
##  shifted by <M>1</M>. Observe how a single <M>1</M> travels along the diagnoal
##  in the window <M>[ -3 .. 0 ] x [ 0 .. 3 ]</M>. <Br/><Br/>
##  First we start with the structure sheaf with its Tate resolution:
##      <Example><![CDATA[
##  gap> O := S^0;
##  <The graded free left module of rank 1 on a free generator>
##  gap> T := TateResolution( O, -5, 5 );
##  <An acyclic cocomplex containing 10 morphisms of left modules at degrees 
##  [ -5 .. 5 ]>
##  gap> betti := BettiDiagram( T );
##  <A Betti diagram of <An acyclic cocomplex containing 
##  10 morphisms of left modules at degrees [ -5 .. 5 ]>>
##  gap> Display( betti );
##  total:  35 20 10  4  1  1  4 10 20 35 56  ?  ?  ?
##  ---------|--|--|--|--|--|--|--|--|--|--|--|--|--|
##      3:  35 20 10  4  1  .  .  .  .  .  .  0  0  0
##      2:   *  .  .  .  .  .  .  .  .  .  .  .  0  0
##      1:   *  *  .  .  .  .  .  .  .  .  .  .  .  0
##      0:   *  *  *  .  .  .  .  .  1  4 10 20 35 56
##  ---------|--|--|--|--|--|--|--|--V--|--|--|--|--|
##  twist:  -8 -7 -6 -5 -4 -3 -2 -1  0  1  2  3  4  5
##  -------------------------------------------------
##  Euler:   ?  ?  ? -4 -1  0  0  0  1  4 10 20 35 56
##  ]]></Example>
##  The Castelnuovo-Mumford regularity of the <E>underlying module</E> is distinguished
##  among the list of twists by the character <C>'V'</C> pointing to it. It is <E>not</E>
##  an invariant of the sheaf (see the next diagram). <Br/><Br/>
##  The residue class field (i.e. S modulo the maximal homogeneous ideal):
##      <Example><![CDATA[
##  gap> k := HomalgMatrix( Indeterminates( S ), Length( Indeterminates( S ) ), 1, S );
##  <A homalg external 4 by 1 matrix>
##  gap> k := LeftPresentationWithDegrees( k );
##  <A graded cyclic left module presented by 4 relations for a cyclic generator>
##  ]]></Example>
##  Another way of constructing the structure sheaf:
##      <Example><![CDATA[
##  gap> U0 := SyzygiesModule( 1, k );
##  <A graded left module presented by 6 relations for 4 generators>
##  gap> T0 := TateResolution( U0, -5, 5 );
##  <An acyclic cocomplex containing 10 morphisms of left modules at degrees 
##  [ -5 .. 5 ]>
##  gap> betti0 := BettiDiagram( T0 );
##  <A Betti diagram of <An acyclic cocomplex containing 
##  10 morphisms of left modules at degrees [ -5 .. 5 ]>>
##  gap> Display( betti0 );
##  total:  35 20 10  4  1  1  4 10 20 35 56  ?  ?  ?
##  ---------|--|--|--|--|--|--|--|--|--|--|--|--|--|
##      3:  35 20 10  4  1  .  .  .  .  .  .  0  0  0
##      2:   *  .  .  .  .  .  .  .  .  .  .  .  0  0
##      1:   *  *  .  .  .  .  .  .  .  .  .  .  .  0
##      0:   *  *  *  .  .  .  .  .  1  4 10 20 35 56
##  ---------|--|--|--|--|--|--|--|--|--V--|--|--|--|
##  twist:  -8 -7 -6 -5 -4 -3 -2 -1  0  1  2  3  4  5
##  -------------------------------------------------
##  Euler:   ?  ?  ? -4 -1  0  0  0  1  4 10 20 35 56
##  ]]></Example>
##  The cotangent bundle:
##      <Example><![CDATA[
##  gap> cotangent := SyzygiesModule( 2, k );
##  <A graded non-torsion left module presented by 4 relations for 6 generators>
##  gap> IsFree( cotangent );
##  false
##  gap> Rank( cotangent );
##  3
##  gap> cotangent;
##  <A graded reflexive non-projective rank 3 left module presented by 
##  4 relations for 6 generators>
##  gap> ProjectiveDimension( cotangent );
##  2
##  ]]></Example>
##  the cotangent bundle shifted by <M>1</M> with its Tate resolution:
##      <Example><![CDATA[
##  gap> U1 := cotangent * S^1;
##  <A graded non-torsion left module presented by 4 relations for 6 generators>
##  gap> T1 := TateResolution( U1, -5, 5 );
##  <An acyclic cocomplex containing 10 morphisms of left modules at degrees 
##  [ -5 .. 5 ]>
##  gap> betti1 := BettiDiagram( T1 );
##  <A Betti diagram of <An acyclic cocomplex containing 
##  10 morphisms of left modules at degrees [ -5 .. 5 ]>>
##  gap> Display( betti1 );
##  total:  120  70  36  15   4   1   6  20  45  84 140   ?   ?   ?
##  ----------|---|---|---|---|---|---|---|---|---|---|---|---|---|
##      3:  120  70  36  15   4   .   .   .   .   .   .   0   0   0
##      2:    *   .   .   .   .   .   .   .   .   .   .   .   0   0
##      1:    *   *   .   .   .   .   .   1   .   .   .   .   .   0
##      0:    *   *   *   .   .   .   .   .   .   6  20  45  84 140
##  ----------|---|---|---|---|---|---|---|---|---V---|---|---|---|
##  twist:   -8  -7  -6  -5  -4  -3  -2  -1   0   1   2   3   4   5
##  ---------------------------------------------------------------
##  Euler:    ?   ?   ? -15  -4   0   0  -1   0   6  20  45  84 140
##  ]]></Example>
##  The second power <M>U^2</M> of the shifted cotangent bundle <M>U=U^1</M> and its Tate resolution:
##      <Example><![CDATA[
##  gap> U2 := SyzygiesModule( 3, k ) * S^2;
##  <A graded rank 3 left module presented by 1 relation for 4 generators>
##  gap> T2 := TateResolution( U2, -5, 5 );
##  <An acyclic cocomplex containing 10 morphisms of left modules at degrees 
##  [ -5 .. 5 ]>
##  gap> betti2 := BettiDiagram( T2 );
##  <A Betti diagram of <An acyclic cocomplex containing 
##  10 morphisms of left modules at degrees [ -5 .. 5 ]>>
##  gap> Display( betti2 );
##  total:  140  84  45  20   6   1   4  15  36  70 120   ?   ?   ?
##  ----------|---|---|---|---|---|---|---|---|---|---|---|---|---|
##      3:  140  84  45  20   6   .   .   .   .   .   .   0   0   0
##      2:    *   .   .   .   .   .   1   .   .   .   .   .   0   0
##      1:    *   *   .   .   .   .   .   .   .   .   .   .   .   0
##      0:    *   *   *   .   .   .   .   .   .   4  15  36  70 120
##  ----------|---|---|---|---|---|---|---|---|---V---|---|---|---|
##  twist:   -8  -7  -6  -5  -4  -3  -2  -1   0   1   2   3   4   5
##  ---------------------------------------------------------------
##  Euler:    ?   ?   ? -20  -6   0   1   0   0   4  15  36  70 120
##  ]]></Example>
##  The third power <M>U^3</M> of the shifted cotangent bundle <M>U=U^1</M> and its Tate resolution:
##      <Example><![CDATA[
##  gap> U3 := SyzygiesModule( 4, k ) * S^3;
##  <A graded free left module of rank 1 on a free generator>
##  Display( U3 );
##  Q[x0,x1,x2,x3]^(1 x 1)	(graded, generators degrees: [ 1 ])
##  gap> T3 := TateResolution( U3, -5, 5 );
##  <An acyclic cocomplex containing 10 morphisms of left modules at degrees 
##  [ -5 .. 5 ]>
##  gap> betti3 := BettiDiagram( T3 );
##  <A Betti diagram of <An acyclic cocomplex containing 
##  10 morphisms of left modules at degrees [ -5 .. 5 ]>>
##  gap> Display( betti3 );
##  total:   56  35  20  10   4   1   1   4  10  20  35   ?   ?   ?
##  ----------|---|---|---|---|---|---|---|---|---|---|---|---|---|
##      3:   56  35  20  10   4   1   .   .   .   .   .   0   0   0
##      2:    *   .   .   .   .   .   .   .   .   .   .   .   0   0
##      1:    *   *   .   .   .   .   .   .   .   .   .   .   .   0
##      0:    *   *   *   .   .   .   .   .   .   1   4  10  20  35
##  ----------|---|---|---|---|---|---|---|---|---V---|---|---|---|
##  twist:   -8  -7  -6  -5  -4  -3  -2  -1   0   1   2   3   4   5
##  ---------------------------------------------------------------
##  Euler:    ?   ?   ? -10  -4  -1   0   0   0   1   4  10  20  35
##  ]]></Example>
##  Another way to construct <M>U^2=U^(3-1)</M>:
##      <Example><![CDATA[
##  gap> u2 := Hom( U1, S^(-1) );
##  <A graded rank 3 right module on 4 generators satisfying 1 relation>
##  gap> t2 := TateResolution( u2, -5, 5 );
##  <An acyclic cocomplex containing 10 morphisms of right modules at degrees 
##  [ -5 .. 5 ]>
##  gap> BettiDiagram( t2 );
##  <A Betti diagram of <An acyclic cocomplex containing 
##  10 morphisms of right modules at degrees [ -5 .. 5 ]>>
##  gap> Display( last );
##  total:  140  84  45  20   6   1   4  15  36  70 120   ?   ?   ?
##  ----------|---|---|---|---|---|---|---|---|---|---|---|---|---|
##      3:  140  84  45  20   6   .   .   .   .   .   .   0   0   0
##      2:    *   .   .   .   .   .   1   .   .   .   .   .   0   0
##      1:    *   *   .   .   .   .   .   .   .   .   .   .   .   0
##      0:    *   *   *   .   .   .   .   .   .   4  15  36  70 120
##  ----------|---|---|---|---|---|---|---|---|---V---|---|---|---|
##  twist:   -8  -7  -6  -5  -4  -3  -2  -1   0   1   2   3   4   5
##  ---------------------------------------------------------------
##  Euler:    ?   ?   ? -20  -6   0   1   0   0   4  15  36  70 120
##  ]]></Example>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##  gap> Display(S);
##  Q[x0,x1,x2,x3]
##  gap> Display(A);
##  Q{e0,e1,e2,e3}
##  gap> Display(cotangent);
##  x1,-x2,x3,0,  0,  0, 
##  x0,0,  0, -x2,x3, 0, 
##  0, x0, 0, -x1,0,  x3,
##  0, 0,  x0,0,  -x1,x2 
##  
##  (graded, generators degrees: [ 2, 2, 2, 2, 2, 2 ])
##  
##  Cokernel of the map
##  
##  R^(1x4) --> R^(1x6), ( for R := Q[x0,x1,x2,x3] )
##  
##  currently represented by the above matrix
##
InstallMethod( TateResolution,
        "for homalg modules",
        [ IsHomalgRingOrFinitelyPresentedObjectRep, IsHomalgRing and IsExteriorRing, IsInt, IsInt ],
        
  function( _M, A, degree_lowest, degree_highest )
    local M, CM, d, tate, T, i, source, target, K, Kres;
    
    if IsHomalgRing( _M ) then
        M := HomalgFreeRightModuleWithDegrees( 1, _M );
    else
        M := _M;
    fi;
    
    CM := CastelnuovoMumfordRegularity( M );
    
    d := Maximum( CM + 1, degree_lowest );
    
    tate := RepresentationMapOfKoszulId( d, M, A );
    
    T := HomalgCocomplex( tate, d );
    
    ## above the Castelnuovo-Mumford regularity
    for i in [ d + 1 .. degree_highest - 1 ] do
        
        source := Range( tate );
        
        ## the Koszul map has linear entries by construction
        tate := RepresentationMapOfKoszulId( i, M, A );
        
        target := Range( tate );
        
        tate := MatrixOfMap( tate );
        
        tate := HomalgMap( tate, source, target );
        
        Add( T, tate );
    od;
    
    ## below the Castelnuovo-Mumford regularity
    if degree_lowest < d then
        
        tate := LowestDegreeMorphism( T );
        
        K := Kernel( tate );
        
        ## get rid of the units in the presentation of the kernel K
        ByASmallerPresentation( K );
        
        Kres := Resolution( d - degree_lowest, K );
        
        tate := PreCompose( FreeHullEpi( K ), KernelEmb( tate ) );
        
        Add( tate, T );
        
        for i in [ 1 .. d - degree_lowest - 1 ] do
            Add( CertainMorphism( Kres, i ), T );
        od;
        
    fi;
    
    ## check assertion
    Assert( 1, IsAcyclic( T ) );
    
    SetIsAcyclic( T, true );
    
    ## pass some options to the operation BettiDiagram (applied on complexes):
    
    T!.display_twist := true;
    
    ## starting from the Castelnuovo-Mumford regularity
    ## (and going right) all higher cohomologies vanish
    T!.higher_vanish := CM;
    
    return T;
    
end );

##
InstallMethod( TateResolution,
        "for homalg modules",
        [ IsHomalgRingOrFinitelyPresentedObjectRep, IsInt, IsInt ],
        
  function( M, degree_lowest, degree_highest )
    local A;
    
    A := KoszulDualRing( HomalgRing( M ) );
    
    return TateResolution( M, A, degree_lowest, degree_highest );
    
end );

