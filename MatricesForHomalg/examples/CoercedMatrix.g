LoadPackage( "MatricesForHomalg" );
LoadPackage( "GaussForHomalg" );

zz := HomalgRingOfIntegers( );
QQ := HomalgFieldOfRationals( );

M := HomalgMatrix( [ 1, 2, 3, 4 ], 2, 2, zz );
N := CoercedMatrix( QQ, M );
P := CoercedMatrix( zz, QQ, M );
Assert( 0, N = P );
Assert( 0, NumberRows( N ) = NumberRows( M ) and NrCols( N ) = NrCols( M ) );
Assert( 0, IsIdenticalObj( HomalgRing( N ), QQ ) );
Eval( N );
