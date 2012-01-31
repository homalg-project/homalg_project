LoadPackage( "ToricVarieties" );

## First we recapitulate 1.84 and 1.85 in the lecture notes of professor plesken

sigma1 := Cone( [ [1,0,0], [0,1,0], [1,0,1], [0,1,1] ] );

sigma2 := Cone( [ [4,-1], [0,1] ] );

## Now we construct the varieties

Usigma1 := ToricVariety( sigma1 );

Usigma2 := ToricVariety( sigma2 );

## and compute the coordinate rings

CoordinateRing( Usigma1, "x" );

CoordinateRing( Usigma2, "x" );

## We now recognize the isomorphism types of the varieties.
## We also know some additional properties:

IsSmooth( Usigma1 );

IsOrbifold( Usigma2 );

IsAffine( Usigma1 );