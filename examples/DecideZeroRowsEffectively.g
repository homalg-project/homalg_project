LoadPackage( "RingsForHomalg" );

Qxyz := HomalgFieldOfRationalsInSingular( ) * "x,y,z";

LoadPackage( "LocalizeRingForHomalg" );

SetAssertionLevel( 4 );

R0 := LocalizeAt( Qxyz );

A := LoadDataOfHomalgMatrixFromFile( "AAA.txt", 4, 5, Qxyz );
NrRows( A );
NrColumns( A );

x := Indeterminates( Qxyz )[1];

A := HomalgLocalMatrix( A, ( x^2 - One( Qxyz ) )^30, R0 );

B := LoadDataOfHomalgMatrixFromFile( "BBB.txt", 6, 5, Qxyz );
NrRows( B );
NrColumns( B );

B := HomalgLocalMatrix( B, R0 );

