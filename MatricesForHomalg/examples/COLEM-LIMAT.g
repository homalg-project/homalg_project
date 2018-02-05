LoadPackage( "MatricesForHomalg" );

R := HomalgRingOfIntegers( );

M := HomalgMatrix( "[ \
1, 3, 4, \
0, 1, 8, \
0, 0, 1  \
]", 3, 3, R );

N := LeftInverse( M );

Id := HomalgIdentityMatrix( 3, R );

ZZ := HomalgZeroMatrix( 3, 3, R );

A := UnionOfColumnsOp( Id, -M );

B := UnionOfRowsOp( 2 * M, Id );

C := A * B;

D :=  C - M;
