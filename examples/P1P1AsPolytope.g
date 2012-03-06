LoadPackage( "ToricVarieties" );

P1P1 := Polytope( [[1,1],[1,-1],[-1,-1],[-1,1]] );

P1P1 := ToricVariety( P1P1 );

IsProjective( P1P1 );

IsComplete( P1P1 );

CoordinateRingOfTorus( P1P1, "x" );

IsVeryAmple( Polytope( P1P1 ) );

ProjectiveEmbedding( P1P1 );

Length( last );