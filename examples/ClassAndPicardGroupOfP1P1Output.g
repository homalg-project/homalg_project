## ClassAndPicardGroupOfP1P1andH5.g

## gapcolor ##
gap> LoadPackage( "ToricVarieties" );
true
gap> H5 := Fan( [[-1,5],[0,1],[1,0],[0,-1]],
                [[1,2],[2,3],[3,4],[4,1]] );
<A fan in |R^2>
gap> H5 := ToricVariety( H5 );
<A toric variety of dimension 2>
gap> P1 := Polytope( [[0],[1]] );
<A polytope in |R^1>
gap> P1 := ToricVariety( P1 );
<A projective toric variety of dimension 1>
gap> P1P1 := P1*P1;
<A projective toric variety which is a product of 2 toric varieties>
gap> ClassGroup( H5 );
<A non-torsion left module presented by 2 relations for 4 generators>
gap> PicardGroup( H5 );
<A non-torsion left submodule given by 4 generators>
gap> ClassGroup( P1P1 );
<A non-torsion left module presented by 2 relations for 4 generators>
gap> H5;
<A smooth toric variety of dimension 2>
gap> IsSmooth( P1P1 );
true
gap> PicardGroup( P1P1 );
<A non-torsion left submodule given by 4 generators>
## endgapcolor ##