LoadPackage( "RingsForHomalg" );

LoadPackage( "homalg" );

Qxyz := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";

wmat := HomalgMatrix( "[ \
x*y,  y*z,    z,        0,         0,    \
x^3*z,x^2*z^2,0,        x*z^2,     -z^2, \
x^4,  x^3*z,  0,        x^2*z,     -x*z, \
0,    0,      x*y,      -y^2,      x^2-1,\
0,    0,      x^2*z,    -x*y*z,    y*z,  \
0,    0,      x^2*y-x^2,-x*y^2+x*y,y^2-y \
]", 6, 5, Qxyz );

W := LeftPresentation( wmat );

## the module is isomorphic to LeftPresentation of the multiple extension:
## x,z,1,0, 0, 0,0, 0,    0,  0, 
## 0,0,y,-z,0, 0,0, 0,    0,  0, 
## 0,0,x,0, -z,1,0, 0,    0,  0, 
## 0,0,0,x, -y,0,1, 0,    0,  0, 
## 0,0,0,0, 0, y,-z,0,    0,  0, 
## 0,0,0,0, 0, x,0, -z,   0,  -1,
## 0,0,0,0, 0, 0,x, -y,   -1, 0, 
## 0,0,0,0, 0, 0,-y,x^2-1,0,  0, 
## 0,0,0,0, 0, 0,0, 0,    z,  0, 
## 0,0,0,0, 0, 0,0, 0,    y-1,0, 
## 0,0,0,0, 0, 0,0, 0,    0,  z, 
## 0,0,0,0, 0, 0,0, 0,    0,  y, 
## 0,0,0,0, 0, 0,0, 0,    0,  x

BasisOfModule( W );
syz := SyzygiesGenerators( W );
Y := Hom( Qxyz, W );
iota := TorsionSubobjectEmb( W );
pi := TorsionFreeFactorEpi( W );
C := HomalgComplex( pi, 0 );
Add( C, iota );
T := TorsionSubobject( W );
F := TorsionFreeFactor( W );
O := HomalgCocomplex( iota, -1 );
Add( O, pi );

