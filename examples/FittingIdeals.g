LoadPackage( "MatricesForHomalg" );

R := HomalgRingOfIntegers( );

m := HomalgMatrix( "[ \
2,  0, 0, \
0, 12, 0  \
]", 2, 3, R );

LoadPackage( "Modules" );

M := LeftPresentation( m );

N := TorsionObject( M );
