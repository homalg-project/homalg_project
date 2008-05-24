LoadPackage( "RingsForHomalg" );

B1 := RingForHomalgInMapleUsingJanet( "[x]" );

Rskl := HomalgMorphism( " \
[[ \
[ [1,[x,x,x]], [a(x),[x,x]], [b(x),[x]], [c(x),[]] ] \
]] \
", B1 );
Mskl := Cokernel( Rskl );

Rsys := HomalgMorphism( " \
[ \
[  [[1,[x]]]	,	[[-1,[]]]	,	        0		], \
\
[      0    	,	[[1,[x]]]	,	     [[-1,[]]]		], \
\
[ [[c(x),[]]]  	,	[[b(x),[]]]	,	[[a(x),[]],[1,[x]]]	] \
] \
", B1 );
Msys := Cokernel( Rsys );

alpha := HomalgMorphism( " \
[ \
[ [[1,[]]]	,	0	,	0	] \
] \
", Mskl, Msys );

delta := HomalgMorphism( " \
[ \
[	[[1,[x]]]	] \
] \
", Mskl );
