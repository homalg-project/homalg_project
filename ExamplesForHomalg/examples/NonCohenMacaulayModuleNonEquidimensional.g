LoadPackage( "RingsForHomalg" );
LoadPackage( "LocalizeRingForHomalg" );
LoadPackage( "Modules" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y";

I := LeftSubmodule( "x", R );
J := LeftSubmodule( "x,y", R );
K := LeftSubmodule( "x,y-1", R );

Assert( 0, Depth( I ) = 1 );
Assert( 0, Depth( J ) = 2 );
Assert( 0, Depth( K ) = 2 );

M := 1 * R / ( I * J );

Assert( 0, Depth( I, M ) = 0 );
Assert( 0, Depth( J, M ) = 0 );	## R is not Cohen-Macaulayness
Assert( 0, Depth( K, M ) = 1 );

R0 := LocalizeAtZero( R );
SetLeftGlobalDimension( R0, LeftGlobalDimension( R ) );

M0 := R0 * M;
J0 := R0 * J;
K0 := R0 * K;
