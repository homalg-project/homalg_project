LoadPackage( "RingsForHomalg" );

LoadPackage( "Modules" );

Qt := HomalgFieldOfRationalsInDefaultCAS( ) * "t";
A1 := RingOfDerivations( Qt, "D" );

M := HomalgMatrix( "[ \
t^2, 1-t*D, \
2+t*D, -D^2 \
]", 2, 2, A1 );

M := LeftPresentation( M );

d := Resolution( M );

d_short := ShortenResolution( M );

