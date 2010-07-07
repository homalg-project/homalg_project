LoadPackage( "RingsForHomalg" );

LoadPackage( "homalg" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y";

I := LeftSubmodule( "x", R );
J := LeftSubmodule( "y", R );

M := 1 * R / ( I * J );

K := I + J;

Display( Depth( K, M ) );
