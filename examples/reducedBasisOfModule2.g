LoadPackage( "RingsForHomalg" );

LoadPackage( "homalg" );

Qxyz := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";

wmat := HomalgMatrix( "[ \
0,         -z,       y,    0,    \
-y^2,      x*y,      0,    x^2-1,\
-x*y*z,    x^2*z,    0,    y*z,  \
-x*z^2,    0,        x^2*z,z^2,  \
-x*y^2+x*y,x^2*y-x^2,0,    y^2-y,\
-x^2*z,    0,        x^3,  x*z   \
]", 6, 4, Qxyz );
W := LeftPresentation( wmat );
BasisOfModule( W );
syz:=SyzygiesGenerators( W );
Y := Hom( Qxyz, W );
iota := TorsionObjectEmb( W );
pi := TorsionFreeFactorEpi( W );
C := HomalgComplex( pi, 0 );
Add( C, iota );
T := TorsionObject( W );
F := TorsionFreeFactor( W );
O := HomalgCocomplex( iota, -1 );
Add( O, pi );

