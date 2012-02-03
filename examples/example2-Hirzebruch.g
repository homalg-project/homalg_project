LoadPackage( "ToricVariety" );

## We create the Hirzebruchsurface H5.

H5 := Fan( [[-1,5],[0,1],[1,0],[0,-1]],[[1,2],[2,3],[3,4],[4,1]] );

H5 := ToricVariety( H5 );

## We check some properties

IsComplete( H5 );

IsAffine( H5 );

IsOrbifold( H5 );

## We need to set the coordinate ring of the torus

CoordinateRingOfTorus( H5, [ "x", "y", "z", "w" ] );

## So that we can compute some things

DivisorGroup( H5 );

ClassGroup( H5 );

PicardGroup( H5 );

## That was easy. We might want to check out some of the divisors

D := Divisor( [ 1, 2, 3, 17 ], H5 );

IsPrincipal( D );

IsCartier( D );

IsBasepointFree( D );

## BasisOfGlobalSectionsOfDivisorSheaf( D );

## We might want to have a look at the example 6.2.6

P := PrimeDivisors( H5 );

D := P[4];
D1 := P[1];

IsCartier( D );

IsCartier( D1 );

IsBasepointFree( D );

IsBasepointFree( D1 );

IsAmple( D );

IsAmple( D1 );
