LoadPackage( "ToricVarieties" );

sigma := Cone([[7,-1],[0,1]]);

C7 := ToricVariety( sigma );

CoordinateRing( C7, ["x"] );

CoordinateRingOfTorus( C7, ["y","z"] );

MorphismFromCoordinateRingToCoordinateRingOfTorus( C7 );