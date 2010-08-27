LoadPackage( "GradedRingForHomalg" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "a,b,c";;
r := RandomMatrixBetweenGradedFreeLeftModules( [ 2, 3, 4 ], [ 1, 2 ], R );
S := GradedRing( R );
rand := RandomMatrixBetweenGradedFreeLeftModules( [ 2, 3, 4 ], [ 1, 2 ], S );
