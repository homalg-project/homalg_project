LoadPackage( "GradedRingForHomalg" );

S := GradedRing( HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z" );

LoadPackage( "GradedModules" );

I := GradedLeftSubmodule( "x", S ) * MaximalGradedLeftIdeal( S ) + GradedLeftSubmodule( "y^3", S );

M := FactorObject( I );

Assert( 0, ProjectiveDimension( I ) = 2 );
Assert( 0, CastelnuovoMumfordRegularity( I ) = 3 );
Assert( 0, AffineDimension( M ) = 1 );
Assert( 0, not IsCohenMacaulay( M ) );
