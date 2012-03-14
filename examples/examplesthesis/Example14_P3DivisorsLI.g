# gap> LoadPackage( "ToricVarieties" );
# true
# gap> P3 := Fan( [[1,0,0],[0,1,0],[0,0,1],[-1,-1,-1]],[[1,2,3],[2,3,4],[1,3,4],[1,2,4]] );
# <A fan in |R^3>
# gap> P3 :=ToricVariety( P3 );
# polymake: used package cddlib
#   Implementation of the double description method of Motzkin et al.
#   Copyright by Komei Fukuda.
#   http://www.ifor.math.ethz.ch/~fukuda/cdd_home/cdd.html
# 
# <A toric variety of dimension 3>
# gap> D := Divisor([1,1,1,1],P3);
# <A divisor of a toric variety with coordinates [ 1, 1, 1, 1 ]>
# gap> IsAmple(D);
# true
# gap> P3;
# <A projective normal toric variety of dimension 3>
# gap> D;
# <An ample basepoint free Cartier divisor of a toric variety with coordinates [ 1, 1, 1, 1 ]>
# gap> D2 := Divisor([1,-1,2,-3],P3);
# <A divisor of a toric variety with coordinates [ 1, -1, 2, -3 ]>
# gap> IsSmooth(P3);
# true
# gap> D2;
# <A Cartier divisor of a toric variety with coordinates [ 1, -1, 2, -3 ]>

LoadPackage( "ToricVarieties" );
P3 := Fan( [[1,0,0],[0,1,0],[0,0,1],[-1,-1,-1]],[[1,2,3],[2,3,4],[1,3,4],[1,2,4]] );
P3 :=ToricVariety( P3 );
D := Divisor([1,1,1,1],P3);
IsAmple(D);
P3;
D;
D2 := Divisor([1,-1,2,-3],P3);
IsSmooth(P3);
D2;
