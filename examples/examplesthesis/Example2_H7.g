# gap> LoadPackage( "ToricVarieties" );
# true
# gap> SIGMA := Fan( [[[1,0],[0,1]],[[1,0],[0,-1]],[[-1,7],[0,1]],[[-1,7],[0,-1]]] );
# <A fan in |R^2>
# gap> H7 :=ToricVariety(SIGMA);
# polymake: used package cddlib
#   Implementation of the double description method of Motzkin et al.
#   Copyright by Komei Fukuda.
#   http://www.ifor.math.ethz.ch/~fukuda/cdd_home/cdd.html
# 
# <A toric variety of dimension 2>
# gap> IsAffine(H7);
# false
# gap> IsComplete(H7);
# true
# gap> IsSmooth(H7);
# true
# gap> IsOrbifold(H7);
# true
# gap> HasTorusfactor(H7);
# false
# gap> HasNoTorusfactor(H7);
# true
# gap> IsProjective(H7);
# true
# gap> StructureDescription(H7);
# "H_7"

LoadPackage( "ToricVarieties" );
SIGMA := Fan( [[[1,0],[0,1]],[[1,0],[0,-1]],[[-1,7],[0,1]],[[-1,7],[0,-1]]] );
H7 :=ToricVariety(SIGMA);
IsAffine(H7);
IsComplete(H7);
IsSmooth(H7);
IsOrbifold(H7);
HasTorusfactor(H7);
HasNoTorusfactor(H7);
IsProjective(H7);
StructureDescription(H7);
