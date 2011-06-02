LoadPackage( "MatricesForHomalg" );

Z6 := HomalgRingOfIntegers( ) / "6";

Z3 := Z6 / 3;

Z2 := Z6 / 2;

LoadPackage( "Modules" );

I := LeftSubmodule( "2", Z6 );

ViewObj( I ); Print( "\n" );

Rank( I );

ViewObj( I ); Print( "\n" );

IsProjective( I );

ViewObj( I ); Print( "\n" );

Assert( 0, not FittingIdeal( I ) = Z6 );

M := UnderlyingObject( I );

ViewObj( M ); Print( "\n" );

N := Z3 * M;

ViewObj( N ); Print( "\n" );

L := Z2 * M;

ViewObj( L ); Print( "\n" );
