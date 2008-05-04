LoadPackage( "RingsForHomalg" );

A1 := RingForHomalgInMapleUsingJanetOre( "[[D,t],[],[weyl(D,t)]]" );

Rskl := HomalgMorphism( " \
[ \
[ D^3 + a * D^2 + b * D + c ] \
] \
", A1 );
Mskl := Cokernel( Rskl );

Rsys := HomalgMorphism( " \
[ \
[	D,	-1,	 0	], \
[	0,    	 D,	-1	], \
[	c,	 b,	a+D	] \
] \
", A1 );
Msys := Cokernel( Rsys );

alpha := HomalgMorphism( " \
[ \
[	1,	0,	0	] \
] \
", Mskl, Msys );
