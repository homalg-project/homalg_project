## Eisenbud [CA, p226]
LoadPackage( "RingsForHomalg" );
LoadPackage( "LocalizeRingForHomalg" );
LoadPackage( "homalg" );

S := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";

M := LeftSubmodule( "x", S );
L := LeftSubmodule( "y,z", S );

R := S / ( M * L );

SetLeftGlobalDimension( R, infinity );

I := LeftSubmodule( "x+1,y,z", R );
J := LeftSubmodule( "x,y,z", R );
K := LeftSubmodule( "x,y,z-1", R );

N := 1 * R / I;
O := 1 * R / J;
P := 1 * R / K;
