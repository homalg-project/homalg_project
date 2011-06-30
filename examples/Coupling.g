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
]", 3, 1, A3 );
M := DiagMat( [ M1, M2, M3 ] );
M := ShallowCopy( M );	## copy M before setting entries
SetIsMutableMatrix( M, true );
SetEntryOfHomalgMatrix( M, 1, 2, "1" );
SetEntryOfHomalgMatrix( M, 2, 3, "1" );
SetEntryOfHomalgMatrix( M, 3, 3, "1" );
SetIsMutableMatrix( M, false );

tau1 := HomalgMatrix( "[ \
1, Dx, Dz, \
0,  0,  1, \
0,  1, Dy  \
]", 3, 3, A3 );

tau2 := HomalgMatrix( "[ \
0,  1, Dz+x*y, \
0,  0,      1, \
1, Dz,    x-y  \
]", 3, 3, A3 );

tau3 := HomalgMatrix( "[ \
1,  0, 0, \
1,  1, 0, \
0, -1, 1  \
]", 3, 3, A3 );

tau := tau1 * tau2 * tau3;

LoadPackage( "Modules" );

N := LeftPresentation( M * tau );

M := LeftPresentation( M );

tau := HomalgMap( tau, M, N );

ByASmallerPresentation( N );

DecideZero( tau );

id := HomalgIdentityMap( M );

