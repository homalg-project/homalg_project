LoadPackage( "RingsForHomalg" );

R := HomalgFieldOfRationalsInSingular( ) * "x";

LoadPackage( "LocalizeRingForHomalg" );

S := LocalizeAt( R, "x^2+1" );

a := "x" / R;

Assert( 0, not IsUnit( a ) );

i := a / S;

Assert( 0, IsUnit( i ) );
