LoadPackage( "ToricVarietiesForHomalg" );

C := HomalgCone( [ [ 1, 0 ], [ 0, 1 ] ] );

U := ToricVariety( C );

Dimension( U );

C1 := HomalgCone( [ [ 1 ] ] );

U1 := ToricVariety( C1 );

U2 := U * U1;
