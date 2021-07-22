LoadPackage( "MatricesForHomalg" );
LoadPackage( "GaussForHomalg" );

ZZ := HomalgRingOfIntegers( );
QQ := HomalgFieldOfRationals( );

M := HomalgMatrix( [ 1, 2, 3, 4 ], 2, 2, ZZ );
N := CoercedMatrix( QQ, M );
P := CoercedMatrix( ZZ, QQ, M );
Assert( 0, N = P );
Assert( 0, NrRows( N ) = NrRows( M ) and NrCols( N ) = NrCols( M ) );
Assert( 0, IsIdenticalObj( HomalgRing( N ), QQ ) );
Eval( N );
