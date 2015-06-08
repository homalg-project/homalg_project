## This is the second example shown in
## "An Axiomatic Setup for Algorithmic Homological Algebra and an Alternative Approach to Localization"

LoadPackage( "RingsForHomalg" );
R := HomalgRingOfIntegersInSingular( 5 ) * "x,y,z,v,w";;

LoadPackage( "LocalizeRingForHomalg" );
R0 := LocalizeAtZero( R );;
S0 := LocalizePolynomialRingAtZeroWithMora( R );;

LoadPackage( "Modules" );
i1 := HomalgMatrix( "[ \
x-z, \
y-w  \
]", 2, 1, R );;
i2 := HomalgMatrix( "[ \
y^6*v^2*w-y^3*v*w^20+1,         \
x*y^4*z^4*w-z^5*w^5+x^3*y*z^2-1 \
]", 2, 1, R );;
I := Intersect( LeftSubmodule( i1 ), LeftSubmodule( i2 ) );;
I0 := R0 * I;
OI0 := FactorObject( I0 );
j1 := HomalgMatrix( "[ \
x*z, \
x*w, \
y*z, \
y*w, \
v^2  \
]", 5, 1, R );;
j2 := HomalgMatrix( "[ \
y^6*v^2*w-y^3*v*w^2+1,           \
x*y^4*z^4*w-z^5*w^5+x^3*y*z^2-1, \
x^7                              \
]", 3, 1, R );;
J := Intersect( LeftSubmodule( j1 ), LeftSubmodule( j2 ) );;
J0 := R0 * J;;
OJ0 := FactorObject( J0 );

T0 := Tor( OI0 , OJ0 );

T0Mora := S0 * T0;

Assert( 0, List( ObjectsOfComplex ( T0Mora ), AffineDegree ) = [ 6, 2, 0 ] );
