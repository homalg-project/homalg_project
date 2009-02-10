LoadPackage( "RingsForHomalg" );

R := HomalgFieldOfRationalsInDefaultCAS() * "x,y,z";

wmat := HomalgMatrix( "[ \
x*y,  y*z,    z,        0,         0,    \
x^3*z,x^2*z^2,0,        x*z^2,     -z^2, \
x^4,  x^3*z,  0,        x^2*z,     -x*z, \
0,    0,      x*y,      -y^2,      x^2-1,\
0,    0,      x^2*z,    -x*y*z,    y*z,  \
0,    0,      x^2*y-x^2,-x*y^2+x*y,y^2-y \
]", 6, 5, R );

LoadPackage( "LocalizeRingForHomalg" );

R0 := LocalizeAt( R );

lmat := HomalgLocalMatrix( wmat, R0 );

a:=MinusOne(R0);