LoadPackage( "Sheaves" );

R := HomalgRingOfIntegersInSingular( 5 ) * "x,y,z,v,w";

LoadPackage( "LocalizeRingForHomalg" );

R0 := LocalizeAtZero( R );

S0 := LocalizePolynomialRingAtZeroWithMora( R );

m1 := HomalgMatrix( "[ \
x-z, \
y-w  \
]", 2, 1, R );

m2 := HomalgMatrix( "[ \
y^6*v^2*w-y^3*v*w^2+1,\
x*y^4*z^4*w-z^5*w^5+x^3*y*z^2-1 \
]", 2, 1, R );

M := Intersect( LeftSubmodule( m1 ), LeftSubmodule( m2 ) );

M0 := R0 * M;

LocM := S0 * M;

n1 := HomalgMatrix( "[ \
x*z, \
x*w, \
y*z, \
y*w, \
v^2  \
]", 5, 1, R );

n2 := HomalgMatrix( "[ \
y*z^3*w^6-y^2*z^3*w^4+x*y*z*v*w+1, \
y^6*z^4+y^5*z^4*w, \
-2*z^2*w^4+x^2*y   \
]", 3, 1, R );

n3 := HomalgMatrix( "[ \
x^7 \
]", 1, 1, R );

N := Intersect( LeftSubmodule( n1 ), LeftSubmodule( UnionOfRows( n3, m2 ) ) );

N0 := R0 * N;

LocN := S0 * N;

OM := FactorObject( M );

ON := FactorObject( N );

OM0 := FactorObject( M0 );

ByASmallerPresentation( OM0 );

ON0 := FactorObject( N0 );

ByASmallerPresentation( ON0 );

OLocM := FactorObject( LocM );

ByASmallerPresentation( OLocM );

OLocN := FactorObject( LocN );

ByASmallerPresentation( OLocN );

T0 := Tor(OM0,ON0);

#monster output

T0Mora := S0 * T0;

List ( ObjectsOfComplex ( T0Mora ), AffineDegree ); 