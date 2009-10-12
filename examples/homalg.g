LoadPackage( "homalg" );
R := HOMALG.ZZ; ## HomalgRingOfIntegers( );
mm1 := [[  262,  33,  75,  40 ],
        [  682,  86, 196, 104 ],
	[ 1186, 151, 341, 180 ],
        [ 1932, 248, 556, 292 ],
        [ 1018, 127, 293, 156 ]
       ];
mm2 := [[1,0,0],[1,1,0],[2,1,0]];
M := LeftPresentation( mm1, R );
imat := MatrixOfRelations( M );
z := LeftPresentation( [], R );
M2 := LeftPresentation( mm2, [], R );
#SetRingRelations( R, HomalgRelationsForLeftModule( [[ 1148 ]], R ) );
S := HomalgRingOfIntegers( );
N := RightPresentation( TransposedMat( mm1 ), S );
y := RightPresentation( [], S );
N2 := RightPresentation( TransposedMat( mm2 ), [], S );
#SetRingRelations( R, HomalgRelationsForRightModule( [[ 1148 ]], S ) );
