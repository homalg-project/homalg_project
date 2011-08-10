LoadPackage( "RingsForHomalg" );

LoadPackage( "Modules" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z,w";

I := LeftSubmodule( "x,y", R );
J := LeftSubmodule( "z,w", R );

M := 1 * R / ( I * J );

K := LeftSubmodule( "x,y,z,w", R );
L := LeftSubmodule( "x,y,z,w-1", R );

Assert( 0, Depth( K, M ) = 1 );
Assert( 0, Depth( L, M ) = 2 );
