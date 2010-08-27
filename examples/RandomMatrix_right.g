LoadPackage( "GradedRingForHomalg" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "a,b,c";;
r := RandomMatrixBetweenGradedFreeRightModules( [ 1, 2 ], [ 2, 3, 4 ], R );
S := GradedRing( R );
rand := RandomMatrixBetweenGradedFreeRightModules( [ 1, 2 ], [ 2, 3, 4 ], S );
