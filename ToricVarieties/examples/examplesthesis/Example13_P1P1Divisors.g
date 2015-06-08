gap> LoadPackage( "ToricVarieties" );
true
gap> P1 := Fan( [[[1]],[[-1]]] );
<A fan in |R^1>
gap> P1 := ToricVariety( P1 );
polymake: used package cddlib
  Implementation of the double description method of Motzkin et al.
  Copyright by Komei Fukuda.
  http://www.ifor.math.ethz.ch/~fukuda/cdd_home/cdd.html

<A toric variety of dimension 1>
gap> P1P1 := P1*P1;
<A toric variety of dimension 2 which is a product of 2 toric varieties>
gap> ClassGroup(P1P1);
<A non-torsion left module presented by 2 relations for 4 generators>
gap> Display(last);
[ [   1,  -1,   0,   0 ],
  [   0,   0,   1,  -1 ] ]

Cokernel of the map

Z^(1x2) --> Z^(1x4),

currently represented by the above matrix
gap> D:=Divisor([1,0,1,0],P1P1);
<A divisor of a toric variety with coordinates [ 1, 0, 1, 0 ]>
gap> ClassOfDivisor(D);
[ 0, 1, 0, 1 ]
gap> IsBasepointFree(D);
true
gap> IsAmple(D);
true
gap> Polytope(D);
<A polytope in |R^2>
gap> IsVeryAmple(D);
true
gap> CoordinateRingOfTorus(P1P1,"x");
----------------------------------------------------------------
Loading  IO_ForHomalg 2011.07.25
by Thomas Bächler (http://wwwb.math.rwth-aachen.de/~thomas/)
   Mohamed Barakat (http://www.mathematik.uni-kl.de/~barakat/)
   Max Neunhöffer (http://www-groups.mcs.st-and.ac.uk/~neunhoef/)
   Daniel Robertz (http://wwwb.math.rwth-aachen.de/~daniel/)
For help, type: ?IO_ForHomalg package 
----------------------------------------------------------------
================================================================
                     SINGULAR                                 /
 A Computer Algebra System for Polynomial Computations       /   version 3-1-3
                                                           0<
 by: W. Decker, G.-M. Greuel, G. Pfister, H. Schoenemann     \   March 2011
FB Mathematik der Universitaet, D-67653 Kaiserslautern        \
================================================================
Q[x1,x1_,x2,x2_]/( x2*x2_-1, x1*x1_-1 )
gap> CharactersForClosedEmbedding(D);
[ |[ x1_*x2_ ]|, |[ x1_ ]|, |[ x2_ ]|, |[ 1 ]| ]
gap> CoxRingOfTargetOfDivisorMorphism(D);
Q[x_1,x_2,x_3,x_4]
(weights: [ 1, 1, 1, 1 ])
gap> RingMorphismOfDivisor(D);
<A "homomorphism" of rings>
gap> Display(last);
Q[x_1,x_2,x_3,x_4]
(weights: [ [ 0, 1, 0, 0 ], [ 0, 1, 0, 0 ], [ 0, 0, 0, 1 ], [ 0, 0, 0, 1 ] ])
  ^
  |
[ x_2*x_4, x_2*x_3, x_1*x_4, x_1*x_3 ]
  |
  |
Q[x_1,x_2,x_3,x_4]
(weights: [ 1, 1, 1, 1 ])
gap> ClassOfDivisor(D);
[ 0, 1, 0, 1 ]
gap> ByASmallerPresentation(ClassGroup(P1P1));
<A free left module of rank 2 on free generators>
gap> ClassOfDivisor(D);
[ 1, 1 ]
gap> RingMorphismOfDivisor(D);
<A "homomorphism" of rings>
gap> Display(last);
Q[x_1,x_2,x_3,x_4]
(weights: [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
  ^
  |
[ x_2*x_4, x_2*x_3, x_1*x_4, x_1*x_3 ]
  |
  |
Q[x_1,x_2,x_3,x_4]
(weights: [ 1, 1, 1, 1 ])
gap> P:=TorusInvariantPrimeDivisors(P1P1);
[ <A prime divisor of a toric variety with coordinates [ 1, 0, 0, 0 ]>, <A prime divisor of a toric variety with coordinates [ 0, 1, 0, 0 ]>, 
  <A prime divisor of a toric variety with coordinates [ 0, 0, 1, 0 ]>, <A prime divisor of a toric variety with coordinates [ 0, 0, 0, 1 ]> ]
gap> D2 := 2*Sum(P);
<A divisor of a toric variety with coordinates [ 2, 2, 2, 2 ]>
gap> ClassOfDivisor(D2);
[ 4, 4 ]
gap> Polytope(D2);
<A polytope in |R^2>
gap> IsAmple(D2);
true
gap> IsVeryAmple(D2);
true
gap> RingMorphismOfDivisor(D2);
<A "homomorphism" of rings>
gap> Display(last);
Q[x_1,x_2,x_3,x_4]
(weights: [ [ 1, 0 ], [ 1, 0 ], [ 0, 1 ], [ 0, 1 ] ])
  ^
  |
[ x_2^4*x_4^4, x_2^4*x_3*x_4^3, x_2^4*x_3^2*x_4^2, x_2^4*x_3^3*x_4, x_2^4*x_3^4, x_1*x_2^3*x_4^4, x_1*x_2^3*x_3*x_4^3, x_1*x_2^3*x_3^2*x_4^2, x_1*x_2^3*x_3^3*x_4, 
  x_1*x_2^3*x_3^4, x_1^2*x_2^2*x_4^4, x_1^2*x_2^2*x_3*x_4^3, x_1^2*x_2^2*x_3^2*x_4^2, x_1^2*x_2^2*x_3^3*x_4, x_1^2*x_2^2*x_3^4, x_1^3*x_2*x_4^4, x_1^3*x_2*x_3*x_4^3, 
  x_1^3*x_2*x_3^2*x_4^2, x_1^3*x_2*x_3^3*x_4, x_1^3*x_2*x_3^4, x_1^4*x_4^4, x_1^4*x_3*x_4^3, x_1^4*x_3^2*x_4^2, x_1^4*x_3^3*x_4, x_1^4*x_3^4 ]
  |
  |
Q[x_1,x_2,x_3,x_4,x_5,x_6,x_7,x_8,x_9,x_10,x_11,x_12,x_13,x_14,x_15,x_16,x_17,x_18,x_19,x_20,x_21,x_22,x_23,x_24,x_25]
(weights: [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ])


LoadPackage( "ToricVarieties" );
P1 := Fan( [[[1]],[[-1]]] );
P1 := ToricVariety( P1 );
P1P1 := P1*P1;
ClassGroup(P1P1);
Display(last);
D:=Divisor([1,0,1,0],P1P1);
ClassOfDivisor(D);
IsBasepointFree(D);
IsAmple(D);
Polytope(D);
IsVeryAmple(D);
CoordinateRingOfTorus(P1P1,"x");
CharactersForClosedEmbedding(D);
CoxRingOfTargetOfDivisorMorphism(D);
RingMorphismOfDivisor(D);
Display(last);
ClassOfDivisor(D);
ByASmallerPresentation(ClassGroup(P1P1));
ClassOfDivisor(D);
RingMorphismOfDivisor(D);
Display(last);
P:=TorusInvariantPrimeDivisors(P1P1);
D2 := 2*Sum(P);
ClassOfDivisor(D2);
Polytope(D2);
IsAmple(D2);
IsVeryAmple(D2);
RingMorphismOfDivisor(D2);
Display(last);
