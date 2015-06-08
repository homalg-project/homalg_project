LoadPackage( "RingsForHomalg" );

LoadPackage( "Modules" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y";

I := LeftSubmodule( "x", R );
J := LeftSubmodule( "y", R );

## Cohen-Macaulay module with nonregular support
M := 1 * R / ( I * J );

K := I + J;

Assert( 0, Depth( K, M ) = 1 );
