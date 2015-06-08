LoadPackage( "GradedRingForHomalg" );

S := GradedRing( HomalgFieldOfRationalsInDefaultCAS( ) * "a,b,c" );;
rand := RandomMatrixBetweenGradedFreeRightModules( [ 1, 2 ], [ 2, 3, 4 ], S );
