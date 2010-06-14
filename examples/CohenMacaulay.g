LoadPackage( "RingsForHomalg" );

LoadPackage( "homalg" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y";

J := LeftSubmodule( "x", R );
K := LeftSubmodule( "y", R );

M := 1 * R / ( J * K );

L := LeftSubmodule( "x,y", R );

Display( Codim( M ) );
Display( Depth( L, M ) );
