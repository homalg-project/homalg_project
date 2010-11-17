## An exmaple of Janet used by Pommaret and Quadrat

LoadPackage( "RingsForHomalg" );

LoadPackage( "Modules" );

Qxyz := HomalgFieldOfRationalsInDefaultCAS( ) * "d1,d2,d3";

wmat := HomalgMatrix( "[ \
0, -2*d1, d3-2*d2-d1, -1, \
0, d3-2*d1, 2*d2-3*d1, 1, \
d3, -6*d1, -2*d2-5*d1, -1, \
0, d2-d1, d2-d1, 0, \
d2, -d1, -d2-d1, 0, \
d1, -d1, -2*d1, 0 \
]", 6, 4, Qxyz );

W := LeftPresentation( wmat );

filt := PurityFiltration( W );

m := IsomorphismOfFiltration( filt );

Display( TimeToString( homalgTime( Qxyz ) ) );
