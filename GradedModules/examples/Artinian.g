LoadPackage( "GradedRingForHomalg" );

S := GradedRing( HomalgFieldOfRationalsInDefaultCAS( ) * "x0..2" );

m := HomalgMatrix( "[ x0^2, x0*x1, x0*x2, x1^2, x1*x2, x2^2  ]", 6, 1, S );

A := KoszulDualRing( S, "e0..2" );

LoadPackage( "GradedModules" );

M := LeftPresentationWithDegrees( m );
