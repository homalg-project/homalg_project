LoadPackage( "ToricVarieties" );

C := Cone( [ [ 1, 0 ], [ 0, 1 ] ] );

U := ToricVariety( C );

Dimension( U );

C1 := Cone( [ [ 1 ] ] );

U1 := ToricVariety( C1 );

U2 := U * U1;

CoordinateRing( U2, "x" );
