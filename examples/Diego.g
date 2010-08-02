LoadPackage( "RingsForHomalg" );

LoadPackage( "homalg" );

Qxy := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y";

YI := HomalgMatrix( "[ \
y^2-x*(x-1)*(x+1), 0, 0, \
0, x, 0, \
0, y, 0, \
0, 0, x, \
0, 0, y-1 \
]", 5, 3, Qxy );

Y := LeftPresentation( Involution( YI ) );

Yt := TorsionObject( Y );

Ann := Annihilator( Yt );
