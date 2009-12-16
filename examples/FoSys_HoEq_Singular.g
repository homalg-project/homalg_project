LoadPackage( "RingsForHomalg" );

A1 := RingForHomalgInSingular( "(0,a,b,c),(t,D),dp" );
homalgSendBlocking( [ A1, " = Weyl(1); setring ", A1 ], "need_command", A1 );

_Singular_SetRing( A1 );

SetName( A1, "K[t,a,b,c]<D>" );

Rskl := HomalgMatrix( "[ D^3 + a * D^2 + b * D + c ]", 1, 1, A1 );

Rskl := HomalgMap( Rskl );
Mskl := Cokernel( Rskl );

Rsys := HomalgMatrix( "[ \
D, -1,   0, \
0,  D,  -1, \
c,  b, a+D  \
]", 3, 3, A1 );

Rsys := HomalgMap( Rsys );
Msys := Cokernel( Rsys );

alpha := HomalgMatrix( "[ 1, 0, 0 ]", 1, 3, A1 );

alpha := HomalgMap( alpha, Mskl, Msys );

delta := HomalgMatrix( "[ D ]", 1, 1, A1 );

delta := HomalgMap( delta, Mskl );
