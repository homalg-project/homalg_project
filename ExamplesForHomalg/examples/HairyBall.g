LoadPackage( "RingsForHomalg" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z" / "x^2+y^2+z^2-1";

m := HomalgMatrix( "[ x, y, z ]", 1, 3, R );

LoadPackage( "Modules" );

M := LeftPresentation( m );

IsStablyFree( M );	## also figures out the rank

