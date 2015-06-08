# gap> LoadPackage( "ToricVarieties" );
# true
# gap> H7 := Fan( [[0,1],[1,0],[0,-1],[-1,7]],[[1,2],[2,3],[3,4],[4,1]] );
# <A fan in |R^2>
# gap> H7 := ToricVariety( H7 );
# polymake: used package cddlib
#   Implementation of the double description method of Motzkin et al.
#   Copyright by Komei Fukuda.
#   http://www.ifor.math.ethz.ch/~fukuda/cdd_home/cdd.html
# 
# <A toric variety of dimension 2>
# gap> P := TorusInvariantPrimeDivisors( H7 );
# [ <A prime divisor of a toric variety with coordinates [ 1, 0, 0, 0 ]>, <A prime divisor of a toric variety with coordinates [ 0, 1, 0, 0 ]>, 
#   <A prime divisor of a toric variety with coordinates [ 0, 0, 1, 0 ]>, <A prime divisor of a toric variety with coordinates [ 0, 0, 0, 1 ]> ]
# gap> D := P[3]+P[4];
# <A divisor of a toric variety with coordinates [ 0, 0, 1, 1 ]>
# gap> IsBasepointFree(D);
# true
# gap> IsAmple(D);
# true
# gap> CoordinateRingOfTorus(H7,"x");
# ----------------------------------------------------------------
# Loading  IO_ForHomalg 2011.07.25
# by Thomas Bächler (http://wwwb.math.rwth-aachen.de/~thomas/)
#    Mohamed Barakat (http://www.mathematik.uni-kl.de/~barakat/)
#    Max Neunhöffer (http://www-groups.mcs.st-and.ac.uk/~neunhoef/)
#    Daniel Robertz (http://wwwb.math.rwth-aachen.de/~daniel/)
# For help, type: ?IO_ForHomalg package 
# ----------------------------------------------------------------
# ================================================================
#                      SINGULAR                                 /
#  A Computer Algebra System for Polynomial Computations       /   version 3-1-3
#                                                            0<
#  by: W. Decker, G.-M. Greuel, G. Pfister, H. Schoenemann     \   March 2011
# FB Mathematik der Universitaet, D-67653 Kaiserslautern        \
# ================================================================
# Q[x1,x1_,x2,x2_]/( x2*x2_-1, x1*x1_-1 )
# gap> Polytope(D);
# <A polytope in |R^2>
# gap> CharactersForClosedEmbedding(D);
# [ |[ 1 ]|, |[ x2 ]|, |[ x1 ]|, |[ x1*x2 ]|, |[ x1^2*x2 ]|, |[ x1^3*x2 ]|, |[ x1^4*x2 ]|, |[ x1^5*x2 ]|, |[ x1^6*x2 ]|, |[ x1^7*x2 ]|, |[ x1^8*x2 ]| ]
# gap> CoxRingOfTargetOfDivisorMorphism(D);
# Q[x_1,x_2,x_3,x_4,x_5,x_6,x_7,x_8,x_9,x_10,x_11]
# (weights: [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ])
# gap> RingMorphismOfDivisor(D);
# <A "homomorphism" of rings>
# gap> Display(last);
# Q[x_1,x_2,x_3,x_4]
# (weights: [ [ 0, 0, 1, -7 ], [ 0, 0, 0, 1 ], [ 0, 0, 1, 0 ], [ 0, 0, 0, 1 ] ])
#   ^
#   |
# [ x_3*x_4, x_1*x_4^8, x_2*x_3, x_1*x_2*x_4^7, x_1*x_2^2*x_4^6, x_1*x_2^3*x_4^5, x_1*x_2^4*x_4^4, x_1*x_2^5*x_4^3, x_1*x_2^6*x_4^2, x_1*x_2^7*x_4, x_1*x_2^8 ]
#   |
#   |
# Q[x_1,x_2,x_3,x_4,x_5,x_6,x_7,x_8,x_9,x_10,x_11]
# (weights: [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ])
# gap> ByASmallerPresentation(ClassGroup(H7));
# <A free left module of rank 2 on free generators>
# gap> Display(RingMorphismOfDivisor(D));
# Q[x_1,x_2,x_3,x_4]
# (weights: [ [ 1, -7 ], [ 0, 1 ], [ 1, 0 ], [ 0, 1 ] ])
#   ^
#   |
# [ x_3*x_4, x_1*x_4^8, x_2*x_3, x_1*x_2*x_4^7, x_1*x_2^2*x_4^6, x_1*x_2^3*x_4^5, x_1*x_2^4*x_4^4, x_1*x_2^5*x_4^3, x_1*x_2^6*x_4^2, x_1*x_2^7*x_4, x_1*x_2^8 ]
#   |
#   |
# Q[x_1,x_2,x_3,x_4,x_5,x_6,x_7,x_8,x_9,x_10,x_11]
# (weights: [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ])
# gap> MonomsOfCoxRingOfDegree(D);
# [ x_3*x_4, x_1*x_4^8, x_2*x_3, x_1*x_2*x_4^7, x_1*x_2^2*x_4^6, x_1*x_2^3*x_4^5, x_1*x_2^4*x_4^4, x_1*x_2^5*x_4^3, x_1*x_2^6*x_4^2, x_1*x_2^7*x_4, x_1*x_2^8 ]
# gap> D2:=D-2*P[2];
# <A divisor of a toric variety with coordinates [ 0, -2, 1, 1 ]>
# gap> IsBasepointFree(D2);
# false
# gap> IsAmple(D2);
# false

LoadPackage( "ToricVarieties" );
H7 := Fan( [[0,1],[1,0],[0,-1],[-1,7]],[[1,2],[2,3],[3,4],[4,1]] );
H7 := ToricVariety( H7 );
P := TorusInvariantPrimeDivisors( H7 );
D := P[3]+P[4];
IsBasepointFree(D);
IsAmple(D);
CoordinateRingOfTorus(H7,"x");
Polytope(D);
CharactersForClosedEmbedding(D);
CoxRingOfTargetOfDivisorMorphism(D);
RingMorphismOfDivisor(D);
Display(last);
ByASmallerPresentation(ClassGroup(H7));
Display(RingMorphismOfDivisor(D));
MonomsOfCoxRingOfDegree(D);
D2:=D-2*P[2];
IsBasepointFree(D2);
IsAmple(D2);