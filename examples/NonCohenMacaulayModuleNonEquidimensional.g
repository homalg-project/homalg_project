LoadPackage( "RingsForHomalg" );
LoadPackage( "LocalizeRingForHomalg" );
LoadPackage( "homalg" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y";

I := LeftSubmodule( "x", R );
J := LeftSubmodule( "x,y", R );

M := 1 * R / ( I * J );

L := LeftSubmodule( "x,y-1", R );

Display( Depth( J, M ) );
Display( Depth( L, M ) );

R0 := LocalizeAtZero( R );
SetLeftGlobalDimension( R0, LeftGlobalDimension( R ) );

M0 := R0 * M;
J0 := R0 * J;
L0 := R0 * L;
