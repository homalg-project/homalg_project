gap> START_TEST( "UniqueRightDivide" );

#
gap> LoadPackage( "MatricesForHomalg", false : OnlyNeeded );
true
gap> old_assertion_level := AssertionLevel( );;
gap> SetAssertionLevel( 5 );
gap> zz := HomalgRingOfIntegers( );;
gap> A := HomalgMatrix( [ [ 3 ] ], 1, 1, zz );;
gap> B := HomalgMatrix( [ [ 6 ] ], 1, 1, zz );;
gap> T := UniqueRightDivide( B, A );;
gap> Display( T );
[ [  2 ] ]
gap> T * A = B;
true
gap> T := UniqueLeftDivide( A, B );;
gap> Display( T );
[ [  2 ] ]
gap> A * T = B;
true
gap> SetAssertionLevel( old_assertion_level );

#
gap> STOP_TEST( "UniqueRightDivide" );
