# gap> LoadPackage( "ToricVarieties" );
# true
# gap> C:=Cone( [[1,0,0],[0,1,0],[0,0,1]] );
# <A cone in |R^3>
# gap> C3:=ToricVariety(C);
# polymake: used package cddlib
#   Implementation of the double description method of Motzkin et al.
#   Copyright by Komei Fukuda.
#   http://www.ifor.math.ethz.ch/~fukuda/cdd_home/cdd.html
# 
# <An affine normal toric variety of dimension 3>
# gap> Dimension(C3);
# 3
# gap> IsOrbifold(C3);
# true
# gap> IsSmooth(C3);
# true
# gap> CoordinateRingOfTorus(C3,"x");
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
# Q[x1,x1_,x2,x2_,x3,x3_]/( x3*x3_-1, x2*x2_-1, x1*x1_-1 )
# gap> CoordinateRing(C3,"x");
# polymake: used package normaliz2
#   Normaliz is a tool for computations in affine monoids, vector configurations, lattice polytopes, and rational cones.
#   Copyright by Winfried Bruns, Bogdan Ichim, Christof Soeger.
#   http://www.math.uos.de/normaliz/
# 
# Q[x_1,x_2,x_3]
# gap> MorphismFromCoordinateRingToCoordinateRingOfTorus(C3);
# <A monomorphism of rings>
# gap> Display(last);
# Q[x1,x1_,x2,x2_,x3,x3_]/( x3*x3_-1, x2*x2_-1, x1*x1_-1 )
#   ^
#   |
# [ |[ x3 ]|, |[ x2 ]|, |[ x1 ]| ]
#   |
#   |
# Q[x_1,x_2,x_3]
# gap> C3;
# <An affine normal smooth toric variety of dimension 3>
# gap> StructureDescription(C3);
# "A^3"


LoadPackage( "ToricVarieties" );
C:=Cone( [[1,0,0],[0,1,0],[0,0,1]] );
C3:=ToricVariety(C);
Dimension(C3);
IsOrbifold(C3);
IsSmooth(C3);
CoordinateRingOfTorus(C3,"x");
CoordinateRing(C3,"x");
MorphismFromCoordinateRingToCoordinateRingOfTorus(C3);
Display(last);
C3;
StructureDescription(C3);