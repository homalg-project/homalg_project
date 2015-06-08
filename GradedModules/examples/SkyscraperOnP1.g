LoadPackage( "GradedRingForHomalg" );

S := GradedRing( HomalgFieldOfRationalsInDefaultCAS( ) * "x,y" );

LoadPackage( "GradedModules" );

m := MaximalGradedLeftIdeal( S );

k := ResidueClassRingAsGradedLeftModule( S );

I := GradedLeftSubmodule( "y", S );

M := FactorObject( I );
