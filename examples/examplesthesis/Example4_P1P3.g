# gap> LoadPackage( "ToricVarieties" );
# true
# gap> P1 := Polytope( [[0],[1]] );
# <A polytope in |R^1>
# gap> P3 := Polytope( [[0,0,0],[1,0,0],[0,1,0],[0,0,1]] );
# <A polytope in |R^3>
# gap> P1 := ToricVariety( P1 );
# <A projective toric variety of dimension 1>
# gap> P3 := ToricVariety( P3 );
# <A projective toric variety of dimension 3>
# gap> P1P3 := P1*P3;
# <A projective toric variety of dimension 4 which is a product of 2 toric varieties>
# gap> CoordinateRingOfTorus(P1P3,["x","y1","y2","y3"]);
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
# Q[x,x_,y1,y1_,y2,y2_,y3,y3_]/( y3*y3_-1, y2*y2_-1, y1*y1_-1, x*x_-1 )
# gap> Polytope(P1P3);
# polymake: used package cddlib
#   Implementation of the double description method of Motzkin et al.
#   Copyright by Komei Fukuda.
#   http://www.ifor.math.ethz.ch/~fukuda/cdd_home/cdd.html
# 
# <A polytope in |R^4>
# gap> ProjectiveEmbedding(P1P3);
# [ |[ 1 ]|, |[ y3 ]|, |[ y2 ]|, |[ y1 ]|, |[ x ]|, |[ x*y3 ]|, |[ x*y2 ]|, |[ x*y1 ]| ]
# gap> T:=ToricMorphism(P1P3,[[1],[0],[0],[0]],P1);
# <A "homomorphism" of right objects>
# gap> IsMorphism(T);
# true
# gap> T;
# <A homomorphism of right objects>
# gap> T2:=ToricMorphism(P1P3,[[0],[0],[1],[0]],P1);
# <A "homomorphism" of right objects>
# gap> IsMorphism(T2);
# false
# gap> T2;
# <A non-well-defined map between right objects>


LoadPackage( "ToricVarieties" );
P1 := Polytope( [[0],[1]] );
P3 := Polytope( [[0,0,0],[1,0,0],[0,1,0],[0,0,1]] );
P1 := ToricVariety( P1 );
P3 := ToricVariety( P3 );
P1P3 := P1*P3;
CoordinateRingOfTorus(P1P3,["x","y1","y2","y3"]);
Polytope(P1P3);
ProjectiveEmbedding(P1P3);
T:=ToricMorphism(P1P3,[[1],[0],[0],[0]],P1);
IsMorphism(T);
T;
T2:=ToricMorphism(P1P3,[[0],[0],[1],[0]],P1);
IsMorphism(T2);
T2;
