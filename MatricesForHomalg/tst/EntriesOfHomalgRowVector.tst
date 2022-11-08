gap> START_TEST( "EntriesOfHomalgRowVector" );

#
gap> LoadPackage( "MatricesForHomalg", false : OnlyNeeded );
true
gap> ZZ := HomalgRingOfIntegers( );
Z
gap> row_vector := HomalgMatrix( [ 1, 2, 3 ], 1, 3, ZZ );
<A 1 x 3 matrix over an internal ring>
gap> EntriesOfHomalgRowVector( row_vector );
[ 1, 2, 3 ]
gap> column_vector := HomalgMatrix( [ 1, 2, 3 ], 3, 1, ZZ );
<A 3 x 1 matrix over an internal ring>
gap> EntriesOfHomalgColumnVector( column_vector );
[ 1, 2, 3 ]

#
gap> STOP_TEST( "EntriesOfHomalgRowVector" );
