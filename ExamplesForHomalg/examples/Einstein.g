LoadPackage( "RingsForHomalg" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "D1..4";

mat := HomalgMatrix( "[ \
D2^2+D3^2-D4^2, D1^2, D1^2, -D1^2, -2*D1*D2, 0, 0, -2*D1*D3, 0, 2*D1*D4, \
D2^2, D1^2+D3^2-D4^2, D2^2, -D2^2, -2*D1*D2, -2*D2*D3, 0, 0, 2*D2*D4, 0, \
D3^2, D3^2, D1^2+D2^2-D4^2, -D3^2, 0, -2*D2*D3, 2*D3*D4, -2*D1*D3, 0, 0, \
D4^2, D4^2, D4^2, D1^2+D2^2+D3^2, 0, 0, -2*D3*D4, 0, -2*D2*D4, -2*D1*D4, \
0, 0, D1*D2, -D1*D2, D3^2-D4^2, -D1*D3, 0, -D2*D3, D1*D4, D2*D4, \
D2*D3, 0, 0, -D2*D3,-D1*D3, D1^2-D4^2, D2*D4, -D1*D2, D3*D4, 0, \
D3*D4, D3*D4, 0, 0, 0, -D2*D4, D1^2+D2^2, -D1*D4, -D2*D3, -D1*D3, \
0, D1*D3, 0, -D1*D3, -D2*D3, -D1*D2, D1*D4, D2^2-D4^2, 0, D3*D4, \
D2*D4, 0, D2*D4, 0, -D1*D4, -D3*D4, -D2*D3, 0, D1^2+D3^2, -D1*D2, \
0, D1*D4, D1*D4, 0, -D2*D4, 0, -D1*D3, -D3*D4, -D1*D2, D2^2+D3^2 \
]", 10, 10, R );

LoadPackage( "Modules" );

M := LeftPresentation( mat );

filt := PurityFiltration( M );

m := IsomorphismOfFiltration( filt );

Display( StringTime( homalgTime( R ) ) );
