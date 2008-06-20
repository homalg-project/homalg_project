LoadPackage( "RingsForHomalg" );

Qxyz := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";

M := HomalgMatrix( "[ x, y, z ]", 1, 3, Qxyz );
M := LeftPresentation( M );
phi := HomalgMatrix( "[ \
x^2, y^2, 0, \
  1,   0, z  \
]", 2, 3, Qxyz );
F2 := HomalgFreeLeftModule( 2, Qxyz );
phi := HomalgMap( phi, F2, M );
N := Cokernel( phi );
OnLessGenerators( N );
BasisOfModule( N );
psi := HomalgMatrix( "[ \
y, 0,  \
0, z-1 \
]", 2, 2, Qxyz );
psi := HomalgMap( psi, F2, N );
C := Cokernel( psi );
OnLessGenerators( C );
BasisOfModule( C );
