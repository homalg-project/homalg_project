LoadPackage( "RingsForHomalg" );

Qxyz := HomalgFieldOfRationalsInSingular( ) * "x,y,z";

LoadPackage( "LocalizeRingForHomalg" );

SetAssertionLevel( 4 );

R0 := LocalizeAt( Qxyz );

A := LoadDataOfHomalgMatrixFromFile( "A.txt", 4, 4, Qxyz );
NrRows( A );
NrColumns( A );

x := Indeterminates( Qxyz )[1];

A := HomalgLocalMatrix( A, ( One( Qxyz ) - x^2 ), R0 );

B := LoadDataOfHomalgMatrixFromFile( "B.txt", 4, 9, Qxyz );
NrRows( B );
NrColumns( B );

B := HomalgLocalMatrix( B, R0 );

