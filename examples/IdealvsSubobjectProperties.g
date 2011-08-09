LoadPackage( "RingsForHomalg" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y";

LoadPackage( "Modules" );

matI := HomalgMatrix( "[ x^2, x*y ]", 2, 1, R );

mapI := HomalgMap( matI );

I := LeftSubmodule( matI );

II := ImageSubobject( mapI );

Assert( 0, Grade( I ) = 1 );
Assert( 0, Grade( II ) = 0 );

Assert( 0, not IsPure( I ) );
Assert( 0, IsPure( II ) );

Assert( 0, CodegreeOfPurity( I ) = infinity );
Assert( 0, CodegreeOfPurity( II ) = [ 1 ] );

matJ := HomalgMatrix( "[ x, y ]", 2, 1, R );

mapJ := HomalgMap( matJ );

J := LeftSubmodule( matJ );

JJ := ImageSubobject( mapJ );

Assert( 0, IsArtinian( J ) );
Assert( 0, not IsArtinian( JJ ) );

Assert( 0, IsHolonomic( J ) );
Assert( 0, not IsHolonomic( JJ ) );
