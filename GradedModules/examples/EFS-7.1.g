LoadPackage( "GradedRingForHomalg" );

S := GradedRing( HomalgFieldOfRationalsInDefaultCAS( ) * "x0..x3" );

A := KoszulDualRing( S, "e0..e3" );

LoadPackage( "GradedModules" );

## [EFS, Example 7.1]:
## Let C be an elliptic quartic curve in P3 , and consider C as a sheaf on P3

C := HomalgMatrix( "[ x0^2 + x2^2 + x1*x3, x1^2+ x3^2+ x0*x2 ]", 2, 1, S );

C := LeftPresentationWithDegrees( C );

