##  <#GAPDoc Label="TateResolution:example1">
##  <Example><![CDATA[
##  gap> R := HomalgFieldOfRationalsInDefaultCAS( ) * "x0..x3";;
##  gap> S := GradedRing( R );;
##  gap> A := KoszulDualRing( S, "e0..e3" );;
##  ]]></Example>
##  <#/GAPDoc>

LoadPackage( "GradedModules" );
R := HomalgFieldOfRationalsInDefaultCAS( ) * "x0..x3";;
S := GradedRing( R );;
A := KoszulDualRing( S );;

##  <#GAPDoc Label="TateResolution:example2">
##  <Example><![CDATA[
##  gap> O := S^0;
##  <The graded free left module of rank 1 on a free generator>
##  gap> T := TateResolution( O, -5, 5 );
##  <An acyclic cocomplex containing
##  10 morphisms of graded left modules at degrees [ -5 .. 5 ]>
##  gap> betti := BettiDiagram( T );
##  <A Betti diagram of <An acyclic cocomplex containing 
##  10 morphisms of graded left modules at degrees [ -5 .. 5 ]>>
##  gap> Display( betti );
##  total:   35  20  10   4   1   1   4  10  20  35  56   ?   ?   ?
##  ----------|---|---|---|---|---|---|---|---|---|---|---|---|---|
##      3:   35  20  10   4   1   .   .   .   .   .   .   0   0   0
##      2:    *   .   .   .   .   .   .   .   .   .   .   .   0   0
##      1:    *   *   .   .   .   .   .   .   .   .   .   .   .   0
##      0:    *   *   *   .   .   .   .   .   1   4  10  20  35  56
##  ----------|---|---|---|---|---|---|---|---S---|---|---|---|---|
##  twist:   -8  -7  -6  -5  -4  -3  -2  -1   0   1   2   3   4   5
##  ---------------------------------------------------------------
##  Euler:  -35 -20 -10  -4  -1   0   0   0   1   4  10  20  35  56
##  ]]></Example>
##  <#/GAPDoc>

O := S^0;
T := TateResolution( O, -5, 5 );
betti := BettiDiagram( T );
Display( betti );

##  <#GAPDoc Label="TateResolution:example3">
##  <Example><![CDATA[
##  gap> k := HomalgMatrix( Indeterminates( S ), Length( Indeterminates( S ) ), 1, S );
##  <A 4 x 1 matrix over a graded ring>
##  gap> k := LeftPresentationWithDegrees( k );
##  <A graded cyclic left module presented by 4 relations for a cyclic generator>
##  ]]></Example>
##  <#/GAPDoc>

k := HomalgMatrix( Indeterminates( S ), Length( Indeterminates( S ) ), 1, S );
k := LeftPresentationWithDegrees( k );

##  <#GAPDoc Label="TateResolution:example4">
##  <Example><![CDATA[
##  gap> U0 := SyzygiesObject( 1, k );
##  <A graded torsion-free left module presented by yet unknown relations for 4 ge\
##  nerators>
##  gap> T0 := TateResolution( U0, -5, 5 );
## <An acyclic cocomplex containing
## 10 morphisms of graded left modules at degrees [ -5 .. 5 ]>
##  gap> betti0 := BettiDiagram( T0 );
##  <A Betti diagram of <An acyclic cocomplex containing 
##  10 morphisms of graded left modules at degrees [ -5 .. 5 ]>>
##  gap> Display( betti0 );
##  total:   35  20  10   4   1   1   4  10  20  35  56   ?   ?   ?
##  ----------|---|---|---|---|---|---|---|---|---|---|---|---|---|
##      3:   35  20  10   4   1   .   .   .   .   .   .   0   0   0
##      2:    *   .   .   .   .   .   .   .   .   .   .   .   0   0
##      1:    *   *   .   .   .   .   .   .   .   .   .   .   .   0
##      0:    *   *   *   .   .   .   .   .   1   4  10  20  35  56
##  ----------|---|---|---|---|---|---|---|---S---|---|---|---|---|
##  twist:   -8  -7  -6  -5  -4  -3  -2  -1   0   1   2   3   4   5
##  ---------------------------------------------------------------
##  Euler:  -35 -20 -10  -4  -1   0   0   0   1   4  10  20  35  56
##  ]]></Example>
##  <#/GAPDoc>

