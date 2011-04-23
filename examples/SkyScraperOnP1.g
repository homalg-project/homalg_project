LoadPackage( "GradedRingForHomalg" );

S := GradedRing( HomalgFieldOfRationalsInDefaultCAS( ) * "x,y" );

LoadPackage( "GradedModules" );

m := MaximalGradedLeftIdeal( S );

k := FactorObject( m );

I := GradedLeftSubmodule( "y", S );

M := FactorObject( I );
