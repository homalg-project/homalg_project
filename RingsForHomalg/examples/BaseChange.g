LoadPackage( "RingsForHomalg" );

R2 := HomalgRingOfIntegersInSingular( 2 ) * "x,y,z";
R5 := HomalgRingOfIntegersInSingular( 5, R2 ) * "x,y,z";

m5 := HomalgMatrix( "[ 2 ]", 1, 1, R5 );

Assert( 0, IsZero( m5 ) = false );

m2 := R2 * m5;

Assert( 0, IsZero( m2 ) );
