LoadPackage( "ToricVarieties" );

P3 := Polytope( [ [0,0,0], [1,0,0], [0,1,0], [0,0,1] ] );
P4 := Polytope( [ [0,0,0,0], [1,0,0,0], [0,1,0,0], [0,0,1,0], [0,0,0,1] ] );

P3 := ToricVariety( P3 );
P4 := ToricVariety( P4 );

IsSmooth( P3 );
IsSmooth( P4 );

IsProjective( P3 );
IsProjective( P4 );

ClassGroup( P3 );
ClassGroup( P4 );

PicardGroup( P3 );
PicardGroup( P4 );

P43 := P3 * P4;

ClassGroup( P43 );

DivisorGroup( P43 );

PrimeDivisors( P43 );

CoordinateRingOfTorus( P43, "x" );

CC := MaximalCones( FanOfVariety( P43 ) );

Con := IntersectionOfCones( CC[ 1 ], CC[ 2 ] );

C := ClosureOfTorusOrbitOfCone( P43, Con );

RayGenerators( FanOfVariety( C ) );

ClassGroup( C );