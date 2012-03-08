## Hirzebruch5.g
## gapcolor ##
gap> LoadPackage( "ToricVarieties" );
true  
gap> H5 := Fan( [[-1,5],[0,1],[1,0],[0,-1]]
,[[1,2],[2,3],[3,4],[4,1]] );
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
## endgapcolor ##