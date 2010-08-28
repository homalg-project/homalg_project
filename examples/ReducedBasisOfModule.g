LoadPackage( "RingsForHomalg" );

# Qxyz := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";
Qxyz := HomalgFieldOfRationalsInSingular( ) * "x,y,z";
#Qxyz := HomalgFieldOfRationalsInMAGMA( ) * "x,y,z";
#Qxyz := HomalgFieldOfRationalsInMacaulay2( ) * "x,y,z";
#Qxyz := HomalgFieldOfRationalsInMaple( ) * "x,y,z";

LoadPackage( "LocalizeRingForHomalg" );

# SetInfoLevel( InfoLocalizeRingForHomalgShowUnits, 1 );;
# SetInfoLevel( InfoLocalizeRingForHomalg, 2 );;

SetAssertionLevel( 4 );

# ProfileOperationsAndMethods( true );
# ProfileGlobalFunctions( true );

R0 := LocalizeAtZero( Qxyz );

wmat := HomalgMatrix( "[ \
x*y,  y*z,    z,        0,         0,    \
x^3*z,x^2*z^2,0,        x*z^2,     -z^2, \
x^4,  x^3*z,  0,        x^2*z,     -x*z, \
0,    0,      x*y,      -y^2,      x^2-1,\
0,    0,      x^2*z,    -x*y*z,    y*z,  \
0,    0,      x^2*y-x^2,-x*y^2+x*y,y^2-y \
]", 6, 5, Qxyz );

wmat := HomalgLocalMatrix( wmat, R0 );

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
Y := Hom( R0, W );
iota := TorsionObjectEmb( W );
pi := TorsionFreeFactorEpi( W );
C := HomalgComplex( pi, 0 );
Add( C, iota );
T := TorsionObject( W );
F := TorsionFreeFactor( W );
O := HomalgCocomplex( iota, -1 );
Add( O, pi );

