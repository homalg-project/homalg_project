LoadPackage( "RingsForHomalg" );

LoadPackage( "Modules" );

Qxyz := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";

wmat := HomalgMatrix( "[ \
0, -2*x, z-2*y-x, -1, \
0, z-2*x, 2*y-3*x, 1, \
z, -6*x, -2*y-5*x, -1, \
0, y-x, y-x, 0, \
y, -x, -y-x, 0, \
x, -x, -2*x, 0 \
]", 6, 4, Qxyz );

W := LeftPresentation( wmat );

