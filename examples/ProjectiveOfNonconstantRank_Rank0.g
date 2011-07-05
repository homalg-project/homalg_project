LoadPackage( "RingsForHomalg" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "x" / "x^2-x";

R1 := R / "x-1";

R0 := R / "x";

LoadPackage( "Modules" );

I := LeftSubmodule( "x", R );

ViewObj( I ); Print( "\n" );

Rank( I );

ViewObj( I ); Print( "\n" );

IsProjective( I );

ViewObj( I ); Print( "\n" );

Assert( 0, not FittingIdeal( I ) = R );

M := UnderlyingObject( I );

ViewObj( M ); Print( "\n" );

N := R1 * M;

ViewObj( N ); Print( "\n" );

L := R0 * M; IsZero( L );

ViewObj( L ); Print( "\n" );
