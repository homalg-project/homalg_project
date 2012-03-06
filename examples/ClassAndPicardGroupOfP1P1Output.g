gap> LoadPackage( "ToricVarieties" );
true
gap> 
gap> H5 := Fan( [[-1,5],[0,1],[1,0],[0,-1]],[[1,2],[2,3],[3,4],[4,1]] );
<A fan>
## gapcolor ##
gap> H5 := Fan( [[-1,5],[0,1],[1,0],[0,-1]],[[1,2],[2,3],[3,4],[4,1]] );
gap> H5 := ToricVariety( H5 );
<A toric variety>
gap> P1 := Polytope( [[0],[1]] );
<A polytope>
gap> P1 := ToricVariety( P1 );
<A projective toric variety>
gap> P1P1 := P1*P1;
<A projective toric variety which is a product of 2 toric varieties>
gap> ClassGroup( H5 );
<A non-torsion left module presented by 2 relations for 4 generators>
gap> PicardGroup( H5 );
<A non-torsion left submodule given by 4 generators>
gap> ClassGroup( P1P1 );
<A non-torsion left module presented by 2 relations for 4 generators>
gap> PicardGroup( P1P1 );
<A non-torsion left submodule given by 4 generators>
gap> IsSmooth( H5 );
true
gap> IsSmooth( P1P1 );
true
gap> Display(ClassGroup(H5));
[ [  -1,   0,   1,   0 ],
  [   5,   1,   0,  -1 ] ]

Cokernel of the map

Z^(1x2) --> Z^(1x4),

currently represented by the above matrix
gap> Display(ByASmallerPresentation(ClassGroup(H5)));
Z^(1 x 2)
gap> Display(ByASmallerPresentation(ClassGroup(P1P1)));
Z^(1 x 2)
