LoadPackage( "RingsForHomalg" );

HOMALG_IO_Maple.UseJacobsonNormalForm := true;

B1 := RingForHomalgInMapleUsingJanet( "[x]" );

m := HomalgMatrix( "[ \
[  [[1,[x]]]	,	    0		], \
[      0    	,	[[1,[x]]]	]  \
]", B1 );

LoadPackage( "Modules" );

M := LeftPresentation( m );

# ByASmallerPresentation( M );
