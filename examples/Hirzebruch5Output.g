## Hirzebruch5.g
## gapcolor ##
gap> LoadPackage( "ToricVarieties" );
true  
gap> H5 := Fan( [[-1,5],[0,1],[1,0],[0,-1]],
gap> [[1,2],[2,3],[3,4],[4,1]] );
<A fan in |R^2>
gap> H5 := ToricVariety( H5 );
<A toric variety of dimension 2>
gap> IsComplete( H5 );
true
gap> IsAffine( H5 );
false
gap> IsOrbifold( H5 );
true
gap> IsProjective( H5 );
true
gap> TorusInvariantPrimeDivisors(H5);
[ <A prime divisor of a toric variety with coordinates [ 1, 0, 0, 0 ]>,
  <A prime divisor of a toric variety with coordinates [ 0, 1, 0, 0 ]>, 
  <A prime divisor of a toric variety with coordinates [ 0, 0, 1, 0 ]>,
  <A prime divisor of a toric variety with coordinates [ 0, 0, 0, 1 ]> ]
gap> P := TorusInvariantPrimeDivisors(H5);
[ <A prime divisor of a toric variety with coordinates [ 1, 0, 0, 0 ]>,
  <A prime divisor of a toric variety with coordinates [ 0, 1, 0, 0 ]>, 
  <A prime divisor of a toric variety with coordinates [ 0, 0, 1, 0 ]>, 
  <A prime divisor of a toric variety with coordinates [ 0, 0, 0, 1 ]> ]
gap> A := P[ 1 ] - P[ 2 ] + 4*P[ 3 ];
<A divisor of a toric variety with coordinates [ 1, -1, 4, 0 ]>
gap> A;
<A divisor of a toric variety with coordinates [ 1, -1, 4, 0 ]>
gap> IsAmple(A);
false
gap> CoordinateRingOfTorus(H5,"x");
Q[x1,x1_,x2,x2_]/( x2*x2_-1, x1*x1_-1 )
gap> D:=Divisor([0,0,0,0],H5);
<A divisor of a toric variety with coordinates 0>
gap> BasisOfGlobalSections(D);
[ |[ 1 ]| ]
gap> D:=Sum(P);
<A divisor of a toric variety with coordinates [ 1, 1, 1, 1 ]>
gap> BasisOfGlobalSections(D);
[ |[ x1_ ]|, |[ x1_*x2 ]|, |[ 1 ]|, |[ x2 ]|,
  |[ x1 ]|, |[ x1*x2 ]|, |[ x1^2*x2 ]|, 
  |[ x1^3*x2 ]|, |[ x1^4*x2 ]|, |[ x1^5*x2 ]|, 
  |[ x1^6*x2 ]| ]
gap> DivisorOfCharacter([1,2],H5);
<A principal divisor of a toric variety with coordinates [ 9, 2, 1, -2 ]>
gap> BasisOfGlobalSections(last);
[ |[ x1_*x2_^2 ]| ]
## endgapcolor ##