U0 := SyzygiesObject( 1, k );
T0 := TateResolution( U0, -5, 5 );
betti0 := BettiDiagram( T0 );
Display( betti0 );

##  <#GAPDoc Label="TateResolution:example5">
##  <Example><![CDATA[
##  gap> cotangent := SyzygiesObject( 2, k );
##  <A graded torsion-free left module presented by yet unknown relations for 6 ge\
##  nerators>
##  gap> IsFree( UnderlyingModule( cotangent ) );
##  false
##  gap> Rank( cotangent );
##  3
##  gap> cotangent;
##  <A graded reflexive non-projective rank 3 left module presented by 4 relations\
##   for 6 generators>
##  gap> ProjectiveDimension( UnderlyingModule( cotangent ) );
##  2
##  ]]></Example>
##  <#/GAPDoc>

cotangent := SyzygiesObject( 2, k );
IsFree( UnderlyingModule( cotangent ) );
Rank( cotangent );
cotangent;
ProjectiveDimension( UnderlyingModule( cotangent ) );

##  <#GAPDoc Label="TateResolution:example6">
##  <Example><![CDATA[
##  gap> U1 := cotangent * S^1;
##  <A graded non-torsion left module presented by 4 relations for 6 generators>
##  gap> T1 := TateResolution( U1, -5, 5 );
##  <An acyclic cocomplex containing
##  10 morphisms of graded left modules at degrees [ -5 .. 5 ]>
##  gap> betti1 := BettiDiagram( T1 );
##  <A Betti diagram of <An acyclic cocomplex containing 
##  10 morphisms of graded left modules at degrees [ -5 .. 5 ]>>
##  gap> Display( betti1 );
##  total:   120   70   36   15    4    1    6   20   45   84  140    ?    ?    ?
##  -----------|----|----|----|----|----|----|----|----|----|----|----|----|----|
##      3:   120   70   36   15    4    .    .    .    .    .    .    0    0    0
##      2:     *    .    .    .    .    .    .    .    .    .    .    .    0    0
##      1:     *    *    .    .    .    .    .    1    .    .    .    .    .    0
##      0:     *    *    *    .    .    .    .    .    .    6   20   45   84  140
##  -----------|----|----|----|----|----|----|----|----|----S----|----|----|----|
##  twist:    -8   -7   -6   -5   -4   -3   -2   -1    0    1    2    3    4    5
##  -----------------------------------------------------------------------------
##  Euler:  -120  -70  -36  -15   -4    0    0   -1    0    6   20   45   84  140
##  ]]></Example>
##  <#/GAPDoc>

U1 := cotangent * S^1;
T1 := TateResolution( U1, -5, 5 );
betti1 := BettiDiagram( T1 );
Display( betti1 );

##  <#GAPDoc Label="TateResolution:example7">
##  <Example><![CDATA[
##  gap> U2 := SyzygiesObject( 3, k ) * S^2;
##  <A graded rank 3 left module presented by 1 relation for 4 generators>
##  gap> T2 := TateResolution( U2, -5, 5 );
##  <An acyclic cocomplex containing
##  10 morphisms of graded left modules at degrees [ -5 .. 5 ]>
##  gap> betti2 := BettiDiagram( T2 );
##  <A Betti diagram of <An acyclic cocomplex containing 
##  10 morphisms of graded left modules at degrees [ -5 .. 5 ]>>
##  gap> Display( betti2 );
##  total:   140   84   45   20    6    1    4   15   36   70  120    ?    ?    ?
##  -----------|----|----|----|----|----|----|----|----|----|----|----|----|----|
##      3:   140   84   45   20    6    .    .    .    .    .    .    0    0    0
##      2:     *    .    .    .    .    .    1    .    .    .    .    .    0    0
##      1:     *    *    .    .    .    .    .    .    .    .    .    .    .    0
##      0:     *    *    *    .    .    .    .    .    .    4   15   36   70  120
##  -----------|----|----|----|----|----|----|----|----|----S----|----|----|----|
##  twist:    -8   -7   -6   -5   -4   -3   -2   -1    0    1    2    3    4    5
##  -----------------------------------------------------------------------------
##  Euler:  -140  -84  -45  -20   -6    0    1    0    0    4   15   36   70  120
##  ]]></Example>
##  <#/GAPDoc>

