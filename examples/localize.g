LoadPackage( "RingsForHomalg" );

SetAssertionLevel( 4 );

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

m := [ HomalgRingElement("x",R) , HomalgRingElement("y",R) , HomalgRingElement("z",R) ];

R0 := LocalizeAt( R , m );

lmat := HomalgLocalMatrix( wmat, R0 );

a := HomalgRingElement(HomalgRingElement("x+1",R),One(R),R0);

lmat2:=a*lmat;

T := HomalgVoidMatrix(R0);

M := LeftPresentation(lmat);

Red := DecideZeroRowsEffectively(lmat,lmat2,T);