LoadPackage( "ToricVariety" );

## We create the Hirzebruchsurface H5.

H5 := Fan( [[-1,5],[0,1],[1,0],[0,-1]],[[1,2],[2,3],[3,4],[4,1]] );

H5 := ToricVariety( H5 );

## We check some properties

IsComplete( H5 );

IsAffine( H5 );

IsOrbifold( H5 );

IsProjective( H5 );
