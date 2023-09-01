gap> START_TEST( "HomalgRowVector" );

#
gap> LoadPackage( "MatricesForHomalg", false : OnlyNeeded );
true
gap> zz := HomalgRingOfIntegers( );
Z
gap> row_vector := HomalgRowVector( [ 1, 2, 3 ], 3, zz );
<A 1 x 3 matrix over an internal ring>
gap> EntriesOfHomalgRowVector( row_vector );
[ 1, 2, 3 ]
gap> column_vector := HomalgColumnVector( [ 1, 2, 3 ], 3, zz );
<A 3 x 1 matrix over an internal ring>
gap> EntriesOfHomalgColumnVector( column_vector );
[ 1, 2, 3 ]

#
gap> STOP_TEST( "HomalgRowVector" );
