LoadPackage( "RingsForHomalg" );

Zx := HomalgRingOfIntegersInDefaultCAS( ) * "x";

rel := HomalgMatrix( "[ x^2 + 5 ]", 1, 1, Zx );
rel := HomalgRelationsForLeftModule( rel );

R := Zx / rel;

M := HomalgMatrix( "[ \
2, \
1+x \
]", 2, 1, R );

M := HomalgMap( M, "free", "free" );

M := ImageModule( M );

e := FreeHullEpi( M );

s := PreInverse( e );

a := PreCompose( s, e );

IsIsomorphism( a );

DecideZero( a );

N := Hom( R, M );

f := FreeHullEpi( N );

t := PreInverse( f );

b := PreCompose( t, f );

IsIsomorphism( b );

DecideZero( b );

