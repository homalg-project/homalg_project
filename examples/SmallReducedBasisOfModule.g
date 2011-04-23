LoadPackage( "GradedRingForHomalg" );

Qxyzt := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z,t";
S := GradedRing( Qxyzt );

wmat := HomalgMatrix( "[ \
x*y,  y*z,    z*t,       \
x^3*z,x^2*z^2,0,         \
x^4,  x^3*z,  0,         \
0,    0,      x*y,       \
0,    0,      x^2*z      \
]", 5, 3, Qxyzt );

LoadPackage( "GradedModules" );

wmor := GradedMap( wmat, "free", "free", "left", S );
W := LeftPresentationWithDegrees( wmat, S );
Hom(W,W);
WW := UnderlyingModule( W );
Res := Resolution( W );
Res2 := ShortenResolution( W );
Resolution( W );
BasisOfModule( W );
ByASmallerPresentation( W );
syz := SyzygiesGenerators( W );
wmor := GradedMap( wmat, "left", S);
ker := Kernel( wmor );
Y := Hom( S^0, W );
iota := TorsionObjectEmb( W );
pi := TorsionFreeFactorEpi( W );
C := HomalgComplex( pi, 0 );
Add( C, iota );
T := TorsionObject( W );
F := TorsionFreeFactor( W );
O := HomalgCocomplex( iota, -1 );
Add( O, pi );
W2 := TensorProduct( W, W );
WW2 := TensorProduct( WW, WW );