U2 := SyzygiesObject( 3, k ) * S^2;
T2 := TateResolution( U2, -5, 5 );
betti2 := BettiDiagram( T2 );
Display( betti2 );

##  <#GAPDoc Label="TateResolution:example8">
##  <Example><![CDATA[
##  gap> U3 := SyzygiesObject( 4, k ) * S^3;
##  <A graded free left module of rank 1 on a free generator>
##  gap> Display( U3 );
##  Q[x0,x1,x2,x3]^(1 x 1)
##  
##  (graded, degree of generator: 1)
##  gap> T3 := TateResolution( U3, -5, 5 );
##  <An acyclic cocomplex containing
##  10 morphisms of graded left modules at degrees [ -5 .. 5 ]>
##  gap> betti3 := BettiDiagram( T3 );
##  <A Betti diagram of <An acyclic cocomplex containing 
##  10 morphisms of graded left modules at degrees [ -5 .. 5 ]>>
##  gap> Display( betti3 );
##  total:   56  35  20  10   4   1   1   4  10  20  35   ?   ?   ?
##  ----------|---|---|---|---|---|---|---|---|---|---|---|---|---|
##      3:   56  35  20  10   4   1   .   .   .   .   .   0   0   0
##      2:    *   .   .   .   .   .   .   .   .   .   .   .   0   0
##      1:    *   *   .   .   .   .   .   .   .   .   .   .   .   0
##      0:    *   *   *   .   .   .   .   .   .   1   4  10  20  35
##  ----------|---|---|---|---|---|---|---|---|---S---|---|---|---|
##  twist:   -8  -7  -6  -5  -4  -3  -2  -1   0   1   2   3   4   5
##  ---------------------------------------------------------------
##  Euler:  -56 -35 -20 -10  -4  -1   0   0   0   1   4  10  20  35
##  ]]></Example>
##  <#/GAPDoc>

U3 := SyzygiesObject( 4, k ) * S^3;
Display( U3 );
T3 := TateResolution( U3, -5, 5 );
betti3 := BettiDiagram( T3 );
Display( betti3 );

##  <#GAPDoc Label="TateResolution:example9">
##  <Example><![CDATA[
##  gap> u2 := GradedHom( U1, S^(-1) );
##  <A graded torsion-free right module on 4 generators satisfying yet unknown rel\
##  ations>
##  gap> t2 := TateResolution( u2, -5, 5 );
##  <An acyclic cocomplex containing
##  10 morphisms of graded right modules at degrees [ -5 .. 5 ]>
##  gap> BettiDiagram( t2 );
##  <A Betti diagram of <An acyclic cocomplex containing 
##  10 morphisms of graded right modules at degrees [ -5 .. 5 ]>>
##  gap> Display( last );
##  total:   140   84   45   20    6    1    4   15   36   70  120    ?    ?    ?
##  -----------|----|----|----|----|----|----|----|----|----|----|----|----|----|
##      3:   140   84   45   20    6    .    .    .    .    .    .    0    0    0
##      2:     *    .    .    .    .    .    1    .    .    .    .    .    0    0
##      1:     *    *    .    .    .    .    .    .    .    .    .    .    .    0
##      0:     *    *    *    .    .    .    .    .    .    4   15   36   70  120
##  -----------|----|----|----|----|----|----|----|----|----S----|----|----|----|
##  twist:    -8   -7   -6   -5   -4   -3   -2   -1    0    1    2    3    4    5
##  -----------------------------------------------------------------------------
##  Euler:  -140  -84  -45  -20   -6    0    1    0    0    4   15   36   70  120
##  ]]></Example>
##  <#/GAPDoc>

u2 := GradedHom( U1, S^(-1) );
t2 := TateResolution( u2, -5, 5 );
b2 := BettiDiagram( t2 );
Display( b2 );
