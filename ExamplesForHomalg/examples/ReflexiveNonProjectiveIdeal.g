## [Har77, Example 6.5.2]

LoadPackage( "RingsForHomalg" );

A := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";

R := A / "x*y-z^2";

LoadPackage( "Modules" );

I := LeftSubmodule( "y,z", R );

Assert( 0, not IsProjective( I ) );
Assert( 0, IsReflexive( I ) );

ViewObj( I ); Print( "\n" );

