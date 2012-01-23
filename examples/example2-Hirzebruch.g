LoadPackage( "ToricVariety" );

## We create the Hirzebruchsurface H5.

H5 := HomalgFan( [[0,1],[1,0],[0,-1],[-1,5]],[[1,2],[2,3],[3,4],[4,1]] );

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

