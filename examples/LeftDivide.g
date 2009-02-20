LoadPackage( "RingsForHomalg" );

Qxyz := HomalgFieldOfRationalsInSingular( ) * "x,y,z";

LoadPackage( "LocalizeRingForHomalg" );

SetAssertionLevel( 4 );

R0 := LocalizeAt( Qxyz );

A := LoadDataOfHomalgMatrixFromFile( "mm.txt", 15, 18, Qxyz );
NrRows( A );
NrColumns( A );

A := HomalgLocalMatrix( A, R0 );

B := LoadDataOfHomalgMatrixFromFile( "nn.txt", 15, 15, Qxyz );
NrRows( B );
NrColumns( B );

B := HomalgLocalMatrix( B, R0 );

