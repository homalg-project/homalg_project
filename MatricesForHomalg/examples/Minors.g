LoadPackage( "MatricesForHomalg" );

ZZ := HomalgRingOfIntegers( );

m := HomalgMatrix( "[ \
2,  0, 0, \
0, 12, 0  \
]", 2, 3, ZZ );

Assert( 0, Minors( -1, m ) = [ 1 ] );
Assert( 0, Minors( 0, m ) = [ 1 ] );
Assert( 0, Minors( 1, m ) = [ 2, 12 ] );
Assert( 0, Minors( 2, m ) = [ 24 ] );
Assert( 0, Minors( 3, m ) = [ 0 ] );
Assert( 0, Minors( 4, m ) = [ 0 ] );
