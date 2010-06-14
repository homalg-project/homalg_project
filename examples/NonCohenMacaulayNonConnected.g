LoadPackage( "RingsForHomalg" );

LoadPackage( "homalg" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z,w";

J := LeftSubmodule( "x,y", R );
K := LeftSubmodule( "z,w", R );

M := 1 * R / ( J * K );

L0 := LeftSubmodule( "x,y,z,w", R );
L := LeftSubmodule( "x,y,z,w-1", R );

Display( Codim( M ) );
Display( Depth( L0, M ) );
Display( Depth( L, M ) );
