# gap> LoadPackage( "ToricVarieties" );
# true
# gap> P18:=Polytope( [[0,0],[1,0],[0,1],[8,1]] );
# <A polytope in |R^2>
# gap> H7 :=ToricVariety(P18);
# <A projective toric variety of dimension 2>
# gap> StructureDescription( H7 );
# polymake: used package cddlib
#   Implementation of the double description method of Motzkin et al.
#   Copyright by Komei Fukuda.
#   http://www.ifor.math.ethz.ch/~fukuda/cdd_home/cdd.html
# 
# "H_7"
# gap> CoordinateRingOfTorus( H7, "x" );
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
# gap> ProjectiveEmbedding( H7 );
# [ |[ 1 ]|, |[ x2 ]|, |[ x1 ]|, |[ x1*x2 ]|, |[ x1^2*x2 ]|, |[ x1^3*x2 ]|, |[ x1^4*x2 ]|, |[ x1^5*x2 ]|, |[ x1^6*x2 ]|, |[ x1^7*x2 ]|, |[ x1^8*x2 ]| ]
# gap> M:=MaximalCones(Fan(H7));
# [ <A cone in |R^2 with 2 ray generators>, <A cone in |R^2 with 2 ray generators>, <A cone in |R^2 with 2 ray generators>, <A cone in |R^2 with 2 ray generators> ]
# gap> C1:=M[1];
# <A cone in |R^2 with 2 ray generators>
# gap> OC1:=ClosureOfTorusOrbitOfCone(H7,C1);
# polymake:  WARNING: rule _4ti2.hilbert: HILBERT_BASIS : CONE_AMBIENT_DIM , FACETS | INEQUALITIES failed: couldn't run 4ti2: hilbert -q /tmp/poly5076Taaaa0001
# polymake: used package normaliz2
#   Normaliz is a tool for computations in affine monoids, vector configurations, lattice polytopes, and rational cones.
#   Copyright by Winfried Bruns, Bogdan Ichim, Christof Soeger.
#   http://www.math.uos.de/normaliz/
# 
# <A toric subvariety of dimension 0>
# gap> StructureDescription(OC1);
# "A^0"
# gap> C2:=Intersect(M[1],M[2]);
# <A ray in |R^2>
# gap> OC2:=ClosureOfTorusOrbitOfCone(H7,C2);
# polymake:  WARNING: rule _4ti2.hilbert: HILBERT_BASIS : CONE_AMBIENT_DIM , FACETS | INEQUALITIES failed: couldn't run 4ti2: hilbert -q /tmp/poly5076Taaaa0003
# <A toric subvariety of dimension 1>
# gap> StructureDescription(OC2);
# "P^1"


LoadPackage( "ToricVarieties" );
P18:=Polytope( [[0,0],[1,0],[0,1],[8,1]] );
H7 :=ToricVariety(P18);
StructureDescription( H7 );
CoordinateRingOfTorus( H7, "x" );
ProjectiveEmbedding( H7 );
M:=MaximalCones(Fan(H7));
C1:=M[1];
OC1:=ClosureOfTorusOrbitOfCone(H7,C1);
StructureDescription(OC1);
C2:=Intersect(M[1],M[2]);
OC2:=ClosureOfTorusOrbitOfCone(H7,C2);
StructureDescription(OC2);