LoadPackage( "RingsForHomalg" );

LoadPackage( "homalg" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "a,b,c,d";

A := HomalgMatrix( "[ \
a, b, \
c, d  \
]", 2, 2, R );

M := ConvertMatrixToColumn( A^2 );

M := LeftPresentation( M );

filt := PurityFiltration( M );

m := IsomorphismOfFiltration( filt );
