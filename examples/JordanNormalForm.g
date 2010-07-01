LoadPackage( "RingsForHomalg" );

LoadPackage( "homalg" );

R := HomalgFieldOfRationalsInSingular( ) * "d";

m := HomalgMatrix( "[ \
 2,-1, 1,-1,-1, \
-1, 2,-1, 1, 0, \
-1, 1, 0, 1, 1, \
 1,-1, 1, 0, 0, \
 0, 1, 0, 1, 1  \
]", 5, 5, R );

d := Indeterminates( R )[1];

M := LeftPresentation( m - HomalgScalarMatrix( d, NrRows( m ) ) );

n := HomalgMatrix( "[ \
 3, 4, 3, \
-1, 0,-1, \
 1, 2, 3  \
]", 3, 3, R );

d := Indeterminates( R )[1];

N := LeftPresentation( n - HomalgScalarMatrix( d, NrRows( n ) ) );

