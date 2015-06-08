LoadPackage( "RingsForHomalg" );

Qt := HomalgFieldOfRationalsInMaple( ) * "t";
A1 := RingOfDerivations( Qt, "D" );

Rskl := HomalgMatrix( "[ \
D^3 + a * D^2 + b * D + c \
]", 1, 1, A1 );

Rsys := HomalgMatrix( "[ \
D, -1,   0, \
0,  D,  -1, \
c,  b, a+D  \
]", 3, 3, A1 );

LoadPackage( "Modules" );

Mskl := LeftPresentation( Rskl );
Msys := LeftPresentation( Rsys );

alpha := HomalgMatrix( "[ 1, 0, 0 ]", 1, 3, A1 );

alpha := HomalgMap( alpha, Mskl, Msys );

delta := HomalgMatrix( "[ D ]", 1, 1, A1 );

delta := HomalgMap( delta, Mskl );
