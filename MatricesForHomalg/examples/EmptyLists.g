LoadPackage( "MatricesForHomalg" );

R := HomalgRingOfIntegers( );

M := UnionOfRows( R, 0, [ ] );
Assert( 0, IsEmptyMatrix( M ) and NumberRows( M ) = 0 and NumberColumns( M ) = 0 );

M := UnionOfRows( R, 3, [ ] );
Assert( 0, IsEmptyMatrix( M ) and NumberRows( M ) = 0 and NumberColumns( M ) = 3 );

M := UnionOfColumns( R, 0, [ ] );
Assert( 0, IsEmptyMatrix( M ) and NumberRows( M ) = 0 and NumberColumns( M ) = 0 );

M := UnionOfColumns( R, 3, [ ] );
Assert( 0, IsEmptyMatrix( M ) and NumberRows( M ) = 3 and NumberColumns( M ) = 0 );

M := DiagMat( R, [ ] );
Assert( 0, IsEmptyMatrix( M ) and NumberRows( M ) = 0 and NumberColumns( M ) = 0 );
