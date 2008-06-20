# sys:=Ind2Diff([u[x,x]-u[x,y],u[x,y,y],u[x,y,z]],[x,y,z],[u]);

LoadPackage( "RingsForHomalg" );

Qxyz := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";
A3 := RingOfDerivations( Qxyz, "Dx,Dy,Dz" );

M1 := HomalgMatrix( "[ \
Dx  \
]", 1, 1, A3 );
M2 := HomalgMatrix( "[ \
Dx, \
Dy  \
]", 2, 1, A3 );
M3 := HomalgMatrix( "[ \
Dx, \
Dy, \
Dz  \
] ", 3, 1, A3 );
M := DiagMat( [ M1, M2, M3 ] );
M := HomalgMatrix( M );	## copy M before setting entries
SetEntryOfHomalgMatrix( M, 1, 2, "1" );
SetEntryOfHomalgMatrix( M, 2, 3, "1" );
SetEntryOfHomalgMatrix( M, 3, 3, "1" );
M := HomalgMap( M );
M := Cokernel( M );
