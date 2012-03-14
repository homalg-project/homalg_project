# gap> LoadPackage( "ToricVarieties" );
# true
# gap> P18:=Polytope( [[0,0],[1,0],[0,1],[8,1]] );
# <A polytope in |R^2>
# gap> H7 :=ToricVariety(P18);
# <A projective toric variety of dimension 2>
# gap> ClassGroup(H7);
# polymake: used package cddlib
#   Implementation of the double description method of Motzkin et al.
#   Copyright by Komei Fukuda.
#   http://www.ifor.math.ethz.ch/~fukuda/cdd_home/cdd.html
# 
# <A non-torsion left module presented by 2 relations for 4 generators>
# gap> Display(ByASmallerPresentation(last));
# Z^(1 x 2)
# gap> PicardGroup(H7);
# <A free left module of rank 2 on free generators>


LoadPackage( "ToricVarieties" );
P18:=Polytope( [[0,0],[1,0],[0,1],[8,1]] );
H7 :=ToricVariety(P18);
ClassGroup(H7);
Display(ByASmallerPresentation(last));
PicardGroup(H7);
H7;