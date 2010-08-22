LoadPackage( "RingsForHomalg" );

LoadPackage( "Modules" );

S := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z,w";

I := LeftSubmodule( "x,y", S );
J := LeftSubmodule( "z,w", S );

R := S / ( I * J );

SetLeftGlobalDimension( R, infinity );

R!.MaximumNumberOfResolutionSteps := 4;

K := LeftSubmodule( "x,y,z,w", R );
L := LeftSubmodule( "x,y,z,w-1", R );

O := 1 * R / K;
N := 1 * R / L;
