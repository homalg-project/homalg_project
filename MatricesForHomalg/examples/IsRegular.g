LoadPackage( "homalg" );

zz := HomalgRingOfIntegers( );
R := zz / 2^8;

r := 3 * One( R );

Assert( 0, IsRegular( r ) );

s := 2 * One( R );

Assert( 0, not IsRegular( s ) );
