LoadPackage( "ToricVarieties" );

## We start with affine varieties, 3 and 2 dimensional.

sigma1 := Cone( [ [1,0,0], [0,1,0], [1,0,1], [0,1,1] ] );

U1 := ToricVariety( sigma1 );