#Read( "../gap/PurityViaAuslanderDuals.g" );

LoadPackage( "RingsForHomalg" );

R := HomalgFieldOfRationalsInDefaultCAS( ) * "x1,x2,x3,x4";

mat := HomalgMatrix( "[ \
x1^3, \
x2^3, \
x1^2*x4+x2^2*x4+x1*x2*x3 \
]", 3, 1, R);

LoadPackage( "Modules" );

M := LeftPresentation( mat );

filt := PurityFiltration( M );

m := IsomorphismOfFiltration( filt );

Display( TimeToString( homalgTime( R ) ) );
