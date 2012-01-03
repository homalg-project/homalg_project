LoadPackage( "ToricVarietiesForHomalg" );

C := HomalgCone( [ [ 1, 0 ], [ 0, 1 ] ] );

U := ToricVariety( C );

Dimension( U );

CoordinateRing( U, [ "x","y" ] );

C1 := HomalgCone( [ [ 1 ] ] );

U1 := ToricVariety( C1 );

CoordinateRing( U1, ["z"] );

U2 := U * U1;

CoordinateRing( U2 );
