LoadPackage( "RingsForHomalg" );
LoadPackage( "LocalizeRingForHomalg" );
LoadPackage( "Modules" );

S := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y";

II := LeftSubmodule( "x", S );
JJ := LeftSubmodule( "x,y", S );
KK := LeftSubmodule( "x,y-1", S );

Assert( 0, Depth( II ) = 1 );
Assert( 0, Depth( JJ ) = 2 );
Assert( 0, Depth( KK ) = 2 );

R := S / ( II * JJ );

SetLeftGlobalDimension( R, infinity );

R!.MaximumNumberOfResolutionSteps := 3;

I := LeftSubmodule( "x", R );
J := LeftSubmodule( "x,y", R );
K := LeftSubmodule( "x,y-1", R );

Assert( 0, Depth( I ) = 0 );
Assert( 0, Depth( J ) = 0 );	## R is not Cohen-Macaulayness
Assert( 0, Depth( K ) = 1 );

O := 1 * R / J;

Assert( 0, Depth( O ) = 0 );

Assert( 0, not IsZero( Hom( Ext( 1, O ) ) ) );	## R is not Cohen-Macaulayness
