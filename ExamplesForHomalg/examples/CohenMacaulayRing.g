LoadPackage( "RingsForHomalg" );
LoadPackage( "LocalizeRingForHomalg" );
LoadPackage( "Modules" );

S := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y";

I := LeftSubmodule( "x", S );
J := LeftSubmodule( "y", S );

## nonregular but Cohen-Macaulay ring
R := S / ( I * J );

SetLeftGlobalDimension( R, infinity );

R!.MaximumNumberOfResolutionSteps := 3;

K := LeftSubmodule( "x,y", R );

Assert( 0, Grade( K ) = 1 );
