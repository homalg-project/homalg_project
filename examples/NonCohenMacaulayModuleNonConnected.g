LoadPackage( "RingsForHomalg" );

LoadPackage( "homalg" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z,w";

I := LeftSubmodule( "x,y", R );
J := LeftSubmodule( "z,w", R );

M := 1 * R / ( I * J );

L0 := LeftSubmodule( "x,y,z,w", R );
L := LeftSubmodule( "x,y,z,w-1", R );

Display( Depth( L0, M ) );
Display( Depth( L, M ) );
