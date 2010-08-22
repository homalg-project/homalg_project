LoadPackage( "RingsForHomalg" );
LoadPackage( "LocalizeRingForHomalg" );
LoadPackage( "Modules" );

S := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y";

I := LeftSubmodule( "x", S );
J := LeftSubmodule( "x,y", S );

R := S / ( I * J );

SetLeftGlobalDimension( R, infinity );

R!.MaximumNumberOfResolutionSteps := 3;

K := LeftSubmodule( "x,y", R );

O := 1 * R / K;

