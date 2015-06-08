LoadPackage( "RingsForHomalg" );

B1 := RingForHomalgInMapleUsingJanet( "[x]" );

Rskl := HomalgMatrix( "[ \
[ [[1,[x,x,x]], [a(x),[x,x]], [b(x),[x]], [c(x),[]]] ] \
]", B1 );

Rsys := HomalgMatrix( "[ \
[  [[1,[x]]]	,	[[-1,[]]]	,	        0		], \
[      0    	,	[[1,[x]]]	,	     [[-1,[]]]		], \
[ [[c(x),[]]]  	,	[[b(x),[]]]	,	[[a(x),[]],[1,[x]]]	]  \
]", B1 );

LoadPackage( "Modules" );

Mskl := LeftPresentation( Rskl );
Msys := LeftPresentation( Rsys );

alpha := HomalgMatrix( "[ \
[ [[1,[]]]	,	0	,	0	] \
]", B1 );

alpha := HomalgMap( alpha, Mskl, Msys );

delta := HomalgMatrix( "[ \
[	[[1,[x]]]	] \
]", B1 );

delta := HomalgMap( delta, Mskl );
