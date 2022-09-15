LoadPackage( "GradedRingForHomalg", false );

S := GradedRing( HomalgFieldOfRationalsInDefaultCAS( ) * "x,y" );

LoadPackage( "GradedModules", false );

m := MaximalGradedLeftIdeal( S );

k := ResidueClassRingAsGradedLeftModule( S );

I := GradedLeftSubmodule( "y", S );

M := FactorObject( I );
