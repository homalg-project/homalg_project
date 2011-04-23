LoadPackage( "GradedRingForHomalg" );

S := GradedRing( HomalgFieldOfRationalsInSingular( ) * "x,y" );

LoadPackage( "GradedModules" );

m := MaximalGradedLeftIdeal( S );

k := FactorObject( m );

I := GradedLeftSubmodule( "y", S );

M := FactorObject( I );
