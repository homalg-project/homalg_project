## [Har77, Example 6.5.2]

LoadPackage( "RingsForHomalg" );

A := HomalgFieldOfRationalsInSingular( ) * "x,y,z";

R := A / "x*y-z^2";

LoadPackage( "Modules" );

I := LeftSubmodule( "y,z", R );

Assert( IsProjective( I ), false );
Assert( IsReflexive( I ), true );

ViewObj( I ); Print( "\n" );

