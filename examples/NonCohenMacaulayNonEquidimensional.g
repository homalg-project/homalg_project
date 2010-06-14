LoadPackage( "RingsForHomalg" );
LoadPackage( "LocalizeRingForHomalg" );
LoadPackage( "homalg" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y";

J := LeftSubmodule( "x", R );
K := LeftSubmodule( "x,y", R );

M := 1 * R / ( J * K );

L := LeftSubmodule( "x,y-1", R );

Display( Codim( M ) );
Display( Depth( K, M ) );
Display( Depth( L, M ) );

R0 := LocalizeAtZero( R );
SetLeftGlobalDimension( R0, LeftGlobalDimension( R ) );

M0 := R0 * M;
K0 := R0 * K;
L0 := R0 * L;
