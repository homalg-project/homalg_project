LoadPackage( "homalg" );
r := Integers;
#mm1 := [[2,53,12,0],[44,18,3,0],[46,71,15,0]];
mm1 := [[262, -33, 75, -40],
        [682, -86, 196, -104],
	[1186, -151, 341, -180],
        [-1932,248,-556,292 ],
        [1018,-127,293,-156 ]	
       ];
mm2 := [[1,0,0],[1,1,0],[2,1,0]];
M := LeftPresentation( mm1, r );
imat := MatrixOfRelations( M );
z := LeftPresentation( [], r );
M2 := LeftPresentation( mm2, [], r );
R := HomalgRing( M );
#SetRingRelations( R, HomalgRelationsForLeftModule( [[ 1148 ]], R  ) );
N := RightPresentation( TransposedMat( mm1 ), r );
y := RightPresentation( [], r );
N2 := RightPresentation( TransposedMat( mm2 ), [], r );
S := HomalgRing( N );
#SetRingRelations( S, HomalgRelationsForRightModule( [[ 1148 ]], S  ) );
