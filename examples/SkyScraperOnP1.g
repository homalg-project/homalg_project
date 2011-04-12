LoadPackage( "GradedRingForHomalg" );

S := GradedRing( HomalgFieldOfRationalsInSingular( ) * "x,y" );

LoadPackage( "GradedModules" );

m := MaximalGradedLeftIdeal( S );

k := FactorObject( m );

I := LeftSubmodule( "y", S );

M := FactorObject( I );
